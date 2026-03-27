---
title: "Penrose Diagrams"
date: 2026-03-22
lastmod: 2026-03-23
version: "2.0"
status: "finished"
confidence: "certain"
description: "How to fit infinite spacetime onto a finite sheet of paper — and why it matters. A visual guide to conformal diagrams: Minkowski, Schwarzschild, de Sitter, Anti-de Sitter."
tags: ["physics", "general-relativity", "penrose-diagrams", "black-holes", "cosmology"]
series: "Physics Explainers"
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
---

Spacetime is infinite. Light can travel forever. A black hole crushes a point to zero. How do you draw all of this on a finite sheet?

Roger Penrose's answer, developed in the early 1960s: conformal compactification. A mathematical transformation that squeezes infinity into finite points and lines while preserving the one thing that matters for the physics of causality — the structure of light cones.

This one idea gave physicists a tool so powerful that it now appears in virtually every major result in general relativity — from the singularity theorems to the holographic principle, from the classification of spacetimes to the proof that gravitational waves carry energy.


## The Problem

By the early 1960s, general relativity was in crisis — not because the theory was wrong, but because nobody could prove it was right in the ways that mattered most.

Karl Schwarzschild found his black hole solution in 1916, within months of Einstein publishing the field equations. But the solution assumed perfect spherical symmetry — a condition that never holds in nature. Most physicists, Einstein included, believed that any real-world deviation from perfect symmetry would prevent a singularity from forming. The question of whether black holes actually exist, or are just artifacts of idealized mathematics, remained open for nearly 50 years.

The difficulty was that existing tools couldn't handle the global structure of spacetime. You could write down the metric at any single point, but understanding what happens "at infinity" — where gravitational waves arrive, where light rays end up, what the ultimate fate of collapsing matter is — required seeing the whole spacetime at once.

## The Idea

The technique came together across three key moments. In a short 1963 note in *Physical Review Letters*, Penrose introduced conformal compactification as a tool for studying asymptotic structure. At the Les Houches Summer School that same year, he gave three lectures explaining the method in detail — including how the conformal boundary changes depending on the sign of the cosmological constant. Then in 1965, he published the singularity theorem that the Nobel Committee would later call "the most important contribution to the general theory of relativity since Einstein."

The key to the singularity theorem came to Penrose during a walk with colleague Ivor Robinson in London, autumn 1964. As he later recalled, they reached a crossroad, stopped talking to watch for traffic, and in that moment the concept of a "trapped surface" flashed into his mind. That single idea — combined with the conformal methods he had been developing — proved that singularities are inevitable in general relativity, ending five decades of debate.

## How It Works

The core insight is elegant: if you care only about causality — which events can influence which other events — then you don't need to preserve distances. You only need to preserve the light cone structure.

A conformal transformation rescales the metric by a factor Ω²: every distance is multiplied by Ω, but angles are unchanged. Light rays still travel at 45°. The causal ordering of events is preserved. What changes is that Ω is chosen to go to zero at infinity, compressing infinitely distant regions into a finite boundary.

The result: an infinite spacetime fits on a finite diagram. Its causal structure is perfectly intact. What you lose — distances — is precisely what you don't need for understanding which events can influence which.

## Five Rules for All Diagrams

<div class="metrics">
  <div class="metric"><div class="val">↑</div><div class="desc">Time flows upward</div></div>
  <div class="metric"><div class="val">↔</div><div class="desc">Space extends horizontally</div></div>
  <div class="metric"><div class="val">45°</div><div class="desc">Light always travels at 45°</div></div>
  <div class="metric"><div class="val">&gt;45°</div><div class="desc">Massive bodies: steeper paths</div></div>
  <div class="metric"><div class="val">S²</div><div class="desc">Every point is a 2-sphere</div></div>
</div>

With these five rules, you can read any Penrose diagram — from flat spacetime to rotating black holes.

## Four Fundamental Spacetimes

### Minkowski — The Diamond

