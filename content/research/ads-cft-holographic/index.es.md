---
title: "El universo como holograma"
date: 2026-03-22
lastmod: 2026-03-23
version: "2.0"
status: "finished"
confidence: "likely"
description: "Correspondencia AdS/CFT y el principio holográfico: ¿podría todo lo que percibimos como realidad ser una proyección desde una superficie lejana?"
tags: ["física", "principio-holográfico", "AdS-CFT", "gravedad-cuántica", "cosmología"]
series: "Física: explicaciones"
ai_disclosure: "Investigación realizada con Claude (Anthropic). Dirección editorial y experiencia de dominio del autor."
license: "CC BY-NC 4.0"
---

En 1997, Juan Maldacena — un físico argentino de 29 años, un año después de su doctorado en Princeton y recién nombrado profesor en Harvard — publicó lo que se convertiría en el artículo más citado en la historia de la física de altas energías. Más de 20.000 citas hasta la fecha, aproximadamente dos por día durante más de dos décadas.

Demostró que la gravedad cuántica en un espacio-tiempo acotado y con curvatura negativa es matemáticamente idéntica a una teoría cuántica de campos en su frontera — sin gravedad y con una dimensión menos. Todo lo que sucede en el interior está completamente codificado en el borde. Como un holograma.

Esta es la correspondencia AdS/CFT. No solo resolvió un problema. Creó un campo entero.

## El origen: un doctorando contra todos

La historia comienza con Jacob Bekenstein, un estudiante de doctorado en Princeton a principios de los 1970. Su asesor, John Wheeler, planteó un experimento mental: ¿qué sucede con la entropía de una taza de té si la arrojas a un agujero negro? Bekenstein respondió: los agujeros negros mismos tienen entropía, proporcional al área del horizonte de eventos — no al volumen. Publicó esto en 1973. La comunidad lo rechazó. Como escribió Kip Thorne: "Todos los expertos del mundo se alinearon con Hawking." La excepción fue Wheeler: *"Tu idea es lo bastante loca para ser correcta."*

<div class="highlight-box">
<strong>S = A / 4</strong>
La fórmula de Bekenstein-Hawking: la entropía de un agujero negro es un cuarto del área de su horizonte en unidades de Planck. La ecuación más compacta de la física conectando gravedad, mecánica cuántica y termodinámica.
</div>

Dos años después, Hawking — que intentaba refutar a Bekenstein — demostró que los agujeros negros emiten radiación térmica. Esto confirmó la fórmula y estableció la termodinámica de agujeros negros como física real. Pero el mensaje profundo era: si la entropía máxima escala con el área y no con el volumen, la información está en la frontera. Como si el interior fuera una proyección.

## El principio holográfico y AdS/CFT

En los 1990, 't Hooft y Susskind propusieron el principio holográfico: toda la información de un volumen puede codificarse en su superficie. Pero era un principio sin prueba. Eso cambió en noviembre de 1997.

<div class="metrics">
  <div class="metric"><div class="val val--blue">10⁻⁶⁶ cm²</div><div class="desc">Área de Planck — límite de 1 bit</div></div>
  <div class="metric"><div class="val val--green">S = A/4</div><div class="desc">Entropía = cuarto del área</div></div>
  <div class="metric"><div class="val val--yellow">20.000+</div><div class="desc">Citas del artículo de Maldacena</div></div>
  <div class="metric"><div class="val val--red">~2/día</div><div class="desc">Tasa de citación, 27 años</div></div>
</div>

Maldacena mostró que la teoría de cuerdas en AdS 5-dimensional es equivalente a una teoría conforme de Yang-Mills en la frontera 4-dimensional. Cada objeto tiene su contraparte exacta. La clave: cuando la teoría frontera es fuertemente acoplada (difícil), la descripción del volumen es débilmente acoplada (fácil), y viceversa.

<div class="compare">
  <div class="compare-col col-a">
    <h4>Volumen (AdS)</h4>
    <div class="compare-item"><strong>Gravedad</strong><span>Ecuaciones de Einstein con Λ negativa</span></div>
    <div class="compare-item"><strong>Agujero negro</strong><span>Horizonte de eventos</span></div>
    <div class="compare-item"><strong>Acoplamiento débil</strong><span>Gravedad clásica</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Frontera (CFT)</h4>
    <div class="compare-item"><strong>Sin gravedad</strong><span>Teoría cuántica de campos</span></div>
    <div class="compare-item"><strong>Estado térmico</strong><span>Temperatura finita</span></div>
    <div class="compare-item"><strong>Acoplamiento fuerte</strong><span>Régimen no perturbativo</span></div>
  </div>
