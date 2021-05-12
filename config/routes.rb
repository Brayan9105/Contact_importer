Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users
  resources :books, only: %i[new create]
end
