---
title: "jQuery is not an architecture"
date: "2012-07-11 01:26 PDT"
tags: "javascript"
---
There is no question about the enormous positive impact [jQuery](http://jquery.com/) has had on front end web development. It removes all the pain of the terrible DOM API and provides utility functions for just about everything small applications need. But when your application starts to grow, you need to structure your code in a more organized way to make sure things are testable, maintainable, and that features are discoverable to both new members of your team and your future self, who may not be able to discern the business logic of your application from looking at a slew of selectors and anonymous function callbacks.

Although jQuery has many facilities, its main purpose is as an abstraction layer to create a single, developer-friendly API that hides the ugliness of bad APIs and browser implementation quirks. Because most of its methods involve selecting, traversing, and manipulating DOM elements, the basic unit in jQuery is the selector. While this has the benefit of making DOM interaction simple and easy for beginners to learn, it has the unfortunate side effect of making people think that anything but very trivial amounts of JavaScript should be organized around jQuery selectors.

In a very simple application or basic web page, e.g. a WordPress blog, tiny snippets of jQuery or a plugin dropped into the page may be appropriate. But if you're building something with an amount of JavaScript even slightly larger than that, things will get difficult to maintain quickly.

jQuery is no substitute for good application architecture. It's just another utility library in your toolbelt. Think of jQuery simply as an abstraction of the DOM API and a way to think about Internet Explorer less often.

To illustrate just how backwards the jQuery-selector-as-basic-unit approach is for a non-trivial application, think about how it compares to the structure of an object in an object-oriented paradigm. At the most basic level, objects consist of members and methods – stateful data and functions that perform actions to manipulate that data. Methods take arguments on which they operate. In selector-as-basis jQuery, you're effectively starting with an argument (the selector), and *passing it a method* in the form of anonymous functions. This is not to say that object-oriented software is the only correct approach to writing software. The problem is that jQuery tends to make the target of an action the focus and not the action itself.

## Ways to improve architecture

There are a few simple ways to improve the architecture of your JavaScript code beyond what is shown in most jQuery literature.

### Namespaces

Use a single global object to namespace all your code. Use more objects attached to your global object to separate your modules by their high-level purpose. This protects you from name collisions and organizes the parts of your application in a discoverable way. When your application grows very large, this makes it easier for people less familiar with the system to find where a particular widget or behavior is defined.

~~~ javascript
window.FOO = {
  Widgets: {},
  Utilities: {},
};
~~~

### Modules

Use function prototypes or the [module pattern](http://addyosmani.com/resources/essentialjsdesignpatterns/book/#modulepatternjavascript) to create pseudo classes for your modules. All the intelligence about what your application does should be encapsulated inside these discoverable modules. Use clear, straight-forward method names. By extracting your event handlers and other functions into named methods, they can be unit tested in isolation for a high level of confidence that your system behaves the way you expect. It's also much clearer what the module does when looking at code you haven't seen in a while.

~~~ javascript
FOO.Widgets.CommentBox = function (containerSelector) {
  this.container = $(containerSelector);
  this.container.on("submit", "form", this.addComment.bind(this));
};

FOO.Widgets.CommentBox.prototype.addComment = function (event) {
  // More logic here...
};

// Many more methods...
~~~

### Instantiate your modules

Initialize your modules by constructing new objects, passing in the appropriate selectors as arguments. Assign the newly created object to a property on your global object. A good convention is to use properties beginning with capital letters for modules, and properties beginning with lowercase letters for instances of those modules. Using this approach, you can have multiple instances of the same widget on one page with explicit control over each individual instance. This is useful both for interaction between widgets and for development in the web inspector in your browser.

Deferring initialization until a module is instantiated programmaticaly gives you great flexibility when testing. You can isolate the effect of your module to a particular subtree of the DOM, which can be cleared out in a teardown phase after each test.

~~~ javascript
FOO.comments = new FOO.Widgets.CommentBox(".comment-box");
~~~

## Just the beginning

These are just a few very simple examples of ways to structure your code as your application starts to grow. For even better object-oriented abstractions, consider using a library like [Backbone](http://documentcloud.github.com/backbone/), which, although usually associated with Gmail-style single page applications, is also very useful for writing well-organized JavaScript that focuses on behavior and application logic instead of selectors tying it to the markup and heavy chains of callbacks.
