Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users
  resource :profile, only: %i[show] do
    resources :books, only: %i[show], controller: 'profiles/books'
  end
  resources :books, only: %i[new create] do
    post '/contacts/import', to: 'books#import_contacts'
  end

  namespace :api do
    namespace :v1 do
      post '/authenticate', to: 'authentication#create'

      resources :books, only: [:create] do
        post '/contacts/import', to: 'books#import_contacts'
      end
      get 'profile', to: 'profiles#show'
      get 'profile/book/:id', to: 'profile/books#show'
    end
  end
end