Flat spacetime, no gravity. The diagram is a diamond with five boundary components: future and past timelike infinity (i⁺, i⁻) where massive particles end and begin; spatial infinity (i⁰) at the waist; and future and past null infinity (I⁺, I⁻) — the surfaces where light rays arrive and originate. Gravitational wave energy is defined precisely at I⁺, a concept that only becomes rigorous through Penrose's conformal boundary. The Bondi-Metzner-Sachs group (1962), which describes asymptotic symmetries at null infinity, turns out to be infinite-dimensional — much larger than the 10-dimensional Poincaré group of flat spacetime. This surprising structure was discovered through conformal methods.

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 460 500" xmlns="http://www.w3.org/2000/svg" style="max-width: 420px; width: 100%;">
  <defs>
    <marker id="arr" markerWidth="6" markerHeight="4" refX="6" refY="2" orient="auto">
      <polygon points="0 0, 6 2, 0 4" fill="var(--text-tertiary)"/>
    </marker>
  </defs>
  <polygon points="230,40 410,250 230,460 50,250" fill="var(--bg-secondary)" stroke="var(--blue-soft)" stroke-width="1.5" opacity="0.7"/>
  <line x1="230" y1="40" x2="410" y2="250" stroke="var(--red-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="230" y1="40" x2="50" y2="250" stroke="var(--red-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="50" y1="250" x2="230" y2="460" stroke="var(--blue-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="410" y1="250" x2="230" y2="460" stroke="var(--blue-soft)" stroke-width="2" opacity="0.7"/>
  <line x1="230" y1="450" x2="230" y2="50" stroke="var(--text-tertiary)" stroke-width="1" marker-end="url(#arr)" opacity="0.4"/>
  <line x1="60" y1="250" x2="400" y2="250" stroke="var(--text-tertiary)" stroke-width="1" marker-end="url(#arr)" opacity="0.4"/>
  <circle cx="230" cy="300" r="4" fill="var(--text-secondary)" opacity="0.9"/>
  <line x1="230" y1="300" x2="310" y2="220" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="5,4" opacity="0.5"/>
  <line x1="230" y1="300" x2="150" y2="220" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="5,4" opacity="0.5"/>
  <polygon points="230,300 310,220 150,220" fill="var(--text-tertiary)" opacity="0.06" stroke="none"/>
  <path d="M 230,420 Q 245,350 240,300 Q 235,250 230,80" fill="none" stroke="var(--text)" stroke-width="1.5" opacity="0.3" stroke-dasharray="2,3"/>
  <circle cx="230" cy="40" r="5" fill="var(--red-soft)"/>
  <text x="230" y="28" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--red-soft)" font-style="italic">i⁺</text>
  <text x="230" y="16" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">future timelike ∞</text>
  <circle cx="230" cy="460" r="5" fill="var(--blue-soft)"/>
  <text x="230" y="482" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic">i⁻</text>
  <text x="230" y="496" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">past timelike ∞</text>
  <circle cx="410" cy="250" r="5" fill="var(--text-secondary)"/>
  <text x="432" y="245" font-family="var(--font-body)" font-size="14" fill="var(--text-secondary)" font-style="italic">i⁰</text>
  <text x="432" y="260" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">spatial ∞</text>
  <circle cx="50" cy="250" r="5" fill="var(--text-secondary)"/>
  <text x="28" y="245" text-anchor="end" font-family="var(--font-body)" font-size="14" fill="var(--text-secondary)" font-style="italic">i⁰</text>
  <text x="340" y="135" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" transform="rotate(-45,340,135)">I⁺</text>
  <text x="120" y="135" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" transform="rotate(45,120,135)">I⁺</text>
  <text x="340" y="370" font-family="var(--font-body)" font-size="13" fill="var(--blue-soft)" font-style="italic" transform="rotate(45,340,370)">I⁻</text>
  <text x="120" y="370" font-family="var(--font-body)" font-size="13" fill="var(--blue-soft)" font-style="italic" transform="rotate(-45,120,370)">I⁻</text>
  <text x="316" y="216" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">light ray (45°)</text>
  <text x="245" y="314" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">event</text>
  <text x="236" y="62" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t</text>
  <text x="396" y="264" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">r</text>
  <text x="40" y="150" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)" transform="rotate(-90,40,150)">r = 0 (origin)</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Flat Minkowski spacetime. The diamond shape compresses all of infinite spacetime to a finite figure. Light cones are always at 45°. The five boundary components — i⁺, i⁻, i⁰, I⁺, I⁻ — encode the asymptotic structure.</div>
</div>

