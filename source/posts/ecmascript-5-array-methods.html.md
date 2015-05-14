---
title: "ECMAScript 5: Array methods"
date: "2011-10-12 00:02 PDT"
tags: "javascript"
---
<aside>This is the third part in a series of posts about ECMAScript 5. Be sure to check out the [first part](/posts/ecmascript-5-object-creation-and-property-definition), and [second part](/posts/ecmascript-5-tamper-proofing-objects) if you missed them.</aside>

This is the third and final part of my series on ECMAScript 5. In [part one](/posts/ecmascript-5-object-creation-and-property-definition), we looked at new methods for object creation and property definition. [Part two](/posts/ecmascript-5-tamper-proofing-objects) focused on tamper proofing objects. I'll now provide a quick overview of the new high level array methods.

Unlike the new methods discussed in the first two parts, the methods here are all reproducible using JavaScript itself. Native implementations are simply faster and more convenient. Having a uniform API for these operations also promotes their usage, making code clearer when shared between developers.

## Search methods

### Array.prototype.indexOf

`indexOf` provides an easy way to determine whether or not an object is in an array. It returns the first index at which the item was found, or `-1` if it was not found at all. Strict equality is used to determine that an item is present in the array. An optional second argument can start the search at an index other than `0`.

~~~ javascript
var arr = ["apple", "banana", "carrot", "apple"];

arr.indexOf("apple"); // 0
arr.indexOf("daikon"); // -1
~~~

### Array.prototype.lastIndexOf

Identical to `indexOf`, but returns the last index at which an item is found, if at all.

~~~ javascript
var arr = ["apple", "banana", "carrot", "apple"];

arr.lastIndexOf("apple"); // 3
~~~

## Iteration methods

### Array.prototype.forEach

Ever seen this before?

~~~ javascript
for (var i = 0, l = arr.length; i < l; i++) {
  doSomething(arr[i], i, arr);
}
~~~

There is now a clean, high level way to do this with `forEach`. The method accepts a callback which will be executed once for each item in the array. The callback receives three arguments: the value of the current iteration, the index of the current iteration, and the array itself. The following is equivalent to the above:

~~~javascript
arr.forEach(doSomething);
~~~

An optional second argument specifies the value of `this` within the callback.

### Array.prototype.every

`every` checks every element in an array against a condition, by means of a passed in function. If any of the items in the array cause the function to return a falsy value, `every` returns `false`. If they all return truthy values, `every` returns `true`.  Like `forEach`, an optional second argument supplies a value for the callback's `this`, and the callback itself will receive the same three arguments.

~~~ javascript
var arr = ["apple", "banana", "carrot", "apple"];

arr.every(function (value, index, array) { return value.length > 1; }); // true
arr.every(function (value, index, array) { return value.length < 6; }); // false
~~~

### Array.prototype.some

`some` is similar to `every`, but the passing condition is that *at least one* callback returns true, rather than all of them.

~~~ javascript
var arr = ["apple", "banana", "carrot", "apple"];

arr.some(function (value, index, array) { return value.length < 6; }); // true
~~~

## Transformation methods

### Array.prototype.map

Mapping is the most common transformation. It loops through an array, running a function and creating a new array built from the return values of each iteration. `map` takes the same optional second argument and receives the same callback arguments as the iteration methods.

~~~ javascript
var names = ["Abigail", "Bongo", "Carlitos"];

names.map(function (value, index, array) {
  return value + " Jones";
});
// ["Abigal Jones", "Bongo Jones", "Carlitos Jones"]
~~~

### Array.prototype.filter

Filtering is like mapping, but creates a new array containing only the items of the original array that return a truthy value from the callback. `filter` takes the familiar optional argument and its callback receives the usual suspects.

~~~ javascript
var names = ["Abigail", "Bongo", "Carlitos"];

names.filter(function (value, index, array) {
  return value.length > 5
});
// ["Abigail", "Carlitos"]
~~~

### Array.prototype.reduce

`reduce` is used to melt the items in an array down to a single value by the operations performed in its callback function. The callback takes the usual three iteration arguments, but is prepended with an extra argument, the value of the previous iteration's result. By default, the first iteration is effectively a no-op, so the calculation begins with the array's first value as the accumulated result and the array's second value as the current iteration. This is probably best illustrated with an example:

~~~ javascript
[10, 20, 30, 40, 50].reduce(function (accum, value, index, array) {
  return accum + value;
});
// 150
~~~

On the first iteration, `accum` is `10` and `value` is `20`. The return value of `accum + value` becomes `accum` on the next iteration of the loop.

`reduce` can also take an initial value for `accum` as a second argument. When invoked this way, the first `value` in the callback is the first item in the array:

~~~ javascript
[10, 20, 30, 40, 50].reduce(function (accum, value, index, array) {
  return accum + value;
}, 50);
// 200
~~~

### Array.prototype.reduceRight

`reduce`'s sibling, which performs the same behavior and accepts the same arguments, except it iterates beginning with the rightmost item in the array and moves left. If not specified with a argument, the initial value of `accum` is the last value in the array, and the initial iteration value is the second to last.

~~~ javascript
[10, 20, 30, 40, 50].reduceRight(function (accum, value, index, array) {
  return accum - value;
});
// -50
~~~

## ECMAScript 5 is full of goodness

ECMAScript 5 packs lots of new, useful features into JavaScript which speed up both development and performance of code. The new APIs are implented in the most recent versions of Chrome, Firefox, Safari, and (*gasp!*) Internet Explorer, so I encourage you to start using these new APIs today!
