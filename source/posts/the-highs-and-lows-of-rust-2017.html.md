---
title: "The highs and lows of Rust (2017)"
date: "2017-06-22 00:40 PST"
tags: "rust"
---
More than a year ago, I wrote about my experience programming in [Rust](https://www.rust-lang.org/) and what I felt were its [high and low points](/posts/the-highs-and-lows-of-rust/).
Recently, I was asked if the things I wrote then are still relevant, and if the highs and lows are the same now.
I realized there is enough to talk about since my last review that it was worth writing a new post.

## The highs

The high points of using Rust for me are essentially the same as before, so I'd suggest reading [that part](/posts/the-highs-and-lows-of-rust/#the-highs) if you didn't read it then.

To summarize, Rust has been a paradigm shift for me as a programmer.
It greatly raised the bar for me in terms of what I require out of a programming language, and like all the best changes of its kind, left me with the sentiment, "How did I ever go without this?"
I remember a time when I felt that about Ruby (my previous programming paradigm shift), but using Ruby drives me crazy now.

Rust gets attention largely because of its memory safety guarantees, making it a potential replacement for C and C++ for systems that require the highest levels of performance and low-level control.
However, I'm not a low-level programmer, so for me, the thing that Rust brings to the table is _correctness_.
Others have described this quality as "fearless" (e.g. [fearless concurrency](https://blog.rust-lang.org/2015/04/10/Fearless-Concurrency.html)), and while a bit jargony, I agree with the sentiment.
What Rust has done for me is allowed me to let go of the immense worry I didn't even realize I had in other languages.
In dynamically typed languages, or even statically typed languages with weak guarantees (e.g. Go), I had to program defensively, always worrying about things like a value being unexpectedly nil.
In Rust, the guarantees I get from reaching the simple goal of "it compiles" gives me more confidence in the correctness of my program than a full-blown test suite ever did in Ruby.

Rust's value is not just that it's statically typed.
There are many languages that are that.
Rust's value is that it brings all the benefits of static typing without sacrificing the expressive, natural feeling of writing code in a language like Ruby.
I get the same feeling of freedom to design and explore that I felt with Ruby, but with essentially none of the dangers.
This is largely because of Rust's fantastic type system.
Algebraic data types—specifically Rust's enums—are something I simply cannot imagine programming without at this point.
Many of the other great parts of Rust are not new ideas, but Rust melds so many great ideas from different languages together cohesively that it feels like you're getting the best of every world.
The only other mainstream language I know of with a comparable type system to Rust is Haskell, but Rust doesn't force me into a purely functional world, and provides a lot of other great benefits Haskell doesn't.

## The lows

I'm happy to report that the two specific lows I mentioned last year are now mostly resolved.

The big pain point of doing serialization on stable Rust was resolved in [Rust 1.15](https://blog.rust-lang.org/2017/02/02/Rust-1.15.html) when "Macros 1.1" was stabilized.
This allows any crate to do automatic implementations of traits using custom `derive` annotations.
We now have a 1.0 version of [Serde](https://serde.rs/), which has matured into an absolutely fantastic serialization library.
The only minor downside to the custom derive feature is that it is limited to generating implementations based on type declarations and does not offer a full-featured procedural macro system.
The procedural macro system _is_ being revamped, however, and is already partially available in the nightly compiler as "[Macros 2.0](https://github.com/rust-lang/rfcs/pull/1566)."

The other specific pain point I mentioned last year, about not having a stable, robust crypto library has improved as [*ring*](https://github.com/briansmith/ring) has matured and become the de facto crate for crypto in Rust.
It's still not 1.0 and still not audited, so we're not quite there yet.
In my work I also frequently need to create and manage X.509 certificates, and there is still nothing in Rust that does that yet.
We don't have a 1.0, audited, pure-Rust TLS implementation yet, but [rustls](https://github.com/ctz/rustls) is on its way, and unlike last year, we also have [native-tls](https://github.com/sfackler/rust-native-tls) which greatly improves the TLS story on macOS and Windows.

Interestingly, there are more lows this year than there were last year.
Not only are there more, but despite my perhaps-overzealous love of Rust, I actually feel more negative about the language this year.
My negative feelings are not because anything in Rust is _bad_.
It's because of the things that are on the horizon that we don't have yet.

Rust the language has been 1.0 since May 2015.
The problem is that 1.0 only means that what's there is stable.
It doesn't mean that it is featureful enough to write anything you might want, realistically.
It doesn't mean that the ecosystem of libraries and supporting tools is featureful and easy enough to use that you will convince non-early adopters to try it out or use it for real work.
This, by itself, is largely the same sentiment as last year: Rust the ecosystem is still just too young and immature for a lot of use cases.

The thing that's worse this year is that I've come much further in the development of my Rust programs, to the point where finishing things is blocked by certain features of Rust not being implemented yet.
While I don't have to worry about things I write today breaking in some future version of Rust, the critical problem is this:

**Knowing what features are coming, the APIs I would write when they're stable are significantly different than how I'd write them today.**

This knowledge of what is coming, but isn't here yet, completely paralyzes me.
I'm not going to declare any of my libraries 1.0 when I know for sure that I will make breaking changes to them once a feature I wanted but didn't have previously becomes available.

Here is a list of specific features that are either implemented but unstable, or still in the RFC process and not even implemented.
The stabilization of each of these would change the design of at least one piece of code in one of my applications or libraries:

* [Associated constants](https://github.com/rust-lang/rust/issues/29646) (this particular one will be stabilized pretty soon)
* [Associated type constructors](https://github.com/rust-lang/rfcs/pull/1598) (Here are two examples of where I would use it: [1](https://gist.github.com/jimmycuadra/c00813610a3aab67fca7), [2](https://gist.github.com/jimmycuadra/d652fa9a944bb5f8a7f5))
* [`async`/`await`](https://github.com/rust-lang/rfcs/pull/2033)
* [Constant generics](https://github.com/rust-lang/rfcs/pull/2000)
* `impl Trait` ([minimal](https://github.com/rust-lang/rust/issues/34511), [expanded](https://github.com/rust-lang/rust/issues/42183), and `impl Trait` in traits, which doesn't even have an RFC yet)
* [Fields in traits](https://github.com/rust-lang/rfcs/pull/1546) (Here is an example of where I would use it: [1](https://github.com/rust-lang/rfcs/pull/1546#issuecomment-246568198))
* [Never type](https://github.com/rust-lang/rust/issues/35121)
* [Non-exhaustive enum matches](https://github.com/rust-lang/rfcs/pull/2008) (the author didn't credit me, but this attribute [was my idea](https://github.com/rust-lang/rust/issues/32770#issuecomment-206658464)!)
* [Procedural macros](https://github.com/rust-lang/rust/issues/38356)
* [Specialization](https://github.com/rust-lang/rust/issues/31844) (Specifically with support for intersecting impls. Here are two examples of where I would use it: [1](https://www.reddit.com/r/rust/comments/5o89f6/optional_associated_types/), [2](https://www.reddit.com/r/rust/comments/6amj9g/generic_implementation_of_a_trait_with_associated/))
* [`TryFrom` and `TryInto`](https://github.com/rust-lang/rust/issues/33417)

All of these are _language features_, and say nothing of the huge amount of unstable crates that would need to be 1.0, many of which themselves are blocked on unstable or nonexistent features.

Right now, The most discussed of these features within the Rust community is asynchronous I/O.
For my use cases, this is the current state of things:

* Anything that uses HTTP needs to be asynchronous.
* This requires a 1.0 version of Hyper.
* Hyper, in turn, requires a 1.0 version of the Tokio stack.
* Tokio, in turn, requires a 1.0 version of futures.
* Futures, in turn, require `impl Trait` for realistic adoption.
* Futures are likely to be migrated to the standard library.
* Even with all of the above 1.0 and stabilized, `async`/`await` is also needed to make async APIs ergonomic enough to consider stabilizing.

Even this particular chain of dependencies is going to take a while, and this is the stuff on my wishlist that the Rust team has prioritized most highly.
It's likely going to be multiple years before all this stuff is done.

I'd like to make it very clear that the Rust teams and the Rust community are not doing anything wrong.
All of the things I've mentioned here are long since known as desired by the Rust team, and there's a plan to get there.
All of these things are making progress, and a lot of very smart and hard working people are making it happen.

My negative feelings are quite simply because of the paralysis I feel knowing how different Rust will be once we have all these things, and having no recourse but to simply continue waiting, contributing to discussions and generally staying involved.
It wouldn't be so bad if I could continue using other languages in the meantime and consider Rust something I'd consider picking up again in a few years.
The good parts of Rust, even right now, are so good that I have trouble bringing myself to go back to any other language I know.
So I'm trapped in this limbo between a crippled version of the language I want, and this fantastic version of the language I know is coming.
I feel like a pouty little child writing this, but this is honestly how I feel right now.

## Should you use Rust?

It's always hard to generalize when the answer is nuanced, but if I _had_ to pick an absolute yes or no for everyone, I'd have to say no.
Rust is most certainly not ready for massive, widespread adoption.
I can't confidently claim that yes, it will work well for whatever you want to do with it, as I could say for Go, Java, C++, etc.

What I can say confidently is that there will be a time when I will unequivocably say, "Yes, you should use Rust."
The only reason I'm not saying yes today is because Rust is still young and its foundational pieces are still being built.
Everything that is in Rust today is awesome, and for many use cases it is already enough.
If you value the correctness of your programs over delivering quickly with minimal investment (i.e. the "always be shipping" mentality), you will already benefit from using Rust today.

That said, if you try to build anything significantly complex in Rust right now, I think you're likely to come across at least one place where you're unable to do something because the language doesn't support it yet.
This may be acceptable for building an application, where you're the only consumer of your API, but for a library it can be a major blocker.
Of course, even this may be less of an issue if you are more willing to stabilize code you know for sure will have breaking changes in the near-to-medium future than I am.

My current, totally unscientific estimate is that roughly two years from now, I will be able to recommend that people choose Rust for their next project, full stop.
