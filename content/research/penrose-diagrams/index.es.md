---
title: "Diagramas de Penrose"
date: 2026-03-22
lastmod: 2026-03-23
version: "2.0"
status: "finished"
confidence: "certain"
description: "Cómo encajar un espacio-tiempo infinito en una hoja finita de papel — y por qué importa. Guía visual de diagramas conformes: Minkowski, Schwarzschild, de Sitter, anti-de Sitter."
tags: ["física", "relatividad-general", "diagramas-de-Penrose", "agujeros-negros", "cosmología"]
series: "Física: explicaciones"
ai_disclosure: "Investigación realizada con Claude (Anthropic). Dirección editorial y experiencia de dominio del autor."
license: "CC BY-NC 4.0"
---

El espacio-tiempo es infinito. La luz puede viajar eternamente. Un agujero negro comprime un punto hasta cero. ¿Cómo dibujar todo esto en una hoja finita?

La respuesta de Roger Penrose, desarrollada a principios de la década de 1960: compactificación conforme. Una transformación matemática que comprime el infinito en puntos y líneas finitos, preservando lo único que importa para la física de la causalidad — la estructura de los conos de luz.

Esta única herramienta demostró ser tan poderosa que ahora aparece en prácticamente todos los grandes resultados de la relatividad general — desde los teoremas de singularidad hasta el principio holográfico, desde la clasificación de espacio-tiempos hasta la prueba de que las ondas gravitacionales transportan energía.

## El problema

Hacia principios de los 1960, la relatividad general estaba en crisis. Karl Schwarzschild encontró su solución de agujero negro en 1916, pero asumía simetría esférica perfecta. La mayoría de los físicos, incluido Einstein, creían que cualquier desviación de la simetría impediría la formación de singularidades. ¿Existen realmente los agujeros negros, o son solo artefactos matemáticos? La pregunta permaneció abierta durante casi 50 años.

El problema: las herramientas existentes no podían manejar la estructura global del espacio-tiempo. Para entender qué sucede "en el infinito" — dónde terminan los rayos de luz, cuál es el destino de la materia en colapso — se necesitaba ver todo el espacio-tiempo de una vez.

## La idea

La técnica se consolidó en tres momentos: una nota de 1963 en *Physical Review Letters*, tres conferencias detalladas en la Escuela de Verano de Les Houches ese mismo año, y el teorema de singularidad de 1965 que el Comité Nobel llamaría "la contribución más importante a la relatividad general desde Einstein."

La clave del teorema llegó a Penrose durante un paseo con su colega Ivor Robinson en Londres, otoño de 1964. Al llegar a un cruce, dejaron de hablar para vigilar el tráfico, y en ese momento la idea de "superficies atrapadas" surgió en su mente. Esta idea, combinada con los métodos conformes, demostró que las singularidades son inevitables en la relatividad general.

## Cómo funciona

Si solo importa la causalidad, no es necesario preservar distancias — basta con preservar los conos de luz. Una transformación conforme reescala la métrica por un factor Ω², manteniendo los ángulos invariantes. La luz sigue viajando a 45°. El infinito se comprime en una frontera finita. El espacio-tiempo infinito cabe en un diagrama finito con su estructura causal intacta.

## Cinco reglas para todos los diagramas

<div class="metrics">
  <div class="metric"><div class="val">↑</div><div class="desc">El tiempo fluye hacia arriba</div></div>
  <div class="metric"><div class="val">↔</div><div class="desc">El espacio se extiende horizontalmente</div></div>
  <div class="metric"><div class="val">45°</div><div class="desc">La luz siempre viaja a 45°</div></div>
  <div class="metric"><div class="val">&gt;45°</div><div class="desc">Cuerpos masivos: trayectorias más inclinadas</div></div>
  <div class="metric"><div class="val">S²</div><div class="desc">Cada punto es una 2-esfera</div></div>
</div>

## Cuatro espacio-tiempos fundamentales

### Minkowski — El rombo

