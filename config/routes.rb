Rails.application.routes.draw do
  get 'movies/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'lists#index'
  resources :movies, only: :index do
    resources :bookmarks, only: %i[new create]
  end

  resources :lists, only: %i[index new create show]

  resources :bookmarks, only: :destroy
end
