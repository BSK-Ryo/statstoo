# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

StatsToo is a Jekyll-based static website for basketball stats recording and analysis, deployed to GitHub Pages at https://statstoo.com. Content is in Japanese.

## Common Commands

```bash
# Install Ruby dependencies
bundle install

# Run local development server (http://localhost:4000)
bundle exec jekyll serve

# Build the static site to _site/
bundle exec jekyll build

# Generate a column article via Gemini API (requires GEMINI_API_KEY env var)
pip install google-genai
python generate_column.py
```

No `package.json` exists — this is a pure Jekyll/Ruby project. Tailwind CSS and Chart.js are loaded via CDN, not npm.

## Branch & Deployment

- **develop** — active development branch
- **main** — triggers GitHub Actions deployment to GitHub Pages
- Push to `main` → Jekyll builds and deploys automatically (`.github/workflows/jekyll.yml`)
- A daily cron workflow (`.github/workflows/daily-article.yml`) runs `generate_column.py` to auto-publish articles to `column/` on the `develop` branch using Gemini 1.5 Flash

## Architecture

### Two Layout System

All pages use one of two Jekyll layouts defined in `_layouts/`:

| Layout | Used by | Description |
|---|---|---|
| `default` | Most pages (index, tools, about, help, etc.) | Standard page with header/footer/sidebars. Supports `extra_css` and `extra_js` front matter keys for per-page assets. |
| `column` | Blog articles in `column/*.md` | Article layout with TOC, breadcrumbs, category badge, and special block styles (note, point, warning boxes). |

Shared partials in `_includes/`: `head.html` (fonts, analytics, Tailwind config, AdSense), `header.html` (nav with dropdowns), `footer.html`, `sidebar-left.html`, `sidebar-right.html`.

### Interactive Tools Are Standalone HTML

Pages under `tools/` (shot charts, multi-game stats, video stats tracker) are **self-contained HTML files** with all CSS and JavaScript inline. They intentionally bypass Jekyll's layout system. The homepage `index.html` (the main game-stats tool) follows the same pattern — it is a large standalone page (~2800 lines) with embedded Chart.js and html2canvas.

Do not refactor tools into Jekyll partials or shared JS modules without understanding that each tool is designed to work as a single deployable file.

### Column (Blog) Articles

Articles live in `column/*.md` and use `layout: column`. Required front matter fields:

```yaml
layout: column
title: "..."            # ~32 chars, SEO title
description: "..."      # ~120 chars
date: YYYY-MM-DD
update: YYYY-MM-DD
author: StatsToo編集部
category: 戦術          # or 練習, ルール, 用具, その他
tags:
  - バスケットボール
  - ...
thumbnail: /image/column/FILENAME.jpg
excerpt: "..."          # ~100 char summary for listing page
toc: true
permalink: /column/SLUG/
```

The `column/index.html` listing page reads these articles and renders a filterable grid. When adding a new article, ensure `permalink` matches the filename slug.

### Styling

- Tailwind CSS is configured inline in `_includes/head.html` with custom theme colors (primary: `#EA580C`, secondary: `#1e293b`) and fonts (Bebas Neue for display, Noto Sans JP for body).
- Breakpoints used: 480px, 768px, 1280px.
- Column article styles (headings, special boxes, TOC) are defined in `_layouts/column.html`.

## Key Files

| File | Role |
|---|---|
| `_config.yml` | Jekyll config (title, URL, permalink style, excluded files) |
| `_includes/head.html` | Global `<head>`: Tailwind config, fonts, GA, AdSense |
| `_includes/header.html` | Responsive navigation with dropdown menus |
| `_layouts/default.html` | Standard page layout |
| `_layouts/column.html` | Blog article layout + article-specific CSS |
| `index.html` | Homepage / main game-stats recording tool |
| `column/*.md` | Blog articles |
| `column/index.html` | Column listing page |
| `generate_column.py` | Auto-article generator using Gemini API |
| `.github/workflows/jekyll.yml` | Deploy workflow |
| `.github/workflows/daily-article.yml` | Daily article generation workflow |
