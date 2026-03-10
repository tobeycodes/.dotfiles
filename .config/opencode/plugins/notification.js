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
        await $`notify "OpenCode"`;
      }
    },
  };
};
