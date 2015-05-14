---
title: Option types and Ruby
date: 2015-03-11 00:00 PDT
tags: ruby, rust
---

I've been learning the [Rust](http://www.rust-lang.org/) programming language over the last several months. One of the great things about learning a new programming language is that it expands your understanding of programming in general by exposing you to new ideas. Sometimes new ideas can result in lightbulb moments for programming in languages you already know. One of the things learning Rust has made me realize is how much I wish Ruby had sum types.

A sum type is a type that has a number of "variants." These variants are alternate constructors for the type that can be differentiated from each other to confer different meaning, while still being the enclosing type. In Rust, sum types are provided through `enum`. An enum type can be destructured into a value using pattern matching via Rust's `match` operator.

~~~ rust
enum Fruit {
  Apple,
  Banana,
  Cherry,
}

fn print_fruit_name(fruit: Fruit) {
  match fruit {
    Apple => println!("Found an apple!"),
    Banana => println!("Found a banana!"),
    Cherry => println!("Found a cherry!"),
  }
}
~~~

We define an enum, `Fruit`, with three variants. The `print_fruit_name` function takes a `Fruit` value and then matches on it, printing a different message depending on which variant this particular `Fruit` is. For our purposes here, the reason we use `match` instead of a chain of if/else conditions is that `match` guarantees that all variants must be accounted for. If one of the three arms of the match were omitted, the program would not compile, citing a non-exhaustive pattern match.

Enum variants can also take arguments which allow them to wrap other types of values. The most common, and probably most useful example of this is the `Option` type. This type allows you to represent the idea of a method that sometimes returns a meaningful value, and sometimes returns nothing. The same concept goes by different names sometimes. In Haskell, it's called the Maybe monad.

~~~ rust
pub enum Option<T> {
  Some(T),
  None,
}
~~~

An option can have two possible values: "Some" arbitrary value of any type T, or None, representing nothing. An optional value could then be returned from a method like so:

~~~ rust
fn find(id: u8) -> Option<User> {
  if user_record_for_id_exists(id) {
    Some(load_user(id))
  } else {
    None
  }
}
~~~

Code calling this method would then have to explicitly account for both possible outcomes:

~~~ rust
match find(1) {
  Some(user) => user.some_action(),
  None => return,
}
~~~

What you do in the two cases is, of course, up to you and dependent on the situation. The point is that the caller must handle each case explicitly.

How does this relate to Ruby? Well, how often have you seen this exception when working on a Ruby program?

~~~ text
NoMethodError: undefined method `foo' for nil:NilClass
~~~

Chances are, you've seen this a million times, and it's one of the most annoying errors. Part of why it's so bad is that associated stack traces may not make it clear where the `nil` was originally emitted. Ruby code tends to use `nil` quite liberally. Rails frequently follows the convention of methods returning `nil` to indicate either the lack of a value or the failure of some operation. Because there are loose `nil`s everywhere, they end up in your code in places you don't expect and tripping you up.

This problem is not unique to Ruby. It's been seen in countless other languages. Java programmers rue the NullPointerException, and [Tony Hoare](https://en.wikipedia.org/wiki/Tony_Hoare) refers to the issue as his billion dollar mistake.

What, then, might we learn from the concept of an option type in regards to Ruby? We could certainly simulate an Option type by creating our own class that wraps another value, but that doesn't really solve anything since it can't force callers to explicitly unwrap it. You'd simply end up with:

~~~ text
NoMethodError: undefined method `foo' for #<Option:0x007fddcc4c1ab0>
~~~

But we do have a mechanism in Ruby that will stop a caller cold in its tracks if it doesn't handle a particular case: exceptions. While it's a common adage not to "use exceptions for control flow," let's take a look at how exceptions might be used to bring some of the benefits of avoiding `nil` through sum types. Imagine this example using an Active-Record-like `User` object:

~~~ ruby
def message_user(email, message_content)
  user = User.find_by_email(email)
  message = Message.new(message_content)
  message.send_to(user)
end
~~~

The `find_by_email` method will try looking up a user from the database by their email address, and return either a user object or `nil`. It's easy to forget this, and move along assuming our `user` variable is bound to a user object. In the case where no user is found by the provided email address, we end up passing `nil` to `Message#send_to`, which will crash our program, because it always expects a user.

One way to get around this is to just use a condition to check if `user` is `nil` or not before proceeding. But again, this is easy to forget. If we control the implementation of the `User` class, we can force callers to explicitly handle this case by raising an exception when no user is found instead of simply returning `nil`.

~~~ ruby
def message_user(email, message_content)
  user = User.find_by_email(email)
  message = Message.new(message_content)
  message.send_to(user)
rescue UserNotFound
  logger.warn("Failed to send message to unknown user with email #{email}.")
end
~~~

Now `message_user` explicitly handles the "none" case, and if it doesn't, an exception will be raised right where the `nil` would otherwise have been introduced. Of course, the program will still run if this exception isn't handled, but it will crash in the case where it does, and the crash will have a more useful exception than the dreaded `NoMethodError` on `nil`. Forcing the caller to truly account for all cases is something that pattern matching provides in Rust which is not possible in Ruby, but using exceptions to provide earlier failures and better error messages gets us a bit closer to the practical benefit.

There are other approaches to dealing with the propagation of `nil` values in Ruby. Another well known approach is to use the null object pattern, returning a "dummy" object (in our example, a `User`), that responds to all the same messages as a real user but simply has no effect. Some people would argue that is a more object-oriented or Rubyish approach, but I find that it introduces more complexity than its benefit is worth.

Using exceptions as part of the interfaces of your objects forces callers to handle those behaviors, and causes early errors when they don't, allowing them to get quick, accurate feedback when something goes wrong.
