require 'sidekiq/web'

WebMProcessor::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :settings
      resources :encoding_jobs
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end