Espacio-tiempo plano sin gravedad. El diagrama es un rombo con cinco componentes de frontera: infinitos temporal futuro y pasado (i⁺, i⁻) donde las partículas masivas terminan y comienzan; infinito espacial (i⁰) en la cintura; e infinitos nulos futuro y pasado (I⁺, I⁻) — las superficies donde los rayos de luz llegan y se originan. La energía de las ondas gravitacionales se define con precisión en I⁺, un concepto que solo se hace riguroso a través de la frontera conforme de Penrose. El grupo de Bondi-Metzner-Sachs (1962), que describe las simetrías asintóticas en el infinito nulo, resulta ser de dimensión infinita — mucho mayor que el grupo de Poincaré de 10 dimensiones del espacio-tiempo plano. Esta sorprendente estructura fue descubierta mediante métodos conformes.

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
  <text x="230" y="16" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">∞ temporal futura</text>
  <circle cx="230" cy="460" r="5" fill="var(--blue-soft)"/>
  <text x="230" y="482" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic">i⁻</text>
  <text x="230" y="496" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">∞ temporal pasada</text>
  <circle cx="410" cy="250" r="5" fill="var(--text-secondary)"/>
  <text x="432" y="245" font-family="var(--font-body)" font-size="14" fill="var(--text-secondary)" font-style="italic">i⁰</text>
  <text x="432" y="260" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">∞ espacial</text>
  <circle cx="50" cy="250" r="5" fill="var(--text-secondary)"/>
  <text x="28" y="245" text-anchor="end" font-family="var(--font-body)" font-size="14" fill="var(--text-secondary)" font-style="italic">i⁰</text>
  <text x="340" y="135" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" transform="rotate(-45,340,135)">I⁺</text>
  <text x="120" y="135" font-family="var(--font-body)" font-size="13" fill="var(--red-soft)" font-style="italic" transform="rotate(45,120,135)">I⁺</text>
  <text x="340" y="370" font-family="var(--font-body)" font-size="13" fill="var(--blue-soft)" font-style="italic" transform="rotate(45,340,370)">I⁻</text>
  <text x="120" y="370" font-family="var(--font-body)" font-size="13" fill="var(--blue-soft)" font-style="italic" transform="rotate(-45,120,370)">I⁻</text>
  <text x="316" y="216" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">rayo de luz (45°)</text>
  <text x="245" y="314" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">evento</text>
  <text x="236" y="62" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t</text>
  <text x="396" y="264" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">r</text>
  <text x="40" y="150" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)" transform="rotate(-90,40,150)">r = 0 (origen)</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Espacio-tiempo plano de Minkowski. La forma de rombo comprime todo el espacio-tiempo infinito en una figura finita. Los conos de luz siempre están a 45°. Los cinco componentes de frontera — i⁺, i⁻, i⁰, I⁺, I⁻ — codifican la estructura asintótica.</div>
</div>

### Schwarzschild — La singularidad en zigzag

