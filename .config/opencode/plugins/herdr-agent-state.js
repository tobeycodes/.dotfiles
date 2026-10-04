// installed by herdr
// managed by herdr; reinstalling or updating the integration overwrites this file.
// add custom hooks/plugins beside this file instead of editing it.
// HERDR_INTEGRATION_ID=opencode
// HERDR_INTEGRATION_VERSION=11
// Locally ported to the OpenCode V2 server plugin API.

import net from "node:net";
import { Plugin } from "@opencode/plugin";

const SOURCE = "herdr:opencode";
const AGENT = "opencode";
let reportSeq = Date.now() * 1000;
let requestChain = Promise.resolve();
let reportedRootSessionID;

// Track child sessions so their events cannot replace the pane's root session.
// User prompts carry the root id to preserve its identity and cross-talk guard.
const childSessions = new Map();
const CHILD_EVENT_STATES = new Map([
  ["permission.asked", "blocked"],
  ["form.created", "blocked"],
  ["permission.replied", "working"],
  ["form.replied", "working"],
  ["form.cancelled", "working"],
]);

function nextReportSeq() {
  reportSeq += 1;
  return reportSeq;
}

function sessionIDFromData(data) {
  return typeof data?.sessionID === "string" && data.sessionID ? data.sessionID : undefined;
}

const SESSION_STATE_BY_STATUS = new Map([
  ["idle", "idle"],
  ["active", "working"],
  ["busy", "working"],
  ["pending", "working"],
  ["retry", "working"],
  ["running", "working"],
  ["streaming", "working"],
  ["working", "working"],
]);

function stateFromSessionStatus(status) {
  const kind = typeof status === "string" ? status : status?.type;
  return typeof kind === "string" ? SESSION_STATE_BY_STATUS.get(kind.toLowerCase()) : undefined;
}

function request(method, params) {
  const pending = requestChain.then(() => requestOnce(method, params));
  requestChain = pending.catch(() => {});
  return pending;
}

function requestOnce(method, params) {
  const paneId = process.env.HERDR_PANE_ID;
  const socketPath = process.env.HERDR_SOCKET_PATH;

  if (!paneId || !socketPath) {
    return Promise.resolve();
  }

  const socketEndpoint = process.platform === "win32" ? `\\\\.\\pipe\\${socketPath}` : socketPath;

  const requestId = `${SOURCE}:${Date.now()}:${Math.floor(Math.random() * 1_000_000)
    .toString()
    .padStart(6, "0")}`;
  const request = {
    id: requestId,
    method,
    params: {
      pane_id: paneId,
      source: SOURCE,
      agent: AGENT,
      seq: nextReportSeq(),
      ...params,
    },
  };

  return new Promise((resolve) => {
    const client = net.createConnection(socketEndpoint, () => {
      client.write(`${JSON.stringify(request)}\n`);
    });

    const finish = () => {
      client.destroy();
      resolve();
    };

    client.setTimeout(500, finish);
    client.on("data", finish);
    client.on("error", finish);
    client.on("end", finish);
    client.on("close", resolve);
  });
}

function reportSession(sessionID) {
  if (!sessionID) {
    return Promise.resolve();
  }
  return request("pane.report_agent_session", { agent_session_id: sessionID });
}

function reportState(state, sessionID) {
  const params = { state };
  if (sessionID) {
    reportedRootSessionID = sessionID;
    params.agent_session_id = sessionID;
  }
  return request("pane.report_agent", params);
}

export default Plugin.define({
  id: "herdr.opencode.agent-state",
  async setup(ctx) {
    if (
      process.env.HERDR_ENV !== "1" ||
      !process.env.HERDR_SOCKET_PATH ||
      !process.env.HERDR_PANE_ID
    ) {
      return;
    }

    await ctx.session.hook("prompt", async ({ sessionID }) => {
      const session = await ctx.session.get({ sessionID });
      if (session.parentID) {
        childSessions.set(sessionID, session.parentID);
        return;
      }
      await reportState("working", sessionID);
    });

    const handleEvent = async (event) => {
      // V2 subscriptions receive events from every server location.
      if (
        event.location &&
        (event.location.directory !== ctx.location.directory ||
          event.location.workspaceID !== ctx.location.workspaceID)
      ) {
        return;
      }
      const type = event.type;
      const data = type === "form.created" ? event.data.form : event.data;
      const sessionID = sessionIDFromData(data);
      if (!sessionID || !sessionID.startsWith("ses")) {
        return;
      }

      if (type === "session.created" && data.parentID) {
        childSessions.set(sessionID, data.parentID);
      }
      if (type === "session.deleted") {
        childSessions.delete(sessionID);
        return;
      }
      if (childSessions.has(sessionID)) {
        const state = CHILD_EVENT_STATES.get(type);
        if (state) {
          let rootSessionID = sessionID;
          while (childSessions.has(rootSessionID)) {
            rootSessionID = childSessions.get(rootSessionID);
          }
          await reportState(state, rootSessionID);
        }
        return;
      }

      switch (type) {
        case "session.created":
          // Creation is server-global, so an attached client may own it. The
          // TUI plugin separately reports the root selected in this pane.
          reportedRootSessionID = sessionID;
          break;
        case "session.viewed":
          if (sessionID !== reportedRootSessionID) {
            await reportSession(sessionID);
          }
          break;
        case "session.status": {
          const state = stateFromSessionStatus(data.status);
          if (state) {
            await reportState(state, sessionID);
          } else {
            await reportSession(sessionID);
          }
          break;
        }
        case "session.execution.started":
        case "session.retry.scheduled":
        case "session.tool.called":
        case "session.tool.success":
        case "session.tool.failed":
        case "permission.replied":
        case "form.replied":
        case "form.cancelled":
        case "session.compaction.started":
        case "session.compaction.ended":
          await reportState("working", sessionID);
          break;
        case "permission.asked":
        case "form.created":
        case "session.execution.failed":
          await reportState("blocked", sessionID);
          break;
        case "session.execution.succeeded":
        case "session.execution.interrupted":
        case "session.idle":
          await reportState("idle", sessionID);
          break;
        default:
          break;
      }
    };

    const controller = new AbortController();
    const subscription = (async () => {
      for await (const event of ctx.event.subscribe({ signal: controller.signal })) {
        await handleEvent(event);
      }
    })().catch((error) => {
      if (!controller.signal.aborted) {
        console.error(
          "Herdr agent-state subscription stopped; reload the plugin to resume reporting.",
          error,
        );
      }
    });

    return async () => {
      controller.abort();
      await subscription;
    };
  },
});
