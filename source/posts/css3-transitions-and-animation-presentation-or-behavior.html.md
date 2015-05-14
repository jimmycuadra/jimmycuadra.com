---
title: "CSS3 transitions and animation: Presentation or behavior?"
date: "2009-09-29 08:56 PDT"
tags: "css"
---
When I first heard about [CSS 3 transitions](http://www.w3.org/TR/css3-transitions/) and [CSS 3 animations](http://www.w3.org/TR/css3-animations/), I didn't really think it was a good idea. One of the main purposes of CSS has been to separate presentational information from structural markup and data. This seemed like a good set up: HTML for structure and data, CSS for presentation, and JavaScript for behavior. Adding behavioral elements to CSS that should be done in JavaScript seemed like it was blurring the lines in a bad way.

I think in order to see the value of CSS 3 transitions and animations, it's necessary to rethink what "presentation" and "behavior" really are. Developers have gotten used to thinking of presentation as the answer to simpler questions like, "what color is the text?" and "how much space should exist between menu items?" JavaScript has been used for almost everything involving dynamic and interactive styling on a page.

<aside>*Note: The site has been redesigned since this post was written so this aside no longer applies. I will leave it here for posterity.*<br />
To put some of these new CSS 3 features into action in my own work, I've updated the main navigation here on jimmycuadra.com to use one effect from each module. The currently selected menu item now slowly pulses between white and blue, and the text color and shadows on the other menu items fade in and out as the mouse moves over them. For those using a browser based on [Webkit](http://webkit.org/), such as [Safari](http://www.apple.com/safari/) or [Google Chrome](http://www.google.com/chrome/), you'll be able to see these new effects. For everyone else, enjoy the new text shadows, and think of giving [Webkit](http://webkit.org/) a try.</aside>

The key thing to realize is that a lot of the things JavaScript has been used for *are* presentational, and have been done to close the gaps where CSS features were lacking. Take rounded borders, for example. Until CSS 3, this was achieved through either images or JavaScript. But it's clear to everyone that this is strictly presentational and didn't really fit as a task for JavaScript. The CSS 3 border radius property finally offers a solution to this common problem without fudging it with JavaScript or images.

CSS 3 transitions and animations are really no different. The reason I thought they were out of place at first is that they involve the manipulation of elements on the page, making things move and change. That sure sounds like behavior. Well, in a way, it is, but it's also *presentational behavior*. Links that change color on hover are ubiquitous presentational behavior, so why wouldn't it be presentational to have the color visually transition from one to the other instead of switching instantly?

Instead of thinking of presentation as what things look like and behavior as what things do, we should think of presentation as anything that doesn't fundamentally alter the page, and behavior as anything that manipulates document structure or data, or that facilitates explicit user interaction.
