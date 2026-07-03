---
name: impeccable
description: Use when designing, redesigning, critiquing, auditing, polishing, or improving any frontend interface — websites, landing pages, dashboards, product UI, components, forms, onboarding, empty states. Covers visual hierarchy, typography, color, layout, spacing, motion, micro-interactions, UX copy, accessibility, responsive behavior, theming, and anti-"AI-slop" craft. Not for backend-only or non-UI tasks.
---

# Impeccable — design craft (guidance-only)

Design and iterate production-grade frontend interfaces: real working code, committed design choices, exceptional craft.

> **Guidance-only vendoring.** This is the runtime-free core of the impeccable skill. The upstream Node scripts, `$impeccable` command system, live browser-iteration mode, and editor hooks are intentionally omitted so r-stack stays zero-dependency (see `NOTICE`). Apply the methods below by hand.

## Register first

Visual decisions hinge on which register you are in. Read the matching reference before committing to choices:

- **Brand** — design IS the product (landing pages, marketing, campaigns, portfolios, long-form). → `reference/brand.md`
- **Product** — design SERVES the product (app UI, dashboards, admin, tools). → `reference/product.md`

Pick by first match: the task cue ("landing page" vs "dashboard"), the surface in focus, or the project's stated register in `VISION.md`.

## Design guidance

Produce ready-to-ship, production-grade code, not prototypes or starting points. Take no shortcuts unless the user asks for them (when in doubt, ask). Don't stop until you arrive at a complete implementation: beautiful, responsive, fast, precise, bug-free, on brand. Take attention to detail seriously — battle-test every page, section, and component at every breakpoint. Don't hold back.

### Color

- **Verify contrast.** Body text must hit ≥4.5:1 against its background; large text (≥18px or bold ≥14px) needs ≥3:1. Placeholder text needs the same 4.5:1, not the muted-gray default. The most common failure: muted gray body text on a tinted near-white. If the contrast is even close, bump the body color toward the ink end of the ramp; light gray "for elegance" is the single biggest reason AI designs feel hard to read.
- Gray text on a colored background looks washed out. Use a darker shade of the background's own hue, or a transparency of the text color.

### Typography

- Cap body line length at 65–75ch.
- Don't pair fonts that are similar but not identical (two geometric sans-serifs, two humanist sans-serifs). Pair on a contrast axis (serif + sans, geometric + humanist) or use one family in multiple weights.
- Hero / display heading ceiling: `clamp()` max ≤ 6rem (~96px). Above that the page is shouting, not designing.
- Display heading letter-spacing floor: ≥ -0.04em. Anything tighter and letters touch; cramped, not "designed". (-0.02 to -0.03em is plenty for tight grotesque display.)
- Use `text-wrap: balance` on h1–h3 for even line lengths; `text-wrap: pretty` on long prose to reduce orphans.

### Layout

- Vary spacing for rhythm.
- Cards are the lazy answer. Use them only when they're truly the best affordance. Nested cards are always wrong.
- Flexbox for 1D, Grid for 2D. Don't default to Grid when `flex-wrap` would be simpler.
- For responsive grids without breakpoints: `repeat(auto-fit, minmax(280px, 1fr))`.
- Build a semantic z-index scale (dropdown → sticky → modal-backdrop → modal → toast → tooltip). Never arbitrary values like 999 or 9999.

### Motion

- Motion should be intentional, not an afterthought. Consider it part of the build.
- Don't animate CSS layout properties unless truly needed.
- Ease out with exponential curves (ease-out-quart / quint / expo). No bounce, no elastic.
- Use libraries for more advanced motion needs (e.g. motion, gsap, anime.js, lenis).
- Reduced motion is not optional. Every animation needs a `@media (prefers-reduced-motion: reduce)` alternative: typically a crossfade or instant transition.
- Staggering items within one list is legitimate. The tell is the uniform reflex (one identical entrance applied to every section), not motion itself; each reveal should fit what it reveals. Suppressing the reflex is never a reason to ship a page with no motion at all.
- Reveal animations must enhance an already-visible default. Don't gate content visibility on a class-triggered transition; transitions pause on hidden tabs and headless renderers, so the reveal never fires and the section ships blank.
- Premium motion materials are not just transform/opacity. Blur, backdrop-filter, clip-path, mask, and shadow/glow are part of the palette when they materially improve the effect and stay smooth.

### Interaction

- Dropdowns rendered with `position: absolute` inside an `overflow: hidden` or `overflow: auto` container will be clipped. Use the native `<dialog>` / popover API, `position: fixed`, or a portal to escape the stacking context.

### New projects only (when no prior work exists)

