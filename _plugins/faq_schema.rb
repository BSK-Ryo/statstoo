# 記事本文の「よくある質問」セクションから FAQPage 構造化データ用のデータを抽出する。
#
# 対象: H2見出しに「よくある質問」または「FAQ」を含むセクション。
#       その中の H3 を質問、直後の本文を回答として扱う。
# 結果は page.data["faq"] に [{ "question" => ..., "answer" => ... }, ...] として入り、
# _layouts/column.html が FAQPage の JSON-LD を出力する。
#
# 本文に実際に表示されているQ&Aだけを対象にしているため、構造化データと
# ページ内容が食い違うことはない（Googleのガイドライン上も必須の条件）。
module StatsToo
  module FaqSchema
    FAQ_HEADING = /\A##\s+.*(?:よくある質問|FAQ|Q&A)/.freeze
    H2 = /\A##\s+/.freeze
    H3 = /\A###\s+(.+?)\s*\z/.freeze

    # Markdown/HTML の装飾を落として構造化データ用のプレーンテキストにする
    def self.plain_text(text)
      text.gsub(/\[([^\]]+)\]\([^)]*\)/, '\1')   # リンク → テキスト
          .gsub(/[*_]{1,3}([^*_]+)[*_]{1,3}/, '\1') # 強調
          .gsub(/`([^`]*)`/, '\1')                # インラインコード
          .gsub(%r{<br\s*/?>}i, " ")
          .gsub(/<[^>]+>/, "")                    # 生HTML
          .gsub(/\A[-*]\s+/, "")                  # リストマーカー
          .gsub(/\s+/, " ")
          .strip
    end

    def self.extract(content)
      return [] if content.nil? || content.empty?

      faqs = []
      current = nil
      in_section = false

      content.each_line do |raw_line|
        line = raw_line.chomp

        if line =~ FAQ_HEADING
          in_section = true
          next
        elsif in_section && line =~ H2
          break # 次のH2でセクション終了
        end

        next unless in_section

        if (match = line.match(H3))
          faqs << current if current && !current["answer"].empty?
          current = { "question" => plain_text(match[1]), "answer" => "" }
        elsif current && !line.strip.empty?
          separator = current["answer"].empty? ? "" : " "
          current["answer"] = current["answer"] + separator + plain_text(line)
        end
      end

      faqs << current if current && !current["answer"].empty?
      faqs.reject { |faq| faq["question"].empty? || faq["answer"].empty? }
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  site.pages.each do |page|
    next unless page.data["layout"] == "column"

    faqs = StatsToo::FaqSchema.extract(page.content)
    page.data["faq"] = faqs unless faqs.empty?
  end
end
