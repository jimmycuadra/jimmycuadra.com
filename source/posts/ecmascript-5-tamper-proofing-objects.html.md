---
title: "ECMAScript 5: Tamper proofing objects"
date: "2011-06-19 21:50 PDT"
tags: "javascript"
---
<aside>This is the second in a series of three posts about ECMAScript 5. If you missed the [first part](/posts/ecmascript-5-object-creation-and-property-definition), be sure to check it out.</aside>

In the [first part](/posts/ecmascript-5-object-creation-and-property-definition) of this series, we took a look at some of the new features offered by the latest edition of JavaScript, ECMAScript 5. In particular, we looked at new methods for object creation and property definition. In this article, we will look at a few ways of protecting objects against unwanted tampering.

## Preventing extensions

The first and simplest method to discuss is `Object.preventExtensions`. By default, any object can have new properties added to it simply by assigning a new property a value. There may be cases where you want to to prevent this, and that's what `Object.preventExtensions` does:

~~~ javascript
var o = {
  foo: "bar"
};

// adding a new property normally:
o.hey = "guys";

// preventing further extensions:
Object.preventExtensions(o);

// silent error, or TypeError under strict mode:
o.anotherProp = "This will fail!";

// existing properties can still be changed:
o.hey = "gals";
~~~

Note that `Object.preventExtensions` only prevents adding new properties to the object. It's still possible to change the values of existing properties, or even reconfigure or delete properties.

## Preventing configuration

Recall from the [first part](/posts/ecmascript-5-object-creation-and-property-definition) of this series that when a property is defined as configurable, it can be deleted from the object, and its attribute description record can be modified. If we want to prevent extensions to an object and also want to prevent configuration of its properties, we can use the `Object.seal` method. `Object.seal` does everything that `Object.preventExtensions` does, but also sets its properties to be *non-configurable*. This means that properties cannot be deleted, their enumerability cannot change, and they cannot be changed between data properties and accessor properties. `Object.seal` does not, however, change the state of a property's *writability*, so the value of existing data properties can continue to be changed if the property was *writable* when the object was sealed. To illustrate:

~~~ javascript
var o = {
  foo: "bar"
};

// adding a new property normally:
o.hey = "guys";

// deleting a property normally:
delete o.hey;

// sealing the object:
Object.seal(o);

// silent failure, or TypeError under strict mode:
o.anotherProp = "This will fail!";

// existing properties can still be changed if they were writable:
o.foo = "baz";

// silent failure, or TypeError under strict mode:
delete o.foo;
~~~

## Preventing writability

We can do everything `Object.seal` does, but also protect data properties from being overwritten by using the `Object.freeze` method.

~~~ javascript
var o = {
  foo: "bar"
};

// adding a new property normally:
o.hey = "guys";

// deleting a property normally:
delete o.hey;

// sealing the object:
Object.freeze(o);

// silent failures, or TypeErrors under strict mode:
o.anotherProp = "This will fail!";
o.foo = "baz";
delete o.foo;
~~~

Keep in mind that this only works for data properties, as accessor properties (ones that use getter and setter functions) do not use the *writable* descriptor property. It's also important to note that these new methods do not prevent extensions, seal, or freeze the values of properties – only the properties themselves. If it is necessary to protect data at a deeper level, manual traversal is required.

## Determining an object's current state

ECMAScript 5 also supplies us with convenient functions to check whether any of the previously discussed methods have been applied to an object:

* `Object.isExtensible(o)` – `true` if extensions have not been prevented
* `Object.isSealed(o)` – `true` if the object is effectively sealed
* `Object.isFrozen(o)` – `true` if the object is effectively frozen

For `Object.isSealed` and `Object.isFrozen`, I write that these methods check for "effective" sealing and freezing because they simply check that the state of the object matches what the built-in methods would have done. For example, an object can be frozen without ever passing it to `Object.freeze`:

~~~javascript
var o = { foo: "bar" };
Object.preventExtensions(o);
Object.defineProperty(o, "foo", {
  writable: false,
  configurable: false
});

// Object.isFrozen(o) === true
~~~

## A chart to remember all this

<table>
  <tr>
    <th></th>
    <th>Object.preventExtensions</th>
    <th>Object.seal</th>
    <th>Object.freeze</th>
  </tr>
  <tr>
    <th>Prevents new properties?</th>
    <td>Yes</td>
    <td>Yes</td>
    <td>Yes</td>
  </tr>
  <tr>
    <th>Prevents configuration of existing properties?</th>
    <td>No</td>
    <td>Yes</td>
    <td>Yes</td>
  </tr>
  <tr>
    <th>Prevents assigning existing data properties?</th>
    <td>No</td>
    <td>No</td>
    <td>Yes</td>
  </tr>
</table>

In the third and final part of this series, we will look into the new Array methods that have been added with ECMAScript 5.
