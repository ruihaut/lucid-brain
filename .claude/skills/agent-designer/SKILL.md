---
name: agent-designer
description: Use when creating or specializing an agent definition — turns a generic role into a project-specific one grounded in the Vision.
---

# Agent designer

How to turn a generic `catalog/` role into a sharp, project-specific agent. This is the specialization procedure `/bootstrap` (Phase 4) and `/specialize` follow. The difference between r-stack and a generic template lives here: a specialized agent knows *this* project's finalité, domain, users, and constraints — it is not a role card.

## Procedure

1. **Read `VISION.md`.** It is the source of truth — problem, finalité, scope, non-goals, constraints, domain & vocabulary, tone, risks. If it is still a template, stop and run `/bootstrap` first.
2. **Start from the generic source** in `catalog/` (the `catalog/_TEMPLATE.md` schema plus the role file, e.g. `catalog/specialists/backend.md`). Inherit its structure — do not reinvent it.
3. **Inject project specifics** into the body, replacing every generic line with the concrete equivalent:
   - the finalité this role serves (one sentence);
   - the domain & vocabulary the role must use correctly;
   - the target users the role builds for;
   - the stack / constraints from the Vision;
   - measurable success criteria (Goal-Driven);
   - the project's tone/brand where the role produces user-facing output;
   - responsibilities and anti-patterns rewritten in the project's terms.
4. **Set exact frontmatter** (schema below).
5. **Assign skills:** always `karpathy`; then only the skills this role actually uses (e.g. `impeccable` for design roles). Fewer is better.
6. **Keep it minimal (KISS).** A specialized agent is shorter and sharper than the generic template, not longer. Cut anything that is not specific to this project.

## Output frontmatter schema

```
---
name: <kebab-case-role>
description: <one line — when to use this agent (trigger style)>
tools: Read, Grep, Glob, Edit, Write
model: inherit
---
```

## Target

Most agents are written to `.claude/agents/<name>.md`. The one exception is `director-general`: its specialized body is written into the `CLAUDE.md` DG PROFILE block, between the `<!-- BEGIN GENERATED: DG PROFILE -->` and `<!-- END GENERATED: DG PROFILE -->` markers, because the DG is the always-loaded lead.