### Schwarzschild — The Zigzag Singularity

A non-rotating black hole. The diagram reveals what coordinates obscured for decades: the singularity at r = 0 is not a point in space — it's a moment in time. It appears as a horizontal zigzag line, meaning that once you cross the event horizon (a 45° line), the singularity lies in your future no matter which direction you move. You can't escape not because you can't run fast enough, but because all spatial directions point toward the singularity.

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 400" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <polygon points="160,40 300,200 160,200 160,40" fill="var(--blue-soft)" opacity="0.05" stroke="none"/>
  <polygon points="160,200 300,200 160,360 160,200" fill="var(--blue-soft)" opacity="0.05" stroke="none"/>
  <polygon points="20,40 160,40 160,200 20,200" fill="var(--red-soft)" opacity="0.05" stroke="none"/>
  <line x1="20" y1="40" x2="160" y2="40" stroke="var(--red-soft)" stroke-width="3"/>
  <path d="M 25,40 L 35,35 L 45,45 L 55,35 L 65,45 L 75,35 L 85,45 L 95,35 L 105,45 L 115,35 L 125,45 L 135,35 L 145,45 L 155,40" fill="none" stroke="var(--red-soft)" stroke-width="1.5"/>
  <text x="90" y="30" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--red-soft)">singularity (r = 0)</text>
  <line x1="160" y1="40" x2="160" y2="360" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <text x="172" y="120" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">event</text>
  <text x="172" y="132" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">horizon</text>
  <line x1="160" y1="40" x2="300" y2="200" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="300" y1="200" x2="160" y2="360" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="20" y1="200" x2="160" y2="360" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="20" y1="200" x2="20" y2="40" stroke="var(--red-soft)" stroke-width="1" opacity="0.3"/>
  <circle cx="300" cy="200" r="4" fill="var(--text-secondary)"/>
  <text x="310" y="203" font-family="var(--font-mono)" font-size="10" fill="var(--text-secondary)">i⁰</text>
  <circle cx="160" cy="360" r="4" fill="var(--blue-soft)"/>
  <text x="160" y="378" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--blue-soft)">i⁻</text>
  <text x="80" y="130" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--red-soft)" font-style="italic" opacity="0.6">II</text>
  <text x="80" y="148" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--red-soft)" opacity="0.4">inside BH</text>
  <text x="230" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.6">I</text>
  <text x="230" y="218" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--blue-soft)" opacity="0.4">exterior</text>
  <path d="M 250,320 Q 200,240 120,100" fill="none" stroke="var(--text)" stroke-width="1.2" opacity="0.3" stroke-dasharray="2,3"/>
  <text x="252" y="318" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">infalling</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Schwarzschild black hole. The event horizon is a dashed 45° line. Beyond it, all paths lead to the zigzag singularity at the top. There is no escape — not because you can't move fast enough, but because the singularity is in your future.</div>
</div>

The maximally extended solution — first found using Kruskal-Szekeres coordinates (1960) — reveals a white hole, a second universe, and an Einstein-Rosen bridge connecting them. The bridge closes faster than light can traverse it. Penrose diagrams added the crucial step of compactifying the asymptotic regions, making the full causal structure visible at a glance.

### De Sitter — The Square Universe

Positive cosmological constant, no matter — our Universe's approximate future as dark energy dominates. The diagram is a square with spacelike (horizontal) top and bottom boundaries: the universe begins and ends everywhere at once.

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 320" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <rect x="40" y="40" width="240" height="240" fill="var(--blue-soft)" opacity="0.04" stroke="var(--blue-soft)" stroke-width="1" stroke-opacity="0.2"/>
  <line x1="40" y1="40" x2="280" y2="40" stroke="var(--red-soft)" stroke-width="3" opacity="0.7"/>
  <line x1="40" y1="280" x2="280" y2="280" stroke="var(--blue-soft)" stroke-width="3" opacity="0.7"/>
  <line x1="160" y1="280" x2="160" y2="40" stroke="var(--text)" stroke-width="1.5" stroke-dasharray="4,4" opacity="0.25"/>
  <circle cx="160" cy="160" r="4" fill="var(--text)">
    <animate attributeName="r" values="3;5;3" dur="2s" repeatCount="indefinite"/>
  </circle>
  <line x1="40" y1="160" x2="160" y2="40" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="160" y1="40" x2="280" y2="160" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="40" y1="160" x2="160" y2="280" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="160" y1="280" x2="280" y2="160" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <text x="160" y="30" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--red-soft)">I⁺ (future ∞)</text>
  <text x="160" y="300" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--blue-soft)">I⁻ (past ∞)</text>
  <text x="100" y="100" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)" transform="rotate(-45,100,100)">horizon</text>
  <text x="160" y="155" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">observer</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">De Sitter spacetime. A square instead of a diamond. Top and bottom boundaries are spacelike — the universe begins and ends everywhere at once. Each observer is surrounded by a cosmological horizon.</div>
