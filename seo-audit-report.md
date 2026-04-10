# statstoo.com SEO監査レポート

**対象サイト**: https://statstoo.com/
**運営者**: Ryousei（Webエンジニア・SEOコンサルタント）
**サイト種別**: バスケットボールスタッツ記録・分析ツール（無料SaaS + コラムメディア）
**監査日**: 2026年4月10日

---

## 1. エグゼクティブサマリー

### 総合評価

statstoo.com はバスケットボールのスタッツ記録・分析ツールを提供する無料Webアプリケーション。ツール6種 + コラム記事59本 + ルール解説ページで構成されている。

**良い点**: meta description・titleタグは各ページに固有設定済み、コラム記事にBlogPosting構造化データ・著者情報・公開日を実装、パンくずリスト（コラム・ルール配下）はビジュアル表示を実装済み。

**主要課題**: `<meta name="viewport">` と `<html lang>` 属性が全ページで未実装（モバイルSEO・言語認識に致命的）、トップページ・ルールページ等でH1タグが存在しない、OGPタグとcanonical tagが全ページで未実装、画像alt属性の大量欠落。

### 優先度トップ5

| # | 課題 | 優先度 | 影響範囲 |
|---|------|--------|---------|
| 1 | `<meta name="viewport">` が全ページで未実装 | **最高** | 全70ページ（モバイル表示・インデックスに致命的） |
| 2 | `<html lang="ja">` 属性が全ページで未実装 | **高** | 全70ページ（言語認識） |
| 3 | トップページ・ルールページ等でH1タグが存在しない | **高** | 主要ページ複数 |
| 4 | OGPタグ（og:title, og:description, og:image）が全ページで未実装 | **高** | 全70ページ |
| 5 | canonical tagが全ページで未実装 | **高** | 全70ページ |
| 6 | 画像alt属性の大量欠落（コラムサムネイル・ツール内画像） | **高** | 全ページ |
| 7 | ツールページにSoftwareApplication構造化データなし | **中** | ツール6ページ |
| 8 | ヘルプページのFAQにFAQPage構造化データなし | **中** | 1ページ（SERP表示機会損失） |

### 良好な点

- コラム記事: `BlogPosting` 構造化データ、著者情報（StatsToo編集部）、公開日/更新日を実装済み
- titleタグ: 各ページに固有のタイトルを設定、キーワード含有・ブランド名付与が適切
- meta description: 主要ページに固有の説明文を設定済み（文字数も適切）
- robots.txt: シンプルかつ適切に構成（全ページ許可 + サイトマップ参照）
- XMLサイトマップ: 70URL収録、適切なURL構成
- パンくずリスト: コラム記事・ルールページにビジュアル表示を実装済み（※BreadcrumbList構造化データは未実装）
- URL構造: 読みやすいスラッグ、一貫した階層構造
- コンテンツ更新: 2026年4月現在も継続更新中
- プライバシーポリシー・利用規約: 必要要素が揃っている

---

## 2. クロール・インデックス

### 2-1. robots.txt — 問題なし

| 項目 | 状況 |
|------|------|
| User-agent | `*`（全ボット対象） |
| Allow | `/`（全ページ許可） |
| Disallow | なし |
| Sitemap | `https://statstoo.com/sitemap.xml` あり |

**評価**: 適切に構成されている。修正不要。

---

### 2-2. XMLサイトマップ

| 項目 | 状況 |
|------|------|
| URL総数 | 70 |
| 形式 | 単一ファイル（インデックスなし） |
| lastmod | **未設定** |
| changefreq | **未設定** |
| priority | **未設定** |

#### Issue 1: サイトマップにlastmod未設定

**Issue**: 全70URLにlastmod（最終更新日）が設定されていない。

**Impact**: **中** — Googleはlastmodを参考にクロール優先度を決定する。未設定だと更新されたコンテンツの再クロールが遅れる可能性がある。

**Fix**: 各URLに正確なlastmod日付を追加する。特にコラム記事は公開日・更新日データがあるため、それをサイトマップに反映する。

```xml
<url>
  <loc>https://statstoo.com/column/off-ball-screen/</loc>
  <lastmod>2026-04-03</lastmod>
</url>
```

#### Issue 2: HTMLサイトマップとXMLサイトマップのURL不一致

**Issue**: HTMLサイトマップ（`/sitemap/`）には `/tools/practice/`、`/tools/shot-chart/`、`/tools/mulch-team-stats/` が含まれるが、XMLサイトマップには含まれていない可能性がある（XMLには70URL、HTMLには上記を含むより多くのツールページが掲載）。