</div>

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 500 300" xmlns="http://www.w3.org/2000/svg" style="max-width: 460px; width: 100%;">
  <defs>
    <radialGradient id="bulkG" cx="50%" cy="50%"><stop offset="0%" stop-color="var(--blue-soft)" stop-opacity="0.12"/><stop offset="100%" stop-color="var(--blue-soft)" stop-opacity="0"/></radialGradient>
  </defs>
  <ellipse cx="250" cy="150" rx="180" ry="110" fill="url(#bulkG)" stroke="var(--border)" stroke-width="1" stroke-dasharray="4,4"/>
  <path d="M 120 150 Q 250 90 380 150" fill="none" stroke="var(--border-light)" stroke-width="1"/>
  <path d="M 120 150 Q 250 210 380 150" fill="none" stroke="var(--border-light)" stroke-width="1"/>
  <path d="M 250 45 Q 200 150 250 255" fill="none" stroke="var(--border-light)" stroke-width="1"/>
  <path d="M 250 45 Q 300 150 250 255" fill="none" stroke="var(--border-light)" stroke-width="1"/>
  <ellipse cx="250" cy="150" rx="180" ry="110" fill="none" stroke="var(--blue-soft)" stroke-width="2.5"/>
  <circle cx="200" cy="130" r="6" fill="var(--purple-soft)" opacity="0.9"/>
  <text x="215" y="125" font-family="var(--font-mono)" font-size="9" fill="var(--purple-soft)">agujero negro</text>
  <text x="215" y="137" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">en el bulk (d+1)</text>
  <circle cx="400" cy="95" r="4" fill="var(--red-soft)" opacity="0.9"/>
  <line x1="206" y1="127" x2="396" y2="95" stroke="var(--red-soft)" stroke-width="1" stroke-dasharray="3,3" opacity="0.4"/>
  <text x="250" y="157" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--text-tertiary)" font-style="italic">AdS</text>
  <text x="250" y="173" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">gravedad · d+1 dimensiones</text>
  <text x="250" y="282" text-anchor="middle" font-family="var(--font-body)" font-size="12" fill="var(--blue-soft)">CFT en la frontera</text>
  <text x="250" y="296" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">teoría cuántica de campos · d dimensiones · sin gravedad</text>
  <text x="410" y="88" font-family="var(--font-mono)" font-size="9" fill="var(--red-soft)">estado térmico</text>
  <text x="410" y="100" font-family="var(--font-mono)" font-size="9" fill="var(--red-soft)">in CFT</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Bulk ↔ Frontera: un agujero negro en el volumen AdS = un estado térmico en la teoría cuántica de la frontera.</div>
</div>

En Strings '98, Jeff Harvey lideró a cientos de físicos cantando "The Maldacena" (parodia de la Macarena): *"You start with the brane and the brane is BPS / Then you go near the brane and the space is AdS / Ehhhh, Maldacena!"*

## Espacio-tiempo desde el entrelazamiento

Ryu y Takayanagi (2006): la entropía de entrelazamiento en la frontera = área de una superficie mínima en el volumen. Van Raamsdonk (2010): eliminar entrelazamiento hace que el espacio-tiempo se desconecte. Maldacena y Susskind (2013):

<div class="highlight-box">
<strong>ER = EPR</strong>
Puentes de Einstein-Rosen (agujeros de gusano) = pares Einstein-Podolsky-Rosen (partículas entrelazadas). Geometría = entrelazamiento. Relatividad general y mecánica cuántica podrían ser dos descripciones de la misma realidad.
</div>

## El problema: nuestro Universo no es AdS

<div class="psych-grid">
  <div class="psych-card"><h4>AdS (Λ &lt; 0)</h4><p>Curvatura negativa. Tiene frontera. AdS/CFT funciona. No es nuestro Universo.</p><div class="big">✓ resuelto</div></div>
  <div class="psych-card"><h4>dS (Λ &gt; 0)</h4><p>Curvatura positiva. Nuestro Universo. Sin frontera convencional. Holografía incierta.</p><div class="big">? abierto</div></div>
