# config valid for current version and patch releases of Capistrano
lock "~> 3.17.2"

set :application, "gatewood"
set :repo_url, "git@github.com:tenforwardconsulting/gatewood.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/u/apps/gatewood"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/application.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "config/puma"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :ssh_options, verify_host_key: :always, forward_agent: true

after "deploy:published", "deploy:restart"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      execute :sudo, 'systemctl restart puma'
    end
    # on roles(:app), in: :sequence, wait: 5 do
    #   execute :sudo, 'systemctl restart sidekiq'
    # end
  end
end
