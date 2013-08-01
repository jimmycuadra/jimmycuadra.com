JimmycuadraCom::Application.routes.draw do
  # default route
  root to: "posts#index"

  # restful routes
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  get "comments/preview" => "comments#preview", as: :preview

  resources :tags, only: [:index, :show]

  # static pages
  get "/projects" => "pages#projects", as: :projects
  get "/resume" => "pages#resume", as: :resume
  get "/about" => redirect("/resume")

  # sessions
  get "/login" => "sessions#new", as: :new_login
  post "/login" => "sessions#create", as: :login
  get "/logout" => "sessions#destroy", as: :logout

  # legacy routes
  get "screencasts/1-*seo" => redirect("/posts/screencast-equalizing-column-heights-with-jquery")
  get "screencasts/2-*seo" => redirect("/posts/screencast-actionmailer-and-gmail")
  get "screencasts/3-*seo" => redirect("/posts/screencast-default-form-values-with-jquery")

  get "blog/1-*seo"  => redirect("/posts/big-update-new-blog-and-more")
  get "blog/2-*seo"  => redirect("/posts/frameworks-do-they-speed-things-up-or-slow-things-down")
  get "blog/3-*seo"  => redirect("/posts/twilight-site-launched")
  get "blog/4-*seo"  => redirect("/posts/kalenabovellcom-launched")
  get "blog/5-*seo"  => redirect("/posts/moxiemaster-application-under-development")
  get "blog/6-*seo"  => redirect("/posts/secure-authentication-with-javascript")
  get "blog/7-*seo"  => redirect("/posts/adventures-into-ruby-and-rails")
  get "blog/8-*seo"  => redirect("/posts/the-html-5-buzz-why-it-matters")
  get "blog/9-*seo"  => redirect("/posts/jimmy-cuadra-on-rails")
  get "blog/10-*seo" => redirect("/posts/from-cake-to-rails")
  get "blog/11-*seo" => redirect("/posts/can-google-chrome-frame-really-help")
  get "blog/12-*seo" => redirect("/posts/css3-transitions-and-animation-presentation-or-behavior")
  get "blog/13-*seo" => redirect("/posts/jimmy-cuadra-featured-on-html5-gallery")
  get "blog/14-*seo" => redirect("/posts/what-it-do-what-it-do")
  get "blog/15-*seo" => redirect("/posts/organizing-javascript-with-namespaces-and-function-prototypes")
  get "blog/16-*seo" => redirect("/posts/understanding-jquery-14s-proxy-method")
  get "blog/17-*seo" => redirect("/posts/do-websites-need-to-look-the-same-in-every-browser")
  get "blog/18-*seo" => redirect("/posts/checking-for-one-key-among-several-in-a-ruby-hash")
  get "blog/19-*seo" => redirect("/posts/javascript-factory-constructors")
  get "blog/20-*seo" => redirect("/posts/a-t-shirt-idea")
  get "blog/21-*seo" => redirect("/posts/keeping-track-of-javascript-event-handlers")
  get "blog/22-*seo" => redirect("/posts/metaprogramming-ruby-class-eval-and-instance-eval")
  get "blog/23-*seo" => redirect("/posts/project-roadmap")
  get "blog/24-*seo" => redirect("/posts/githubs-inflexible-pricing-model")
  get "blog/25-*seo" => redirect("/posts/to-lang-a-ruby-library-for-translating-strings")
end
