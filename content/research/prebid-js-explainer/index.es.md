---
title: "Prebid.js: Cómo funciona el estándar de monetización programática"
date: 2026-03-27
lastmod: 2026-03-27
version: "2.0"
status: "finished"
confidence: "certain"
description: "Análisis profundo de la tecnología que procesa billones de subastas publicitarias al año — de la mecánica al impacto empresarial."
tags: ["adtech", "programmatic", "header-bidding", "prebid", "monetization"]
series: "Información ≠ Comprensión"
ai_disclosure: "Research conducted with Claude (Anthropic). Human editorial direction and domain expertise."
license: "CC BY-NC 4.0"
---

La publicidad programática es un mercado de $595 mil millones (2024), con proyección de $779 mil millones para 2028. Aproximadamente el 90% del display digital se compra automáticamente. En el centro de la infraestructura del lado del publisher se encuentra una biblioteca open-source utilizada por más de 10.000 empresas: Prebid.js.

Este análisis es para responsables de decisiones: qué hace Prebid, cómo funciona, por qué se convirtió en el estándar y qué palancas determinan los resultados de negocio.

<div class="metrics">
<div class="metric"><div class="val">300+</div><div class="desc">bid adapters</div></div>
<div class="metric"><div class="val">~90%</div><div class="desc">display = programático</div></div>
<div class="metric"><div class="val">$203B</div><div class="desc">programático en EE.UU. 2026</div></div>
<div class="metric"><div class="val">10K+</div><div class="desc">empresas usan Prebid</div></div>
</div>

## El problema: el waterfall deja dinero sobre la mesa

Históricamente, los publishers vendían inventario mediante un **waterfall** — las redes publicitarias se llamaban secuencialmente por prioridad. La primera que aceptaba el precio se llevaba la impresión. Las demás nunca competían, incluso si hubieran pagado mucho más.

**Header bidding** lo solucionó: todos los compradores pujan simultáneamente, gana el precio más alto. Prebid.js es la biblioteca open-source que se convirtió en el estándar de la industria para header bidding del lado del navegador.

<div class="compare">
  <div class="compare-col col-a">
    <h4>Waterfall</h4>
    <div class="compare-item"><strong>Red A (prioridad 1)</strong><span>$2.00 — gana por defecto</span></div>
    <div class="compare-item"><strong>Red B (prioridad 2)</strong><span>Nunca consultada</span></div>
    <div class="compare-item"><strong>Red C (prioridad 3)</strong><span>Habría pagado $5.00 — nunca consultada</span></div>
    <div class="compare-item"><strong>Resultado</strong><span>Impresión vendida por $2.00</span></div>
  </div>
  <div class="compare-col col-b">
    <h4>Header Bidding (Prebid)</h4>
    <div class="compare-item"><strong>Red A</strong><span>$2.00</span></div>
    <div class="compare-item"><strong>Red B</strong><span>$3.10</span></div>
    <div class="compare-item"><strong>Red C</strong><span>$5.00 — gana</span></div>
    <div class="compare-item"><strong>Resultado</strong><span>Todos pujan en paralelo → $5.00 gana (+150%)</span></div>
  </div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--green">+20–50%</div><div class="desc">incremento waterfall → header bidding</div></div>
<div class="metric"><div class="val val--green">+70%</div><div class="desc">The Telegraph (caso de estudio)</div></div>
<div class="metric"><div class="val val--green">+25–50%</div><div class="desc">incremento CPM, Future plc</div></div>
<div class="metric"><div class="val val--green">30–40%</div><div class="desc">incremento promedio en portafolio (AdPushup)</div></div>
</div>

## Cómo funciona: 5 pasos en ~1000ms

