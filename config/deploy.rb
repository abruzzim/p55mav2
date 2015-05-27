puts "%DEPLOY-I-TRACE, config/deploy.rb called."

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'p55ma'
set :repo_url, 'git@github.com:abruzzim/p55mav2.git'
set :rbenv_ruby, '2.2.0'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/p55ma'

# Default value for :log_level is :debug
set :log_level, :debug

namespace :deploy do

	desc 'Restart Passenger application server'
	task :restart do
		puts "%DEPLOY-I-TRACE, config/deploy.rb deploy:restart called."
		on roles(:web), in: :sequence, wait: 5 do
			execute :touch, release_path.join('tmp/restart.txt')
		end
	end
	after :publishing, 'deploy:restart'
	after :finishing, 'deploy:cleanup'

end