Agujero negro sin rotación. El diagrama revela lo que las coordenadas ocultaron durante décadas: la singularidad en r = 0 no es un punto en el espacio — es un momento en el tiempo. Aparece como una línea horizontal en zigzag, lo que significa que una vez cruzado el horizonte de eventos (una línea a 45°), la singularidad yace en tu futuro sin importar la dirección en que te muevas. No puedes escapar, no porque no puedas correr lo suficientemente rápido, sino porque todas las direcciones espaciales apuntan hacia la singularidad.

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 400" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <polygon points="160,40 300,200 160,200 160,40" fill="var(--blue-soft)" opacity="0.05" stroke="none"/>
  <polygon points="160,200 300,200 160,360 160,200" fill="var(--blue-soft)" opacity="0.05" stroke="none"/>
  <polygon points="20,40 160,40 160,200 20,200" fill="var(--red-soft)" opacity="0.05" stroke="none"/>
  <line x1="20" y1="40" x2="160" y2="40" stroke="var(--red-soft)" stroke-width="3"/>
  <path d="M 25,40 L 35,35 L 45,45 L 55,35 L 65,45 L 75,35 L 85,45 L 95,35 L 105,45 L 115,35 L 125,45 L 135,35 L 145,45 L 155,40" fill="none" stroke="var(--red-soft)" stroke-width="1.5"/>
  <text x="90" y="30" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--red-soft)">singularidad (r = 0)</text>
  <line x1="160" y1="40" x2="160" y2="360" stroke="var(--text-secondary)" stroke-width="1.5" stroke-dasharray="6,4"/>
  <text x="172" y="120" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">horizonte</text>
  <text x="172" y="132" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">de eventos</text>
  <line x1="160" y1="40" x2="300" y2="200" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="300" y1="200" x2="160" y2="360" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="20" y1="200" x2="160" y2="360" stroke="var(--blue-soft)" stroke-width="1" opacity="0.4"/>
  <line x1="20" y1="200" x2="20" y2="40" stroke="var(--red-soft)" stroke-width="1" opacity="0.3"/>
  <circle cx="300" cy="200" r="4" fill="var(--text-secondary)"/>
  <text x="310" y="203" font-family="var(--font-mono)" font-size="10" fill="var(--text-secondary)">i⁰</text>
  <circle cx="160" cy="360" r="4" fill="var(--blue-soft)"/>
  <text x="160" y="378" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--blue-soft)">i⁻</text>
  <text x="80" y="130" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--red-soft)" font-style="italic" opacity="0.6">II</text>
  <text x="80" y="148" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--red-soft)" opacity="0.4">dentro del AN</text>
  <text x="230" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.6">I</text>
  <text x="230" y="218" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--blue-soft)" opacity="0.4">exterior</text>
  <path d="M 250,320 Q 200,240 120,100" fill="none" stroke="var(--text)" stroke-width="1.2" opacity="0.3" stroke-dasharray="2,3"/>
  <text x="252" y="318" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">en caída</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Agujero negro de Schwarzschild. El horizonte de eventos es una línea discontinua a 45°. Más allá, todos los caminos conducen a la singularidad en zigzag de arriba. No hay escape — no porque no puedas moverte lo suficientemente rápido, sino porque la singularidad está en tu futuro.</div>
</div>

La solución maximalmente extendida — encontrada por primera vez usando coordenadas de Kruskal-Szekeres (1960) — revela un agujero blanco, un segundo universo y un puente de Einstein-Rosen que los conecta. El puente se cierra más rápido de lo que la luz puede recorrerlo. Los diagramas de Penrose añadieron el paso crucial de compactificar las regiones asintóticas, haciendo visible de un vistazo la estructura causal completa.

### De Sitter — El universo cuadrado

Constante cosmológica positiva, sin materia — el futuro aproximado de nuestro Universo a medida que la energía oscura domina. El diagrama es un cuadrado con fronteras espaciales (horizontales) superior e inferior: el universo comienza y termina en todas partes simultáneamente.

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
  <text x="160" y="30" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--red-soft)">I⁺ (∞ futura)</text>
  <text x="160" y="300" text-anchor="middle" font-family="var(--font-mono)" font-size="10" fill="var(--blue-soft)">I⁻ (∞ pasada)</text>
  <text x="100" y="100" text-anchor="middle" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)" transform="rotate(-45,100,100)">horizonte</text>
  <text x="160" y="155" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-secondary)">observador</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Espacio-tiempo de Sitter. Un cuadrado en lugar de un rombo. Las fronteras superior e inferior son espaciales — el universo comienza y termina en todas partes simultáneamente. Cada observador está rodeado por un horizonte cosmológico.</div>
</div>

Cada observador tiene un horizonte cosmológico: las regiones que se alejan más rápido que la luz nunca pueden enviar señales que te alcancen. Desde 1998, cuando Riess, Perlmutter y Schmidt descubrieron la expansión acelerada (Premio Nobel 2011), sabemos que nuestro Universo se dirige hacia este destino tipo de Sitter.

### Anti-de Sitter — La franja vertical

Constante cosmológica negativa. El diagrama es una franja vertical con fronteras temporales (verticales). No es nuestro Universo — pero posiblemente el espacio-tiempo más importante de la física teórica actual.

