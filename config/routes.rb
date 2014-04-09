WebMProcessor::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :encoding_jobs
    end
  end
end