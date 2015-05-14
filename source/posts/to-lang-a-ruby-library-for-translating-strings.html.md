---
title: "to_lang: A Ruby library for translating strings"
date: "2010-12-27 18:12 PST"
tags: "ruby, to_lang"
---
**to_lang** is a project I've been working on that is now ready for an official introduction. It's a Ruby library for translating strings, backed by the Google Translate API. **to_lang** is unique in that it allows you to call translation methods directly on strings.

The first thing to do is require the library and call the `start` method:

~~~ ruby
require 'to_lang'
ToLang.start('YOUR_GOOGLE_TRANSLATE_API_KEY')
~~~

Voilà. Strings now have access to a bunch of dynamic translation methods.

~~~ ruby
"Very cool gem!".to_spanish
# => "Muy fresco joya!"
~~~

You can use similar `to_language` methods for any of the 53 supported languages. Google Translate attempts to detect the language of the string you're translating, but sometimes the source language is ambiguous, and Google Translate may guess wrong. In this case, you can manually specify the source language by appending `_from_language` to the end of the method.

~~~ ruby
"a pie".to_spanish
# => "a pie"
"a pie".to_spanish_from_english
# => "un pastel"
~~~

All the dynamic methods are syntactic sugar for a more general method, `translate`, which is also made available to strings. You can use this as well, as it may make programmatic translations easier.

~~~ ruby
"hello world".translate('es')
# => "hola mundo"
"a pie".translate('es', :from => 'en')
# => "un pastel"
~~~

Give it a try! I'd love to get feedback on it if you do.

* Install with `gem install to_lang`
* [API documentation](http://rubydoc.info/github/jimmycuadra/to_lang/master/frames)
* [Source code on GitHub](https://github.com/jimmycuadra/to_lang)
