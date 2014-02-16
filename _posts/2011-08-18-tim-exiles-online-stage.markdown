---
layout: post
status: publish
published: true
title: Tim Exile's Online Stage
author: Johan
author_login: johan
author_email:
author_url: http://www.freenerd.de
wordpress_id: 1573
wordpress_url: http://www.freenerd.de/?p=1573
date: 2011-08-18 02:03:49.000000000 +02:00
---
<a href="http://www.timexile.tv"><img src="/assets/timexileonlinestage.jpg" alt="" title="timexileonlinestage"  class="aligncenter size-full wp-image-1577" /></a>

This Thursday, August 18th at 19:00 CEST/UTC+2, <a href="http://en.wikipedia.org/wiki/Tim_Exile">Tim Exile</a> will play the first official gig on his new Online Stage at <a href="http://www.timexile.tv">www.timexile.tv</a> ... and I'm super excited about it, because <a href="http://twitter.com/roelven">Roel</a> and me build that site for him (with the design help of <a href="http://www.failme.net/">Sheikh</a>). You have to tune in! You can watch an <a href="http://timexile.tv/">explanation video on the site</a> now already.

So on Thursday, Tim will plug in his laptop, midi controllers and webcam in his studio in London. When the gig starts, the website will reveal a live video stream and a chat. Tim will make music and people can watch, listen and write fancy comments. So far a normal online performance.

The thing that is really interesting is the "REC" button under the stream. All viewers can record audio in the browser and send this audio via <a href="http://www.soundcloud.com">SoundCloud</a> to Tim. Within seconds, the new sound will turn up on Tim's Launchpad. Tim can instantly use it, manipulated, jam with it. Also, all sent sounds can be seen and listened to on the website via the play buttons under the stream. You can literally see the new sounds dropping in. And Tim will use the sound, that you just recorded on your little island in India or wherever, instantly in his live gig. Wicked!

So how did we build the site? The stream is done via <a href="http://www.livestream.com/">Livestream</a> and we also use the chat widget from there. The recording functionality is largely based on <a href="https://github.com/jwagener/recorder.js/">recorder.js</a>. Playback of audio is done via <a href="http://www.schillmania.com/projects/soundmanager2/">Soundmanager 2</a>. Everything is glued together with <a href="http://www.jquery.com/">jQuery</a>. The DOM and styles are plain HTML/CSS.

To get the newest tracks from SoundCloud we use a <a href="http://en.wikipedia.org/wiki/Reverse_proxy">reverse proxy</a>. This is needed since we do the requests to <a href="http://developers.soundcloud.com/docs/api/me-activities">Tim's activities</a> with a <a href="http://developers.soundcloud.com/docs/api/authentication">never-expiring OAuth2 token</a> and we can't reveal that token in the frontend. The first version we wrote used <a href="http://www.sinatrarb.com/">Sinatra</a> and <a href="http://code.macournoyer.com/thin/">Thin</a>, but this performed very badly with concurrent users. When a request hit the reverse proxy and was relayed to the SoundCloud API, the server was blocked until this request returned. Such a request can take seconds. To solve this, we switched to <a href="https://github.com/postrank-labs/goliath">Goliath</a>, which doesn't block on I/O, but instead suspends the request using Ruby's <a href="http://ruby-doc.org/core-1.9/classes/Fiber.html">Fibres</a>, until the HTTP call returns.

The whole site is deployed to <a href="http://www.heroku.com">Heroku</a> on the <a href="http://devcenter.heroku.com/articles/cedar">cedar stack</a>.

To get the samples from SoundCloud to Tim, we use a simple ruby script that polls the activities of his SoundCloud account. Whenever a new sound comes in, it is played with mplayer to a sound card. The sound card's output is connected with a cable (!) to the input of a <a href="http://www.native-instruments.com/en/products/producer/reaktor-5/">Reaktor patch</a> that records incoming sounds and maps maps then to the Launchpad.

Yes, this approach appears strange but it works surprisingly well. The two problems it has tho are 1) it needs the duration of the sound to load it in Reaktor and 2) we loose the mapping between the track on SoundCloud and the audio in Reaktor. This mapping could enable awesome stuff like a back channel for displaying which samples Tim currently uses. But for now we will leave this to future iterations.

I'm super excited about the launch. I hope you will be there to see it.

