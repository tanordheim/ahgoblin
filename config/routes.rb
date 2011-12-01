AhGoblin::Application.routes.draw do

  root :to => 'shopping_list#index'

  resource :session, :only => [:new, :create, :destroy]

  resources :reagent_groups, :only => [:new, :create, :edit, :update, :destroy]
  resources :reagents, :only => [:new, :create, :edit, :update, :destroy]
  resources :item_components, :only => [:new, :create]
  resources :reagent_components, :only => [:new, :create]
  resources :transformation_components, :only => [:new, :create]

  resources :items, :only => [:index]

  resources :transformations, :only => [:index, :new, :create, :edit, :update, :destroy]
  resources :transformation_reagents, :only => [:new, :create]
  resources :transformation_yields, :only => [:new, :create]

  resources :professions, :only => [:show]
  resources :recipe_groups, :only => [:new, :create, :edit, :update, :destroy]
  resources :recipes, :only => [:new, :create, :edit, :update, :destroy]
  resources :mass_recipes, :only => [:new, :create]
  resources :recipe_reagents, :only => [:new, :create]

  resources :auto_mail_characters, :only => [:index, :new, :create, :edit, :update, :destroy]
  resources :auto_mail_items, :only => [:new, :create, :destroy]

  get 'exports' => 'exports#index', :as => :exports
  get 'exports/auctioneer' => 'exports#auctioneer', :as => :auctioneer_export
  get 'exports/tradeskillmaster' => 'exports#tradeskillmaster', :as => :tradeskillmaster_export

end
