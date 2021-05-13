Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users
  resource :profile, only: %i[show] do
    resources :books, only: %i[show], controller: 'profiles/books'
  end
  resources :books, only: %i[new create] do
    post '/contacts/import', to: 'books#import_contacts'
  end
end
