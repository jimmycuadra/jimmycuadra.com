---
title: "CoffeeScript classes: under the hood"
date: "2011-10-14 04:13 PDT"
tags: "coffeescript, javascript"
---
CoffeeScript has a very elegant mechanism for creating classes. If you're new to JavaScript, you may not be aware that there are no native classes, and that CoffeeScript classes are actually syntactic sugar for JavaScript's constructor functions and object prototypes. Most people are more familiar with the syntax offered by CoffeeScript, but it's a good idea to know what's happening behind the scenes.

## The prototypal model

In JavaScript, there are no classes, in the classical sense. Objects are created and inherit directly from other objects. Functions are a type of object, and when invoked with the `new` operator, create a new object which use the function as a constructor. This new object has a hidden link to the **prototype** property of the constructor function that establishes its inheritance. If you attempt to access a property on the new object that doesn't exist, JavaScript will follow the inheritance chain to the constructor's prototype and use the value it finds there.

When you create a class in CoffeeScript, you're really creating a constructor function. Each instance method in the class is actually a property of the constructor's prototype.

## A simple class

Let's take a look at an example class, `Bear`. A bear is very simple. It has one property, `name`, and one method, `attack`. A class delcared with the `class` keyword creates an empty constructor function. The class definition is followed by an object defining the properties of the constructor's prototype. Each key in the object becomes a property on the prototype. The special key `constructor` becomes the body of the constructor function itself.

~~~ text
class Bear
  constructor: (@name) ->

  attack: ->
    "#{@name} the bear attacks with his bare paws!"

oswalt = new Bear "Oswalt"
console.log oswalt.attack()
# Oswalt the bear attacks with his bare paws!
~~~

`Bear` defines a simple constructor which takes one argument, the bear's name, and assigns it to the `name` property of the instance. The `attack` method simply returns a string saying the bear is attacking. We instantiate a new `Bear` named "Oswalt" and log the results of his `attack` method. This outputs "Oswalt the bear attacks with his bare paws!" to the console. Let's take a look at how CoffeeScript translates this into JavaScript. (I've left out some closures and added whitespace for clarity.)

~~~ text
var Bear, oswalt;

function Bear(name) {
  this.name = name;
}

Bear.prototype.attack = function() {
  return "" + this.name + " the bear attacks with his bare paws!";
};

oswalt = new Bear("Oswalt");
console.log(oswalt.attack());
~~~

As we can see, the `Bear` class is really just a function named `Bear`. It takes one argument and assigns it to the new instance's `name` property. The ``attack`` method is just a function assigned to the `attack` property of `Bear`'s prototype. We instantiate an object by calling `new Bear` and passing it the bear's name. When we attempt to access the `attack` property of the new object, JavaScript sees there there is no such property, and travels up the hidden link to the class's prototype, where it finds the method we want and executes it.

## Inheritance

CoffeeScript's class syntax is a bit cleaner than the compiled JavaScript, but ultimately not that different. Where CoffeeScript classes really shine is in abstracting away the clunky steps required to produce classical inhertiance via the prototypal model. Let's extend `Bear` to see how it works.

~~~ coffeescript
class BearWithChainsawPaws extends Bear
  attack: ->
    super + " BY THE WAY, HIS PAWS ARE CHAINSAWS."

rodrigo = new BearWithChainsawHands "Rodrigo"
console.log rodrigo.attack()
# Rodrigo the bear attacks with his bare paws! BY THE WAY, HIS PAWS ARE CHAINSAWS.
~~~

This new `BearWithChainsawPaws` class is a child class of `Bear`. It overrides the `attack` method but does not change the constructor. Note that the new `attack` method uses `super` to call `Bear`'s version of `attack`. This is very useful, because there isn't a direct equivalent of `super` in JavaScript, as you can see in the compiled code (again modified for clarity):

~~~ javascript
var Bear, BearWithChainsawHands, rodrigo;

var __hasProp = Object.prototype.hasOwnProperty;

var __extends = function(child, parent) {
  for (var key in parent) {
    if (__hasProp.call(parent, key)) {
      child[key] = parent[key];
    }
  }

  function ctor() { this.constructor = child; }

  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;

  return child;
};

function Bear(name) {
  this.name = name;
}

Bear.prototype.attack = function() {
  return "" + this.name + " the bear attacks with his bare paws!";
};

__extends(BearWithChainsawHands, Bear);

function BearWithChainsawHands() {
  BearWithChainsawHands.__super__.constructor.apply(this, arguments);
}

BearWithChainsawHands.prototype.attack = function() {
  return BearWithChainsawHands.__super__.attack.apply(this, arguments) + " BY THE WAY, HIS PAWS ARE CHAINSAWS.";
};

rodrigo = new BearWithChainsawHands("Rodrigo");
console.log(rodrigo.attack());
~~~

There's a lot happening here, so let's take it a bit at a time.

The first thing to notice here is that CoffeeScript has generated some boilerplate above the classes themselves that wasn't there in the first example. `__hasProp` is just a shortcut for `Object.prototype.hasOwnProperty`. Since it's used in a loop in the following function, this is a bit more performant. It's not particularly important in understanding how inheritance works, however. The real meat is the next function.

`__extends` is a helper function that sets up one class to inherit from another. The `for...in` loop copies all the class-level methods from the parent to the child. In this particular case, our classes have only instance methods, but if we were to have defined a class property, say `Bear.awesome = true`, then the loop would copy `true` into `BearWithChainsawPaws.awesome`.

The second half of `__extends` sets up the prototype link (which contains the instance properties and methods) from the child to the parent. At its simplest, prototypal inheritance is achieved by assigning an instance of the parent to the child's prototype. `__extends` uses a bit of indirection to both establish this link, and to correctly assign the `constructor` property for all instances of the child. This property points back at the constructor function itself, and is necessary for the `instanceof` operator to give the desired result. The intermediate `ctor` method is used to for this purpose.

Lastly, a `__super__` property is added to the child class, which establishes a reference to the parent's prototype. Without this, achieving `super` would require manually calling the parent class by name, which is error prone and not particularly maintainable. Inside `BearWithChainsawHands`'s methods, we can see this reference to `__super__` being used to call `Bear`'s methods through the magic of `apply` – a method which invokes one object's method within the context of another object.

## The point

While I do think CoffeeScript is pretty rad, the point of this post is to aid in understanding of what CoffeeScript is doing behind the scenes to provide its niceties. It uses good, clean JavaScript to abstract away what, to many, is an awkward approach, and in doing so, teaches a great deal about how JavaScript works.

## Further reading

This post covers a lot of ground in a short span, and many parts of it could be explained in more depth. Here are some links to the [MDC docs](https://developer.mozilla.org/en/JavaScript) with more detail that should be helpful:

* [new](https://developer.mozilla.org/en/JavaScript/Reference/Operators/Special/new)
* [constructor](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Object/constructor)
* [prototype and inheritance](https://developer.mozilla.org/en/JavaScript/Guide/Inheritance_constructor_prototype)
* [instanceof](https://developer.mozilla.org/en/JavaScript/Reference/Operators/Special/instanceof)
* [call](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Function/call) and [apply](https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Function/apply)
