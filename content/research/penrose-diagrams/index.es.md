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

<div style="margin: 2rem 0; padding: 1.5rem; border: 1px solid var(--border-color); border-radius: 8px; background: var(--bg-secondary);">

**[Abrir la guía visual interactiva →](/research/penrose-diagrams/infographic.html)**

6 secciones con diagramas SVG anotados y referencias completas. Atlas interactivo de 4 espacio-tiempos.

</div>

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

**Minkowski — El rombo.** Espacio-tiempo plano sin gravedad. Cinco componentes de frontera: infinitos temporal futuro y pasado (i⁺, i⁻), infinito espacial (i⁰), e infinitos nulos futuro y pasado (I⁺, I⁻). La energía de las ondas gravitacionales se define en I⁺ — concepto que solo se hace riguroso a través de la frontera conforme de Penrose.

**Schwarzschild — La singularidad en zigzag.** Agujero negro sin rotación. El diagrama revela que la singularidad en r = 0 no es un punto en el espacio sino un momento en el tiempo. Una vez cruzado el horizonte de eventos (línea a 45°), la singularidad yace en tu futuro sin importar la dirección. La extensión máxima revela el puente de Einstein-Rosen: una conexión con una segunda región asintóticamente plana que se cierra más rápido que la luz.

**De Sitter — El universo cuadrado.** Constante cosmológica positiva — el futuro aproximado de nuestro Universo. Diagrama cuadrado con fronteras espaciales: el universo comienza y termina en todas partes simultáneamente. Desde 1998, sabemos que nuestro Universo se dirige hacia un futuro de Sitter (Nobel 2011).

**Anti-de Sitter — La franja vertical.** Constante cosmológica negativa. Fronteras temporales verticales. En 1997, Maldacena demostró que la gravedad cuántica en este espacio es equivalente a una teoría de campos cuánticos en su frontera — la [correspondencia AdS/CFT](/research/ads-cft-holographic/), el resultado más citado en la historia de la física de altas energías (20.000+ citas). Los bordes verticales del diagrama de Penrose son donde vive la teoría dual.

## Línea temporal

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1963</div><div class="tl-title">Penrose introduce la compactificación conforme</div><div class="tl-desc">Physical Review Letters + Les Houches.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1965</div><div class="tl-title">Teorema de singularidad</div><div class="tl-desc">"La contribución más importante a la relatividad general desde Einstein." Nobel 55 años después.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1970</div><div class="tl-title">Teoremas Penrose-Hawking</div><div class="tl-desc">Hawking extiende el método a la cosmología: el Big Bang contiene una singularidad.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1973–75</div><div class="tl-title">Entropía y radiación de Hawking</div><div class="tl-desc">Bekenstein: entropía ∝ área. Wheeler: "Tu idea es lo bastante loca para ser correcta." Hawking confirma: los agujeros negros radian.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">1997</div><div class="tl-title">Correspondencia AdS/CFT</div><div class="tl-desc">Maldacena: gravedad cuántica en AdS = teoría de campos en la frontera del diagrama de Penrose.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2013</div><div class="tl-title">ER = EPR</div><div class="tl-desc">Puentes de Einstein-Rosen (visibles en diagramas de Penrose) = entrelazamiento cuántico.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2015</div><div class="tl-title">LIGO detecta ondas gravitacionales</div><div class="tl-desc">La energía de las ondas se define en I⁺ — la frontera que los diagramas de Penrose hicieron rigurosa.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2020</div><div class="tl-title">Premio Nobel</div><div class="tl-desc">Penrose, 89 años. 55 años entre descubrimiento y reconocimiento.</div></div>
</div>

## La persona detrás de los diagramas

<div class="highlight-box">
<strong>Una mente visual entre disciplinas</strong>
Roger Penrose (n. 1931) propuso el triángulo imposible (1954) e inspiró a Escher. Sus mosaicos aperiódicos (1974) anticiparon los cuasicristales. Su teorema de singularidad usó topología donde otros intentaron cálculos directos. Sus diagramas conformes reemplazaron páginas de ecuaciones por una sola imagen. Premio Wolf 1988 con Hawking. Nobel 2020 a los 89 años.
</div>

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