</div>

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 400 340" xmlns="http://www.w3.org/2000/svg" style="max-width: 380px; width: 100%;">
  <polygon points="200,30 370,170 200,310 30,170" fill="var(--blue-soft)" opacity="0.04" stroke="var(--blue-soft)" stroke-width="1" stroke-opacity="0.15"/>
  <line x1="80" y1="30" x2="320" y2="30" stroke="var(--red-soft)" stroke-width="3" opacity="0.7"/>
  <line x1="80" y1="310" x2="320" y2="310" stroke="var(--blue-soft)" stroke-width="3" opacity="0.7"/>
  <text x="200" y="20" text-anchor="middle" font-family="var(--font-mono)" font-size="11" fill="var(--red-soft)">I⁺ (infinito futuro)</text>
  <text x="200" y="332" text-anchor="middle" font-family="var(--font-mono)" font-size="11" fill="var(--blue-soft)">I⁻ (infinito pasado)</text>
  <line x1="200" y1="310" x2="200" y2="30" stroke="var(--text)" stroke-width="1.5" stroke-dasharray="4,4" opacity="0.25"/>
  <circle cx="200" cy="170" r="4" fill="var(--text)">
    <animate attributeName="r" values="3;5;3" dur="2s" repeatCount="indefinite"/>
  </circle>
  <text x="215" y="167" font-family="var(--font-mono)" font-size="10" fill="var(--text-secondary)">nosotros</text>
  <line x1="30" y1="170" x2="200" y2="30" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="200" y1="30" x2="370" y2="170" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="30" y1="170" x2="200" y2="310" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <line x1="200" y1="310" x2="370" y2="170" stroke="var(--text-secondary)" stroke-width="1" opacity="0.35"/>
  <text x="100" y="90" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--text-tertiary)" transform="rotate(-45, 100, 90)">horizonte</text>
  <text x="200" y="55" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" opacity="0.6">CFT ?</text>
  <text x="200" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.4">dS bulk</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Diagrama de Penrose del espacio-tiempo de Sitter. El observador "nosotros" ve solo parte del espacio. Una hipotética CFT vive en I⁺ — en el infinito futuro. A diferencia de AdS, esta frontera es espacial, no temporal.</div>
</div>

Tenemos una descripción holográfica completa de un universo que no es el nuestro, y ninguna del que sí lo es. Esta es la pregunta central abierta del campo.

## Línea temporal

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1973</div><div class="tl-title">Bekenstein: entropía ∝ área</div><div class="tl-desc">Un doctorando propone que la información está en la frontera. Casi todos discrepan.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1975</div><div class="tl-title">Radiación de Hawking</div><div class="tl-desc">S = A/4 establecida. Nace la paradoja de la información.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">1993–95</div><div class="tl-title">Principio holográfico</div><div class="tl-desc">'t Hooft y Susskind: la información escala con el área, no el volumen.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1997</div><div class="tl-title">Maldacena publica AdS/CFT</div><div class="tl-desc">Primera realización concreta del principio holográfico.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2006</div><div class="tl-title">Fórmula Ryu-Takayanagi</div><div class="tl-desc">Entrelazamiento en la frontera = área en el volumen.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2010</div><div class="tl-title">Van Raamsdonk: espacio-tiempo desde entrelazamiento</div><div class="tl-desc">Sin entrelazamiento → el espacio-tiempo se desconecta.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2013</div><div class="tl-title">ER = EPR</div><div class="tl-desc">Agujeros de gusano = entrelazamiento. Geometría = información cuántica.</div></div>
</div>

---

## Referencias

- J. D. Bekenstein, *Phys. Rev. D* **7**, 2333 (1973)
- S. W. Hawking, *Commun. Math. Phys.* **43**, 199 (1975)
- J. M. Maldacena, *Adv. Theor. Math. Phys.* **2**, 231 (1998) — [arXiv:hep-th/9711200](https://arxiv.org/abs/hep-th/9711200)
- S. Ryu, T. Takayanagi, *Phys. Rev. Lett.* **96**, 181602 (2006) — [arXiv:hep-th/0603001](https://arxiv.org/abs/hep-th/0603001)
- M. Van Raamsdonk, *Gen. Rel. Grav.* **42**, 2323 (2010) — [arXiv:1005.3035](https://arxiv.org/abs/1005.3035)
- J. M. Maldacena, L. Susskind, *Fortschr. Phys.* **61**, 781 (2013) — [arXiv:1306.0533](https://arxiv.org/abs/1306.0533)
