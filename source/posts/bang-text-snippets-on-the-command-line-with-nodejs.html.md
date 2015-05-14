---
title: "Bang: text snippets on the command line with Node.js"
date: "2011-11-14 01:33 PST"
tags: "bang, coffeescript, jasmine, javascript, node.js"
---
There's a great Ruby gem called [Boom](https://github.com/holman/boom) by [Zach Holman](https://github.com/holman) for managing text snippets via the command line. I've used it since it was released and have even contributed to it a few times. But after using it for a long time, I realize that I don't really need the "lists" feature – the ability to store snippets with keys two levels deep. Because of Boom's syntax, I often accidentally create lists because I can't quite remember the name of the key I'm looking for.

I decided this was a good prompt for a new program, so I created [Bang](https://github.com/jimmycuadra/bang). Bang is a module for [Node](http://nodejs.org) that gives you a very simple key value store with one level of depth. I use it to store all sorts of things: articles I refer to often, simple code snippets, Imgur links to animated GIFs, and strings with Unicode characters that are a pain to type.

For those, like me, who are experimenting with Node, [CoffeeScript](http://coffeescript.org), testing using [Jasmine](http://pivotal.github.com/jasmine/), and annotated source using [Docco](http://jashkenas.github.com/docco/), you will want to check out the source on GitHub to see some examples of all of these.

## Install Bang

Install [Node](http://nodejs.org/) and [npm](http://npmjs.org/).

~~~ text
$ npm install -g bang
~~~

## Set a key

~~~ text
$ bang apples oranges
~~~

## Get a key

~~~ text
$ bang apples
oranges
~~~

"oranges" is now copied to your clipboard.

## Delete a key

~~~ text
$ bang -d apples
~~~

## List keys

~~~ text
$ bang
  foo: bar
 blah: bleh
jimmy: cuadra
 bang: is rad
~~~

## Feedback

I hope you enjoy Bang and find it useful. If you have a problem or suggestion, feel free to open an issue or send a pull request.

## TL;DR

* `npm install -g bang`
* Check out [Bang](https://github.com/jimmycuadra/bang) on GitHub
* Read the [annotated source code](http://jimmycuadra.github.com/bang/)