<div class="flow-steps">
<div class="flow-step"><div><div class="flow-num">1</div><div class="flow-line"></div></div><div class="flow-body"><h4>La página carga → la subasta comienza</h4><p>Prebid.js identifica los slots publicitarios y envía simultáneamente bid requests a todos los compradores conectados.</p><span class="flow-tag">~0ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">2</div><div class="flow-line"></div></div><div class="flow-body"><h4>Los compradores responden con pujas</h4><p>Cada DSP/SSP recibe datos del slot y devuelve una puja o pasa. Todo en paralelo.</p><span class="flow-tag">200–800ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">3</div><div class="flow-line"></div></div><div class="flow-body"><h4>El timeout elimina a los lentos</h4><p>Los que no respondieron quedan excluidos. Protección de UX.</p><span class="flow-tag">timeout: 1000–1500ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">4</div><div class="flow-line"></div></div><div class="flow-body"><h4>Las mejores pujas → ad server</h4><p>Las pujas ganadoras se envían a Google Ad Manager para competir con ventas directas y AdX.</p><span class="flow-tag">~50ms</span></div></div>
<div class="flow-step"><div><div class="flow-num">5</div><div class="flow-line"></div></div><div class="flow-body"><h4>El ad server elige al ganador → se muestra el anuncio</h4><p>GAM compara todas las fuentes y sirve el creativo con mayor pago.</p><span class="flow-tag">~1100ms total</span></div></div>
</div>

<div class="highlight-box">
<strong>Prebid no reemplaza al ad server.</strong>
Crea competencia <em>antes</em> de la decisión, aumentando el precio efectivo de cada impresión.
</div>

## Contexto de mercado

<div class="metrics">
<div class="metric"><div class="val val--blue">$1.14T</div><div class="desc">mercado publicitario global 2025</div></div>
<div class="metric"><div class="val val--blue">$595B</div><div class="desc">programático (global) 2024</div></div>
<div class="metric"><div class="val val--blue">$203B</div><div class="desc">display programático en EE.UU. 2026</div></div>
</div>

El estudio de la cadena de suministro de la ANA (2023) encontró que solo **36 centavos** de cada dólar del anunciante llegaban a los publishers. Para el Q3 2025 esto mejoró a **47.1¢** (+11 puntos), pero $26.8 mil millones/año aún se pierden por ineficiencias en la cadena de suministro.

<div class="dollar-flow">
<div class="dollar-node"><div class="dollar-box">Anunciante</div><div class="dollar-amt">$1.00</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">Comisiones DSP + SSP</div><div class="dollar-amt" style="color: var(--purple-soft)">−29¢</div><div class="dollar-note">transacciones</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">Desperdicio</div><div class="dollar-amt" style="color: var(--red-soft)">−24¢</div><div class="dollar-note">IVT, MFA</div></div>
<div class="dollar-arr">→</div>
<div class="dollar-node"><div class="dollar-box">Publisher</div><div class="dollar-amt" style="color: var(--green-soft)">47¢</div><div class="dollar-note">era 36¢</div></div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--red">$26.8B</div><div class="desc">pérdidas anuales en la cadena de suministro</div></div>
<div class="metric"><div class="val val--green">47.1%</div><div class="desc">participación del publisher (era 36%)</div></div>
<div class="metric"><div class="val val--green">0.8%</div><div class="desc">inventario MFA (mínimo histórico)</div></div>
<div class="metric"><div class="val val--blue">87.8%</div><div class="desc">participación PMP (era 64.5%)</div></div>
</div>

## Google Antitrust: por qué Prebid importa más

En abril de 2025, un tribunal federal de EE.UU. declaró a Google culpable de monopolizar ilegalmente los mercados de ad server y ad exchange para publishers. La UE multó a Google con €2.95B. Texas llegó a un acuerdo por $1.375B. El DOJ busca la desinversión de AdX.

<div class="metrics">
<div class="metric"><div class="val val--red">~90%</div><div class="desc">cuota de Google en ad server</div></div>
<div class="metric"><div class="val val--red">€2.95B</div><div class="desc">multa de la UE</div></div>
<div class="metric"><div class="val val--red">$1.375B</div><div class="desc">acuerdo con Texas</div></div>
</div>

> "Google se involucró deliberadamente en una serie de actos anticompetitivos para adquirir y mantener poder de monopolio en los mercados de ad server y ad exchange para publishers."
> — Jueza Leonie Brinkema, 17 de abril de 2025

Para Prebid, esto es un **viento de cola estructural**. Si Google debe desacoplar su ad server de su exchange, las soluciones de subasta neutrales se convierten en infraestructura crítica.

## Tres arquitecturas

