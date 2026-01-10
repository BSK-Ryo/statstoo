import os
import datetime
from google import genai

# --- 設定 ---
API_KEY = os.environ.get("GEMINI_API_KEY")
OUTPUT_DIR = "column"
# -----------

PROMPT = """
あなたはプロのWebライターです。
以下の条件に従って、バスケットボールに関する記事を1つ書いてください。

## テーマ
バスケットボールの初心者向け戦術、または練習法、ルール解説の中からランダムに1つ選定。

## 必須フォーマット（厳守）
---
layout: column
title: "{{32文字以内のSEOタイトル}}"
description: "{{120文字程度の説明文}}"
date: {{YYYY-MM-DD}}
update: {{YYYY-MM-DD}}
author: StatsToo編集部
category: 戦術
tags:
  - バスケットボール
  - 初心者
thumbnail: /image/column/sample-thumbnail.jpg
excerpt: "{{記事一覧用 100文字要約}}"
toc: true
permalink: /column/{{英数字のスラッグ}}/
---

{{以下、見出しH2、H3を使って本文を作成}}
"""

def main():
    if not API_KEY:
        print("Error: API Keyが見つかりません。GitHub Secretsを確認してください。")
        return

    try:
        # 新しいクライアントの初期化
        client = genai.Client(api_key=API_KEY)
        
        # 記事生成 (モデル名を指定)
        response = client.models.generate_content(
            model='gemini-1.5-flash',
            contents=PROMPT
        )
        
        content = response.text.replace("```markdown", "").replace("```", "").strip()

        # 保存処理
        os.makedirs(OUTPUT_DIR, exist_ok=True)
        today = datetime.date.today()
        filename = f"{today}-auto.md"
        filepath = os.path.join(OUTPUT_DIR, filename)

        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        
        print(f"Success: {filepath} を作成しました")

    except Exception as e:
        print(f"Error: {e}")
        exit(1)

if __name__ == "__main__":
    main()