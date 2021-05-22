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
      mount_devise_token_auth_for 'User', at: 'auth',
                                  controller: { sessions: 'api/v1/sessions' }
      resources :books, only: [:create] do
        post '/contacts/import', to: 'books#import_contacts'
      end
      resources :profiles, only: [:show] do
        resources :books, only: [:show], controller: 'profiles/books'
      end
    end
  end
end
