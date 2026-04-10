# Set last_modified_at from update or date frontmatter for jekyll-sitemap lastmod
Jekyll::Hooks.register :pages, :post_init do |page|
  if page.data["update"]
    page.data["last_modified_at"] ||= page.data["update"]
  elsif page.data["date"]
    page.data["last_modified_at"] ||= page.data["date"]
  end
end
