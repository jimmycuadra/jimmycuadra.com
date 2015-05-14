---
title: "Do websites need to look the same in every browser?"
date: "2010-02-04 13:14 PST"
tags: "browsers"
---
There are numerous awesome new features introduced in HTML5 and CSS 3, but neither specification is finalized and browser support for them is still pretty unreliable. After getting a taste of what these new technologies can do, it can be hard to resist using them and to wait for better browser support. My position for a long time has been that, although it's frustrating as a developer, it's best to create things for the lowest common denominator and not use features that don't have reliable support across browsers. But my thoughts on the subject have been changing recently.

One of the catalysts for this change was a spectacular quote from [Douglas Crockford](http://www.crockford.com/) that I came across:

> If a web browser is defective, causing errors in the display or performance of the page, should the page developer struggle to hide the browser's defects, or should the defects be revealed in hope of creating market pressure to force the browser maker to make good? By which approach is humanity better served?

The debate as to whether or not a developer should support bad, buggy browsers (henceforth referred to as IE) is not a new one. Most often it is simply not a choice for the developer. Most businesses will require support for IE due to its sheer market share and the monetary consequences of not doing so. Even on a project without requirements dictated by an employer, choosing not to support IE puts you at a disadvantage, because chances are there are other developers out there making similar products that *do* support IE. And when faced with a choice, which are clients going to choose?

Because of these reasons, I've always erred on the side of caution and supported IE. But reading that insightful quote from Douglas Crockford reinvigorated the debate in my mind. I started to rethink how important supporting IE really is and how to find a better compromise in regard to feature support in browsers. There's an emerging school of thought that we should rid ourselves of the preconception that a website should look exactly the same in every browser. I've seen this new attitude come up in several different places recently.

So, does a website need to look the same in every browser? The short answer: [no](http://dowebsitesneedtolookexactlythesameineverybrowser.com/).

My new attitude is to think of browser support with a progressive enhancement approach. I can dramatically improve the look of a site with new CSS 3 effects such as `box-shadow`. But IE doesn't support it. Should I forego its use? Or use some JavaScript to recreate the effect? Neither! I should use it. Users with browsers that support it will see the fancy version, and IE users will see something more basic, but still fully functional. Since they have not seen it any other way, they're not disappointed, and nothing looks wrong or broken. They're none the wiser.

I feel that this approach is a good compromise on what Douglas Crockford's quote suggests. Instead of crying, "IE be damned!" and allowing it to break, it inverts the sentiment to use a positive context. Instead of punishing IE users for using an outdated browser, it continues to present the baseline for them, and rewards users of modern browsers with extra sparkle. This encourages the use of modern browsers just like the "let IE break" attitude, but keeps everything perfectly useable and presentable to the least common denominator.
