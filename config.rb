Time.zone = "America/Los_Angeles"

config[:css_dir] = 'stylesheets'
config[:js_dir] = 'javascripts'
config[:images_dir] = 'images'

activate :blog do |blog|
  blog.default_extension = ".md"
  blog.layout = "post"
  blog.permalink = "{title}.html"
  blog.prefix = "posts"
  blog.sources = "{title}.html"
  blog.tag_template = "tag.html"
end

activate :directory_indexes
activate :livereload

configure :build do
  activate :asset_hash
  activate :gzip
  activate :minify_css
  activate :minify_javascript
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :git
end
