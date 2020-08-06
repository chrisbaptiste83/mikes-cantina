Rails.application.routes.draw do
  
  devise_for :users
  
  resources :categories, only: [:show, :index]
  
  root to: 'home#index' 
  get '/home/index', to: 'home#index' 

  resources :users, only: [:show] do 
    resources :cocktail_recipes, only: [:show, :index, :new]
  end 

  resources :ingredients 
  
  resources :cocktail_recipes do 
    resources :ingredients 
    resources :comments
  end
  
end