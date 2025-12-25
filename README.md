# StatsToo - Jekyll Site

バスケットボールスタッツ記録ツール StatsToo のウェブサイトです。

## フォルダ構成

```
statstoo/
├── _config.yml          # Jekyll設定ファイル
├── _includes/           # 共通パーツ
│   ├── head.html        # <head>タグ内の共通部分
│   ├── header.html      # ヘッダー（ナビゲーション）
│   └── footer.html      # フッター
├── _layouts/
│   └── default.html     # デフォルトレイアウト
├── index.html           # トップページ
├── privacy/
│   └── index.html       # プライバシーポリシー
├── terms/
│   └── index.html       # 利用規約
├── contact/
│   └── index.html       # お問い合わせ
├── about/
│   └── index.html       # 運営者情報
├── help/
│   └── index.html       # ヘルプ
├── sitemap/
│   └── index.html       # サイトマップ
├── column/
│   └── index.html       # コラム一覧ページ
└── tools/
    └── game-stats/
        └── index.html   # 試合スタッツ記録ツール（※別途配置）
```

## GitHub Pages での公開方法

### 1. GitHubリポジトリを作成

1. GitHub.com で新しいリポジトリを作成
2. リポジトリ名を `statstoo` などに設定
3. Public を選択

### 2. ファイルをアップロード

このフォルダの全ファイルをリポジトリにアップロードします。

### 3. GitHub Pages を有効化

1. リポジトリの Settings → Pages
2. Source で「GitHub Actions」を選択

### 4. Jekyll用のワークフローを作成

`.github/workflows/jekyll.yml` を作成：

```yaml
name: Deploy Jekyll site to Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v4
      - name: Build with Jekyll
        uses: actions/jekyll-build-pages@v1
        with:
          source: ./
          destination: ./_site
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## ヘッダー・フッターの編集方法

共通部分を変更したい場合は、以下のファイルを編集してください：

- **ヘッダー（ナビゲーション）**: `_includes/header.html`
- **フッター**: `_includes/footer.html`
- **<head>タグ**: `_includes/head.html`

これらを編集すると、全ページに変更が反映されます。

## 試合スタッツ記録ツールについて

`/tools/game-stats/index.html` には、試合スタッツ記録ツールの完全なHTMLを配置してください。

このツールは複雑なJavaScriptを含むため、Jekyllのレイアウトシステムとは別に、単独のHTMLファイルとして管理することをおすすめします。

## コラムについて

`/column/index.html` はコラム一覧ページです。

個別のコラム記事は `_posts/` ディレクトリに以下の形式で作成できます：

```
_posts/
└── 2024-01-15-basketball-tips.md
```

ファイル名は `YYYY-MM-DD-タイトル.md` の形式にしてください。

### コラム記事のテンプレート

```markdown
---
layout: default
title: 記事タイトル
date: 2024-01-15
category: column
---

記事の本文をここに書きます。
```

## ローカルでの確認方法

```bash
# Jekyll をインストール（初回のみ）
gem install bundler jekyll

# 依存関係をインストール
bundle install

# ローカルサーバーを起動
bundle exec jekyll serve

# ブラウザで http://localhost:4000 を開く
```

## カスタマイズ

### サイト情報の変更

`_config.yml` を編集：

```yaml
title: StatsToo（スタッツー）
description: バスケットボールのスタッツ記録・分析ツール
url: "https://yourdomain.com"
```

### 運営者情報の変更

`about/index.html` 内のプレースホルダーを編集して、開発背景のテキストを追加してください。

### お問い合わせフォーム

`contact/index.html` 内のコメントに従って、Googleフォームのiframeを埋め込んでください。
