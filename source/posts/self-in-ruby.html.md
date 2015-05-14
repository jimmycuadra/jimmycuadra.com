---
title: "Self in Ruby"
date: "2011-02-02 03:22 PST"
tags: "ruby"
---
The keyword `self` in Ruby gives you access to the current object – the object that is receiving the current message. To explain: a method call in Ruby is actually the sending of a message to a receiver. When you write `obj.meth`, you're sending the `meth` message to the object `obj`. `obj` will respond to `meth` if there is a method body defined for it. And inside that method body, `self` refers to `obj`. When I started with Ruby, I learned this pretty quickly, but it wasn't totally apparent when you might actually need to use `self`. I will outline the two most common use cases I've found for it.

## Class methods

The first usage I ran into was to define class methods. Inside a class, the `def` keyword will create a new instance method, when used without an explicit receiver.

~~~ ruby
class Post
  attr_writer :title

  def print_title
    puts "The title of this post is #{@title}"
  end
end

pst = Post.new
pst.title = "Green Beans"
pst.print_title
# "The title of this post is Green Beans"
~~~

In the context of a class, `self` refers to the current class, which is simply an instance of the class `Class`. Defining a method on `self` creates a class method.

~~~ ruby
class Post
  def self.print_author
    puts "The author of all posts is Jimmy"
  end
end

Post.print_author
# "The author of all posts is Jimmy"
~~~

Another more advanced way to do this is to define a method inside the `Class` instance itself. This is referred to as the eigenclass or the singleton class and it uses the `self` keyword to open a new context where the `Class` instance is held in `self`.

~~~ ruby
class Post
  class << self
    def print_author
      puts "The author of all posts is Jimmy"
    end
  end
end

Post.print_author
# "The author of all posts is Jimmy"
~~~

## Disambiguation

When you call a method without an explicit receiving object, the method is implicitly called on `self`. So if `self` is assumed for us, why do we ever need to use `self.meth` outside of a class method definition? As it turns out, it may not always be clear which method you're trying to call. Consider this example:

~~~ ruby
class Post
  attr_writer :title

  def self.author
    "Jimmy"
  end

  def full_title
    "#{@title} by #{class.author}"
  end
end

pst = Post.new
pst.title = "Delicious Ham"
puts pst.full_title
~~~

When we call `full_title`, we get a syntax error because `class.author` in the method body attempts to use the `class` keyword instead of the `class` method on the `pst` object, which is what we want – the object's class. If we use `self.class.author` instead, Ruby knows that we want the `class` method of `pst`, and we get the result we expect.

Another time when `self` is needed for disambiguation is when assigning a value to one of the object's attributes. Here is a contrived example:

~~~ ruby
class Post
  attr_accessor :title

  def replace_title(new_title)
    title = new_title
  end

  def print_title
    puts title
  end
end

pst = Post.new
pst.title = "Cream of Broccoli"
pst.replace_title("Cream of Spinach")
pst.print_title
# "Cream of Broccoli"
~~~

Even though we replaced the title of the post with "Cream of Spinach," it remained set to "Cream of Broccoli" and that's what we see when calling `print_title`. This is because the assignment inside `replace_title` is simply assigning to a local variable called `title` which is not used for anything. If we change that line to `self.title = new_title`, then the call to `print_title` at the end will give us "Cream of Spinach" as we were expecting. Note that it is not necessary to use `self.title` explicitly when using the accessor method inside the definition of `print_title`, because Ruby will see that there is no local variable with that name and then send `self` the message `title`. In the case of assignment, Ruby must assume you want to assign to a local variable, because if it sends the `title=` message to `self`, you are left with no way to set a local variable.

If you have more examples of when you might use `self`, feel free to leave a comment.
