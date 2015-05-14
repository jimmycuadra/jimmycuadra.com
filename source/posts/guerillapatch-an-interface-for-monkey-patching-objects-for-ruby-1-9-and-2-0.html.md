---
title: "GuerillaPatch: An interface for monkey patching objects for Ruby 1.9 and 2.0"
date: "2012-11-02 19:03 PDT"
tags: "ruby"
---
At RubyConf this week, the first preview of the upcoming Ruby 2.0 was released. One of the new features is *refinements*, a way of adding new behavior to an object that only takes place within a certain scope. This allows a safer way to extend existing objects without screwing up code that may be depending on the original behavior. A common example of this is ActiveSupport, which adds extensions to many of the core classes. With refinements, these extensions can be added to a refinement module, which can then be "used" in other namespaces without affecting the object globally.

This is a powerful new feature, but I was curious how best to write library code that uses it in a way that is interoperable with Ruby 1.9. I created a gem called **GuerillaPatch** which provides a single interface that will extend an object with a refinement if run under Ruby 2.0, and fall back to simply modifying the class globally if run under 1.9.

Install with `gem install guerilla_patch`. The [source code](https://github.com/jimmycuadra/guerilla_patch) and usage examples are available on GitHub.
