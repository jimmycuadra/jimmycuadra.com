---
title: "Checking for one key among several in a Ruby hash"
date: "2010-02-07 04:54 PST"
tags: "ruby"
---
I've been hard at work on More Things Need To this weekend and have learned lots of things in the process. One of these things was a handy bit of Ruby that seemed worth sharing for other newcomers.

What I wanted to do was find out if any key from a list of keys existed in a hash. For example, given a hash `animals`, I'd like to know if it contains at least one key among the keys `horse`, `frog`, and `cow`. Checking for a single key is easy:

~~~ ruby
animals.key?('horse')
~~~

But what about when we want to check for all three of those animals? Well, we could just do one after another:

~~~ ruby
animals.key?('horse') || animals.key?('frog') || animals.key?('cow')
~~~

But that can get cumbersome very quickly. There are a few cleaner ways to do this for multiple keys, but the method I ended up using takes advantage of the fact that the `Array` class in Ruby includes the `Enumerable` module, which has a handy method called [any?](http://ruby-doc.org/core/classes/Enumerable.html#M003132). This method takes a block and will return true if any invocations of the block return a "truthy" value. So, here is the solution:

~~~ ruby
['horse', 'frog', 'cow'].any? do |key|
  animals.key?(key)
end
~~~

So what is happening here? First, we're defining an array that contains all the keys we want to check for. Then we call the `any?` method on that array and pass it a block. Inside the block, we check if the key in the current invocation exists in `animals`. If an existing key is ever found, the entire call will return true. This removes some repetition and makes the code easier to read.

Note that you can also find out if the hash contains all of the keys rather than just one by using the [all?](http://ruby-doc.org/core/classes/Enumerable.html#M003131) method instead of `any?`.
