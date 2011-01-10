JimmycuadraCom::Application.routes.draw do
  root :to => "posts#index"

  resources :posts

  match "projects" => "projects#index", :as => :projects
  match "about" => "about#index", :as => :about
end
