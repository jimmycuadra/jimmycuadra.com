JimmycuadraCom::Application.routes.draw do
  root :to => "posts#index"

  resources :posts
  resources :tags, :only => [:index, :show]

  match "projects" => "projects#index", :as => :projects
  match "about" => "about#index", :as => :about
end