**Impact**: **中** — XMLサイトマップに含まれないページはクロール発見が遅れる。

**Fix**: HTMLサイトマップとXMLサイトマップのURLを同期させる。全ての公開ページをXMLサイトマップに含める。

---

### 2-3. canonical tag

#### Issue 3: canonical tagが全ページで未実装

**Issue**: 再検証の結果、検査した全ページでcanonical tagが確認できなかった:
- トップページ（`/`）
- コラム一覧（`/column/`）
- コラム記事（`/column/off-ball-screen/`、`/column/double-dribble-walking/`、`/column/paint-area-rules/` 等）
- ツールページ（`/tools/3point-shot-chart/`、`/tools/mulch-game-stats/` 等）
- ルールページ（`/rule/`、`/rule/3x3/`）
- 固定ページ（`/about/`、`/contact/`、`/privacy/`、`/terms/`、`/help/`）

※初回調査で一部記事にcanonicalありと報告したが、これはJSON-LD内の `mainEntityOfPage` を誤認したもの。`<link rel="canonical">` タグは全ページに存在しない。

**Impact**: **高** — canonical tagがないと、パラメータ付きURL（`?ref=`等）やwww/non-wwwの重複が発生した場合にインデックスの分散が起きる。

**Fix**: 全ページに自己参照canonical tagを設置する。

```html
<link rel="canonical" href="https://statstoo.com/{path}/" />
```

---

### 2-4. サイト構造

| 項目 | 状況 |
|------|------|
| 階層の深さ | 最大3階層（適切） |
| 孤立ページ | 要調査（HTMLサイトマップ限定URLあり） |
| ナビゲーション | ヘッダー + フッターで主要ページ網羅 |
| 内部リンク | コラム記事間の相互リンクは一部のみ |

#### Issue 4: コラム記事間の内部リンクが不十分

**Issue**: コラム記事は59本あるが、記事本文内の相互リンクが限定的。関連記事セクションは一部記事にのみ実装（グリッドレイアウトはあるが中身が空の場合あり）。

**Impact**: **中** — 内部リンクはPageRankの分配とユーザーの回遊に重要。59記事のトピッククラスター（戦術系、ルール系、練習法系）を内部リンクで結ぶことでSEO効果が高まる。

**Fix**:
1. 関連記事セクションを全コラム記事に実装（関連度の高い3-5記事を表示）
2. 記事本文内に自然なアンカーテキストで関連記事へのリンクを追加
3. トピッククラスターごとのまとめページ（ピラーページ）の作成を検討

---

## 3. テクニカルSEO

### 3-1. OGPタグ

#### Issue 9: OGPタグが全ページで未実装

**Issue**: `og:title`、`og:description`、`og:image`、`og:url`、`og:type` が全ページで確認できなかった。Twitter Card（`twitter:card`等）も未実装。

**Impact**: **高** — SNSでシェアされた際にタイトル・説明・画像が正しく表示されない。バスケットボール関連コンテンツはSNS拡散が見込まれるため、機会損失が大きい。Instagramアカウントを運営しているにもかかわらず、OGPが未実装なのは特に問題。

**Fix**: 全ページに以下を追加:

```html
<!-- OGP -->
<meta property="og:title" content="{ページタイトル}" />
<meta property="og:description" content="{meta description}" />
<meta property="og:image" content="https://statstoo.com/image/{適切な画像}" />
<meta property="og:url" content="https://statstoo.com/{path}/" />
<meta property="og:type" content="website" /> <!-- 記事は "article" -->
<meta property="og:site_name" content="StatsToo（スタッツー）" />
<meta property="og:locale" content="ja_JP" />

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="{ページタイトル}" />
<meta name="twitter:description" content="{meta description}" />
<meta name="twitter:image" content="https://statstoo.com/image/{適切な画像}" />
```

---

### 3-2. 構造化データ

#### 現状

| ページ種別 | @type | 評価 |
|-----------|-------|------|
| トップページ | WebSite | 不十分 |
| コラム記事 | BlogPosting | **良好** |
| ツールページ | WebPage | 不十分 |
| ルールページ | WebPage | 不十分 |
| ヘルプページ | WebPage | 不十分 |
| その他固定ページ | WebPage | 最低限 |

#### Issue 5: トップページの構造化データ不足

