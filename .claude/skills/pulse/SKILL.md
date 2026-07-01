---
name: pulse
description: Dynamic, vibrant style with thick borders, geometric shapes, high-contrast colors, and expressive typography conveying motion and vitality.
license: MIT
metadata:
  author: typeui.sh
---

<!-- TYPEUI_SH_MANAGED_START -->
# Pulse Design System Skill (Universal)

## Mission
You are an expert design-system guideline author for Pulse.
Create practical, implementation-ready guidance that can be directly used by engineers and designers.

## Brand
Pulse design style embodies vibrant, dynamic, and bold aesthetics. It uses thick borders, striking geometric shapes, high-contrast colors (like vibrant oranges), and expressive typography to convey motion, vitality, and power.

## Style Foundations
- Visual style: bold, geometric, vibrant, thick-bordered
- Typography scale: 12/14/16/20/24/32/48 | Fonts: primary=Limelight, display=Limelight, mono=JetBrains Mono | weights=400
- Color palette: primary, secondary, neutral | Tokens: primary=#EA580B, secondary=#F59E0B, background=#FFEDD5, surface=#FDBA74, text=#EA580C
- Spacing scale: 4/8/12/16/24/32/48/64
- Borders: Thick 4px borders are a signature element.


## Accessibility
WCAG 2.2 AA, keyboard-first interactions, visible focus states. High contrast is naturally achieved through bold colors and thick borders.

## Writing Tone
punchy, dynamic, motivating, bold

## Rules: Do
- prefer semantic tokens over raw values
- use thick (4px) borders for structural elements and containers
- preserve visual hierarchy with bold typography and scale
- keep interaction states explicit with scale/transform animations

## Rules: Don't
- avoid thin or delicate borders
- avoid low contrast text
- avoid inconsistent spacing rhythm
- avoid subtle or slow animations; prefer snappy, spring-based motion

## Expected Behavior
- Follow the foundations first, then component consistency.
- When uncertain, prioritize accessibility and clarity over novelty.
- Provide concrete defaults and explain trade-offs when alternatives are possible.
- Keep guidance opinionated, concise, and implementation-focused.

## Guideline Authoring Workflow
1. Restate the design intent in one sentence before proposing rules.
2. Define tokens and foundational constraints before component-level guidance.
3. Specify component anatomy, states, variants, and interaction behavior.
4. Include accessibility acceptance criteria and content-writing expectations.
5. Add anti-patterns and migration notes for existing inconsistent UI.
6. End with a QA checklist that can be executed in code review.

## Required Output Structure
When generating design-system guidance, use this structure:
- Context and goals
- Design tokens and foundations
- Component-level rules (anatomy, variants, states, responsive behavior)
- Accessibility requirements and testable acceptance criteria
- Content and tone standards with examples
- Anti-patterns and prohibited implementations
- QA checklist

## Component Rule Expectations
- Define required states: default, hover, focus-visible, active, disabled, loading, error (as relevant).
- Describe interaction behavior for keyboard, pointer, and touch.
- State spacing, typography, and color-token usage explicitly.
- Include responsive behavior and edge cases (long labels, empty states, overflow).

## Quality Gates
- No rule should depend on ambiguous adjectives alone; anchor each rule to a token, threshold, or example.
- Every accessibility statement must be testable in implementation.
- Prefer system consistency over one-off local optimizations.
- Flag conflicts between aesthetics and accessibility, then prioritize accessibility.

## Example Constraint Language
- Use "must" for non-negotiable rules and "should" for recommendations.
- Pair every do-rule with at least one concrete don't-example.
- If introducing a new pattern, include migration guidance for existing components.

<!-- TYPEUI_SH_MANAGED_END -->

<!-- ===== StatsToo プロジェクト適合メモ（typeui管理外・再pullで保持される） ===== -->
## StatsToo への適用ルール

このスキルは StatsToo（バスケのスタッツ記録・分析サイト）の既定デザイン言語として採用された。
pulse の「躍動・活力・力強さ」はスポーツサイトの世界観に合致する。実装時は **pulse の意図を、
StatsToo の既存トークンへマッピングして適用する**（pulse の生の値で上書きしないこと）。

### トークン対応表（pulse → StatsToo 実値）
| 役割 | pulse 既定 | StatsToo で使う値 |
|---|---|---|
| Primary（主アクセント） | `#EA580B` | `primary` = `#EA580C`（`light #FB923C` / `dark #C2410C`） |
| Secondary（補助アクセント） | `#F59E0B` | アンバー `#F59E0B` を採用可（強調・ハイライト用） |
| Background（地） | `#FFEDD5` | `#faf8f5`（既存のクリーム地を維持） |
| Text（本文） | `#EA580C` | `secondary` = `#1e293b`（**本文をオレンジにしない**。可読性優先） |
| Surface（カード面） | `#FDBA74` | 白〜クリーム面＋オレンジのボーダー／見出しで表現 |

### タイポグラフィ
- **見出し（display）は既存の Bebas Neue を維持**する（pulse の Limelight に置き換えない）。
  Bebas Neue はコンデンスでアスレチックな印象があり pulse の力強さと整合する。
- 本文は Noto Sans JP を維持。等幅が必要な箇所のみ JetBrains Mono を許可。

### pulse から取り入れる要素
- **太め（4px）のボーダー**を構造要素・カード・スタッツ表の枠に使い、力強さを出す。
- 幾何学的・ブロック的レイアウト、高コントラスト、明快な視覚階層。
- インタラクションは scale/transform のスナップ感あるモーション（reduced-motion に配慮）。

### やらないこと
- 本文テキストをオレンジ一色にする（可読性低下）。
- 地の色を既存クリーム `#faf8f5` から大きく変える。
- 見出しフォントを Bebas Neue から差し替える。
