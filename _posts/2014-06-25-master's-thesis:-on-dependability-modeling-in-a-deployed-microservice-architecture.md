---
layout:   post
title:    "Master's Thesis: On Dependability Modeling in a Deployed Microservice Architecture"
permalink: "masters-thesis"
comments: true
---

<img src="/assets/masters-thesis-handin.jpg" alt="Master's Thesis Cover" />

Today I handed in my Master's Thesis for <a href="http://hpi.de/">IT-Systems Engineering</a>. Seven months of doubt and hard work, breakthroughs and setbacks finally come to a conclusion. It's a good feeling.

I posted about the core content of the thesis [earlier already](/modeling-dependencies-in-a-microservice-architure/). The final title is _"On Dependability Modeling in a Deployed Microservice Architecture"_ and here is the final abstract:

> The microservice architectural style is a common way of constructing software systems. Such a software system then consists of many applications that communicate with each other over a network. Each application has an individual software development lifecycle. To work correctly, applications depend on each other. In this thesis, we investigate how dependability of such a microservice architecture may be assessed. We specifically investigate how dependencies between applications may be modeled and how these models may be used to improve the dependability of a deployed microservice architecture. We evaluate dependency graphs as well as qualitative and quantitative fault trees as modeling approaches. For this work the author was embedded in the engineering team of “SoundCloud”, a “Software as a Service" company with 250 million monthly users. The modeling approaches were executed and qualitatively evaluated in the context of that real case study. As results we found that dependency graphs are a valuable tool for visualizing dependencies in microservice architectures. We also found quantitative fault trees to deliver promising results.

You can download the whole thesis [here](/assets/masters_thesis_johan_uhle.pdf) (pdf/118 pages/1.5 MB). The Latex source is [on Github](https://github.com/freenerd/masters-thesis). Both the thesis itself and the source are licensed under the [Creative Commons BY-NC-ND 4.0 License](https://creativecommons.org/licenses/by-nc-nd/4.0/).

Thanks to [Peter Tröger](http://www.troeger.eu/) for sending me on the journey for this thesis. Thanks also to all engineers at SoundCloud, especially [Peter Bourgon](http://peter.bourgon.org/) for embedding me in his team and [Alexander Grosse](http://alexandergrosse.com/) for allowing me to do the research with the company. Also thanks to [nxtbgthng](https://nxtbgthng.com/) for letting me use their office and Lea and [Hannes](http://hannes.tyden.name/) for proof-reading.
