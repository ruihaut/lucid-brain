---
description: Re-specialize one agent (or all) from the current Vision — used for continuous improvement.
argument-hint: <agent-name | all>
---

# /specialize — re-specialize an agent from the Vision

Re-specialize a team member so it matches the current `VISION.md` and the latest learnings. Use it after a retro, when the vision shifts, or when an agent feels generic. Idempotent and surgical: show a diff and get confirmation before overwriting.

**Argument:** an agent name (e.g. `dev-director`, `backend`) or `all`.

## Steps

1. **Read the inputs:** `VISION.md` (source of truth), the generic source in `catalog/` for the target role, the current `.claude/agents/<name>.md` (if it exists), and the latest `scrum/retros/retro-NN.md` for improvement notes.
2. **Guard:** if `VISION.md` is still a template, STOP and tell the maintainer to run `/bootstrap` first.
3. **Apply `agent-designer`:** follow its procedure to produce the specialized definition — inject the finalité, domain & vocabulary, target users, stack/constraints, measurable success criteria, tone, and project-specific responsibilities + anti-patterns. Keep it minimal (KISS).
4. **Write the target:**
   - A director or specialist → `.claude/agents/<name>.md`.
   - `director-general` → the `CLAUDE.md` DG PROFILE block, between the `<!-- BEGIN GENERATED: DG PROFILE -->` and `<!-- END GENERATED: DG PROFILE -->` markers (leave the markers in place).
   - `all` → repeat for every active agent listed in `team/roster.md`.
5. **Diff & confirm:** show the maintainer the diff and require confirmation before overwriting (idempotent, Surgical Changes). Never overwrite silently.
6. **Commit** the change with a message noting which agent(s) were re-specialized and why.
