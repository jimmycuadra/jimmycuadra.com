---
title: "Project Roadmap"
date: "2010-12-16 20:16 PST"
tags: ""
---
It's been a while since I wrote about what I've been doing in the web development world. Most of my mental energy is used at my day job, but I've been doing some work on my own, slowly but steadily.

I migrated a few of my apps from Rails 2 to Rails 3. This includes [More Things Need To](http://morethingsneed.to/), [Changesets](https://github.com/jimmycuadra/changesets), and this site itself. The hardest part of the process was deployment – getting all the right dependencies set up on my production machine. I'm thoroughly enjoying Rails 3. In particular, the new ActiveRecord API based on ActiveRelation is really awesome. It allowed me to do some internal refactoring on MTNT that greatly improved the maintainability of some of the basic logic. I'm also enjoying the new routing syntax quite a bit.

[More Things Need To](http://morethingsneed.to/) has received a bit of work beyond just the Rails 3 upgrade, the most notable of which is a new search feature. You can now search for entries by any string that appears in either its noun phrase or verb phrase. Currently the search just uses a primitive SQL query. I did a little research on indexed search with Sphinx but decided it was overkill for the small amount of traffic the site gets. It's certainly something that would become priority in the future if the site started getting heavier traffic and performance was an issue.

I started on my first real Ruby gem, [to_lang](https://github.com/jimmycuadra/to_lang). It's a Ruby wrapper for the Google Translate API that mixes a translation method directly into Ruby's String class. For now it simply adds a `translate` method, but my plan is to include a bunch of automagic methods to allow conversion between languages in plain English, like `"a pie".to_spanish` or `"a pie".to_english_from_spanish`.

As evidenced by my work on this gem, I've become more interested in learning Ruby outside the confines of Rails. I've spent some time experimenting with Rack and Sinatra and have been enjoying it. [Perceptes](http://www.perceptes.com/) now runs on Sinatra, in fact. All it does is pick a random quote to display, but it was a good starting exercise. I'm also looking at [Grape](https://github.com/intridea/grape) as a possible framework for giving MTNT a public API, and considering [OmniAuth](https://github.com/intridea/omniauth) as a new authentication system for it as well.

[The RSpec Book](http://www.pragprog.com/titles/achbd/the-rspec-book) from the [Pragmatic Programmers](https://www.pragprog.com/) has also reached an official release version, so I've been reading through that as well. I've had the book since its early beta version but ran into various technical problems the times I'd tried working through its examples. This time around, everything is going fine. I'm not a fan of Cucumber and wish there was a version that focused simply on specs, but it's still very useful. I've grown tired of Test::Unit so I'm planning to use RSpec from here on out.

Hosting is another thing I've been giving some thought to. Site5 has been a very good host, but now that I'm focusing solely on Ruby, when my current contract runs out I'm planning to move all my code to private GitHub repositories and host each application on Heroku, with email via Gmail. The only down side is that I would no longer be able to support my legacy PHP applications. Given that they get essentially no traffic at this point, I think it's a reasonable compromise.

On the far horizon, I have plans to redo [Altered Perception](http://www.keysandwings.com/), as it's embarrassingly out of date, and to recreate this site with a simpler structure, narrower focus, and a more elegant design.
