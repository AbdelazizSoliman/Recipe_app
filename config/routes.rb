Rails.application.routes.draw do
  devise_for :users

  get '/public_recipes', to: 'recipes#public_recipes'
  delete '/recipes/:id/:food_id', to: 'recipes#remove_food_from_recipe', as: 'recipe_food'

  resources :foods, only: [:index, :new, :create, :destroy]
  
  resources :recipes, only: [:index, :new, :show, :create, :update, :destroy] do
    resources :recipe_foods, only: [:index, :show, :new, :create]

      member do
        delete :destroy
        patch :toggle_recipe_public
        get 'add_ingredient', to: 'recipes#add_ingredient'
        post 'add_ingredient', to: 'recipes#add_ingredient'
        get 'generate_shopping_list', to: 'recipes#generate_shopping_list'
        delete 'remove_food'
    end
  end
  
  root 'foods#index'
  resources :users, only: [:show, :edit]
end
