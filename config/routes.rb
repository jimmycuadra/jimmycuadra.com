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

  # legacy routes
  match "screencasts/1-*seo" => redirect("/posts/screencast-equalizing-column-heights-with-jquery")
  match "screencasts/2-*seo" => redirect("/posts/screencast-actionmailer-and-gmail")
  match "screencasts/3-*seo" => redirect("/posts/screencast-default-form-values-with-jquery")

  match "blog/1-*seo"  => redirect("/posts/big-update-new-blog-and-more")
  match "blog/2-*seo"  => redirect("/posts/frameworks-do-they-speed-things-up-or-slow-things-down")
  match "blog/3-*seo"  => redirect("/posts/twilight-site-launched")
  match "blog/4-*seo"  => redirect("/posts/kalenabovellcom-launched")
  match "blog/5-*seo"  => redirect("/posts/moxiemaster-application-under-development")
  match "blog/6-*seo"  => redirect("/posts/secure-authentication-with-javascript")
  match "blog/7-*seo"  => redirect("/posts/adventures-into-ruby-and-rails")
  match "blog/8-*seo"  => redirect("/posts/the-html-5-buzz-why-it-matters")
  match "blog/9-*seo"  => redirect("/posts/jimmy-cuadra-on-rails")
  match "blog/10-*seo" => redirect("/posts/from-cake-to-rails")
  match "blog/11-*seo" => redirect("/posts/can-google-chrome-frame-really-help")
  match "blog/12-*seo" => redirect("/posts/css3-transitions-and-animation-presentation-or-behavior")
  match "blog/13-*seo" => redirect("/posts/jimmy-cuadra-featured-on-html5-gallery")
  match "blog/14-*seo" => redirect("/posts/what-it-do-what-it-do")
  match "blog/15-*seo" => redirect("/posts/organizing-javascript-with-namespaces-and-function-prototypes")
  match "blog/16-*seo" => redirect("/posts/understanding-jquery-14s-proxy-method")
  match "blog/17-*seo" => redirect("/posts/do-websites-need-to-look-the-same-in-every-browser")
  match "blog/18-*seo" => redirect("/posts/checking-for-one-key-among-several-in-a-ruby-hash")
  match "blog/19-*seo" => redirect("/posts/javascript-factory-constructors")
  match "blog/20-*seo" => redirect("/posts/a-t-shirt-idea")
  match "blog/21-*seo" => redirect("/posts/keeping-track-of-javascript-event-handlers")
  match "blog/22-*seo" => redirect("/posts/metaprogramming-ruby-class-eval-and-instance-eval")
  match "blog/23-*seo" => redirect("/posts/project-roadmap")
  match "blog/24-*seo" => redirect("/posts/githubs-inflexible-pricing-model")
  match "blog/25-*seo" => redirect("/posts/to-lang-a-ruby-library-for-translating-strings")
end