<div style="text-align:center; margin: 2rem 0; padding: 1.5rem; background: var(--bg-secondary); border: 1px solid var(--border); border-radius: 8px;">
<svg viewBox="0 0 320 380" xmlns="http://www.w3.org/2000/svg" style="max-width: 300px; width: 100%;">
  <rect x="80" y="30" width="160" height="320" fill="var(--blue-soft)" opacity="0.04" stroke="none"/>
  <line x1="80" y1="30" x2="80" y2="350" stroke="var(--purple-soft)" stroke-width="2.5" opacity="0.7"/>
  <line x1="240" y1="30" x2="240" y2="350" stroke="var(--purple-soft)" stroke-width="2.5" opacity="0.7"/>
  <line x1="80" y1="30" x2="240" y2="30" stroke="var(--blue-soft)" stroke-width="1" opacity="0.25"/>
  <line x1="80" y1="350" x2="240" y2="350" stroke="var(--blue-soft)" stroke-width="1" opacity="0.25"/>
  <path d="M 160,300 L 240,220 L 160,140 L 80,60" fill="none" stroke="var(--text-secondary)" stroke-width="1.2" stroke-dasharray="4,3" opacity="0.4"/>
  <circle cx="160" cy="300" r="3" fill="var(--text-secondary)" opacity="0.6"/>
  <text x="60" y="190" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--purple-soft)" font-style="italic" transform="rotate(-90,60,190)">frontera (CFT)</text>
  <text x="260" y="190" text-anchor="middle" font-family="var(--font-body)" font-size="13" fill="var(--purple-soft)" font-style="italic" transform="rotate(90,260,190)">frontera (CFT)</text>
  <text x="160" y="200" text-anchor="middle" font-family="var(--font-body)" font-size="14" fill="var(--blue-soft)" font-style="italic" opacity="0.5">bulk AdS</text>
  <text x="160" y="20" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t → +∞</text>
  <text x="160" y="368" text-anchor="middle" font-family="var(--font-mono)" font-size="9" fill="var(--text-tertiary)">t → −∞</text>
  <text x="248" y="218" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">la luz «rebota»</text>
  <text x="248" y="230" font-family="var(--font-mono)" font-size="8" fill="var(--text-tertiary)">en la frontera</text>
</svg>
<div style="font-size: 0.78rem; color: var(--text-tertiary); margin-top: 0.5rem;">Espacio-tiempo anti-de Sitter. Una franja vertical. Las paredes laterales son fronteras temporales donde vive la CFT dual. La luz alcanza la frontera en tiempo finito y «rebota» — el espacio actúa como una caja.</div>
</div>

