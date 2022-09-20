Rails.application.routes.draw do
  # Define your application routes per the DSL in https:/article//article/guides.rubyonrails.org/article/routing.html
  root 'articles#index'
  scope :article do
    get '/:id', to: 'articles#article'
    get '/', to: 'articles#page'
    post '/', to: 'articles#create'
  end
end
