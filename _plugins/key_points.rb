# 記事末尾の「まとめ」セクションの箇条書きを抽出し、冒頭のリード要約ブロック用に
# page.data["key_points"] へ格納する。
#
# 生成AIや検索エンジンは冒頭の要約を引用の起点にしやすい。本文（筆者自身のまとめ）
# をそのまま使うため、要約と本文の内容が食い違うことはない。
# frontmatter に key_points を書いた記事はそちらを優先する。
module StatsToo
  module KeyPoints
    SUMMARY_HEADING = /\A##\s+.*(?:まとめ|結論)/.freeze
    H2 = /\A##\s+/.freeze
    LIST_ITEM = /\A(?:\d+\.|[-*])\s+(.+?)\s*\z/.freeze
    MAX_POINTS = 5

    def self.plain_text(text)
      text.gsub(/\[([^\]]+)\]\([^)]*\)/, '\1')
          .gsub(/[*_]{1,3}([^*_]+)[*_]{1,3}/, '\1')
          .gsub(/`([^`]*)`/, '\1')
          .gsub(%r{<br\s*/?>}i, " ")
          .gsub(/<[^>]+>/, "")
          .gsub(/\s+/, " ")
          .strip
    end

    def self.extract(content)
      return [] if content.nil? || content.empty?

      points = []
      in_section = false

      content.each_line do |raw_line|
        line = raw_line.chomp

        if line =~ SUMMARY_HEADING
          in_section = true
          next
        elsif in_section && line =~ H2
          break
        end

        next unless in_section

        if (match = line.match(LIST_ITEM))
          text = plain_text(match[1])
          points << text unless text.empty?
        end
      end

      points.first(MAX_POINTS)
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  site.pages.each do |page|
    next unless page.data["layout"] == "column"
    next if page.data["key_points"]

    points = StatsToo::KeyPoints.extract(page.content)
    page.data["key_points"] = points unless points.empty?
  end
end
