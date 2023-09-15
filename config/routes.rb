Rails.application.routes.draw do
  devise_for :users

  get '/public_recipes', to: 'recipes#public_recipes'
  get 'users/:id', to: 'application#after_sign_out_path', as: 'after_sign_out_path'  # delete '/recipes/:id/:food_id', to: 'recipes#remove_food_from_recipe', as: 'recipe_food'

  resources :foods, only: [:index, :new, :create]
      delete 'foods/:id', to: 'foods#destroy', as: 'delete_food'
  
  resources :recipes, only: [:index, :new, :show, :create, :update, :destroy] do
    resources :recipe_foods, only: [:index, :show, :new, :create]

      member do
        delete :destroy
        patch :toggle_recipe_public
        get 'add_ingredient', to: 'recipes#add_ingredient'
        post 'add_ingredient', to: 'recipes#add_ingredient'
        get 'generate_shopping_list', to: 'recipes#generate_shopping_list'
        delete 'remove', to: 'recipes#destroy', as: 'remove'
    end
  end
  
  root 'pages#home'
  resources :users, only: [:show, :edit]
end
