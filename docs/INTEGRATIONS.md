# Integrations

r-stack has **zero runtime dependencies** — no Node.js, no Python. The integrations below are all optional enhancements, layered in three tiers: a remote MCP (Context7), an optional Anthropic plugin (frontend-design), and a vendored guidance-only skill (impeccable).

## Context7 (default MCP)

Context7 provides up-to-date, version-specific documentation for libraries and frameworks, so dev specialists don't code against stale training data. It is registered in `.mcp.json` as a remote HTTP MCP server (`https://mcp.context7.com/mcp`).

**Usage.** In a prompt, add the trigger phrase **"use context7"**, or call the tools directly: first `resolve-library-id` to turn a library name into a Context7-compatible ID, then `get-library-docs` to fetch the documentation for that ID (optionally scoped to a topic).

**API key (optional).** Anonymous access works out of the box. For higher rate limits, set a `CONTEXT7_API_KEY` environment variable — `.mcp.json` reads it via `${CONTEXT7_API_KEY}`. A key is obtained from context7.com.

**Privacy note.** Context7 is a third-party service (`mcp.context7.com`, operated by Upstash). The library names and documentation queries you send are transmitted to that service. Do not include proprietary code or secrets in Context7 queries.

## frontend-design (optional plugin — proprietary, do not vendor)

Anthropic's official `frontend-design` skill raises front-end quality (layout, spacing, typography, motion). It is **proprietary**, so r-stack never vendors it — install it as a plugin instead:

```
/plugin marketplace add anthropics/claude-code
/plugin install frontend-design@claude-code-plugins
```

Once installed, the design-director and the `ui-ux` specialist use it when it is present.

## impeccable (vendored, guidance-only)

A design-craft skill for distinctive, anti-"AI-slop" UI, vendored under `.claude/skills/impeccable/` (Apache-2.0 — see `.claude/skills/impeccable/NOTICE` for attribution and the pinned source commit). r-stack vendors **guidance only**: the upstream Node.js scripts and any `npx`/`node` tooling are intentionally omitted to honor the zero-runtime-dependency rule. Apply its methods manually as described in its `SKILL.md`.

## Prerequisites

- **Claude Code ≥ v2.1.178.**
- **Agent Teams (experimental)** — the flag `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` is already set in `.claude/settings.json`, with `teammateMode: in-process` (required on Windows, where tmux/iTerm2 split-panes are unavailable). With the flag off, r-stack runs in Solo mode (subagents).
- **No runtime dependencies** — markdown + Claude-native only.
- **Optional:** `CONTEXT7_API_KEY` (higher Context7 limits); the `frontend-design` plugin (design quality).
