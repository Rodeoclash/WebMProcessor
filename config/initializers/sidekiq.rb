require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_MONITOR_USER'], ENV['SIDEKIQ_MONITOR_PASSWORD']]
end

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => ENV['SIDEKIQ_NAMESPACE'] }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => ENV['SIDEKIQ_NAMESPACE'] }
end