**Issue**: トップページには `WebSite` スキーマのみ。`Organization` スキーマ（運営者情報、ロゴ、SNSリンク等）が未実装。

**Impact**: **中** — Google Knowledge Panelの表示機会損失。ブランド検索時の情報表示が不十分。

**Fix**: `Organization` スキーマを追加:

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "StatsToo（スタッツー）",
  "url": "https://statstoo.com",
  "logo": "https://statstoo.com/image/favicon.png",
  "sameAs": [
    "https://www.instagram.com/statstoo_2026/"
  ],
  "contactPoint": {
    "@type": "ContactPoint",
    "contactType": "customer service",
    "url": "https://statstoo.com/contact/"
  }
}
```

#### Issue 6: ツールページにSoftwareApplication構造化データなし

**Issue**: 6つのツールページ（試合スタッツ記録、3Pショットチャート、2Pショットチャート、マルチゲームスタッツ等）に `SoftwareApplication` または `WebApplication` スキーマが未実装。

**Impact**: **中** — ツール系検索クエリ（「バスケ スタッツ ツール」「シュート記録 アプリ」等）でのリッチリザルト表示機会を逃している。

**Fix**: ツールページに `SoftwareApplication` スキーマを追加:

```json
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "3Pシュートチャート",
  "applicationCategory": "SportsApplication",
  "operatingSystem": "Web",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "JPY"
  },
  "description": "3Pシュートのスポット別成功率を記録・分析",
  "url": "https://statstoo.com/tools/3point-shot-chart/"
}
```

#### Issue 7: ヘルプページにFAQPage構造化データなし

**Issue**: ヘルプページに9つのFAQ（アコーディオン形式）が存在するが、`FAQPage` 構造化データが未実装。

**Impact**: **中** — 「StatsToo 使い方」等の検索でFAQリッチリザルトが表示されない。SERP上の占有面積拡大の機会損失。

**Fix**: `FAQPage` スキーマを追加:

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "質問テキスト",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "回答テキスト"
      }
    }
  ]
}
```

#### Issue 8: コラム記事のパンくずリストにBreadcrumbList構造化データなし

**Issue**: コラム記事にはHTMLでパンくずリスト（「ホーム > コラム一覧 > 記事タイトル」）が表示されているが、`BreadcrumbList` 構造化データが確認できなかった。

**Impact**: **低** — GoogleはHTMLからパンくずを推測できるが、構造化データがあるとSERPでの表示が確実になる。

**Fix**: パンくずリストに `BreadcrumbList` スキーマを追加。

---

### 3-3. viewport meta tag

#### Issue 10: viewport meta tagが全ページで未実装（最優先）

**Issue**: 検査した全ページで `<meta name="viewport" content="width=device-width, initial-scale=1">` が確認できなかった。

**Impact**: **最高** — viewport meta tagはモバイル対応の最も基本的な要素。未実装の場合:
- Googleのモバイルフレンドリーテストに不合格となる
- モバイルファーストインデックスにおいてランキングに深刻な悪影響
- モバイル端末でページが正しく表示されない（デスクトップ表示が縮小表示される）

**Fix**: 全ページの `<head>` 内に追加:

