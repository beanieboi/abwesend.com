require "bundler"
Bundler.require

class App < Sinatra::Base
  set :sprockets,     Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
  set :assets_prefix, "/assets"
  set :digest_assets, true
  set(:assets_path)   { File.join public_folder, assets_prefix }

  configure :production do
    use Rack::Cache,
      verbose:     settings.development?,
      metastore:   'memcached://localhost:11211/meta',
      entitystore: 'memcached://localhost:11211/body?compress=true'
  end

  configure do
    # Setup Sprockets
    sprockets.append_path File.join(root, "assets", "stylesheets")
    sprockets.append_path File.join(root, "assets", "javascripts")
    sprockets.append_path File.join(root, "assets", "images")
    sprockets.append_path File.join(root, "assets", "fonts")

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder
    end
  end

  helpers do
    include Sprockets::Helpers
  end

  get "/" do
    expires 2 * 60, :public
    erb :index
  end
end
