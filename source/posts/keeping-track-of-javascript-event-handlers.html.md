---
title: "Keeping Track of JavaScript Event Handlers"
date: "2010-04-28 11:09 PDT"
tags: "javascript"
---
When working with the DOM and JavaScript, adding, removing, and keeping track of event handlers can be tricky because there are multiple ways to do things and they're not all consistent across different browsers. Things can be made a lot easier by using a JavaScript library, but it's still useful to see how things are working behind the scenes, and may come in handy when you need to work with events without a library.

## The single property method

The original and simplest method of adding an event handler to an element is to assign a handler function to a property of the element that corresponds to an event type. The property names are all prefixed with "on," such as "onclick" and "onblur." Here is how you might attach a handler to the click event of an element with this method:

~~~ javascript
var div = document.getElementById('mydiv');
div.onclick = function () {
  alert('clicked!');
};
~~~

Note that you could assign either a named function or an anonymous one as I've done here. To remove the handler, just set the property to `null`:

~~~ javascript
div.onclick = null;
~~~

Finding out which handler is bound to the event is easy, because it's just the current value of the property. This method will work across browsers, but doesn't immediately support attaching multiple handler functions to the same event on the same element. There are ways to work around this, however, which I'll provide an example of shortly.

## The addEventListener method

A function called `addEventListener` was later added to the DOM API which does allows you to attach multiple handlers. `addEventListener` takes three parameters: the type of the event (not prefixed with "on" this time), a handler function, and a boolean to determine whether the event capturing or event bubbling model should be used. The details of the last parameter are beyond the scope of this article, but in a nutshell, always set it to `false`. Here's an example of adding events with this method (using the same `div` element as before):

~~~ javascript
div.addEventListener('click', handlerOne, false);
div.addEventListener('click', handlerTwo, false);
~~~

In this example I'm using a named function instead of an anonymous one, so this presumes that `handlerOne` and `handlerTwo` are defined elsewhere. Now, when you click on the div, both of these handler functions will execute (though the order in which they do cannot be guaranteed). Removing one of these handlers is done using the aptly named `removeEventListener` function with the same signature, like this:

~~~ javascript
div.removeEventListener('click', handlerOne, false);
~~~

The third parameter is necessary because handlers registered with the capturing model are tracked separately from handlers registered with the bubbling model.

The rub with `addEventListener` is that it is not implemented in Internet Explorer. Microsoft opted to use its own `attachEvent` function instead. `attachEvent` is similar to `addEventListener`, except it doesn't take the boolean parameter at the end and it prefixes the event name with "on" like the first method. For removing handlers, IE also has an equivalent function, `detachEvent`.

~~~ javascript
div.attachEvent('onclick', handlerOne);
div.detachEvent('onclick', handlerOne);
~~~

The result of this inconsistency is that you must check for the existence of these handler registration functions to determine which method to use in your own code. For example:

~~~ javascript
if (div.addEventListener) {
  div.addEventListener('click', handlerOne, false);
} else {
  div.attachEvent('click', handlerOne);
}
~~~

This checks for the existence of the standard DOM method first, and uses that if available. If not, it falls back to the IE version.

While this method allows you to attach multiple handlers to the same event on the same element, it doesn't provide a way to see which handlers are currently attached to a given event for a given element. There is an interface called [EventListenerList](http://www.w3.org/TR/2001/WD-DOM-Level-3-Events-20010823/events.html#Events-EventListenerList) in the DOM Level 3 API that will provide such an ability, but it is currently not implemented in any browsers.

## A custom method

Of course the most full-featured, cross-browser solutions will be provided by JavaScript libraries, but as an exercise, let's take a look at how you might implement an event registration function that allows multiple handlers per event, allows you to track which handlers are attached to which events, and works across browsers.

~~~javascript
function addTrackedListener(element, type, handler) {
  if (!element.trackedEvents) {
    element.trackedEvents = {};
  }

  if (!element.trackedEvents[type]) {
    element.trackedEvents[type] = [];

    element[type] = function () {
      for (var i = 0; i < element.trackedEvents[type].length; i++) {
        element.trackedEvents[type][i]();
      }
    };
  }

  element.trackedEvents[type].push(handler);
};
~~~

This new function, `addTrackedListener`, works by storing the handler functions in a property on the element itself, and using a wrapper function to call each one in sequence when the event is fired. It takes three parameters: the element to operate on, the event type (with the "on" prefix), and the handler function you want to attach.

The behavior of `addTrackedListener` can be described in four steps:

1. If this is the first handler to be registered on this element, create a new property on the element called `trackedEvents` and initialize it to an empty object. This will be used for mapping to all the different events for that element.
2. If this is the first handler to be registered for this particular event, create a new property of `trackedEvents` named after the event type and initialize it to an empty array. This will be used to store all the handler functions for that event.
3. If this is the first handler to be registered for this particular event, attach a single handler to that event using the first method discussed in this article (which works across browsers). This handler will call all the other functions stored in the array in sequence when invoked.
4. Push the provided handler to the array for that event type.

The function could be used like this:

~~~ javascript
addTrackedListener(div, 'onclick', clickHandlerOne);
addTrackedListener(div, 'onclick', clickHandlerTwo);
addTrackedListener(div, 'onmouseover', mouseoverHandler);
// and so on...
~~~

To find out which handlers are attached to which events on the element, you can just inspect the data structure in `div.trackedEvents`. Likewise, removing a handler is as easy as splicing it out of the array for that event. Of course, helper functions could be created to simplify those tasks, but the groundwork has been laid.

Events can be tricky to work with, but hopefully these examples offered some insight into ways of managing them and how custom functions can be used to solve higher-level problems.
