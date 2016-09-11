---
title: "The relationship between async libraries in Rust"
date: "2016-09-11 00:00 PST"
tags: "rust"
---
After all the recent announcements and hype about these async libraries, I was still a little confused about what each of these crates does and how they relate to each other.
The crates I'm talking about are [Futures](https://github.com/alexcrichton/futures-rs), [MIO](https://github.com/carllerche/mio), [Tokio](https://github.com/tokio-rs/tokio), and to a lesser extent [Hyper](https://github.com/hyperium/hyper) and even [Iron](https://github.com/iron/iron).
Futures and MIO were especially confusing considering that there are also (or were, at least) several futures-*foo* crates and tokio-*foo* crates.
After reading a bit more, I think I understand how they all relate now, so I wanted to share the knowledge (and please correct me if I'm wrong!)

**Futures** contains primitives for general purpose non-blocking computation, not necessarily specific to IO.
The most important types here are the `Future` trait, which represents a single non-blocking computation, and `Stream`, which is like an iterator that yields a sequence of non-blocking computations.
All the related futures-*foo* crates that were in the repo when it was first announced seem to have been renamed to tokio-*foo* and moved into the tokio-rs organization on GitHub.
Most of them were just examples of how Futures could be used as the underlying mechanism for a few different purposes.

**MIO** contains primitives for building cross-platform asynchronous IO systems, generally focused around network IO.

**Tokio** (as the overarching project) marries Futures and MIO to provide asynchronous IO using the Futures APIs.
Tokio is split up into several crates, which are, roughly in order from lowest level to highest level abstractions: **tokio-core**, **tokio-service**, **tokio-proto**, and the currently vaporware **tokio**.
tokio-core has the low level guts of asynchronous IO.
tokio-service contains the the `Service` trait, which similar to the futures crate's `Future` and `Stream` traits, is the central abstraction that the project provides for writing composable network programs.
tokio-proto provides additional types that are helpful for implementing a network protocol such as HTTP.
Finally, the crate actually called tokio will provide a higher level API that combines the features of the lower level crates.
This is the crate that most of us will use when we want to write an asynchronous network service.
The other crates exist separately just as a nice separation of concerns and to allow programs with more specific requirements to cherry-pick only the functionality they need.
The tokio crate itself does not exist at the time I'm writing this because the lower level building blocks are still under heavy development and the APIs are not finalized.
The other tokio-*foo* projects in the tokio-rs GitHub organization are either helpers types for specific use cases or examples of how you would build a network service using Tokio.

For those of us writing HTTP clients and servers, **Hyper** is the HTTP library we've come to know and love.
Hyper was originally synchronous, but since MIO's initial release has been undergoing some major architectural changes to switch to an asynchronous model.
According to Carl Lerche's [Tokio announcement post](https://medium.com/@carllerche/announcing-tokio-df6bb4ddb34#.bcynme9q5), Hyper is in the process of moving its async implementation to build on top of Tokio instead of MIO directly.

And last but not least, **Iron** is a higher level web development framework built on Hyper.
It's one of the more popular frameworks of its kind currently, though development activity has been very quiet for several months now.
It's not clear to me whether or not the primary authors are still working on the project, whether they have run out of time and need help maintaining it, whether it's intentionally abandoned, or whether they're simply waiting for all these lower level components to stabilize before revising Iron's own APIs to use they Futures/MIO/Tokio/Hyper stack.
Whether or not Iron becomes a framework that uses this stack, surely a web development framework using this stack will materialize sooner rather than later!
