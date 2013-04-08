require 'bundler/capistrano'

set :application, 'smedgd'
# set :repository, 'git@github.com:metalhelix/smedgd.git'
set :repository, 'git://github.com/metalhelix/smedgd.git'

set :domain, 'smedgdkc03'

set :scm, :git
set :scm_username, 'vlandham'
set :branch, 'master'
set :scm_verbose, true
set :ssh_options, { :forward_agent => true }
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache

set :deploy_to, "/var/www/#{application}"
set :user, 'deployer'
set :use_sudo, false


role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end



# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

