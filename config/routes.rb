Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/public_recipes', to: 'recipes#public_recipes'
  delete '/recipes/:id/:food_id', to: 'recipes#remove_food_from_recipe', as: 'recipe_food'


  resources :foods, only: [:index, :new, :create]
  delete 'foods/:id', to: 'foods#delete', as: 'delete_food'

  
  resources :recipes, only: [:index, :new, :show, :create, :update, :destroy] do
    resources :recipe_foods, only: [:index, :show, :new, :create]
  end

  root 'foods#index'
  resources :users, only: [:show, :edit]


end