En 1997, Juan Maldacena demostró que la gravedad cuántica en este espacio es exactamente equivalente a una teoría de campos cuánticos que vive en su frontera. Esta correspondencia AdS/CFT — el [resultado más citado](https://arxiv.org/abs/hep-th/9711200) en la historia de la física de altas energías (20.000+ citas) — significa que los bordes verticales del diagrama de Penrose no son solo fronteras abstractas. Son donde vive la teoría dual. Gravedad en el bulk, campos cuánticos en el borde. El diagrama de Penrose hace visible esta arquitectura.

## Lo que hicieron posible estos diagramas

<div class="timeline">
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1963</div>
    <div class="tl-title">Penrose introduce la compactificación conforme</div>
    <div class="tl-desc">Una breve nota en Physical Review Letters, seguida de tres conferencias detalladas en Les Houches. El método queda establecido.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1965</div>
    <div class="tl-title">El teorema de singularidad</div>
    <div class="tl-desc">Penrose demuestra que las singularidades son inevitables bajo condiciones realistas. El Comité Nobel lo llama "la contribución más importante a la relatividad general desde Einstein." El premio llega 55 años después.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1970</div>
    <div class="tl-title">Teoremas de singularidad Penrose-Hawking</div>
    <div class="tl-desc">Hawking extiende el método a la cosmología: el Big Bang mismo debe contener una singularidad. El universo comenzó a partir de un punto de densidad infinita.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot"></div>
    <div class="tl-year">1973</div>
    <div class="tl-title">Hawking y Ellis publican el texto de referencia</div>
    <div class="tl-desc">"The Large Scale Structure of Space-Time" establece los diagramas de Penrose como la herramienta estándar. La notación y las convenciones utilizadas hasta hoy provienen de este libro.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1973–75</div>
    <div class="tl-title">Entropía de agujeros negros y radiación de Hawking</div>
    <div class="tl-desc">Bekenstein propone entropía ∝ área del horizonte. Wheeler: "Tu idea es lo bastante loca para funcionar." Hawking demuestra que los agujeros negros radian. El diagrama de Penrose de un agujero negro en evaporación — la singularidad desapareciendo eventualmente — crea la paradoja de la información.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">1997</div>
    <div class="tl-title">Correspondencia AdS/CFT</div>
    <div class="tl-desc">Maldacena descubre que la gravedad cuántica en el espacio anti-de Sitter es igual a una teoría de campos cuánticos en su frontera conforme — el borde vertical del diagrama de Penrose. En Strings '98, cientos de físicos cantaron "The Maldacena" con la melodía de la Macarena.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">2013</div>
    <div class="tl-title">ER = EPR</div>
    <div class="tl-desc">Maldacena y Susskind: los puentes de Einstein-Rosen (visibles en diagramas de Penrose) son equivalentes al entrelazamiento cuántico. La geometría del espacio-tiempo y la información cuántica podrían ser dos descripciones de lo mismo.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">2015</div>
    <div class="tl-title">LIGO detecta ondas gravitacionales</div>
    <div class="tl-desc">La energía de las ondas gravitacionales se define en el infinito nulo I⁺ — la frontera que los diagramas de Penrose hicieron rigurosa. El grupo de simetría asintótica BMS, construido sobre métodos conformes, subyace al marco teórico.</div>
  </div>
  <div class="tl-item">
    <div class="tl-dot tl-dot--green"></div>
    <div class="tl-year">2020</div>
    <div class="tl-title">Premio Nobel</div>
    <div class="tl-desc">Penrose, de 89 años, recibe la mitad del Premio Nobel de Física. La distancia entre descubrimiento (1965) y reconocimiento (2020) es de 55 años — una de las más largas en la historia del Nobel.</div>
  </div>
</div>

## La persona detrás de los diagramas

<div class="highlight-box">
<strong>Una mente visual entre disciplinas</strong>
Roger Penrose (n. 1931) propuso el triángulo imposible (concebido en 1954, publicado en 1958) e inspiró las obras de M. C. Escher <em>Cascada</em> y <em>Subiendo y bajando</em>. Sus mosaicos aperiódicos (1974) anticiparon el descubrimiento de los cuasicristales. Su teorema de singularidad usó topología donde otros intentaron cálculos de fuerza bruta. Sus diagramas conformes reemplazaron páginas de ecuaciones por una sola imagen. En cada caso, el avance surgió de ver estructura donde otros solo describían algebraicamente.
</div>

Kip Thorne describió el enfoque de Penrose como "pasar por alto la estructura geométrica detallada del espacio-tiempo y concentrarse únicamente en la topología del espacio, o a lo sumo en su estructura conforme, ya que es esta última — determinada por la disposición de los conos de luz — la que determina las relaciones causales." Compartió el Premio Wolf 1988 con Stephen Hawking y ganó el Nobel a los 89 años.

---

## Referencias

- R. Penrose, *Phys. Rev. Lett.* **10**, 66 (1963)
- R. Penrose, "Conformal Treatment of Infinity," Les Houches (1964)
- R. Penrose, *Phys. Rev. Lett.* **14**, 57 (1965) — Premio Nobel 2020
- S. W. Hawking, R. Penrose, *Proc. R. Soc. Lond. A* **314**, 529 (1970)
- S. W. Hawking, G. F. R. Ellis, *The Large Scale Structure of Space-Time*, Cambridge (1973)
- J. D. Bekenstein, *Phys. Rev. D* **7**, 2333 (1973)
- S. W. Hawking, *Commun. Math. Phys.* **43**, 199 (1975)
- R. M. Wald, *General Relativity*, University of Chicago Press (1984)
- J. M. Maldacena, *Adv. Theor. Math. Phys.* **2**, 231 (1998) — [arXiv:hep-th/9711200](https://arxiv.org/abs/hep-th/9711200)
- Nobel Prize in Physics 2020, [comunicado de prensa](https://www.nobelprize.org/prizes/physics/2020/press-release/)
