# CLAUDE.md

このファイルは、このリポジトリで作業するときの Claude Code (claude.ai/code) へのガイドです。

## プロジェクト概要

StatsToo は Jekyll ベースの静的サイトで、バスケットボールのスタッツ記録と分析のためのウェブサイトです。GitHub Pages に https://statstoo.com でデプロイされています。コンテンツはすべて日本語です。

## よく使うコマンド

```bash
# Ruby の依存パッケージをインストール
bundle install

# ローカル開発サーバーを起動（http://localhost:4000）
bundle exec jekyll serve

# 静的サイトを _site/ へビルド
bundle exec jekyll build

# Gemini API でコラム記事を生成（環境変数 GEMINI_API_KEY が必要）
pip install google-genai
python generate_column.py
```

`package.json` は存在しない。Jekyll/Ruby のみのプロジェクトで、Tailwind CSS と Chart.js は CDN で読み込んでいる（npm ではない）。

## Skills

### write-column

コラム記事執筆スキル。`disable-model-invocation: true` のため、ユーザーが明示的に呼び出した際のみ実行される（Claude による自動発火はしない）。

```
/write-column <トピック>      # 指定トピックで記事を執筆
/write-column                 # トピック未指定 → 候補提案モード
```

- `column/*.md` を全件読み込み、既存記事との重複をチェックする
- `column/sample-article.md` をテンプレートとして使用し、フロントマターと本文構成を適用する
- カテゴリーは記事の内容で自動分類する（戦術・練習・ルール・用具）
- 生成記事は `column/<slug>.md` に書き込む
- スキル本体: `.claude/skills/write-column/SKILL.md`

### suggest-column

未執筆トピック提案スキル。`column/` の既存記事を分析し、バスケットボールの戦術や基本の動きの中で未執筆のトピックを優先順位付きで提案する。候補を選んだら自動で `write-column` を呼び出し執筆まで進める。

```
/suggest-column        # 未執筆トピックの候補を提案 → 選択後に執筆
```

- 戦術（ディフェンス）→ 練習・スキル → ルール の順に優先度付きで提案する
- 候補リスト（47件）は SKILL.md 内に持ち、新記事が追加されると自動で脱落する
- スキル本体: `.claude/skills/suggest-column/SKILL.md`

## ブランチとデプロイ

- **develop** — アクティブな開発ブランチ
- **main** — GitHub Actions を経由して GitHub Pages へデプロイをトリガーする
- `main` へのプッシュ → Jekyll がビルドして自動デプロイ（`.github/workflows/jekyll.yml`）
- 毎日のクロンジョブ（`.github/workflows/daily-article.yml`）が `generate_column.py` を実行し、`develop` ブランチの `column/` に Gemini 1.5 Flash で記事を自動公開する

## アーキテクチャ

### 2種類のレイアウト

すべてのページは `_layouts/` で定義された2種類の Jekyll レイアウトのいずれかを使用している：

| レイアウト | 使用先 | 説明 |
|---|---|---|
| `default` | ほぼ全ページ（index, tools, about, help など） | ヘッダー・フッター・サイドバー付きの標準レイアウト。`extra_css` や `extra_js` のフロントマターキーでページごとのアセットを追加可能 |
| `column` | `column/*.md` のブログ記事 | 目次・パンくず・カテゴリーバッジ・特殊ボックス（note, point, warning）対応の記事レイアウト |

`_includes/` の共有パーシャル: `head.html`（フォント・アナリティクス・Tailwind設定・AdSense）、`header.html`（ドロップダウン付きナビ）、`footer.html`、`sidebar-left.html`、`sidebar-right.html`。

### インタラクティブツールは単一HTMLファイル

`tools/` 以下のページ（シュートチャート・マルチゲームスタッツ・動画スタッツトラッカー）は、CSS と JavaScript がすべてインラインに含まれた**単一の自己完結HTMLファイル**である。これは Jekyll のレイアウトシステムを意図的にバイパスしている。ホームページ `index.html`（メインのゲームスタッツツール）も同じパターンで、Chart.js や html2canvas を内包する大型の単一ページ（約2800行）である。

ツールを Jekyll パーシャルや共有 JS モジュールにリファクタリングする場合は、各ツールが単一のデプロイ可能なファイルとして設計されていることを理解してから行うこと。

### コラム（ブログ）記事

記事は `column/*.md` に配置され、`layout: column` を使用する。必須のフロントマターフィールドは以下の通り：

```yaml
layout: column
title: "..."            # 約32文字、SEOタイトル
description: "..."      # 約120文字
date: YYYY-MM-DD
update: YYYY-MM-DD
author: StatsToo編集部
category: 戦術          # または 練習, ルール, 用具, その他
tags:
  - バスケットボール
  - ...
thumbnail: /image/column/FILENAME.jpg
excerpt: "..."          # 一覧ページに表示される約100文字の要約
toc: true
permalink: /column/SLUG/
```

`column/index.html` の一覧ページがこれらの記事を読み込み、フィルタ可能なグリッドで表示する。新記事を追加する際は、`permalink` がファイル名のslugと一致していることを確認すること。

### スタイリング

- Tailwind CSS は `_includes/head.html` にインライン設定されており、カスタムテーマカラー（primary: `#EA580C`、secondary: `#1e293b`）とフォント（Bebas Neue for display, Noto Sans JP for body）を使用している。
- 使用されるブレークポイント: 480px, 768px, 1280px。
- コラム記事のスタイル（見出し・特殊ボックス・目次）は `_layouts/column.html` で定義されている。

## 主要ファイル

| ファイル | 役割 |
|---|---|
| `_config.yml` | Jekyll設定（タイトル・URL・permalinkスタイル・除外ファイル） |
| `_includes/head.html` | グローバルの `<head>`: Tailwind設定・フォント・GA・AdSense |
| `_includes/header.html` | ドロップダウン付きのレスポンシブナビゲーション |
| `_layouts/default.html` | 標準ページレイアウト |
| `_layouts/column.html` | ブログ記事レイアウト + 記事固有のCSS |
| `index.html` | ホームページ / メインのゲームスタッツ記録ツール |
| `column/*.md` | ブログ記事 |
| `column/index.html` | コラム一覧ページ |
| `generate_column.py` | Gemini API を使用した記事自動生成スクリプト |
| `.github/workflows/jekyll.yml` | デプロイワークフロー |
| `.github/workflows/daily-article.yml` | 毎日の記事生成ワークフロー |
