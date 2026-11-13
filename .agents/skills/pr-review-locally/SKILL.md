---
name: pr-review-locally
description: Open a given Altitude PR in Plannotator and run the Altitude dev server in Plannotator's PR worktree. Use when asked to review a specific Altitude PR with the app running locally.
---

# Review a PR locally

Opens a PR in Plannotator's review UI, waits for its local checkout, then
starts `mise run dev` in that worktree so the reviewer can click through the
change while annotating.

## 1. Get the PR

A PR is required. If the user didn't give a PR number or URL, ask for one.
Never pick a PR yourself.

Resolve it to a URL and confirm it exists:

```bash
gh pr view <PR> --json number,title,url,author
```

## 2. Start the Plannotator review

Run in the background; it blocks until the reviewer submits:

```bash
plannotator review <PR_URL> > /tmp/plannotator-<N>.log 2>&1
```

`--local` is the default, so Plannotator prepares a detached worktree under
`$TMPDIR/plannotator-pr-<owner>-<repo>-<N>-*/pool/pr-<N>`.

## 3. Wait for the checkout

Wait (bounded) until the session is ready and the worktree exists:

```bash
for i in $(seq 1 60); do
  grep -q 'session ready' /tmp/plannotator-<N>.log \
    && git worktree list | grep -q "/pr-<N> " && break
  sleep 2
done
cat /tmp/plannotator-<N>.log
git worktree list | grep "/pr-<N> "
```

Use the path from `git worktree list` as `WORKTREE` for the remaining steps.

## 4. Install dependencies and start dev

The fresh worktree has no `node_modules`. In `WORKTREE`:

```bash
mise run bootstrap
```

Then run in the background:

```bash
mise run dev > /tmp/dev-<N>.log 2>&1
```

`mise run dev` detects the worktree and serves it on worktree-scoped portless
hosts, e.g. `https://pr-<N>.web.altitude.localhost` and
`https://pr-<N>.api.altitude.localhost`. Confirm the URLs from the log once
they appear. The API needs a Rust compile before it responds.

## 5. Report and handle feedback

Report the PR (number, title, author), the Plannotator URL, the worktree path,
and the web/API URLs.

When the Plannotator command finishes, follow the `plannotator-review` skill:
address returned annotations, acknowledge an approval, or stop if the session
closed without feedback. Leave the dev server running unless asked to stop it.
