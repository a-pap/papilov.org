---
title: "MEMEX"
layout: memex
date: 2026-04-20
lastmod: 2026-04-20
version: "1.0"
status: "published"
label: "Apuntes"
description: "Una nota breve sobre el patrón de memoria personal que uso con Claude: un repositorio Git privado de notas Markdown, un Cloudflare Worker que las expone como herramientas MCP, y dos hooks de sesión de Claude Code. El código es mío y privado; esta página es el esbozo público de la idea."
tags: ["claude", "mcp", "personal-memory"]
ai_disclosure: "Escrito con Claude."
license: "CC BY-NC 4.0"
robots: "all"
---

*Un boceto, no una guía. Un repositorio Git más un único worker basta para darle a Claude una memoria que sobreviva a la conversación.*

La instalación tiene tres partes y es deliberadamente pequeña. Un repositorio Git privado guarda notas Markdown cortas — un bootloader minúsculo en la raíz, un archivo de estado cross-dominio por debajo de sesenta líneas, y un archivo de reglas para el comportamiento que no quiero re-explicar en cada sesión. Un Cloudflare Worker de un solo archivo habla Model Context Protocol en `/mcp`, apoyado en D1 para filas estructuradas y R2 para copias ocasionales. Dos hooks de sesión de Claude Code lo conectan todo: `SessionStart` ejecuta `git pull` para que el primer turno vea datos frescos; `SessionEnd` escribe una fila de uso vía una herramienta `auto_log`. Las extensiones opcionales — un bot de captura, una consolidación nocturna, un par de conectores gestionados — son de unos quince minutos cada una e independientes del núcleo.

Cuatro invariantes convierten esto de juguete en algo fiable. Mantener el bootloader pequeño para que el arranque se quede por debajo de unos pocos miles de tokens. Hacer el enrutado por tema determinista — un tema vive en un archivo, nunca en dos. Tratar el Markdown comiteado como más fuerte que cualquier cosa de un chat log cuando los hechos no coinciden. Nunca poner secretos en el repositorio; un pre-commit scanner local y un lint del lado del servidor evitan que un desliz llegue a internet público.

Herramientas cercanas que vale la pena mirar si quieres construir la tuya: el propio [Model Context Protocol](https://modelcontextprotocol.io/); las alternativas gestionadas [mem0](https://mem0.ai/) y [Letta](https://www.letta.com/); el CLI `llm` de Simon Willison y [Datasette](https://datasette.io/) para la escuela &quot;archivo como primitiva&quot;. En esta página no hay nada que invocar — el código es privado y no se publica ningún endpoint. El patrón es lo que importa.