```html
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

※SPA（Single Page Application）構成の場合、ルートHTML（index.html等）に1箇所追加すれば全ページに反映される。

---

### 3-4. html lang属性

#### Issue 11: html lang属性が全ページで未実装

**Issue**: 検査した全ページで `<html lang="ja">` 属性が確認できなかった。

**Impact**: **高** — lang属性は:
- 検索エンジンがページの言語を判定する手がかりとなる
- スクリーンリーダー等の支援技術が正しい言語で読み上げるために必要
- ブラウザの翻訳機能の挙動に影響

**Fix**: HTMLの `<html>` タグにlang属性を追加:

```html
<html lang="ja">
```

---

### 3-5. H1タグ

#### Issue 12: 主要ページでH1タグが存在しない

**Issue**: 再検証の結果、以下のページで `<h1>` タグ自体が存在しないことが判明:
- **トップページ（`/`）**: H1なし。「GAME STATS TRACKER」等はh2またはdivで実装
- **ルールページ（`/rule/`）**: H1なし。見出しはh2以下で構成
- **ルール3x3（`/rule/3x3/`）**: H1なし

一方、以下のページではH1が正しく実装されている（各1つ）:
- コラム記事: 記事タイトルがH1（良好）
- コラム一覧（`/column/`）: 「BASKETBALL COLUMN」がH1（1つのみ）
- ヘルプ（`/help/`）: 「ヘルプ」がH1（1つのみ）
- ツールページ（`/tools/3point-shot-chart/`）: 「3P SHOT CHART」がH1（1つのみ）

※初回調査では「複数H1が存在する」と報告したが、再検証でコラム一覧・ヘルプはH1が1つのみであることを確認。トップページ・ルールページはH1が「複数」ではなく「ゼロ」であり、より深刻な問題。

**Impact**: **高** — H1はページの主題をGoogleに伝える最も重要な見出し要素。トップページ・ルールページのような主要ページにH1がないのは、SEO上大きな機会損失。

**Fix**:
1. トップページに日本語キーワードを含むH1を追加（例: `<h1>バスケットボールのスタッツ記録ツール</h1>`）
2. ルールページに適切なH1を追加（例: `<h1>バスケットボール基本ルールブック</h1>`）
3. 装飾的な英語見出しは `<div>` + CSS、または `<h2>` として残す

---

### 3-6. 画像最適化

#### Issue 13: 画像alt属性の大量欠落

**Issue**: 以下の場所で画像のalt属性が欠落または不十分:
- **コラム一覧ページのサムネイル画像**: alt属性なし（全件。例: `<img src="/image/column/off-ball-screen.jpg">` にaltなし）
- **ツールページ内の画像**: alt属性なし
- **コラム記事のアイキャッチ画像**: 記事により実装にばらつき
  - altあり: `/column/double-dribble-walking/`（記事タイトルをaltに設定）
  - altなし: `/column/off-ball-screen/`、`/column/paint-area-rules/`
- **ロゴ画像**: `alt=""`（空文字）— トップページでは空のalt属性、一部ページでは `alt="StatsToo"` と不統一

**Impact**: **高** — alt属性はGoogle画像検索のランキング要素であり、アクセシビリティの観点からも必須。バスケットボール関連の画像検索流入を逃している。

**Fix**:
1. 全画像にキーワードを含む説明的なalt属性を設定
2. コラム一覧のサムネイルには記事タイトルをaltに使用
3. ツール内の図表には機能説明をaltに使用

---

### 3-7. HTTPS・セキュリティ

| 項目 | 状況 |
|------|------|
| HTTPS | 全ページHTTPS |
| SSL証明書 | 有効 |
| HTTP→HTTPS | 自動リダイレクト |
| 混在コンテンツ | 確認されず |

**評価**: 問題なし。

---

### 3-8. URL構造

| 項目 | 状況 |
|------|------|
| 読みやすさ | 良好（英語スラッグ） |
| 一貫性 | 良好（`/column/{slug}/`、`/tools/{slug}/`） |
| 末尾スラッシュ | 統一（あり） |
| 大文字/小文字 | 小文字で統一 |

**評価**: 良好。修正不要。

#### Issue 14: ツールページのスラッグに軽微な問題

**Issue**: `/tools/mulch-game-stats/` は「mulch」ではなく「multi」が正しいスペル。ユーザーにとって分かりにくい。

**Impact**: **低** — 直接的なSEOへの影響は小さいが、URLの信頼性に関わる。

**Fix**: URLスラッグを `/tools/multi-game-stats/` に修正し、旧URLから301リダイレクトを設定する（既にインデックス済みの場合は慎重に検討）。

---

## 4. オンページSEO

### 4-1. titleタグ

| ページ | titleタグ | 文字数 | 評価 |
|--------|----------|--------|------|
| トップ | バスケットボールのスタッツ記録ツール \| StatsToo（スタッツー） | 31文字 | 良好 |
| コラム一覧 | コラム一覧 バスケットボール情報 \| StatsToo（スタッツー） | 31文字 | 良好 |
| 3Pショットチャート | 3Pシュートチャート \| StatsToo（スタッツー） | 24文字 | 良好 |
| マルチゲーム | マルチチーム対戦スタッツ記録 レクリエーションバスケ用 \| StatsToo（スタッツー） | 39文字 | 良好 |
| ルール | バスケットボール基本ルールブック \| StatsToo（スタッツー） | 27文字 | 良好 |
| 3x3ルール | 3x3バスケットボール ルール完全ガイド \| StatsToo（スタッツー） | 30文字 | 良好 |
| ヘルプ | ヘルプ \| StatsToo（スタッツー） | 17文字 | やや短い |
| 運営者情報 | 運営者情報 \| StatsToo（スタッツー） | 19文字 | やや短い |
| コラム記事 | {記事タイトル} \| StatsToo（スタッツー） | 30-50文字 | 良好 |

**評価**: 全体的に良好。ブランド名の付与パターンも統一されている。

---

### 4-2. meta description

| ページ種別 | 設定状況 | 文字数 | 評価 |
|-----------|---------|--------|------|
| トップ | あり | 約80文字 | 良好 |
| コラム一覧 | あり | 約55文字 | やや短い |
| ツールページ | あり | 30-90文字 | ばらつきあり |
| ルールページ | あり | 約70文字 | 良好 |
| コラム記事 | あり | 60-100文字 | 良好 |

#### Issue 15: 一部ページのmeta descriptionが短い

**Issue**: コラム一覧ページ（約55文字）やツールページの一部（30文字程度）でmeta descriptionが短い。

**Impact**: **低** — SERP上のクリック率に影響する可能性がある。

**Fix**: 全ページのmeta descriptionを80-120文字（日本語）に調整。検索意図に合ったCTAを含める。

---

### 4-3. 見出し構造（コラム記事）

コラム記事の見出し構造は**全体的に良好**:
- H1: 記事タイトル（1つ）
- H2: 主要セクション（6-10個）
- H3: サブセクション（適切に階層化）

**評価**: コラム記事の見出し構造はSEOベストプラクティスに準拠。修正不要。

---

### 4-4. コンテンツ品質

| コンテンツ種別 | 記事数 | 平均文字数 | 評価 |
|---------------|--------|-----------|------|
| コラム記事 | 59本 | 4,500-7,000文字 | 良好 |
| ツールページ | 6ページ | 説明部分1,000-2,000文字 | 最低限 |
| ルールページ | 2ページ | 2,500-3,000文字 | 適切 |

**評価**: コラム記事のコンテンツ量・品質は十分。ツールページの説明コンテンツは増強の余地あり。

---

## 5. E-E-A-T（経験・専門性・権威性・信頼性）

### 現状評価

| E-E-A-T要素 | 状況 | 評価 |
|-------------|------|------|
| 経験（Experience） | 運営者が小学5年からバスケ継続 | 記載あり |
| 専門性（Expertise） | Webエンジニア・SEOコンサルタント | 記載あり |
| 権威性（Authoritativeness） | 外部被リンク・引用は未確認 | 不十分 |
| 信頼性（Trustworthiness） | プライバシーポリシー・利用規約あり | 基本的に良好 |

#### Issue 16: 著者情報の充実化が必要

**Issue**: コラム記事の著者は「StatsToo編集部」のみ。構造化データのauthor.nameも「StatsToo編集部」で個人名なし。`/about/`ページには運営者個人情報があるが、記事ページからリンクされていない。

**Impact**: **中** — YMYL（Your Money Your Life）カテゴリではないが、E-E-ATの「Experience」と「Expertise」を示すために著者プロフィールページへのリンクが有効。

**Fix**:
1. 各コラム記事に著者プロフィールへのリンクを追加
2. 構造化データのauthorに `/about/` ページのURLを追加
3. 著者のバスケットボール経験（プレイ歴、チーム経験等）をより詳しく記載

---

## 6. SNS・ソーシャルシグナル

#### Issue 17: SNS連携が最小限

**Issue**: 外部SNSリンクはInstagramアカウント（`@statstoo_2026`）のみ。OGP未実装と合わせて、SNS経由の流入・拡散機会を逃している。

**Impact**: **中** — バスケットボールコンテンツはSNS（特にX/Twitter、YouTube）での拡散が見込めるジャンル。

**Fix**:
1. OGPタグを全ページに実装（Issue 5で記載）
2. 記事ページにSNSシェアボタンを設置
3. X/Twitter、YouTubeなど追加SNSプラットフォームの運用を検討

---

## 7. その他の改善提案

### 7-1. ページ表示速度

**観察**: ツールページはJavaScriptで動的にUIを構成（React/Next.js等のSPA構成の可能性）。

**推奨**: PageSpeed Insightsでの計測を推奨。特にLCP（Largest Contentful Paint）とINP（Interaction to Next Paint）の確認が必要。SPAの場合、SSR/SSGの活用が重要。

### 7-2. コラム一覧のページネーション未実装

**Issue**: 59記事が1ページに全て表示されている（ページネーションなし）。

**Impact**: **低** — 現在の記事数なら大きな問題ではないが、100記事を超えると初期読み込みが遅くなる。

**Fix**: 20-30記事ごとにページネーション（`/column/page/2/` 等）を実装するか、無限スクロール + `<link rel="next">` での対応を検討。

### 7-3. 404ページの確認

**観察**: `/column/basketball-shooting-tips/`、`/column/basketball-dribble-basics/`、`/column/basketball-defense-basics/` が404を返した。これらがサイトマップに含まれている場合、クロールエラーの原因となる。

**Fix**: XMLサイトマップから存在しないURLを除去。Search Consoleでクロールエラーを確認。

### 7-4. コピーライト年号

**観察**: フッターのコピーライト表記が「© 2025 StatsToo」。

**Fix**: 現在年（2026年）に更新、または「© 2025-2026 StatsToo」に変更。

---

## 8. 優先アクションプラン

### 最緊急（即日対応）

| # | アクション | 対象 | 工数目安 |
|---|-----------|------|---------|
| 1 | `<meta name="viewport">` を全ページに追加 | 全70ページ | テンプレート1箇所修正で一括対応 |
| 2 | `<html lang="ja">` 属性を追加 | 全70ページ | テンプレート1箇所修正で一括対応 |
| 3 | H1タグが存在しないページにH1を追加（トップ、ルール等） | 3-4ページ | 小 |

### 緊急（1-2週間以内）

| # | アクション | 対象 | 工数目安 |
|---|-----------|------|---------|
| 4 | 全ページにOGPタグ + Twitter Cardを実装 | 全70ページ | テンプレート修正で一括対応可 |
| 5 | 全ページにcanonical tagを実装 | 全70ページ | テンプレート修正で一括対応可 |
| 6 | 全画像にalt属性を設定（ロゴ画像のalt統一含む） | 全ページ | 中（画像ごとに個別設定） |

### 高優先度（1ヶ月以内）

| # | アクション | 対象 | 工数目安 |
|---|-----------|------|---------|
| 7 | ツールページにSoftwareApplication構造化データ追加 | 6ページ | 小 |
| 8 | ヘルプページにFAQPage構造化データ追加 | 1ページ | 小 |
| 9 | トップページにOrganization構造化データ追加 | 1ページ | 小 |
| 10 | パンくずリストにBreadcrumbList構造化データ追加 | コラム全記事 | テンプレート修正で一括対応可 |
| 11 | XMLサイトマップにlastmod追加 + URL同期 | sitemap.xml | 小 |

### 中優先度（1-3ヶ月）

| # | アクション | 対象 | 工数目安 |
|---|-----------|------|---------|
| 12 | コラム記事間の内部リンク強化（関連記事セクション充実化） | 59記事 | 中〜大 |
| 13 | 著者プロフィールページの充実化 + 記事からのリンク | /about/ + 全記事 | 小〜中 |
| 14 | meta descriptionの短いページを調整 | 5-10ページ | 小 |

### 長期改善（3ヶ月以上）

| # | アクション | 対象 | 工数目安 |
|---|-----------|------|---------|
| 15 | トピッククラスター戦略の構築（戦術系・ルール系・練習法系のピラーページ） | 新規3-5ページ | 大 |
| 16 | ツールページのコンテンツ拡充（使い方ガイド、活用事例等） | 6ページ | 中 |
| 17 | SNS運用の拡大（X/Twitter、YouTube等） + シェアボタン設置 | 全サイト | 中 |
| 18 | PageSpeed Insights計測 + Core Web Vitals最適化 | 全ページ | 要計測後判断 |

---

## 9. 監査サマリーテーブル

| カテゴリ | 評価 | 主要課題 |
|---------|------|---------|
| HTML基盤 | **D** | viewport未実装、lang属性未実装、主要ページH1なし |
| クロール・インデックス | C+ | サイトマップlastmod未設定、canonical全欠落 |
| テクニカルSEO | C- | OGP全欠落、構造化データ不足 |
| オンページSEO | B | title/description良好、alt欠落 |
| コンテンツ品質 | B+ | コラム記事は充実、ツールページは薄い |
| E-E-A-T | B- | 著者情報最低限、外部権威性不足 |
| 内部リンク | C+ | 記事間リンク不足、関連記事未充実 |
| SNS・ソーシャル | D | OGP未実装、SNS連携最小限 |

**総合評価: C+**（コンテンツ品質は良好だが、HTML基盤とテクニカル面に致命的な欠落がある。viewport・lang属性の即日対応が最優先）
