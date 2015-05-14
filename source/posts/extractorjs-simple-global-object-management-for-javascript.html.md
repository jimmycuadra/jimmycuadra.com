---
title: "Extractor.js: simple global object management for JavaScript"
date: "2011-09-16 01:19 PDT"
tags: "coffeescript, javascript"
---
I was messing around with CoffeeScript and Jasmine this evening and put together a very small library called **Extractor**. Here's the idea:

Everyone hates the global object in JavaScript, and care must be taken to manage potential variable name conflicts. Extractor works as a proxy for the global object, allowing library developers to register their libraries without touching the global object. Developers who use the library can then extract it into a variable name of their choice, possibly never touching the global object at all. The effect is similar to jQuery's `noConflict` function, but is used more like Node's `require`.

For more information (including usage examples), check out [Extractor on GitHub](https://github.com/jimmycuadra/extractor).
