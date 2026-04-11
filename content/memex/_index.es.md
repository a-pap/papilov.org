---
title: "Memex"
description: "Memoria persistente, estructurada y multisuperficie para Claude — respaldada por un repositorio privado de GitHub."
tagline: "Memoria persistente para Claude"
summary: "Claude olvida todo entre conversaciones. Memex te da memoria estructurada y multisuperficie que tú controlas — usando un repositorio privado de GitHub como única fuente de verdad."
meta: "git · markdown · 26 herramientas MCP · ~5 min de configuración"
---

Claude olvida todo entre conversaciones. La memoria integrada se genera automáticamente, sin estructura, y se retrasa días.

**Memex te da memoria estructurada y multisuperficie que tú controlas** — un repositorio privado de GitHub como única fuente de verdad. Tu contexto vive como archivos markdown legibles por humanos, versionados en git, cargados bajo demanda. El mismo repositorio es el cerebro para Claude.ai, Claude Code, la app móvil y las tareas programadas en segundo plano.

## Qué obtienes

- **Continuidad multisuperficie.** Decides algo en el móvil por la mañana; por la tarde Claude Code en tu portátil ya lo sabe.
- **Almacenamiento legible.** Markdown en git, no SQLite opaco. Cada cambio es un commit que puedes leer, comparar y revertir.
- **Carga de contexto por niveles.** ~3K tokens al inicio, más solo cuando el tema lo exige. Sin volcar 50K tokens de historial en cada conversación.
- **Recuperación total tras un fallo.** Un Claude nuevo sin memory edits reconstruye todo su contexto desde el repositorio en unos dos minutos.
- **26 herramientas MCP sobre Cloudflare Workers.** Opcional, para superficies que no pueden ejecutar git — pero el núcleo funciona solo con el repositorio.

## Leer el blueprint

Memex es público y auto-alojable. El repositorio contiene toda la arquitectura, la guía de instalación y ejemplos.

**→ [github.com/a-pap/memex](https://github.com/a-pap/memex)**

Licencia: MIT (código), CC BY 4.0 (documentación). Construido con [Claude](https://claude.ai).
