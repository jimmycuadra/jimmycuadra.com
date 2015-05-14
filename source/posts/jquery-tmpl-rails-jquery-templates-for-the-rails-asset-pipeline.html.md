---
title: "jquery-tmpl-rails: jQuery Templates for the Rails asset pipeline"
date: "2011-09-09 23:58 PDT"
tags: "jquery, ruby on rails"
---
There are myriad of JavaScript templating libraries available. The one officially adopted by jQuery is the [jQuery Templates plugin](http://api.jquery.com/category/plugins/templates/). I have released [jquery-tmpl-rails](https://github.com/jimmycuadra/jquery-tmpl-rails), a gem which adds the plugin and a corresponding [Sprockets](https://github.com/sstephenson/sprockets) engine to the [asset pipeline](http://guides.rubyonrails.org/asset_pipeline.html) for Rails 3.1 applications.

## Installation

Install it the usual way by adding it to your Gemfile:

~~~ ruby
gem "jquery-tmpl-rails"
~~~

Then run the `bundle` command from the shell.

## Usage

Place individual jQuery templates in their own files with the `.tmpl` extension:

~~~ html
<!-- app/assets/javascripts/tmpl/author.tmpl -->
<div class="author">${name}</div>
~~~

In your manifest file, require the plugin followed by your individual templates. The templates are compiled and named with their Sprockets logical path:

~~~ javascript
//= require jquery-tmpl
//= require tmpl/author

$.tmpl("tmpl/author", { name: "Jimmy" }).appendTo("#author");
~~~

Feedback is appreciated! Happy templating!
