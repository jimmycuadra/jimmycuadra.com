---
title: "Please don't use Cucumber"
date: "2012-05-31 19:52 PDT"
tags: "testing"
---
[Cucumber](http://cukes.info/) is by far my least favorite thing in the Ruby ecosystem, and also the worst example of [cargo cult programming](http://en.wikipedia.org/wiki/Cargo_cult_programming). Cucumber has almost no practical benefit over acceptance testing in pure Ruby with [Capybara](https://github.com/jnicklas/capybara). I understand the philosophical goals behind behavior driven development, but in the real world, Cucumber is a solution looking for a problem.

The fact that Cucumber has gained the popularity it has in the Ruby community is outright baffling to me. All the reasons to use it that people give are theoretical, and I have never seen them matter or be remotely applicable in the real world. Cucumber aims to bridge the gap between software developers and non-technical stakeholders, but the reality is that product managers don't really care about Gherkin. Their time is better spent brainstorming all the various use cases for a feature and communicating this either verbally or in free form text. Reading (and especially writing) Gherkin is a waste of their time, because Gherkin is not English. It's extremely inflexible Ruby disguised as English. The more naturally it reads, the more difficult it is to translate it into reusable code via step definitions.

There are basically two extremes of Cucumber:

1. Writing Gherkin describing the feature at a very high level, and reusing few of the step definitions between features.
2. Reusing step definitions, resulting in a level of detail described in the Gherkin which is not useful for any of the stakeholders.

Everything in between is just a bad compromise of one or the other.

Gherkin is really just glorified comments. If you simply write free form comments above Capybara scenarios, you can convey the same high level information about what the test is doing and what the acceptance criteria are, without any of the overhead, maintenance cost, and general technical debt of Cucumber. This doesn't allow for the real red-green-refactor cycle from the outside in of the BDD philosophy, but in my experience, developers tend to avoid the test-first approach with Cucumber simply because it's so painful to use. If you're not really following BDD practices, and your non-technical stakeholders are not reading or writing Gherkin, Cucumber is wasting your developers' time and bloating your test suite.

The one advantage Cucumber offers over simply commenting Capybara scenarios is that, by tying the "English" directly to the implementation, it's impossible for the "comment" to rot. This is certainly a danger, as a misleading comment is worse than no comment at all. However, this benefit comes at an extremly heavy cost. I would argue that it should simply be the discipline of developers to make sure that any time a Capybara scenario is updated, the corresponding comment is read through and updated as necessary.

Whenever someone writes a criticism of a particular piece of software, there is always a group of people who respond by saying, "It's just a tool. If it works for you, use it. If it doesn't, don't." While I agree in theory, this is where the effect of the cargo cult becomes real and damaging. Some guy somewhere came up with this idea that seemed great in theory, and everyone jumped on the bandwagon doing it because it sounded cool and it seemed like something they *should* do. After a while, people choose to use it just because it became the status quo. They don't see that all the reasons a tool like Cucumber seemed like a good idea, based on some blog post they read 3 years ago, are not in tune with the real, practical needs of their project or their organization. And once that choice has been made, everyone has to live with the increasing technical debt and slowed, painful development it creates.
