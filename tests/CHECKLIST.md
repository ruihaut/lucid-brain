# Smoke-test checklist

Run before publishing a change to the template.

## 1. Structural lint (automated)

```
pwsh -File tests/lint.ps1
```

Expected: `LINT OK` and exit code 0. Fix any `FAIL:` lines before continuing.

## 2. Live bootstrap (manual, in Claude Code)

1. In a throwaway copy of the repo, run `/bootstrap` and give canned answers for a small sample project.
2. Assert the outputs:
   - `VISION.md` is filled (no template placeholders under the headings).
   - `team/roster.md` lists active directors + specialists with reasons, plus deliberate exclusions.
   - `.claude/agents/*.md` contains the specialized directors and specialists.
   - `CLAUDE.md` DG PROFILE block (between the markers) is populated with the specialized DG.
   - `scrum/backlog.md` is seeded from the vision.
3. Confirm specialization actually injected project specifics (finalité, domain, users) — not generic text. This is the differentiator.

## 3. Solo-mode fallback

Set `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` to `0` in `.claude/settings.json`, then re-run `/bootstrap` preflight; confirm it announces **Solo mode** and proceeds with subagents. Restore the flag afterward.

## 4. Verify

Apply the Goal-Driven verification loop (`karpathy`): restate each expected outcome above as a check and confirm it holds. Record anything that failed.