- **Use OKLCH** throughout.
- **The cream / sand / beige body bg is the saturated AI default of 2026.** The whole warm-neutral band (OKLCH L 0.84–0.97, C < 0.06, hue 40–100) reads as cream/sand/paper/parchment regardless of what you call it. Token names like `--paper`, `--cream`, `--sand`, `--bone`, `--linen`, `--parchment`, `--ivory` are tells in themselves. Don't translate "warm, editorial, magazine" into a near-white warm-tinted bg — that's the AI move. Pick: (a) a saturated brand color as the body (terracotta, oxblood, deep ochre, near-black), (b) a true off-white at chroma 0 (or chroma toward the brand's own hue), or (c) a darker mid-tone tinted neutral that's clearly the brand's own. Warmth is carried by accent + typography + imagery, not by body bg.
- Tinted neutrals: add 0.005–0.015 chroma toward the brand's hue. Don't default-tint toward warm or cool "because the brand feels that way"; that's the cross-project monoculture move.
- Dark vs. light is never a default — not dark "because tools look cool dark", not light "to be safe". Before choosing, write one sentence of physical scene: who uses this, where, under what ambient light, in what mood. If the sentence doesn't force the answer, add detail until it does.
- Pick a **color strategy** before picking colors, on a commitment axis:
  - **Restrained** — tinted neutrals + one accent ≤10%. Product default; brand minimalism.
  - **Committed** — one saturated color carries 30–60% of the surface. Brand default for identity-driven pages.
  - **Full palette** — 3–4 named roles, each used deliberately. Brand campaigns; product data viz.
  - **Drenched** — the surface IS the color. Brand heroes, campaign pages.

## Absolute bans

Match-and-refuse. If you're about to write any of these, rewrite the element with different structure.

- **Side-stripe borders.** `border-left`/`border-right` greater than 1px as a colored accent on cards, list items, callouts, or alerts. Rewrite with full borders, background tints, leading numbers/icons, or nothing.
- **Gradient text.** `background-clip: text` with a gradient. Decorative, never meaningful. Use a single solid color; emphasis via weight or size.
- **Glassmorphism as default.** Blurs and glass cards used decoratively. Rare and purposeful, or nothing.
- **The hero-metric template.** Big number, small label, supporting stats, gradient accent. SaaS cliché.
- **Identical card grids.** Same-sized cards with icon + heading + text, repeated endlessly.
- **Tiny uppercase tracked eyebrow above every section.** The all-caps wide-tracked kicker ("ABOUT", "PROCESS") on every heading is AI grammar. One named kicker as a deliberate brand system is voice; an eyebrow on every section is not. Choose a different cadence.
- **Numbered section markers as default scaffolding (01 / 02 / 03).** Numbers earn their place only when the section actually IS a sequence (a real 3-step process, an ordered flow). Numbered eyebrows on every section across a site is AI grammar.
- **Text that overflows its container.** Long heading words + large clamp scales + narrow grids cause overflow on tablet/mobile. Test heading copy at every breakpoint; if it overflows, reduce the clamp max or rewrite the copy. The viewport is part of the design.

### Common implementation defects (refuse-and-rewrite)

- **`border: 1px solid X` + `box-shadow: 0 Npx Mpx …` with M ≥ 16px** on the same element (the "ghost-card"). Pick one: a single solid border, OR a defined shadow at ≤8px blur — never both as decoration.
- **`border-radius: 32px+` on cards / sections / inputs.** Cards top out at 12–16px; full-pill is fine for tags/buttons only. 24/28/32/40px on a card is over-rounding.
- **Hand-drawn / sketchy SVG illustrations.** Class names like `*-sketch`, `doodle`, `wavy`; `feTurbulence`/`feDisplacementMap` "paper grain"; crude multi-path scenes. Reads as amateurish. If you can't render the scene with real assets, ship no illustration.
- **`repeating-linear-gradient(…)` stripe backgrounds.** Pure decoration. Don't.
- **Decorative grid backgrounds.** Two-axis CSS grid overlays from `linear-gradient(… 1px, transparent 1px)` + `background-size`, unless the surface is an actual canvas, map, blueprint, or measurement tool.
- **Meta-criticism copy.** Naming a concept then layering an ironic modifier, or staging a strawman to "correct" it. Make the specific claim instead.

## The AI slop test

If someone could look at this interface and say "AI made that" without doubt, it's failed. Cross-register failures are the absolute bans above. Register-specific failures live in each reference.

**Category-reflex check.** Run at two altitudes; the second catches what the first misses.

- **First-order:** if someone could guess the theme + palette from the category alone, it's the first training-data reflex. Rework the scene sentence and color strategy until the answer isn't obvious from the domain.
- **Second-order:** if someone could guess the aesthetic family from category-plus-anti-references ("AI tool that's not SaaS-cream → editorial-typographic", "fintech that's not navy-and-gold → terminal-native dark"), it's the trap one tier deeper. Rework until neither answer is obvious. The brand register's reflex-reject aesthetic lanes (`reference/brand.md`) list the currently-saturated families.

---
_Vendored from **impeccable** by Paul Bakaus — https://github.com/pbakaus/impeccable — Apache-2.0, original version 3.9.1 (commit `1fe9c41`). Guidance only; upstream Node scripts, `$impeccable` commands, live mode, and hooks are intentionally omitted. See `NOTICE`._
