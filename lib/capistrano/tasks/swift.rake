namespace :swift do

  desc '編譯 Swift。'
  task :build do
    on roles(:app) do
      within release_path do
        execute :docker,
          "run --rm \
           -v #{current_path}:/app \
           -v #{shared_path}/.build:#{shared_path}/.build \
           -w='/app' \
           #{fetch(:application)} swift build -c release"
      end
    end
  end

end
