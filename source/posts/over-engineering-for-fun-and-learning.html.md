---
title: "Over-engineering for fun and learning"
date: "2011-05-24 23:49 PDT"
tags: ""
---
I love programming and web development. I like to always have a project to work on. This can be tough to achieve sometimes, because I'm not very good at coming up with ideas for things to build. I've completed some pretty cool projects in the past (like [More Things Need To](http://morethingsneed.to/) and [to_lang](https://github.com/jimmycuadra/to_lang)), but I've been in kind of a slump for ideas lately.

Last week I watched [A re-introduction to the Chrome Developer Tools](http://www.youtube.com/watch?v=N8SS-rUEZPg) with Paul Irish and, though I have used Safari for a long time, could no longer resist the siren call of Google Chrome and its fancy cutting-edge features. One of the things I like about Chrome is how Google is encouraging a developer culture with extensions, packaged web apps, and the Chrome Web Store.

I wanted to make an extension to learn a little about Chrome development, so I spent a few minutes brainstorming what I might create. I decided on an little tool to help improve my workflow at my job at Eventful. Our standard workflow on the front end team is to edit files locally with TextMate, then rsync them to a remote server where the actual virtual hosts are running. I have a Ruby script I use to automate the syncing process, but it still involves three steps: edit and save files, open the terminal and run the script, then refresh the browser to see the changes. I thought it would be cool to have a Chrome extension that would combine the second and third steps.

I ran into a snag in that extensions do not have access to the local filesystem nor the ability to run executables (which makes sense, since it would be a pretty severe security risk.) But for my purposes, I knew it was safe because I was the one writing it and would be the only one using it. Although you can't run a shell script directly from the browser, you can make network requests with XMLHTTPRequest. I whipped up a little Sinatra app that runs locally and listens for calls from the extension, then runs the sync script.

In the end, I had an extension that makes a little blue "E" icon appear in the omnibox whenever I'm on a page on one of my virtual hosts. Clicking it turns the icon yellow while it makes a request to the server. If an error occurs, the icon briefly turns red and logs a message to the console. If it succeeds in syncing, it refreshes the page to get the new changes. It was a highly over-engineered solution for what it actually accomplishes, but it was a fun exercise and allowed me to learn the Chrome extension system and do some problem solving.

I'll keep this experience in mind in the future when I'm aching for a project but can't think of anything to do that seems worthwhile. It's perfectly fine to do something that's not super useful. You'll still learn something and have fun doing it, regardless of whether or not the fruits of your labor have a practical purpose.
