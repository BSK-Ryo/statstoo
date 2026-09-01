require "time"

# コラム記事に関連記事（内部リンク）を自動で割り当てるフック。
#
# 記事間の内部リンクはトピッククラスターの形成に効き、検索エンジン・AIクローラーの
# どちらに対しても「このサイトはこの分野をまとめて扱っている」というシグナルになる。
#
# スコアリング:
#   共通タグ1つにつき +10 / 同カテゴリーで +5
#   同点は新しい記事を優先
# 結果は page.data["related_urls"] に URL の配列として入る（レイアウト側で解決する）。
RELATED_POSTS_LIMIT = 4

module StatsToo
  module RelatedPosts
    GENERIC_TAGS = ["バスケットボール"].freeze

    def self.sort_key(page, score)
      date = page.data["date"]
      timestamp =
        case date
        when Time     then date.to_i
        when Date     then date.to_time.to_i
        when String   then (Time.parse(date).to_i rescue 0)
        else 0
        end
      [-score, -timestamp, page.url]
    end

    def self.significant_tags(page)
      Array(page.data["tags"]) - GENERIC_TAGS
    end
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  columns = site.pages.select { |page| page.data["layout"] == "column" }

  columns.each do |page|
    tags = StatsToo::RelatedPosts.significant_tags(page)
    category = page.data["category"]

    ranked = columns.reject { |other| other.url == page.url }.map do |other|
      score = (StatsToo::RelatedPosts.significant_tags(other) & tags).size * 10
      score += 5 if category && other.data["category"] == category
      [StatsToo::RelatedPosts.sort_key(other, score), other]
    end

    page.data["related_urls"] = ranked.sort_by(&:first)
                                      .first(RELATED_POSTS_LIMIT)
                                      .map { |_key, other| other.url }
  end
end