<div class="fw-grid">
  <div class="fw-card fw-card--blue">
    <h4>Client-side</h4>
    <div class="fw-sub">Subasta en el navegador</div>
    <ul class="fw-list">
      <li>Compradores: 15–20 (límite)</li>
      <li>Latencia: crece con los compradores</li>
      <li>Acceso a cookies: completo (máximo CPM)</li>
      <li>Ideal para: publishers medianos</li>
    </ul>
  </div>
  <div class="fw-card fw-card--purple">
    <h4>Server-side</h4>
    <div class="fw-sub">Subasta en servidor (Prebid Server)</div>
    <ul class="fw-list">
      <li>Compradores: ilimitados</li>
      <li>Latencia: −40%</li>
      <li>Acceso a cookies: limitado (−20–40% CPM)</li>
      <li>Ideal para: CTV, App, AMP</li>
    </ul>
  </div>
  <div class="fw-card fw-card--green">
    <h4>Híbrido (estándar de la industria)</h4>
    <div class="fw-sub">Ambos — balance óptimo</div>
    <ul class="fw-list">
      <li>Compradores: 5–8 client + resto server</li>
      <li>Latencia: controlada</li>
      <li>Acceso a cookies: completo para compradores clave</li>
      <li>Ideal para: grandes publishers</li>
    </ul>
  </div>
</div>

<div class="highlight-box">
<strong>El híbrido es el estándar de la industria:</strong>
5–8 compradores clave en client-side + el resto en server-side. Prebid Server ofrece hasta un 40% de reducción de latencia.
</div>

## Palancas de negocio

### Timeout: ingresos vs. UX

<div class="bars">
  <div class="bar-row"><div class="label">800ms</div><div class="track"><div class="fill" style="width:55%">~55%</div></div><div class="pct">~55%</div></div>
  <div class="bar-row"><div class="label">1000ms ←</div><div class="track"><div class="fill" style="width:75%">~75%</div></div><div class="pct">~75%</div></div>
  <div class="bar-row"><div class="label">1200ms</div><div class="track"><div class="fill" style="width:88%">~88%</div></div><div class="pct">~88%</div></div>
  <div class="bar-row"><div class="label">1500ms</div><div class="track"><div class="fill" style="width:95%">~95%</div></div><div class="pct">~95%</div></div>
</div>

### Price Granularity

| Tipo | Paso | Líneas GAM | Pérdida de ingresos |
|------|------|-----------|--------------|
| Low | $0.50 | ~40 | hasta $0.49 (alta) |
| Medium | $0.10 | ~200 | hasta $0.09 (moderada) |
| High | $0.01 | ~2,000 | $0.009 (mínima) |
| Custom | Variable | Optimizado | Controlada (recomendado) |

### Selección de compradores: rendimientos decrecientes

<div class="bars">
  <div class="bar-row"><div class="label">3 compradores</div><div class="track"><div class="fill" style="width:60%">~60%</div></div><div class="pct">~60%</div></div>
  <div class="bar-row"><div class="label">5 compradores</div><div class="track"><div class="fill" style="width:80%">~80%</div></div><div class="pct">~80%</div></div>
  <div class="bar-row"><div class="label">8 compradores ←</div><div class="track"><div class="fill" style="width:92%">~92%</div></div><div class="pct">~92%</div></div>
  <div class="bar-row"><div class="label">15 compradores</div><div class="track"><div class="fill" style="width:97%">~97%</div></div><div class="pct">~97%</div></div>
  <div class="bar-row muted"><div class="label">20+ compradores</div><div class="track"><div class="fill" style="width:99%">~99%</div></div><div class="pct">latencia↑</div></div>
</div>

El 80% del ingreso incremental proviene de los primeros 5–7 compradores. Punto óptimo: ~8 en client-side.

## CPM por geografía

CPMs promedio de banner (lado SSP, 2024):

<div class="bars">
  <div class="bar-row"><div class="label">EE.UU.</div><div class="track"><div class="fill" style="width:100%">$1.43</div></div><div class="pct">$1.43</div></div>
  <div class="bar-row"><div class="label">Reino Unido</div><div class="track"><div class="fill" style="width:73%">$1.05</div></div><div class="pct">$1.05</div></div>
  <div class="bar-row"><div class="label">Alemania</div><div class="track"><div class="fill" style="width:63%">$0.90</div></div><div class="pct">$0.90</div></div>
  <div class="bar-row"><div class="label">Francia</div><div class="track"><div class="fill" style="width:56%">$0.80</div></div><div class="pct">$0.80</div></div>
  <div class="bar-row"><div class="label">Brasil</div><div class="track"><div class="fill" style="width:35%">$0.50</div></div><div class="pct">$0.50</div></div>
  <div class="bar-row"><div class="label">India</div><div class="track"><div class="fill" style="width:17%">$0.25</div></div><div class="pct">$0.25</div></div>
