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

after 'deploy:finalize_update', 'deploy:symlink_config'
after 'deploy',                 'deploy:cleanup'

role :app, "inno"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
end