</div>

Every observer has a cosmological horizon: regions receding faster than light can never send signals that reach you. Since 1998, when Riess, Perlmutter, and Schmidt discovered the accelerating expansion (Nobel Prize 2011), we know our Universe is heading toward this de Sitter-like fate.

### Anti-de Sitter — The Vertical Strip

Negative cosmological constant. The diagram is a vertical strip with timelike (vertical) boundaries. Not our Universe — but arguably the most important spacetime in theoretical physics today.

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 380" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <rect x="80" y="30" width="160" height="320" fill="var(--blue-soft)" opacity="0.04" stroke="none"/>
  <line x1="80" y1="30" x2="80" y2="350" stroke="var(--purple-soft)" stroke-width="2.5" opacity="0.7"/>
  <line x1="240" y1="30" x2="240" y2="350" stroke="var(--purple-soft)" stroke-width="2.5" opacity="0.7"/>
  <line x1="80" y1="30" x2="240" y2="30" stroke="var(--blue-soft)" stroke-width="1" opacity="0.25"/>
  <line x1="80" y1="350" x2="240" y2="350" stroke="var(--blue-soft)" stroke-width="1" opacity="0.25"/>
  <path d="M 160,300 L 240,220 L 160,140 L 80,60" fill="none" stroke="var(--text-secondary)" stroke-width="1.2" stroke-dasharray="4,3" opacity="0.4"/>
  <circle cx="160" cy="300" r="3" fill="var(--text-secondary)" opacity="0.6"/>
  <text x="60" y="190" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--purple-soft)" font-style="italic" transform="rotate(-90,60,190)">boundary (CFT)</text>
  <text x="260" y="190" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--purple-soft)" font-style="italic" transform="rotate(90,260,190)">boundary (CFT)</text>
  <text x="160" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.5">AdS bulk</text>
  <text x="160" y="20" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t → +∞</text>
  <text x="160" y="368" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t → −∞</text>
  <text x="248" y="218" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">light "bounces"</text>
  <text x="248" y="230" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">off boundary</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Anti-de Sitter spacetime. A vertical strip. The sidewalls are timelike boundaries where the dual CFT lives. Light reaches the boundary in finite time and "bounces" back — the space acts like a box.</div>
</div>

