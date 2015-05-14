---
title: "JavaScript factory constructors"
date: "2010-03-18 21:50 PDT"
tags: "javascript"
---
In JavaScript, a constructor is simply a function. In order to use a function as a constructor, you call it using the `new` keyword. When you use this keyword, a new instance of the function is created and the constructor function executes in the context of the new instance. In other words, `this` within the constructor function will refer to the new instance that's being created. The constructor will also implicitly return `this` (the new instance).

~~~ javascript
function Birthday(name) {
  this.name = name;
}

new Birthday('Jimmy'); // creates a new Birthday instance
~~~

The above code would create a new instance of `Birthday`, whose `name` property would be set to `Jimmy`. Because the constructor is just a function, it can be called normally, without the `new` keyword. This can be quite dangerous however, because when `new` is left out, `this` will refer to the global object instead of the new `Birthday` instance you're trying to create.

~~~ javascript
function Birthday(name) {
  this.name = name;
}

Birthday('Jimmy'); // assigns a new global variable
~~~

In this example, `new` is not used, so `this` within the constructor function is the global object and we're assigning the value `Jimmy` to the global variable, `name`. It's very unlikely that this is intended, and as with all global variables, it can cause some major headaches. So how can you prevent the constructor function from being used this way accidentally? A solution is to use the constructor as a **factory**, where the constructor itself looks at what is happening and decides what to return. Take a look at this:

~~~ javascript
function Birthday(name) {
  if (this === window) {
    return new Birthday(name);
  }

  this.name = name;
}

new Birthday('Jimmy'); // creates a new Birthday instance
Birthday('Jimmy'); // also creates a new Birthday instance
~~~

As I mentioned, a constructor function will implicitly return `this`. But that behavior can be overridden by explicitly returning another object. In this case, the constructor function checks to see if it was called in the context of the global object. If it was, it calls itself in the correct context using `new` and returns the new instance returned by that invocation. If it is not called in the global context, it behaves as it does normally, setting the `name` property and implicitly returning the new instance. This allows you to call the constructor with or without the `new` keyword with exactly the same effect.
