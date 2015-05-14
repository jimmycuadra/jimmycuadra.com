---
title: "ECMAScript 5: Object creation and property definition"
date: "2011-06-08 07:28 PDT"
tags: "javascript"
---
<aside>This is the first in a series of three posts about ECMAScript 5.</aside>

The newest version of JavaScript, ECMAScript 5, is now available in the latest browsers, and brings with it a slew of new features. One of the most significant of these features is a group of functions that offer new and powerful ways to create objects and manipulate their properties. "But creating objects and changing their properties is something I could already do in JavaScript," you say. This is true, but ECMAScript 5 addresses some subtleties that were previously not possible.

## Object creation

JavaScript is a prototypal language, but as the wise [Douglas Crockford](http://www.crockford.com/) has said, JavaScript itself is ambivalent about its prototypal nature. It has traditionally used a strange inheritance model based on C/Java syntax to mask what it's really doing. Previously, if you had a `Parent` object and wanted to create a new `Child` object which inherits from the `Parent`, you'd have to take multiple steps including assigning an instance of `Parent` to the `Child` object's prototype. In ECMAScript 5, this is simplified with the `Object.create` method. It works like this:

~~~ javascript
function Parent() { }
var parent = new Parent();
var child = Object.create(parent);
~~~

This creates a new object, `child`, which inherits from `parent` in one easy step. The argument to `Object.create` is the object to be used as the child's prototype. It can either be an object or `null`, if you don't want the new object to inherit from anything. `Object.create` is handy for creating a simple object which inherits from another, but its hidden power comes from its optional second argument.

## Property definition

Up until now, there were certain subtleties of native objects that could not be emulated by pure JavaScript:

* It was not possible for a property to react to assignment by engaging in behavior. An example of this is setting the `innerHTML` property of a DOM node. Assigning a string to this property would not only change the value of the property, but it would alter the contents of the element in the DOM.
* Certain native object properties, such as `toString`, do not show up when iterating through the properties of a child object using a `for...in` loop. There was no way to create a property in JavaScript that behaved this way, forcing all `for...in` loops to use `hasOwnProperty` to restrict the loop to the child's objects non-inherited properties.

The optional second argument to `Object.create` is a set of **property descriptors**, which allow you to control the above behaviors and more. There are now two types of properties: data properties and accessor properties. Data properties are given an explicit value as we're used to, but accessor properties are given two functions to act as getter and setter methods instead. Here is what they look like:

~~~ javascript
var child = Object.create(parent, {
  dataDescriptor: { value: "This property uses this string as its value." },
  accessorDescriptor: {
    get: function () { return "I am returning: " + accessorDescriptor; },
    set: function (val) { accessorDescriptor = val; }
  }
});
~~~

Here we are defining two properties for the `child` object, `dataDescriptor` and `accessorDescriptor`. The `dataDescriptor` property in this case behaves almost the same as a traditional object property, and except for one subtlety which we'll explore in a moment, it is accessed and set like usual. The `accessorDescriptor` property, however, uses the supplied functions to get and set its value. Assigning a new value to the property calls the `set` function and passes in the value being assigned as the parameter. Accessing the property with the usual syntax actually runs the `get` function and the value returned is whatever the function returns. This allows the value of a property to have arbitrarily complex logic behind it.

There are three additional aspects of a property we can control, each given a boolean value:

1. `writable`: Controls whether or not the property can be assigned. If true, attempts at assignment will fail. Only applies to data descriptors.
2. `enumerable`: Controls whether or not this property will appear in `for...in` loops.
3. `configurable`: Controls whether or not the property can be deleted, and whether its property descriptor (other than `writable`) can be changed.

Each of these defaults to `false` if not supplied. Here is the last code example again with various values for these fields:

~~~ javascript
var child = Object.create(parent, {
  dataDescriptor: {
    value: "This property uses this string as its value.",
    writable: true,
    enumerable: true
  },
  accessorDescriptor: {
    get: function () { return "I am returning: " + accessorDescriptor; },
    set: function (val) { accessorDescriptor = val; },
    configurable: true
  }
});
~~~

In this version, the `dataDescriptor` property can be assigned and will show up in `for...in` loops, but it cannot be deleted and its property descriptor cannot be altered further. `accessorDescriptor`, however, can be deleted and its property descriptor can be altered. The difference between defining a data property with `Object.create` and a property descriptor rather than simply writing `child.dataDescriptor = "This property uses this string as its value";` is in the defaults for the three fields. When using `Object.create`, all three fields default to `false`, whereas using the classic style they all default to `true`.

It is, of course, possible to use property descriptors to create or alter properties after the creation of the object itself. To do this, you can use the new methods `Object.defineProperty` and `Object.defineProperties`. `Object.defineProperty` takes the object in question, the name of the property, and a single property descriptor as its arguments. `Object.defineProperties` lets you define multiple properties at once by passing the object in question and an object whose keys are each properties, just as we did with `Object.create`.

These new features in JavaScript offer power previously unattainable in creating and manipulating objects. In the [next part](/posts/ecmascript-5-tamper-proofing-objects), we will take a look at sealing and freezing objects.