In 1997, Juan Maldacena showed that quantum gravity in this space is exactly equivalent to a quantum field theory living on its boundary. This AdS/CFT correspondence — the [most cited result](https://arxiv.org/abs/hep-th/9711200) in high-energy physics history (20,000+ citations) — means that the vertical edges of the Penrose diagram are not just abstract boundaries. They are where the dual theory lives. Gravity in the bulk, quantum fields on the edge. The Penrose diagram makes this architecture visible.

## What These Diagrams Made Possible

<div class="timeline">
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1963</div>
    <div class="tl-title">Penrose introduces conformal compactification</div>
    <div class="tl-desc">A short note in Physical Review Letters, then three detailed lectures at Les Houches. The method is established.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1965</div>
    <div class="tl-title">The singularity theorem</div>
    <div class="tl-desc">Penrose proves that singularities are inevitable under realistic conditions. The Nobel Committee calls it "the most important contribution to general relativity since Einstein." The prize arrives 55 years later.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1970</div>
    <div class="tl-title">Penrose-Hawking singularity theorems</div>
    <div class="tl-desc">Hawking extends the method to cosmology: the Big Bang itself must contain a singularity. The universe began from a point of infinite density.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot"></div>
    <div class="tl-year">1973</div>
    <div class="tl-title">Hawking & Ellis publish the reference text</div>
    <div class="tl-desc">"The Large Scale Structure of Space-Time" establishes Penrose diagrams as the standard tool. The notation and conventions used to this day come from this book.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1973–75</div>
    <div class="tl-title">Black hole entropy and Hawking radiation</div>
    <div class="tl-desc">Bekenstein proposes entropy ∝ horizon area. Wheeler: "Your idea is just crazy enough to work." Hawking proves black holes radiate. The Penrose diagram of an evaporating black hole — singularity eventually disappearing — creates the information paradox.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1997</div>
    <div class="tl-title">AdS/CFT correspondence</div>
    <div class="tl-desc">Maldacena discovers that quantum gravity in Anti-de Sitter space equals a quantum field theory on its conformal boundary — the vertical edge of the Penrose diagram. At Strings '98, hundreds of physicists sang "The Maldacena" to the tune of the Macarena.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">2013</div>
    <div class="tl-title">ER = EPR</div>
    <div class="tl-desc">Maldacena and Susskind: Einstein-Rosen bridges (visible on Penrose diagrams) are equivalent to quantum entanglement. Spacetime geometry and quantum information may be two descriptions of the same thing.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">2015</div>
    <div class="tl-title">LIGO detects gravitational waves</div>
    <div class="tl-desc">Gravitational wave energy is defined at null infinity I⁺ — the boundary that Penrose diagrams made rigorous. The BMS asymptotic symmetry group, built on conformal methods, underlies the theoretical framework.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">2020</div>
    <div class="tl-title">Nobel Prize</div>
    <div class="tl-desc">Penrose, aged 89, receives half the Nobel Prize in Physics. The gap between discovery (1965) and recognition (2020) is 55 years — one of the longest in Nobel history.</div>
  </div>
</div>

## The Person Behind the Diagrams

<div class="highlight-box">
<strong>A visual mind across disciplines</strong>
Roger Penrose (born 1931) proposed the impossible triangle (conceived 1954, published 1958) and inspired M. C. Escher's <em>Waterfall</em> and <em>Ascending and Descending</em>. His aperiodic tilings (1974) presaged the discovery of quasicrystals. His singularity theorem used topology where others tried brute-force calculation. His conformal diagrams replaced pages of equations with a single picture. In every case, the breakthrough came from seeing structure that others described only algebraically.
</div>

Kip Thorne described Penrose's approach as "overlooking the detailed geometrical structure of spacetime and instead concentrating just on the topology of the space, or at most its conformal structure, since it is the latter — as determined by the lay of the lightcones — that determines the causal relationships." He shared the 1988 Wolf Prize with Stephen Hawking and won the Nobel at 89.

---

## References

- R. Penrose, *Phys. Rev. Lett.* **10**, 66 (1963) — conformal compactification
- R. Penrose, "Conformal Treatment of Infinity," in *Relativity, Groups and Topology*, Les Houches (1964), pp. 563–584
- R. Penrose, "Gravitational Collapse and Space-Time Singularities," *Phys. Rev. Lett.* **14**, 57 (1965) — Nobel Prize 2020
- S. W. Hawking, R. Penrose, *Proc. R. Soc. Lond. A* **314**, 529 (1970) — Penrose-Hawking theorems
- H. Bondi, M. G. J. van der Burg, A. W. K. Metzner, *Proc. R. Soc. Lond. A* **269**, 21 (1962) — BMS group
- S. W. Hawking, G. F. R. Ellis, *The Large Scale Structure of Space-Time*, Cambridge (1973)
- J. D. Bekenstein, *Phys. Rev. D* **7**, 2333 (1973) — black hole entropy
- S. W. Hawking, *Commun. Math. Phys.* **43**, 199 (1975) — Hawking radiation
- R. M. Wald, *General Relativity*, University of Chicago Press (1984)
- J. M. Maldacena, *Adv. Theor. Math. Phys.* **2**, 231 (1998) — [arXiv:hep-th/9711200](https://arxiv.org/abs/hep-th/9711200)
- J. M. Maldacena, L. Susskind, *Fortschr. Phys.* **61**, 781 (2013) — [arXiv:1306.0533](https://arxiv.org/abs/1306.0533) — ER = EPR
- Nobel Prize in Physics 2020, [Press Release](https://www.nobelprize.org/prizes/physics/2020/press-release/)
