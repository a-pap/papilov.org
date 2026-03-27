---
title: "Mecánica de subastas: de Christie's a Google Ads"
date: 2026-03-27
lastmod: 2026-03-27
version: "1.0"
status: "in-progress"
confidence: "likely"
description: "Cuatro formatos de subasta, dos premios Nobel, un teorema — y por qué las reglas de la puja determinan el precio, no al revés. De Christie's y el espectro 5G a la publicidad programática y el EU ETS."
tags: ["economía", "teoría-de-subastas", "programmatic", "diseño-de-mecanismos", "teoría-de-juegos"]
series: "Información ≠ Comprensión"
ai_disclosure: "Investigación realizada con Claude (Anthropic). Dirección editorial y experiencia de dominio del autor."
license: "CC BY-NC 4.0"
---

Nueva Zelanda, 1990. El gobierno contrata a la consultora NERA para diseñar una subasta de espectro radioeléctrico. NERA recomienda la subasta de Vickrey — un formato cuya fundamentación teórica recibiría el Premio Nobel seis años después. Ingresos esperados: NZ$250 millones. Reales: NZ$36 millones. Un postor ofreció NZ$100.000 y pagó NZ$6. Otro pujó NZ$7 millones y pagó NZ$5.000.

Una elección incorrecta del formato de subasta costó al fisco NZ$214 millones.

En 2019, Google cambió el formato de subasta para el mercado de publicidad programática de $48.000 millones. En 2021, la FCC recaudó $81.000 millones en una subasta de espectro C-band — un récord mundial. El EU ETS ha generado €245.000 millones subastando el derecho a contaminar desde 2013. En todos los casos, no fue el bien el que determinó el precio — **las reglas de la subasta determinaron el precio**.

<div style="margin: 2rem 0; padding: 1.5rem; border: 1px solid var(--border-color); border-radius: 8px; background: var(--bg-secondary);">

**[Abrir el explorador interactivo →](/research/auction-mechanics/infographic.html)**

9 secciones: cuatro tipos de subasta · matemática de las pujas · Equivalencia de Ingresos · el desastre de Nueva Zelanda · tablas comparativas · evolución de las subastas publicitarias · subastas en finanzas · subastas en TI · tendencias y futuro.

</div>

## Cuatro subastas básicas

**Inglesa** (Christie's, Sotheby's) — el precio sube, gana el último postor. **Holandesa** (subasta de flores de Aalsmeer, IPO de Google 2004, bonos del Tesoro de EE.UU.) — el precio baja, gana el primero en aceptar. **Sobre cerrado al primer precio** — licitaciones públicas, publicidad programática desde 2019. **Sobre cerrado al segundo precio (Vickrey)** — Premio Nobel 1996, base del RTB 2007–2017, mecanismo de pujas de eBay.

El descubrimiento clave de Vickrey: en una subasta al segundo precio, la estrategia dominante es pujar exactamente tu valoración real. En la de primer precio — siempre reducir la puja (bid shading). El Teorema de Equivalencia de Ingresos establece que **en expectativa** los cuatro formatos producen el mismo ingreso para el vendedor. Pero solo bajo condiciones estrictas: valoraciones independientes, neutralidad al riesgo, postores simétricos, sin colusión. En la realidad, todas se violan.

## Subastas publicitarias: 100 milisegundos y $500.000 millones

Las subastas publicitarias son las más masivas de la historia: billones de pujas al día. Su evolución de 12 años recapituló el camino que la teoría de subastas recorrió en 50 años — de Vickrey (2007) a primer precio (2019), pasando por header bidding (Prebid.js, 2015) que rompió el monopolio de Google.

## Más allá de la publicidad

Los mismos mecanismos operan en computación en la nube (AWS Spot Instances — hasta 90% de descuento), bolsas de valores (subasta doble continua — $120 billones/año), mercados de carbono (EU ETS — €39.000 millones/año), Ethereum (EIP-1559) y mercados energéticos (EPEX SPOT).

Un patrón se repite: subasta pura → híbrido de subasta + precio algorítmico. Las subastas puras son demasiado volátiles para sistemas en producción.

## Una lección

Las reglas determinan el comportamiento. El comportamiento determina el precio. Quien diseña las reglas controla el mercado.

---

*Este artículo se está ampliando. Próximas secciones: mecanismo VCG, subastas combinatorias, agentes de puja con IA.*
