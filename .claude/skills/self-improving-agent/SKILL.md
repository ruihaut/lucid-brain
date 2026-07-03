---
name: self-improving-agent
description: Use during /retro — turn learnings into concrete agent/skill improvements.
---

# Self-improving agent

Continuous improvement means each retro changes the team, not only the product. Convert learnings into concrete edits.

## From learning to change

1. **Name the learning** precisely: what happened, and which agent or skill was involved.
2. **Choose the smallest fix:**
   - The agent was mis-specialized (wrong scope, missing domain knowledge, wrong tone) → run `/specialize <agent>` to rewrite it from the current Vision.
   - The gap is general to the role, not just this project → edit the generic source in `catalog/`.
   - The gap is a reusable method → edit or add a skill in `.claude/skills/` (see `write-a-skill`).
3. **Apply it** surgically (Karpathy: Surgical Changes).
4. **Log it** in the current `scrum/retros/retro-NN.md`: the learning, the change made, and the file touched — so improvements are traceable.

Keep changes small and evidence-based. One good specialization beats a rewrite.
