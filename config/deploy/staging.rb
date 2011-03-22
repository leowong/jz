default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# be sure to change these
set :user, 'deploy'
set :domain, 'staging.jz.ongile.com'
set :application, 'jzcrm0'
set :rails_env, 'staging'

# using mri 1.9.2
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano" # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2'

# the rest should be good
set :repository,  "git@github.com:leowong/jz.git"
set :deploy_to, "/home/#{user}/www/#{domain}"
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web
role :db, domain, :primary => true

namespace :deploy do
  desc "Restart application"
  task :restart do
    run "rvmsudo thin restart -C /etc/thin192/#{application}.yml -O"
  end

  desc "installs Bundler if it is not already installed"
  task :install_bundler, :roles => :app do
    run "sh -c 'if [ -z `which bundle` ]; then echo Installing Bundler; gem install bundler; fi'"
  end

  desc "run 'bundle install' to install Bundler's packaged gems for the current deploy"
  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install --without 'development test'"
  end
end

namespace :shared do
  desc "Upload shared config files"
  task :upload_configs do
    upload "config/database.yml", "#{shared_path}/config/database.yml"
  end

  desc "Link shared config files"
  task :link_configs do
    run %{
      for FILE in $(ls #{shared_path}/config); do
        ln -sf #{shared_path}/config/$(basename $FILE) #{release_path}/config/$(basename $FILE);
      done
    }
    run "ln -sf #{shared_path}/assets #{release_path}/public/assets"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run %{
      if [ ! -d "#{shared_path}/config" ]; then
        mkdir #{shared_path}/config;
      fi
    }
    run %{
      if [ ! -d "#{shared_path}/assets" ]; then
        mkdir #{shared_path}/assets;
      fi
    }
  end
end

after 'deploy:migrations', 'deploy:cleanup'
after 'deploy:setup', 'shared:setup_shared'
after 'deploy:setup', 'shared:upload_configs'
after 'deploy:update_code', 'shared:link_configs'
before 'deploy:bundle_install', 'deploy:install_bundler'
after 'deploy:update_code', 'deploy:bundle_install'
