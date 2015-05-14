---
title: "GitHub's inflexible pricing model"
date: "2010-12-20 09:48 PST"
tags: "github"
---
## The premise

GitHub is a fantastic service – probably one of my favorite sites on the web. I spend a good amount of time there browsing projects and it's inspired me to get more involved in the open source community. Best of all, it's free to do so. Accounts are free to create and you can create unlimited repositories for free, as long as they're viewable by the public. GitHub's beauty and power has whet my appetite to move all private repositories to their service as well, but for that I need to venture into the world of their paid plans.

Currently, there are a few divisions to their paid plans: regular plans and business plans. The regular plans are intended more for individual developers or very small teams, while the business plans seem geared more toward, well, businesses. Rather than list out all the details here, simply take a look at [GitHub's plans and pricing page](https://github.com/plans).

## The problem

A private repository is defined as one that is only visible to the account holder and other users the account holder explicitly specifies. A private collaborator is one such explicitly specified user. GitHub's plans all have a hard cap on how many of each you can have for a given plan. They seem generally reasonable, but the basis of the system is just not very flexible for the customer. I'd like to see a pricing model that offers a lot more control over exactly how many repositories and collaborators I need.

Want a single private repository? Too bad, you have to pay for a plan with 5.
Want 6 private repositories? Too bad, you have to pay for a plan with 10.
Want 10 private repositories and 6 collaborators? Too bad, you have to pay for a plan with 20 and 10, respectively.

The tiers just don't make very much sense. Having to decide a plan based on these arbitrary numbers just doesn't match the potential needs of the customer well. I'd love to see more of a pay-as-you-go model, perhaps something like Heroku's model where you select explicitly how many dynos and workers you want and your cost is associated with what you actually use, in any combination of the two.

## A case study, _my_ case:

Currently I have my private repositories (as well as my sites) on a shared hosting plan with Site5, and when my contract with them runs out in May I'd really like to move all my repositories to GitHub and use Heroku to actually host my apps. I have about 8 sites that I'd want private repositories for, which makes it hard to justify the cost of a setup like this. For the cost of GitHub's small plan, I could buy another year of shared hosting which gives me storage for unlimited git repositories and hosts the sites. Granted GitHub offers a lot more benefit in its repository hosting than just storing the files, like shared hosting provides. But still, I'm finding the lack of control over the cost as compared to what I actually need to be a frustrating aspect of adopting their services.

## I know, I know

I shouldn't expect the best for free. I shouldn't expect all the benefits GitHub provides over simple file storage not to come at a cost. I'm not too cheap to just pay for what I need. I will pay for what I need based on their current model when the time comes, but it leaves a lot to be desired. I imagine there are a lot of small-scale developers in a similar state – several small projects that are very economical to host with a setup like shared hosting, but hard to justify moving to a more specialized service like GitHub. More flexibility in pricing would help in making that jump. I'm also aware that they are fairly open to concessions and special cases if you contact them directly to set up a plan, which is great, but still puts another hurdle in the process, and doesn't change the fundamental flaw of the system: the arbitrary tiering and hard caps.

## TL;DR

Extra features aside, GitHub's paid plans are an expensive alternative to other means of hosting remote repositories, and the arbitrarily tiered pricing model offers little control for the customer in managing that cost appropriately.
