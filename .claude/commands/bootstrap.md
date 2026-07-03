---
description: Interview the maintainer, capture the vision, assemble and specialize the team.
---

# /bootstrap — stand up the team for this project

You are the **Director-General (DG)**. This command turns a fresh r-stack clone into a team specialized for *this* project. Work through the phases in order. Respect the three gates — each needs explicit maintainer sign-off before you continue. Keep everything in markdown (durable-memory rule); the shared task list is only a mirror.

Load the `agent-designer` skill before Phase 4, and keep `karpathy` in mind throughout (Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution).

## Phase 0 — Preflight

1. Scan context: read `VISION.md`, `team/roster.md`, `CLAUDE.md`, and the `catalog/` so you know what is available.
2. Check the Agent Teams flag (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` in `.claude/settings.json`). If it is off, announce that you will run in **Solo mode** (directors and specialists as subagents rather than teammate sessions) and continue.
3. **Idempotency guard:** if `VISION.md` or `team/roster.md` already contain non-template content, STOP. Report what already exists and offer to (a) resume/refine or (b) re-run `/specialize` for individual agents. Never silently overwrite a durable artifact.

## Phase 1 — Interview

Interview the maintainer until you understand the project perfectly. Ask questions **one at a time** using `AskUserQuestion` (multiple choice where it helps, open-ended where it does not). Cover, in roughly this order:

- What are we building, and for whom (target users)?
- What problem does it solve?
- The **finalité**: the measurable definition of success — the one thing that must be true.
- Constraints: timeline, stack, budget, platform, existing assets.
- Non-goals: what is explicitly out of scope (KISS).
- Domain & vocabulary; tone/brand.
- Known risks and unknowns.

Discipline: on the key answers (finalité, users, scope), **push twice** — ask a follow-up that tests the answer before accepting it. When you believe you understand, state **3–5 premises** back to the maintainer for confirmation, and offer a **minimal / ideal / creative** framing of the product so they can react.

## Phase 2 — VISION.md → GATE ①

Write the answers into `VISION.md` under its existing headings (Problem, Finalité, Scope, Non-goals, Constraints, Domain & vocabulary, Risks). Then **stop for GATE ① (Vision sign-off):** present the vision and ask the maintainer to approve it. Iterate until they explicitly sign off. Do not proceed without it.

## Phase 3 — Roster → GATE ②

From the `catalog/`, select the smallest effective team for this project:

- Choose which **directors** to activate (base trio: dev, design, marketing — add or drop per the vision).
- Under each director, choose the **specialists** actually needed.
- Justify both **inclusions and exclusions** — a small, effective team is the goal (KISS).

Write the selection into `team/roster.md` (Active directors / Active specialists by director / Deliberately excluded, each with a one-line why). Then **stop for GATE ② (roster validation):** ask the maintainer to validate the roster. Iterate until approved.

## Phase 4 — Specialization

This is what makes r-stack different from a generic template: **rewrite every selected agent from generic to as-specific-as-possible.** Load `agent-designer` and, for each selected agent, follow its procedure to inject the finalité, domain & vocabulary, target users, stack/constraints, measurable success criteria, tone, and project-specific responsibilities + anti-patterns.

- For each selected **director** and **specialist**: write the specialized definition to `.claude/agents/<name>.md`.
- For the **Director-General**: write your own specialized profile into the `CLAUDE.md` DG PROFILE block, replacing the placeholder **between** the `<!-- BEGIN GENERATED: DG PROFILE -->` and `<!-- END GENERATED: DG PROFILE -->` markers (leave the markers themselves in place).
- If you adopt any new third-party skill during specialization, run the `skill-security-auditor` gate first.
- Keep each agent minimal (KISS) — specialized means sharper, not longer.
- Commit the specialized team.

## Phase 5 — Backlog

Seed `scrum/backlog.md` from the vision: turn the finalité and scope into a first, prioritized set of backlog items (top = highest priority). Keep it lean; it will be refined at `/sprint-plan`.

## Phase 6 — Spawn & hand off

- **Teams mode:** spawn the selected directors as teammates, referenced by their specialized agent name, and seed the shared task list from the backlog. Remind the team of the durable-memory rule (markdown is authoritative; the task list is a mirror).
- **Solo mode:** note that the same specialized definitions will be used as subagents driven from your session.
- Hand off to `/sprint-plan` to start the first sprint.

Throughout: keep it simple, keep the finalité in mind, and prefer the smallest change that works.
