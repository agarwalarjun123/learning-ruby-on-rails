Rails.application.routes.draw do
  # Define your application routes per the DSL in https:/article//article/guides.rubyonrails.org/article/routing.html
  root 'articles#index'
  namespace :v1 do
    resources :articles, only: %i[index show create]
    scope :authors do
      post '/login', to: 'authors#login'
      post '/signup', to: 'authors#signup'
      get '/profile', to: 'authors#profile'
    end
  end
end
