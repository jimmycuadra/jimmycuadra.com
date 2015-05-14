---
title: "to_lang 0.3.0: featuring batch translations and a command line utility"
date: "2011-03-15 00:44 PDT"
tags: "ruby, to_lang"
---
**to_lang** is a gem I wrote for doing translations with the Google Translate API. It adds magic translation methods directly to strings, so you can run things like `"How's it going?".to_spanish` and `"I hope everyone is okay!".from_english_to_japanese`.

I just released version 0.3.0, which adds two great new features: batch translations using arrays and a command line utility. All the methods that were previously available to strings are now available to arrays as well, so you can do this:

~~~ ruby
["Uno", "Dos", "Tres"].to_english
# => ["One", "Two", "Three"]
~~~

As you can see, this is much simpler than looping through a collection of strings and calling a translation method on each one. It's also much more efficient because it only makes one HTTP request to the API.

The command line utility gives you a quick and dirty way to run a translation directly from the shell. You run it like this:

~~~
$ to_lang --key YOUR_API_KEY --to es "hello world"
hola mundo
~~~

You can translate multiple strings at once by simply passing more parameters. If your API key is available in the environment variable `GOOGLE_TRANSLATE_API_KEY`, you can leave out the `--key` option. You can specify the source language with the `--from` option as well.

~~~
$ to_lang --from en --to es one two three
uno
dos
tres
~~~

Give it a try! I hope you find it useful and fun!

* `gem install to_lang`
* [Source on GitHub](https://github.com/jimmycuadra/to_lang)
* [API Documentation on RubyDoc](http://rubydoc.info/gems/to_lang/0.3.0/frames)
* [Gem on RubyGems](https://rubygems.org/gems/to_lang)
