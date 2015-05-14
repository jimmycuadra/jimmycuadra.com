---
title: "Understanding jQuery 1.4's $.proxy() method"
date: "2010-01-15 02:35 PST"
tags: "javascript, jquery"
---
No sooner than I wrote about how to control a JavaScript function's context with the [Prototype](http://www.prototypejs.org/) `Function.prototype.bind`, [jQuery 1.4](http://jquery.com/) is released and one of its new tricks is `jQuery.proxy`, which we can use for exactly the same purpose.

To refresh you, the problem that needed solving was how to preserve a reference to the calling object when the value of `this` is changed. Consider the following:

~~~ javascript
MyModule = function() {
  this.$div = $('#testdiv');
  this.myString = "Hi! I'm an object property!";
  
  this.$div.click(this.handleClick);
};

MyModule.prototype.handleClick = function() {
  console.log(this.myString); // undefined
};

var m = new MyModule();
~~~

When you click on the div, we are given `undefined`, because `this` now refers to the DOM element that triggered the event and not the instance of `MyModule` we've stored in the variable `m`. The element does not have a `myString` property, and hence, it is undefined. So how do we access the `myString` we want? The solution I wrote about previously was to use `Function.prototype.bind` from the Prototype library, which allows us to control what `this` will refer to inside the function we're calling. But now in version 1.4 of jQuery, we can handle this situation with the new `jQuery.proxy` method. The method has two signatures:

~~~ javascript
jQuery.proxy( function, scope )
jQuery.proxy( scope, name )
~~~

In the first form, the `function` argument is the function we're calling, and the `scope` argument sets the context the function should be called in. In the second form, the scope comes first, and the `name` argument is a string that gives the name of the function we're calling. Note that the function provided in `name` should be a property of whatever object we're using as the scope. Let's look at an example to make this more clear.

~~~ javascript
MyModule = function() {
  this.$div = $('#testdiv');
  this.myString = "Hi! I'm an object property!";
  
  this.$div.click($.proxy(this.handleClick, this));
};

MyModule.prototype.handleClick = function() {
  console.log(this.myString); // Hi! I'm an object property!
};

var m = new MyModule();
~~~

Now when we click on the div, we see the result we want, because `this` is now bound to our `m` object, which is an instance of `MyModule`. This uses `jQuery.proxy`'s first signature. We could achieve exactly the same effect using the second signature by using this line instead:

~~~ javascript
this.$div.click($.proxy(this, "handleClick"));
~~~

The small "gotcha" that remains is how to access the DOM element that triggered the event, now that we've changed the value of `this` within our function. The good news is that, like before, all event handling functions are passed an `event` object with details about the event that occurred. Within that event object is a property called `currentTarget`, which holds exactly what we're looking for: the DOM element that triggered the event. Here is an example of how to access it:

~~~ javascript
MyModule.prototype.handleClick = function(event) {
  console.log(this.myString); // Hi! I'm an object property!
  console.log(event.currentTarget); // <div id="testdiv">
};
~~~

Thanks to `jQuery.proxy`, we now have the ability to control function scope with jQuery alone. To read more about all the new features in jQuery 1.4, check out John Resig's overview on [The 14 Days of jQuery](http://jquery14.com/day-01/jquery-14).
