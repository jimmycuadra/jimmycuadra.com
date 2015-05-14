---
title: "Bang goes 1.0, now with Hubot support"
date: "2011-12-15 19:59 PST"
tags: "bang, node.js"
---
I just released version 1.0 of my command line utility, [Bang](https://github.com/jimmycuadra/bang). Bang is a simple key value store for quickly storing and retrieving text snippets. I [talked about it in detail](/posts/bang-text-snippets-on-the-command-line-with-nodejs) last month, so be sure to check out that post for samples of usage.

Version 1.0 merely fixes a few bugs and establishes the public API according to [Semantic Versioning](http://semver.org/). Install Bang via NPM: `npm install -g bang`.

Perhaps the more exciting news is that you can now use Bang to smarten up your [Hubot](http://hubot.github.com/), GitHub's awesome chat bot! The Bang script for Hubot is available in the [hubot-scripts](https://github.com/github/hubot-scripts) repository. Clone the the repository, copy `bang.coffee` into your own Hubot's scripts, and add `bang` and `shellwords` to your package.json file. Deploy your Hubot and enjoy!
