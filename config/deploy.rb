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
after 'deploy:update_code',     'deploy:custom_symlink'

role :app, "inno"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  desc "Make symlink for database yaml"
  task :custom_symlink do
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
end

namespace :abwesend do
  desc "Compress assets in a local file"
  task :compress_assets do
    run_locally("rm -rf public/assets/*")
    run_locally("bundle exec rake assets:precompile")
  end

  desc "Upload assets"
  task :upload_assets do
    find_servers_for_task(current_task).each do |current_server|
      run_locally("rsync --delete -avz -e ssh 'public/assets' '#{user}@#{current_server}:#{shared_path}'")
    end

    run_locally("rm -rf public/assets/*")
  end
end
