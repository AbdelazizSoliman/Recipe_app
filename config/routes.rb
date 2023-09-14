Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, only: [:index, :new, :create]
  delete 'foods/:id', to: 'foods#delete', as: 'delete_food'


  root 'foods#index'
  resources :users, only: [:show, :edit]


end