</div>

Una diferencia de 8x que define la economía de monetización. Q1 2025: los CPMs de display en EE.UU. cayeron −33–42% interanual tras un año récord de publicidad política. Para diciembre 2025: display +6.3% interanual, video +33.2% interanual. Esta volatilidad subraya la necesidad de precios mínimos dinámicos — exactamente lo que hace el Floors Module de Prebid.

## Privacidad: adaptación post-cookie

<div class="badge-list">
<div class="badge-item"><span class="badge-dot" style="background: var(--green-soft)"></span>User ID — UID2, SharedID, EUID, LiveRamp</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--blue-soft)"></span>Datos first-party</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--purple-soft)"></span>Topics API / Protected Audiences</div>
<div class="badge-item"><span class="badge-dot" style="background: var(--yellow-soft)"></span>Consentimiento GDPR / CCPA / GPP</div>
</div>

<div class="metrics">
<div class="metric"><div class="val val--blue">40%</div><div class="desc">marketers en EE.UU. usan datos 1P como targeting principal (2025)</div></div>
<div class="metric"><div class="val val--green">60–80%</div><div class="desc">CPM preservado con Prebid User ID vs. sin identidad</div></div>
</div>

## Más allá del display

| Formato | Arquitectura | Mercado |
|---------|-------------|---------|
| Display | Client + Server | Programático core |
| Video (instream) | Client + Server | CPM más alto |
| Móvil in-app | SDK → Server | 71% programático |
| CTV / OTT | Solo server | 44% cuota (Q2 2025), >$45B |
| Retail Media | Server | $30B+ para 2026, +29% interanual |
| DOOH | Server | +400% desde 2019 |

<div class="metrics">
<div class="metric"><div class="val val--blue">$110B+</div><div class="desc">video programático en EE.UU. 2026</div></div>
<div class="metric"><div class="val val--blue">44%</div><div class="desc">cuota CTV (Q2 2025, era 28%)</div></div>
<div class="metric"><div class="val val--blue">$30B+</div><div class="desc">retail media para 2026</div></div>
</div>

## Ecosistema y competidores

<div class="timeline">
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2015</div><div class="tl-title">Lanzamiento de Prebid.js (AppNexus + socios)</div><div class="tl-desc">Se publica la biblioteca open-source de header bidding.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2017</div><div class="tl-title">Prebid Server + SDK Móvil</div><div class="tl-desc">Se añade subasta server-side y soporte móvil.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2019–20</div><div class="tl-title">95% de los principales publishers de EE.UU. con header bidding</div><div class="tl-desc">Header bidding se convierte en la norma de la industria.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2021–22</div><div class="tl-title">Módulos de User ID, Floors, GDPR</div><div class="tl-desc">Los módulos de la era de privacidad expanden la plataforma.</div></div>
  <div class="tl-item"><div class="tl-dot tl-dot--green"></div><div class="tl-year">2024–25</div><div class="tl-title">v11, CTV, 300+ adapters, PAAPI</div><div class="tl-desc">Expansión multiformato y preparación post-cookie.</div></div>
  <div class="tl-item"><div class="tl-dot"></div><div class="tl-year">2025–26</div><div class="tl-title">Antitrust de Google → infraestructura neutral más crítica</div><div class="tl-desc">El fallo judicial acelera el cambio hacia soluciones vendor-neutral.</div></div>
</div>

| Solución | Tipo | Diferenciación | Lock-in |
|----------|------|----------------|---------|
| Prebid.js | Open source | Neutral, auditable | Ninguno |
| Amazon TAM | Propietario | Vinculado a Amazon DSP | Medio |
| Google Open Bidding | Server-side en GAM | Conflicto de interés | Alto |
| Index Exchange | Propietario | Calidad, pero dependiente del vendor | Medio |

Prebid funciona en paralelo con TAM y Open Bidding. Según datos de Roxot, el header bidding client-side y server-side generan ~22% de los ingresos programáticos cada uno, mientras que AdX representa ~56%.

## Lo que Prebid no hace

