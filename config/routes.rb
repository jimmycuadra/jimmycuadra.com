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

  # omniauth callback
  match "auth/:provider/callback" => "authentications#create"

  # sessions
  match "login/:provider" => "sessions#create", :as => :login
  match "logout" => "sessions#destroy", :as => :logout
end
