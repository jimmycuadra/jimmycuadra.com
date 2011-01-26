JimmycuadraCom::Application.routes.draw do
  # default route
  root :to => "posts#index"

  # restful routes
  resources :posts do
    resources :comments, :only => [:create, :destroy]
  end
  resources :tags, :only => [:index, :show]

  # static pages
  match "projects" => "projects#index", :as => :projects
  match "about" => "about#index", :as => :about

  # sessions
  match "login" => "sessions#new", :via => :get, :as => :new_login
  match "login" => "sessions#create", :via => :post, :as => :login
  match "logout" => "sessions#destroy", :as => :logout
end
