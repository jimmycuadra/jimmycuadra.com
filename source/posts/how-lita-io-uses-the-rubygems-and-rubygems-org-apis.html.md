---
title: "How Lita.io uses the RubyGems and rubygems.org APIs"
date: "2014-01-23 04:09 PST"
tags: "lita, ruby"
---
Today I released a brand new website for Lita at [lita.io](http://www.lita.io/). While the site consists primarily of static pages for documentation, it also has a cool feature that takes advantage of a few relatively unknown things in the Ruby ecosystem. That feature is the [plugins page](http://www.lita.io/plugins), an automatically updating list of all Lita plugins that have been published to RubyGems.

Previously, the only directory of Lita plugins was Lita's wiki on GitHub. When someone released a plugin, they'd have to edit the list manually. This was not ideal. It was easy to forget, and required that people knew that the wiki had such a list in the first place. To make an automatically updating list, I had to think about how I could detect Lita plugins out there on the Internet.

I spent some time digging through the rubygems.org source code to see how I might get the information I wanted out of the API. After experimenting with a few things, I discovered an undocumented API: reverse dependencies. You can hit the endpoint `/api/v1/gems/GEM_NAME/reverse_dependencies.json` and you will get back a list of all gems that depend on the given gem. This was great! Now I had a list of names of all the gems that depend on Lita. It's pretty safe to assume those are all Lita plugins.

This API only returns the names of the gems, however. I also wanted to display a description and the authors' names. This data could be gathered from an additional API request, but there was another piece of information I wanted that couldn't be extracted from the API.

Lita has two types of plugins: adapters and handlers. Adapters allow Lita to connect to a particular chat service, and handlers add new functionality to the robot at runtime; they're the equivalent of Hubot's scripts. I wanted the plugins page to list the plugin type along with the name, author, and link to its page on rubygems.org. To do this, I used another lesser-known feature: RubyGems metadata.

In RubyGems 2.0 or greater, a gem specification can include arbitrary metadata. The metadata consists of a hash assigned to the `metadata` attribute of a `Gem::Specification`. The keys and values must all be strings. In Lita 2.7.1, I updated the templates used to generate new Lita plugins so that they automatically included metadata in their gemspecs indicating which type of plugin it is. For example:

~~~ ruby
Gem::Specification.new do |spec|
  spec.metadata = { "lita_plugin_type" => "handler" }
end
~~~

Because Lita requires Ruby 2.0 or greater, which comes with RubyGems 2.0, any Lita plugin can use the metadata attribute. Any plugins created before the generator update in Lita 2.7.1 can still be detected and listed on the plugins page, it just won't list their type.

Now all I had to do was read this information from each plugin gem. Unfortunately, rubygems.org currently has no API that exposes gem metadata, so things got a little tricky. I wrote a script which called `gem fetch` to download the actual gem files for all the Lita plugins. Once downloaded, running `gem spec` on the gem file outputs a YAML representation of the gem's specification. In Ruby, loading that YAML with `YAML.load` returns a `Gem::Specification`. From there I could simply access the fields I wanted to display, including the type of plugin via `spec.metadata["lita_plugin_type"]`. This data is then persisted in Postgres. The script runs once a day to get the latest data from RubyGems.

This process could be made much easier and less error-prone if rubygems.org added metadata to the information it exposes over its API. Nevertheless, creating the plugins page for Lita.io was a good challenge and gave me a chance to explore some of the pieces of the RubyGems ecosystem I didn't know existed.
