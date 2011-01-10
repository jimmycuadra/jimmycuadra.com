JimmycuadraCom::Application.routes.draw do
  resources :posts
  resources :projects, :only => :index

  root :to => "posts#index"
end
