---
title: "Getting started with Lita"
date: "2013-08-20 01:17 PDT"
tags: "lita, ruby"
---
[Lita](http://lita.io/) is an extendable chat bot for Ruby programmers that can work with any chat service. If you've used Hubot before, Lita is similar, but written in Ruby instead of JavaScript. It's easy to get started, and you can have your own bot running in minutes.

Lita uses regular RubyGems as plugins. You'll need at least one "adapter" gem to connect to the chat service of your choice. Add as many "handler" gems as you want to add functionality to your bot.

1.  Install the *lita* gem.

    ~~~ text
    $ gem install lita
    ~~~

1.  Create a new Lita project.

    ~~~ text
    $ lita new
    ~~~

    This will create a new directory called *lita* with a Gemfile and Lita configuration file.

1.  Edit the Gemfile, uncommenting or adding the plugins you want to use. There should be an adapter gem (such as [lita-hipchat](https://github.com/jimmycuadra/lita-hipchat) or [lita-irc](https://github.com/jimmycuadra/lita-irc)) and as many handler gems as you'd like. For example:

    ~~~ ruby
    source "https://rubygems.org"

    gem "lita"
    gem "lita-hipchat"
    gem "lita-karma"
    gem "lita-google-images"
    ~~~

1.  Install all the gems you specified in the Gemfile:

    ~~~ text
    $ bundle install
    ~~~

1.  Install Redis. On OS X, you can use Homebrew with `brew install redis`.

1.  Test Lita out right in your terminal with the built-in shell adapter.

    ~~~ text
    $ bundle exec lita
    ~~~

    Type "Lita: help" to get a list of commands available to you.

1.  Edit the Lita configuration file to add connection information for the chat service you're using. For example, if you're using the HipChat adapter, it might look something like this:

    ~~~ ruby
    Lita.configure do |config|
      config.robot.name = "Lita Bot"
      config.robot.adapter = :hipchat
      config.adapter.jid = "12345_123456@chat.hipchat.com"
      config.adapter.password = "secret"
      config.adapter.rooms = :all
    end
    ~~~

    You'll want to consult the documentation for whichever adapter you're using for all the configuration options. If you're going to deploy Lita to Heroku, you'll want to add the Redis To Go add on and set `config.redis.url = ENV["REDISTOGO_URL"]`.

1.  Deploy your Lita project anywhere you like. If you're deploying to Heroku, you can use a Procfile like this:

    ~~~ text
    web: bundle exec lita
    ~~~

    Lita also has built-in support for daemonization if you want to deploy it to your own server.

Be sure to visit the [Lita](http://lita.io/) home page for lots more information on usage, configuration, and adding your own behavior to your robot!
