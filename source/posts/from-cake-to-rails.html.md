---
title: "From Cake to Rails"
date: "2009-09-21 02:15 PDT"
tags: "cakephp, php, ruby, ruby on rails"
---
Now that I have finished a large project in [Ruby on Rails](http://www.rubyonrails.org/), I think it's time to document some of my thoughts on how it compares to [CakePHP](http://www.cakephp.org/). I'm in the unique position of having built the exact same application twice, once in CakePHP and now once in Rails. My findings were that Rails is superior in most aspects, but a lot of this has to do with the superiority of the Ruby programming language over PHP.

As I mentioned in a previous blog post, coming from a PHP background makes the Ruby syntax a bit difficult to pick up at first, despite its intent to mimic the structure of natural language. Once you get over the initial mental hurdles, however, Ruby is an absolute pleasure to work with and makes you realize all the things that are less than ideal about PHP. Ruby is much easier to write and to read. It's succinct, isn't littered with braces and semicolons, and it's very flexible. In Ruby, "everything is an object," and this fact leads to some very elegant and compact code. I also love the ability to chain methods together in `object.method1.method2.method3` format. It's easy to follow and does in single lines what often takes PHP a whole section of code. Closures are a concept fairly fundamental to Ruby that current PHP developers may have trouble learning, but with the introduction of closures in PHP 5.3, this conceptual roadblock will likely prove less of an issue as time goes on.

The object-orientation of Ruby makes Rails significantly easier to work with than CakePHP because all your model data are encapsulated in objects, whereas CakePHP simulates objects by passing nested arrays around. Anyone who has dealt with nested arrays in PHP can tell you: they get ugly very fast. The complexity of a model object in Rails never impacts the syntax needed to represent it. It's always easy to write and easy to read.

One example of a significant advantage Rails has over CakePHP is the way it handles associations. In CakePHP, the only built-in model association for handling many-to-many relationships is "has and belongs to many." This requires a join table in the database that keeps track of pairings between records in each of the two relating tables. For example, when I was working on the tagging system for the blog in CakePHP, I was using the HABTM association. Posts had many Tags and Tags had many Posts. The difficulty arises in performing actions on one model from the point of view of the other. There are many examples in the CakePHP documentation of how to save related model data from a form, but I found it extremely difficult to edit existing relationships, such as when I wanted to associate a new blog post with a tag that already existed. While I did come to a solution eventually, it was not by any means intuitive and certainly didn't work out of the box. I had to use some third-party model behaviors which felt like they should have been built in from the start.

Rails has a much more elegant solution to these relationships called "has many through." Has many through connects two tables with a third join table just like HABTM, but with has many through, the two main tables are made aware of each other through an extra association. So in the posts/tags example, Posts and Tags both have many Taggings (the join table), but Posts has many Tags through Taggings, and Tags have many Posts through Taggings. This allows you to access one model via the other directly like this:

~~~ ruby
@post = Post.last
puts @post.tags
# frameworks, rails, testing, etc.
~~~

Very simple and intuitive. Much easier to manage and to build forms for.

There are some things I prefer about CakePHP, however. One thing I prefer is the way Cake handles validation and forms. I found the out-of-the-box form helpers in Rails to be difficult to use and to tweak to my liking. While Rails does provide advanced customization for building forms by creating your own "form builders" and by overriding the built in form classes, CakePHP's forms are much more customizable and intuitive. They don't force you to use a specific layout for your forms and error messages without resorting to writing complex customized classes or other behind-the-scenes hacks.

Somewhat related, I also found the validation handling in Rails to be inferior to Cake's, primarily for one reason: error messages do not persist through requests. The common way of dealing with a form in Rails is to render the form view directly from the controller action processing it when invalid data is received rather than doing a redirect. What this means is that the form-processing action must recreate any setup steps needed to render that view that were already taken care of by the original action.

For example, here on jimmycuadra.com, the blog and screencast views have a comment form at the bottom. These are handled by the show action (called the "view" action in CakePHP terminology). When a comment is submitted, however, it is processed by the create action, which is in charge of, unsurprisingly, creating new comments. But what happens if some of the data submitted in the comment is invalid? In CakePHP, the model sets validation error messages and redirects you to the original page. In Rails, the create action renders the show action directly with no redirect. This means that all the data set up initially done by the show action, such as fetching the current blog post and any other associated comments, must be done again from the create action. Since the error messages don't persist through requests, you can't simply redirect to the original page because the errors will disappear. This particular example is also made worse by the fact that the page that displays the comment form and the action that processes the submitted data are in two different controllers. Because no redirection is happening, this requires the comment controller to take on behavior from the blog and screencast controllers that really feel hacked together and ugly.

Another complexity of using Rails that CakePHP does not suffer from is deployment. For now, deploying a Rails application is not nearly as easy as a PHP application. Deploying a CakePHP app only requires you to set up the database on the server and upload your files. With Rails, there is some configuration required that has a bit of an initial learning curve. In addition, support for Rails applications may not even be present in some situations such as when using shared hosting. Once you've fought your way through the initial setup and deployment, things go back to being easy. [Capistrano](http://www.capify.org/) is a tool commonly used to automate application deployment using a version control repository. This deployment strategy could be seen as a plus for Rails, however, as it encourages you to integrate your project tightly with version control (which you really should be doing anyway).

What I think it boils down to, if I were to give another developer advice on which to choose, is that it really depends on your situation. If you have any technical restrictions that prevent you from using Rails, obviously it's out. If you only know PHP and need to turn out a project quickly, it's probably not worth diving into Rails for it. But if time permits and you're willing to put some effort into learning Ruby and a new way of doing things, I think the benefit to using Rails is very significant.

CakePHP certainly can't be faulted for the shortcomings of PHP when compared to Ruby. CakePHP is a fantastic framework and I will certainly continue to use it for any projects I do that need to be in PHP. But if I'm not restricted to using PHP by the constraints of a particular project, I see no reason to choose it over Rails at this point.