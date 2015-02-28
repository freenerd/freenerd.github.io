---
layout:   post
title:    "How a map is served at Mapbox"
comments: true
---

Some weeks ago I gave a talk at the [Berlin DevOps Meetup](http://www.meetup.com/blndevops/events/219636613/) titled _"Globally serving maps from 8 datacenters"_\*.

Below are the slides. They were made with the great [Deckset app](http://www.decksetapp.com/) and lot's of gifs and videos (which sadly didn't make it into the pdf export).

<iframe src="//www.slideshare.net/slideshow/embed_code/43736203" width="650" height="405" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>

Also during the talk I showed a video of our internal `mapbox-cli` tool which makes deploying with CloudFormation as easy as a `git push`. Questions in the comments are welcome.

<iframe width="650" height="360" src="https://www.youtube-nocookie.com/embed/wmDvcDvc6Jw?rel=0" frameborder="0" allowfullscreen></iframe>

\*_This has bugged me since I gave the talk: We serve from 8 AWS regions, with each region having 1, 2 or 3 availability zones. Each availability zone is an own datacenter, since they are said to be physically and logistically separate. Thus we serve from 1 + 4*2 + 3*3 = 18 datacenters._
