---
title: "Screencast: ActionMailer and Gmail"
date: "2009-09-24 06:32 PDT"
tags: "ruby, ruby on rails, screencast"
youtube_id: "iJZ8w5o_TkE"
---
This screencast shows how to set up a Ruby on Rails application to send email with ActionMailer and Gmail.

Ruby 1.8.7 and Rails 2.2.1 or later versions are required to use TLS (required for Gmail SMTP) without a plugin. If you use older versions of either Ruby or Rails, try a plugin like [action_mailer_optional_tls](https://github.com/collectiveidea/action_mailer_optional_tls/).

I've improved the quality of the video for this screencast. A high quality version is available on YouTube via the link above.

I'd like to give a big thanks to [Nebyoolae](http://nebyoolae.com/) for providing the intro sound!

Here is the code from the screencast:

~~~ ruby
# config/environments/development.rb

config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :authentication => :plain,
  :domain => 'myapp.com',
  :user_name => 'username@gmail.com',
  :password => 'password'
}
~~~

~~~ ruby
# app/models/notifier.rb

class Notifier < ActionMailer::Base
  def gmail_message
    subject     'Message via Gmail'
    recipients  'youremail@address.com'
    from        'webmaster@address.com'
    sent_on     Time.now
  end
end
~~~

~~~ erb
# app/views/notifier/gmail_message.text.plain.erb

Hello,

You are receiving this email via Gmail!
~~~

~~~ html
<!-- app/views/notifications/index.html.erb -->

<a href="/notifications/create">Send</a> a message via Gmail!
~~~

~~~ ruby
# app/controllers/notifications_controller.rb
class NotificationsController < ApplicationController
  def index
  end

  def create
    Notifier.deliver_gmail_message
    flash[:notice] = 'Your message has been sent.'
    redirect_to root_path
  end
end
~~~

~~~ ruby
# config/routes.rb

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => 'notifications', :action => 'index'
end
~~~
