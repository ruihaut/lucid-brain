---
name: write-a-skill
description: Use when authoring a new skill — a concise checklist for a well-scoped, progressive-disclosure SKILL.md.
---

# Write a skill

A skill is a focused, reusable instruction the team loads on demand. Keep it small and single-purpose.

## Checklist

- **One responsibility.** A skill does one thing. If it needs an "and", split it.
- **Name it for the trigger.** `name:` is kebab-case and matches how you would invoke it.
- **Trigger-style description.** Start `description:` with "Use when…" so the model knows *when* to load it, not just what it is. This line is how the skill gets discovered — make it precise.
- **Short body.** The SKILL.md holds the essentials only: the procedure or principles someone needs to act. Aim for well under a screen.
- **Progressive disclosure.** Push depth (long examples, reference tables, data) into `reference/` files the body points to, so the skill stays cheap to load and detailed on demand.
- **Concrete over abstract.** Prefer a checklist or do/avoid pairs to prose.
- **No secrets, no runtime coupling.** Never bake in credentials; prefer instructions that need no external runtime (r-stack is zero-dependency).
