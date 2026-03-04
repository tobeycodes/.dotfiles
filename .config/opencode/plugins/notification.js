export const NotificationPlugin = async ({
  project: _project,
  client: _client,
  $,
  directory: _directory,
  worktree: _worktree,
}) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`osascript -e 'display notification "OpenCode needs your attention" with title "OpenCode" sound name "Glass"'`;
      }
    },
  };
};
