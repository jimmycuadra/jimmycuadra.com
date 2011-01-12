JimmycuadraCom::Application.routes.draw do
  root :to => "posts#index"

  resources :posts do
    resources :comments, :only => [:create, :destroy]
  end
  resources :tags, :only => [:index, :show, :new]

  match "projects" => "projects#index", :as => :projects
  match "about" => "about#index", :as => :about
end
