require "bundler/capistrano"

set :application, "abwesend.com"
set :deploy_to,   "/home/ben/#{application}"
set :scm,         :git
set :repository,  "git@github.com:beanieboi/abwesend.com.git"
set :branch,      "master"
set :user,        'ben'
set :use_sudo,    false
set :deploy_via,  :remote_cache
set :normalize_asset_timestamps, false
default_run_options[:pty] = true

after 'deploy',                 'deploy:cleanup'
after 'deploy:create_symlink',  'abwesend:upload_assets'
before 'deploy:update_code',    'abwesend:compress_assets'

role :app, "inno"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end
  after "deploy:setup", "deploy:setup_config"
end

namespace :abwesend do
  desc "Compress assets in a local file"
  task :compress_assets do
    run_locally("rm -rf public/assets/*")
    run_locally("bundle exec rake assets:precompile")
    run_locally("touch assets.tgz && rm assets.tgz")
    run_locally("tar zcvf assets.tgz public/assets/")
    run_locally("mv assets.tgz public/assets/")
  end

  desc "Upload assets"
  task :upload_assets do
    upload("public/assets/assets.tgz", release_path + '/assets.tgz')
    run_locally("rm -rf public/assets/*")
    run "cd #{release_path}; tar zxf assets.tgz; rm assets.tgz"
  end
end
