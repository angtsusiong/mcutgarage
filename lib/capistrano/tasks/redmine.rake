namespace :redmine do

  desc '執行 Redmine migration。'
  task :migrate do
    on roles(:app) do
      execute "docker exec #{fetch(:application)} bundle exec rake redmine:plugins:migrate RAILS_ENV=production"
      execute "docker exec #{fetch(:application)} chown -R redmine:redmine /usr/src/redmine"
    end
  end

end
