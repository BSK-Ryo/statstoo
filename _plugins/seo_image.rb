# OGP画像（og:image / twitter:image）を全ページで必ず出力するためのフック。
#
# - frontmatter の thumbnail を jekyll-seo-tag が参照する image に引き継ぐ
# - thumbnail の実ファイルが存在しない場合は無視し、サイト共通の /ogp.png を使う
# - thumbnail_valid をセットし、レイアウト側で404画像を <img> に出さないようにする
# - ページが明示的に image を指定している場合はそれを優先する
DEFAULT_OGP_IMAGE = "/ogp.png".freeze

Jekyll::Hooks.register :site, :post_read do |site|
  site.pages.each do |page|
    thumbnail = page.data["thumbnail"]
    thumbnail_valid = false

    if thumbnail.is_a?(String) && !thumbnail.empty?
      relative = thumbnail.sub(%r{\A/}, "")
      thumbnail_valid = File.file?(File.join(site.source, relative))
      page.data["thumbnail_valid"] = thumbnail_valid
    end

    next if page.data["image"]

    page.data["image"] = thumbnail_valid ? thumbnail : DEFAULT_OGP_IMAGE
  end
end
