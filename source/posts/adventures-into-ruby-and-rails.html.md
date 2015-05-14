---
title: "Adventures into Ruby and Rails"
date: "2009-07-01 13:38 PDT"
tags: "cakephp, php, ruby, ruby on rails"
---
The more I've learned about [CakePHP](http://www.cakephp.org/), the more I've become interested in getting acquainted with its better known cousin, [Ruby on Rails](http://www.rubyonrails.org/). In the past few months I've been making my way through two different books from [The Pragmatic Programmers](http://www.pragprog.com/): [Rails for PHP Developers](http://www.pragprog.com/titles/ndphpr/rails-for-php-developers) and [Agile Web Development with Rails](http://www.pragprog.com/titles/rails3/agile-web-development-with-rails-third-edition).

What I've discovered so far is that the two frameworks are very similar. The primary difference is simply the language they're written in. The concepts are essentially the same and having built up a good understanding of CakePHP, the transition to Rails has been significantly easier. Since I had only very briefly taken a look at [Ruby](http://www.ruby-lang.org/), the main hurdle in beginning to develop applications with Rails is just learning Ruby itself. After working with PHP for many years, Ruby is different enough from the familiar to cause some growing pains, but the more time I spend looking at Ruby code, the clearer it becomes that it's a much nicer language to write with.

One of the core ideals of Ruby is that the language should mimic human language rather than forcing the programmer to write in terms easy for a machine to understand. While this seems like a good idea, years of working with "machine-style" programming cements into your brain until it becomes the language *you* use to get your ideas across the best. A similar ideal is found in [AppleScript](http://developer.apple.com/applescript/), although AppleScript goes much further in following human language constructs than Ruby does. I'd always found AppleScript difficult and unappealing because of this syntax. Ruby is a nice balance between the two ideologies because it still follows a good, logical syntax, but simply cleans things up to make code easier to read and understand. For example, AppleScript code attempts to form complete English sentences, like "tell application MyApp to do something." Ruby, on the other hand, still uses familiar syntax but with some twists, such as representing this:

~~~ php
<php
if (!$condition)
	print 'something';
?>
~~~

as this:

~~~ ruby
print something unless condition
~~~

This better follows a human language style of expression, without turning it into a literal English sentence.

In addition to the niceties Ruby provides over PHP, Ruby on Rails definitely has a leg up on CakePHP in many ways. One of the big frustrations I've had with CakePHP is the difficulty of working with model relationships and paginating data from related model searches. While entirely possible, it took much Googling and discussion on IRC and forums to get things working. If you don't want to have to reinvent the wheel with things like complex model relationships, solutions in CakePHP often require incorporating custom code found on the web which can be badly documented, supported, or tested. From what I've seen of Rails so far, dealing with related model data just works, right out of the box, with simple syntax that makes sense.

Some aspects of Ruby on Rails are not any better than CakePHP, however, such as support for Ajax. Both CakePHP and Ruby on Rails have helpers to speed up some common Ajax functionality, but both currently support only the [Prototype](http://www.prototypejs.org/) framework by default and inject all JavaScript code directly into the HTML. As a big advocate of the separation of markup, style, and behavior, this unfortunately renders these helpers useless for me, as I'm not willing to use obtrusive JavaScript in my applications. I also greatly prefer [jQuery](http://www.jquery.com/) to Prototype, and although both CakePHP and Rails are currently working toward updates for framework-agnostic JavaScript helpers, currently they're neck and neck. However, I have read that one of the features of the upcoming Ruby on Rails 3 is a JavaScript helper that produces only unobtrusive code. As far as I know, CakePHP has nothing like that in the works.

Of course, there is still a huge amount to learn about Ruby and Rails (and the other software required to use it, such as various deployment solutions) but these have been my impressions thus far. There are a few applications I have on my to-do list, and I've decided to hold off on starting them until I'm comfortable enough to make them Rails applications. Once I've actually worked with it on a real application I'm sure I will have more thoughts on how CakePHP and Ruby on Rails compare.
