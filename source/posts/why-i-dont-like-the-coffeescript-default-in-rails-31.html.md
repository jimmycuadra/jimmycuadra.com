---
title: "Why I don't like the CoffeeScript default in Rails 3.1 "
date: "2011-04-15 00:13 PDT"
tags: "ruby on rails"
---
I generally don't like to comment on whatever the latest controversy is, but as both a front end developer and a Rails developer, I do want to jot down my thoughts on CoffeeScript becoming the default for JavaScript in Rails 3.1. While it's obviously not the end of the world, I disagree with this decision and I'm less than pleased about the way the core team has reacted to the community over it.

The main problem with this change is that using CoffeeScript is not the majority case. Most people do not use or want to use CoffeeScript, and all those people now have some additional boilerplate work to do every time they start a new app. Commenting the CoffeeScript gem out of the Gemfile to disable it is also unintutive compared to a command line option on app generation. It's not the most painful thing ever, but it's an extra step that must now be taken just to start with a clean slate. It sacrifices the convenience of the majority for the convenience of the minority, which goes against the rapid productivity and convention over configuration that people like me love Rails for.

I don't think this change is really about promoting the next greatest technology. I think it strongly illustrates that, in the end, Rails just uses whatever DHH prefers. There's only one explanation for why CoffeeScript should be default and SASS/Compass, HAML, and RSpec should not: it's DHH's opinion. If he happened to dislike CoffeeScript and like RSpec, I guarantee CoffeeScript would not be default and RSpec would.

A lot of people felt strongly about this change, and the Rails core team took a very "us against them" attitude in their response, calling people whiners, complainers, and trolls, who don't appreciate what has been given to them. I think that's a horrible, unconstructive attitude to take toward the very people who have made the framework successful: the users. People are empassioned about it because they love the framework and have a vested interest in seeing it continue to improve and succeed.

The arrogance of DHH and some of the other team members is by far my least favorite part of the Rails ecosystem. No single person is a god whose every opinion is correct just because of their past success. No one running an open source project should have a "you owe me" attitude about their users. If you have an entitlement complex, you're missing one of the most important aspects of open source software.