<div class="psych-grid">
  <div class="psych-card">
    <h4>No optimiza la ubicación</h4>
    <p>La posición y tamaño de los slots publicitarios son decisiones del publisher — Prebid gestiona la demanda, no el diseño del lado de la oferta.</p>
  </div>
  <div class="psych-card">
    <h4>No reemplaza al ad server</h4>
    <p>GAM sigue siendo necesario para ventas directas, frequency capping y decisión final.</p>
  </div>
  <div class="psych-card">
    <h4>No soluciona la calidad del tráfico</h4>
    <p>Bots, baja viewability y tráfico inválido son problemas raíz fuera del alcance de Prebid.</p>
  </div>
  <div class="psych-card">
    <h4>No es plug-and-play</h4>
    <p>Es una herramienta de ingeniería que requiere optimización continua de configuración y monitoreo.</p>
  </div>
</div>

## Conclusión

Trabajar sin header bidding en 2026 significa dejar **20–40% de los ingresos programáticos** sobre la mesa. La pregunta estratégica no es "¿necesitamos Prebid?" sino **qué configuración es la óptima**. Con el antitrust de Google y la transición post-cookie, las soluciones vendor-neutral son más críticas que nunca.

<div class="metrics">
<div class="metric"><div class="val val--green">+20–50%</div><div class="desc">waterfall → header bidding</div></div>
<div class="metric"><div class="val val--green">+5–15%</div><div class="desc">+ server-side</div></div>
<div class="metric"><div class="val val--green">+3–10%</div><div class="desc">optimización de configuración</div></div>
</div>

---

### Fuentes

1. [Prebid.org](https://prebid.org/) 2. [Prebid.js GitHub](https://github.com/prebid/Prebid.js) 3. [ANA Q2 2025](https://www.ana.net/content/show/id/pr-2025-08-programmatictrans) 4. [ANA Q3 2025](https://www.ana.net/content/show/id/pr-2025-11-transparency) 5. [ANA 2023 Study](https://drupal.unglobalcompact.org/cmo-blueprint-for-sustainable-growth/resources/ana-programmatic-media-supply-chain-transparency) 6. [dentsu](https://www.dentsu.com/news-releases/global-ad-spend-set-to-surpass-one-trillion-for-the-first-time-in-2026-as-the-algorithmic-era-redefines-growth) 7. [Basis](https://basis.com/blog/7-programmatic-advertising-trends-shaping-2026) 8. [eMarketer](https://www.emarketer.com/content/worldwide-programmatic-ad-spending-2025) 9. [AsterioBid](https://asteriobid.com/cpm_trends_banners_2024) 10. [DataBeat](https://databeat.io/blog/us-programmatic-trends-december-2025/) 11. [Digiday](https://digiday.com/media/header-bidding-publishers-boosting-cpms-much-50-percent/) 12. [Digiday Research](https://digiday.com/media/digiday-research-header-bidding-and-first-price-auctions-boost-publisher-revenues/) 13. [AdPushup](https://www.adpushup.com/blog/header-bidding-analytics-using-data-to-optimize-your-stack/) 14. [Mile.tech](https://www.mile.tech/blog/prebid-server) 15. [Criteo](https://www.criteo.com/blog/header-bidding-demystified-client-side-vs-server-side/) 16. [US v. Google](https://en.wikipedia.org/wiki/United_States_v._Google_LLC_(2023)) 17. [Axios](https://www.axios.com/2025/04/17/google-ad-tech-monopoly-antitrust-ruling) 18. [Raptive](https://raptive.com/blog/what-the-dojs-ruling-on-google-means-for-creators-and-publishers/) 19. [Kluwer](https://legalblogs.wolterskluwer.com/competition-blog/impact-of-the-ec-decision-on-googles-adtech-stakeholder-analysis-and-remedies/) 20. [Roxot](https://roxot.com/report/sell-side-programmatic-us-2019) 21. [Enlyft](https://enlyft.com/tech/products/prebid) 22. [6sense](https://6sense.com/tech/libraries-and-widgets/prebid-market-share) 23. [Marketing Brew](https://www.marketingbrew.com/stories/2025/12/09/total-global-ad-revenue-grew-nearly-9-in-2025-wpp-media) 24. [Prebid Server Docs](https://docs.prebid.org/dev-docs/pbsBidAdapter-video-overview.html)
