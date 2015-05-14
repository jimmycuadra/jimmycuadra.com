---
title: "The HTML 5 Buzz: Why It Matters"
date: "2009-07-24 08:05 PDT"
tags: "html"
---
Lately I have been seeing a lot of excitement circulating on Twitter and various blogs about recent developments with HTML and the recently-released [Firefox 3.5](http://www.mozilla.com/firefox/) which adds new support for HTML5 features. The questions I had that no one seemed to be touching on were: Why does it matter if Firefox supports some of HTML5 unless *all* browsers (read: Internet Explorer) do? Why does it matter if it only has partial support? You can't start moving your sites to HTML5 if only some of its features are supported. If you move to an HTML5 doctype, won't browsers that don't fully support it break when viewing your document? If you keep an HTML 4 or XHTML 1 doctype but introduce the more commonly supported HTML5 elements into your document, doesn't that result in invalid markup, since you're mixing elements from different specifications?

I decided to do some investigating to find out the answers to these questions. My worry was that there was no reason for the excitement other than people being happy to see things "moving in the right direction" and that there was no practical reason to be excited. Fortunately, I've found that indeed there *is* reason to be excited. HTML5 can be used *right now*.

Perhaps the first question to address is the last one I posed – how to deal with doctypes when "mixing" HTML5 with HTML 4 or XHTML 1. The answer is that there *isn't* an HTML5 doctype, per se. HTML5 only builds on HTML 4, so everything that exists in HTML 4 and XHTML 1 still exist in HTML5. The doctype used for an HTML5 document is simple: `<!DOCTYPE html>`. This declaration really only exists to force browsers into standards mode, and documents will render with as much knowledge as the browser happens to have about HTML. One of the main focuses of HTML5 is to keep it backward compatible, so there is no reason not to build documents in HTML5 now – it will simply be interpreted as HTML 4 by any browser not yet keen on HTML5, and your markup is still completely valid.

That answer implies the answer to the previous questions. Since there is no fundamental doctype change in moving to HTML5, there is no reason not to take advantage of the partial support in browsers like Firefox 3.5, because a complete implementation isn't needed. Even Internet Explorer will work fine with an HTML5 document (although in order to style new elements like `<section>` and `<article>`, a small bit of JavaScript must be included: [html5shiv](http://code.google.com/p/html5shiv/)). Media tags that aren't supported, like `<video>`, will simply be ignored and not rendered.

With this newfound knowledge that I can already start using HTML5, I've joined the bandwagon on the HTML5 excitement. I'm happy to see that I can start writing more semantic markup right away, thanks to the new HTML5 elements. I plan to start using it for my future work, including the upcoming revision of this site (which will also move from CakePHP to Ruby on Rails).

If you're interested in more details about HTML5 and its real world applications, I've found these sites very helpful and interesting:

* [HTML5 Doctor](http://html5doctor.com/)
* [WHATWG](http://www.whatwg.org/)
* [HTML5 Gallery](http://html5gallery.com/)
