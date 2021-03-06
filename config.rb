compass_config do |config|
  config.output_style = :compact
end

configure :development do
  activate :livereload
  activate :dotenv
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :build_dir, 'build'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
  activate :asset_hash
  activate :relative_assets
  activate :gzip

  activate :s3_sync do |sync|
    sync.bucket = ENV['AWS_BUCKET']
    sync.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    sync.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    sync.region = 'us-east-1'
  end
end

helpers do
  def render_markdown(string)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(string)
  end
end
