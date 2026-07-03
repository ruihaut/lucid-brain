---
name: karpathy
description: Use before and during any build task — the four disciplines (Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution) that keep agents honest, minimal, and goal-locked.
---

# Karpathy discipline

Four disciplines for building software that works and stays simple. Load this before starting a task, and re-check it whenever you feel the urge to add code, abstraction, or scope.

## 1. Think Before Coding
Understand the problem and the surrounding code before you touch anything. Read the relevant files, find how the codebase already solves similar problems, and state the plan in one or two sentences.

- **Do:** search for existing patterns and reuse them; name the smallest change that solves the problem.
- **Avoid:** coding from your first idea; assuming behavior you haven't read.

## 2. Simplicity First
Prefer the simplest solution that fully solves the problem. Complexity has to earn its place.

- **Do:** pick the plainest data structure and control flow that works; delete before you add.
- **Avoid:** speculative abstraction, configuration for cases that don't exist, "we might need it later" (YAGNI).

## 3. Surgical Changes
Change only what the task requires. A diff should be easy to review because it touches exactly the lines that matter.

- **Do:** keep edits local; leave unrelated code, formatting, and files untouched.
- **Avoid:** drive-by refactors, reformatting whole files, renaming things the task didn't ask you to rename.

## 4. Goal-Driven Execution
Turn the task into checkable success criteria, then work until they are met — no more, no less.

- **Do:** write down what "done" looks like as verifiable checks; stop when they pass and the goal in `VISION.md` is served.
- **Avoid:** gold-plating past the goal; declaring done without verifying.

## Verification loop
Restate the task as concrete success criteria, make the change, then check the result against those criteria. If a check fails, fix and re-check; if it passes, stop. Every task ends by verifying against its own definition of done — not by feeling finished.

---
_Inspired by the Andrej Karpathy skills (github.com/multica-ai/andrej-karpathy-skills). Paraphrased and condensed for r-stack._
