Rails.application.routes.draw do
  # Define your application routes per the DSL in https:/article//article/guides.rubyonrails.org/article/routing.html
  root 'articles#index'
  scope :article do
    get '/:id', to: 'articles#show'
    get '/', to: 'articles#index'
    post '/', to: 'articles#create'
  end
  scope :user do
    post '/login', to: 'authors#login'
    post '/signup', to: 'authors#signup'
    get '/profile', to: 'authors#profile'
  end
end
