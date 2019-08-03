---
title: Twitch live streams of Ruma development
date: 2019-08-02 22:31 PDT
tags: rust, ruma, screencast
---

*If you were linked here from Twitch chat, you probably want the <a href="#frequently-asked-questions">FAQ</a> at the end of this post.*


This week I started live streaming development of [Ruma](https://www.ruma.io/) on my [Twitch channel](https://www.twitch.com/jimmycuadra).
Surprisingly, I've never mentioned Ruma on my blog here!
Ruma is a project I started in late 2015 to implement the [Matrix](https://matrix.org) communication protocol in Rust.
It's been slow going, for a number of reasons, but in the last few months development has picked up again.
Partly to motivate myself to continue working on it, and partly because I love to teach and help other people learn to program, I decided to start doing live streams of my work on the project.
I did a couple of streams on the topic more than two years ago (and sadly only managed to save the recording of one of them), but I plan to do them more regularly now.
I've already announced that I'm doing this on Twitter, reddit, and in the Matrix chat room for Ruma, but I'm doing it here as well, to have a central place to link to when talking about the streams.

If all you want is to check out the streams (or the recordings that are archived on YouTube after the fact), here are the relevant links:

* [My Twitch channel](https://www.twitch.com/jimmycuadra), where the streams happen in real time
* [My YouTube channel](https://www.youtube.com/channel/UCnflGGv5ZM2kdn9RPb2NG6Q), where the recordings of each stream are archived
* [My Twitter feed](https://twitter.com/jimmycuadra), where I will announce each stream a few minutes before starting

If you were linked here from the chat on Twitch during a stream, the FAQ below is what you're here for.
These are the most commonly asked questions on the stream, and to avoid repeating myself on-stream too much, this information is provided here to bring you up to speed.
I'll keep this post updated over time if/when the most frequent questions change.

## Frequently asked questions

**Q: What is Ruma?**

A: Ruma is a Matrix homeserver, client, and supporting libraries written in the Rust programming language.
You can dig into the details of Ruma on [the Ruma website](https://www.ruma.io/).

**Q: What is Matrix?**

A: Matrix is an open specification for an online communication protocol.
It includes all the features you'd expect from a modern chat platform including instant messaging, group chats, audio and video calls, searchable message history, synchronization across all your devices, and end-to-end encryption.
Matrix is federated, so no single company controls the system or your data.
You can use an existing server you trust or run your own, and the servers synchronize messages seamlessly.
To get a better understanding of what Matrix is and why you should care, check out the [Introduction to Matrix](https://www.ruma.io/docs/matrix/) on the Ruma website.

**Q: What is Rust?**

A: Rust is a systems programming language from Mozilla built with safety, concurrency, and performance in mind.
Its novel approach to memory safety and its rich type system make it an excellent choice for writing fast, secure, and reliable programs.
Learn more about Rust on [the Rust website](https://www.rust-lang.org/).
If you're ready to start learning Rust, [the book](https://doc.rust-lang.org/book/) is where everyone starts, and it's a fantastic resource.
