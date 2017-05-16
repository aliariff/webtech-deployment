# config valid only for current version of Capistrano
lock '3.8.1'

set :application, 'node_app'
set :user, 'webtech'
set :repo_url, 'https://github.com/aliariff/webtech-deployment.git'
set :deploy_to, "/home/#{fetch(:user)}"
after 'deploy:finishing', 'deploy:restart_docker'

namespace :deploy do
  desc 'Restart application'
  task :restart_docker do
    on roles(:web_app) do |host|
      execute "cd #{deploy_to}/current && docker build --rm=true -t #{fetch(:application)} ."
      execute "docker stop #{fetch(:application)}; echo 0"
      execute "docker rm -fv #{fetch(:application)}; echo 0"
      execute "docker run -d -p 80:3000 --name #{fetch(:application)} #{fetch(:application)}"
    end
  end

  desc 'Stop application'
  task :stop_docker do
    on roles(:web_app) do |host|
      execute "docker stop #{fetch(:application)}; echo 0"
      execute "docker rm -fv #{fetch(:application)}; echo 0"
    end
  end
end
