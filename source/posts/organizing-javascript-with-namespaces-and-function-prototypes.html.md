---
title: "Organizing JavaScript with Namespaces and Function Prototypes"
date: "2010-01-10 20:00 PST"
tags: "javascript"
---
Keeping your JavaScript code organized and readable can be a bit of a task. Since I started with jQuery, most of the JavaScript for my applications has just been inside a giant `$(function() { })` block, and as the code grows longer and more complex, it becomes much harder to find the thing you're looking for and edit it later. I was searching for a design pattern that would help me organize my code in a way such that I wouldn't dread looking at my JavaScript files in the future. My solution came in the form of **namespacing** and building modules with **function prototypes**.

## Namespaces

A **namespace** is a context in which variables can exist without conflicting with other variables of the same name elsewhere. For example, say I write a function called `insert` for inserting some text into a page. Then I include a 3rd party library that also defines a function called `insert` (and for the sake of argument, is not namespaced). My original `insert` function has now been overridden by the library's version. This type of collision is rarely what you want and can introduce some major headaches. You can get around this by encapsulating your code in an object that is unlikely to collide with other libraries and then accessing it with `MyObject.function`. It's a good idea to put all the code for your project under one main object (named after your project) and then separate the different sections of your code into modules within that object. Start with this at the very beginning of all your JavaScript code (I'll be using my upcoming **More Things Need To** project as an example):

~~~ javascript
// file: main.js
if (typeof MTNT == 'undefined') {
  MTNT = {};
}
~~~

This creates a new empty object called `MTNT`, but does not overwrite it if for some reason it already exists. Now, you can write your code in modules (that are themselves further namespaces) that exist as properties of the global namespace object. It is a good idea to also put these modules in separate files to keep things clean. For example:

~~~ javascript
// file: mtnt.form-validator.js
MTNT.FormValidator = function() {
  // code for form validation goes here
}
~~~

Now, instead of adding more spaghetti code to your *main.js* JavaScript file, you can simply instantiate your module: `new MTNT.FormValidator()`.

## Function prototypes

This brings us to the second part of organizing your code, which is to split up different behaviors into **prototype functions** within each module. JavaScript does not use classical inheritance patterns in its object orientation – it uses a technique called *prototyping*. While the explanation of this is really beyond the scope of this article, in a nutshell, the *prototype* property of a function `myFunction` exists only once in memory and is shared by every instance of `myFunction`. This will become more clear in an example (I'm using jQuery here):

~~~ javascript
// file: mtnt.form-validator.js
MTNT.FormValidator = function(myProperty, form) {
  // initialize some variables
  this.myProperty = myProperty;
  this.form = form;
  // ...
  
  // call a function to valid the form data
  this.form.submit(this.validate); // "submit" is jQuery's submit
}

MTNT.FormValidator.prototype.validate = function() {
  // validate the form data
  // ...
}
~~~

Using this technique, all instances of `MTNT.FormValidator` will have a `validate` method. This allows us to separate the methods within our module like this without nesting functions inside functions. It also saves memory because each method only exists in the *function prototype* and a new copy of the method is not created for each instance of `MTNT.FormValidator`.

## A very serious "gotcha"

This introduces a new complication, however. By separating our methods in this way, we change the *context* of each. Consider the value of `this` inside `MTNT.FormValidator`. It refers to the current instance of that module. But inside `MTNT.FormValidator.validate`, the value of `this` has been changed by jQuery's `submit` method to refer to the DOM element that triggered the event. This means that we won't be able to access `myProperty` from `MTNT.FormValidator` because `this.myProperty` will refer to a non-existent property on a DOM element from within the `validate` method. How do we solve this?

## Function.prototype.bind

The solution is a function we will extract from the [Prototype](http://www.prototypejs.org/) JavaScript library: `bind`. Let's take a look at it and then I will explain what it does. Include this at the top of your main JavaScript file, along with the code that initializes your main namespace:

~~~ javascript
if (typeof Function.prototype.bind == 'undefined') {
  Function.prototype.bind = function() {
    var __method = this, args = Array.prototype.slice.call(arguments), object = args.shift();
    return function() {
      var local_args = args.concat(Array.prototype.slice.call(arguments));
      if (this !== window) local_args.push(this);
      return __method.apply(object, local_args);
    }
  }
}
~~~

Without getting into too much detail, `bind` uses the magic of JavaScript's `call` and `apply` functions to create a function call forced into a particular context. The first parameter to `bind` is the context you wish to call the function in. Any additional parameters are passed on as parameters to the function you're calling. We can now replace this line:

~~~ javascript
this.form.submit(this.validate);
~~~

with this:

~~~ javascript
this.form.submit(this.validate.bind(this));
~~~

Now when `validate` is called, `this` will still refer to the instance of `MTNT.FormValidator` and we can access `myProperty` with `this.myProperty`.

## Where did my parameters go?

While we're now able to access the original `this` from our object, the reference to the DOM element that jQuery normally provides is gone. Or is it? Are we simply trading one `this` for another? The answer is no. The original `this` is still there, but it's been moved into a parameter. Let's change the signature of our `validate` method to take this into account:

~~~ javascript
MTNT.FormValidator.prototype.validate = function(event, form) {
  // "event" is the event object that is normally passed into event handlers by jQuery
  // "form" is the original value of "this" that jQuery would have set
  
  // validate the form data
  // ...
}
~~~

Now we have the best of both worlds. We can control the context our methods are called in, and we still have access to everything that was originally provided to them.

## Ugh, mixing Prototype into jQuery?

When it was first suggested to me to use Prototype's `bind` as a solution for this context problem, I was hesitant. It seemed like a pretty nasty hack, for a couple of reasons. One reason is the same reason many people criticize the Prototype library in the first place: that it overrides built-in JavaScripts objects like `Function`, which very strongly violates the namespacing idea discussed at the beginning of this article.

While this is a very valid concern, it is worth noting that this particular usage of `Function.prototype.bind` has become so common and is so well accepted that it is even part of the recently released [ECMAScript 5 specification](http://www.ecma-international.org/publications/standards/Ecma-262.htm), meaning that `bind` will be built into future versions of JavaScript itself, and as such, the namespacing considerations of adding `bind` to JavaScript's `Function` prototype are nearly moot.

The other thing that bothered me about this solution was just the idea of needing something extra in order to make jQuery behave. I looked around for a "jQuery equivalent" way of doing this, and my conclusion is that there really is no direct equivalent. jQuery encourages use of the [JavaScript module pattern](http://www.yuiblog.com/blog/2007/06/12/module-pattern/) instead of the prototype pattern I describe here. This is not so much an equivalent as it is an entirely different approach altogether. I've experimented with the module pattern a bit, but for the moment I feel using function prototypes fits my style better. The choice, of course, is entirely up to you.

## Conclusion

What I present here is simply one way to organize your code. As with most decisions you make when writing JavaScript, there is no one right way, and that's part of what's so great about JavaScript: it's expressive and allows you to write things in a way that works best for you. That said, the ideas I present here are very common, solid solutions to making your JavaScript more modular and readable. This promotes better maintainability and code reuse, which is something all developers should strive for.
