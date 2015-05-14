---
title: "Constraints and compromises in ECMAScript 6"
date: "2012-04-22 22:28 PDT"
tags: "javascript"
---
This past week I attended a talk by [Dave Herman](http://calculist.org/), an employee of Mozilla and member of ECMA TC39, who are in charge of the standard for JavaScript. Dave talked about a few of the features and improvements coming to JS in ECMAScript 6, including, what I think is the most exciting and desperately needed: the new module system.

I won't describe how the new module system actually works in this post, as that information is already available elsewhere (in particular at the [ES Wiki](http://wiki.ecmascript.org/doku.php?id=harmony:modules)). While this new module system looks great, I was concerned with the fact that it eschews the current community built around Node and its CommonJS module loading system. I asked Dave what the reasoning for this was. It boiled down to wanting to provide features for module loading which would not be possible using Node's current CommonJS system. Interoperability between client and server side JavaScript programs will eventually be achieved by converting existing code targeted for Node to the new module system.

While this may be a painful migration due to the amount of existing code using CommonJS, it seems like the best choice, given that the amount of JavaScript code targeting Node is dwarfed by the amount targeting the browser. Node will also be able to begin the conversion process fairly soon, as it only needs to wait for the implementation of ECMAScript 6 modules in V8.

Another feature Dave talked about was variable interpolation in strings via so-called [quasi-literals](http://wiki.ecmascript.org/doku.php?id=harmony:quasis). This feature is something very common in other high level languages, but to date JavaScript has relied on the concatenation of strings and variables with the `+` operator to achieve this. ES6, somewhat confusingly, uses the `` ` `` (backtick) to surround these quasi-literals and interpolates variables with `${varname}` syntax. I was also curious about the reason for this awkward choice, given Ruby and CoffeeScript's precedence for using double-quoted strings with embedded expressions in `#{}`, but Dave had the answer. Backticks were chosen for backwards compatibility. If existing strings were to suddenly gain this ability, existing code on the web that happened to have literal occurrences of `${` in them would become syntax or reference errors. The most important constraint TC39 must embrace, unlike languages which compile to JavaScript, is that changes to the language must not break existing code on the web.

Backticks, even though they are often used to execute shell commands in other languages, were chosen simply due to limited set of ASCII characters remaining for new syntax. Again, the syntax they chose here is not ideal, but given the constraints necessary for advancing JavaScript without breaking the web as it exists today, it's a pretty decent compromise.

I'd like to thank Dave again for his talk. I'm looking forward to ES6!
