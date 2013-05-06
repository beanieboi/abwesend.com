set :application, "abwesend.com"
set :deploy_to,   "/home/ben/#{application}"
set :scm,         :none
set :repository,  '_site'
set :branch,      "master"
set :user,        'ben'
set :use_sudo,    false
set :deploy_via,  :copy
set :copy_compression,  :gzip
set :normalize_asset_timestamps, false
default_run_options[:pty] = true

after 'deploy',                 'deploy:cleanup'
role :app, 'abwesend.com'

before 'deploy:update', 'deploy:update_jekyll'

namespace :deploy do
  [:start, :stop, :restart, :finalize_update].each do |t|
    desc "#{t} task is a no-op with jekyll"
    task t, :roles => :app do ; end
  end

  desc 'Run jekyll to update site before uploading'
  task :update_jekyll do
    %x(rm -rf _site/* && jekyll build)
  end
end
