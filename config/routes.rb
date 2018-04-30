Rails.application.routes.draw do
  get 'articles/search'
  devise_for :users, controllers: {
  	sessions: "users/sessions",
  	registrations: "users/registrations",
  	passwords: "users/passwords"
  }
  resources :categories
  resources :articles do
    resources :comments
  end
  post "contacts/new"
  get 'welcomes/contactos'
  resources :contacts, only: [:create, :new]

  root 'articles#index'





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
