require 'bundler/capistrano'

load 'deploy/assets'

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

after 'deploy:update_code', 'deploy:symlink_db'

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :assets do
  task :precompile, :roles => :web, :except => { :no_release => true } do
    # Check if assets have changed. If not, don't run the precompile task - it takes a long time.
    force_compile = false
    changed_asset_count = 0
    begin
      from = source.next_revision(current_revision)
      asset_locations = 'app/assets/ lib/assets vendor/assets'
      changed_asset_count = capture("cd #{latest_release} && #{source.local.log(from)} #{asset_locations} | wc -l").to_i
    rescue Exception => e
      logger.info "Error: #{e}, forcing precompile"
      force_compile = false
    end
    if changed_asset_count > 0 || force_compile
      logger.info "#{changed_asset_count} assets have changed. Pre-compiling"
      run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
    else
      logger.info "#{changed_asset_count} assets have changed. Skipping asset pre-compilation"
    end
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

