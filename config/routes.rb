WebMProcessor::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :settings
      resources :encoding_jobs do
      	resource :movie
      end
    end
  end
end