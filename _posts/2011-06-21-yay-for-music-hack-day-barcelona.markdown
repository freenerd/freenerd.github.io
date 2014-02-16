---
layout: post
status: publish
published: true
title: Yay for Music Hack Day Barcelona
author: Johan
author_login: johan
author_email:
author_url: http://www.freenerd.de
wordpress_id: 1542
wordpress_url: http://www.freenerd.de/?p=1542
date: 2011-06-21 14:13:10.000000000 +02:00
---
<img src="/assets/mhd_bcn_2011.png" alt="" title="Music Hack Day Barcelona"  class="aligncenter size-full wp-image-1549" />

Last week I attended <a href="http://bcn.musichackday.org/2011/">Music Hack Day Barcelona</a>. This is a write-up of my experience.

If you do not know <a href="http://musichackday.org/">Music Hack Day</a> (MHD) yet: It's a two-days event where programmers, designers and artists meet to build prototypes for the future of music. I have attended several of them in the past and organized the one in Berlin a month ago (which still deserves it's own post ...). Watch <a href="http://www.youtube.com/watch?v=SHcudrJMfX8">this video</a> from MHD New York to get an impression.

The <strong>MHD in Barcelona</strong> was the second one there; I did a write-up of the first one half a year ago <a href="http://backstage.soundcloud.com/2010/10/music-hack-day-barcelona/">here</a>. The recent one was held in connection with the <a href="http://2011.sonar.es">Sonar Festival</a>. On the one hand this was amazing (Hello <a href="http://instagr.am/p/F0u3p/">Nicolas Jaar</a> & <a href="http://instagr.am/p/GFn_q/">Four Tet</a>, <a href="http://www.elpais.com/articulo/Pantallas/Pincha/movil/discoteca/elpepurtv/20110619elpepirtv_1/Tes">press</a>, <a href="http://www.native-instruments.com/">awesome</a> <a href="http://ableton.com">people</a> already on site to chat with). On the other hand it was pretty noisy and hectic, people just randomly dropped-by and it was easy to get distracted by the festival. To give you an impression, watch <a href="http://www.youtube.com/watch?v=BgrI0rbLCs0">this video</a> of me walking from the hack space to the exit:

<object width="600" height="371"><param name="movie" value="http://www.youtube-nocookie.com/v/BgrI0rbLCs0?version=3&amp;hl=en_US&amp;rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube-nocookie.com/v/BgrI0rbLCs0?version=3&amp;hl=en_US&amp;rel=0" type="application/x-shockwave-flash" width="600" height="371" allowscriptaccess="always" allowfullscreen="true"></embed></object>

 On a personal level I think that a Hack Day at a festival can be a pleasant change. On a professional level I prefer relaxed but focused Hack Days more. There is already a lot of stuff going on anyways and adding more distraction drains energy from the MHD core of hacking and socializing.

<a id="more"></a><a id="more-1542"></a>

<strong>My Hack</strong> <a href="http://freenerd.github.com/potty-mouth-bands/">Potty Mouth Band</a>

```
Which band has the dirtier lyrics? Let your favorite bands fight. Enter two band names and we will fetch their lyrics from MusixMatch and send them through the sentiment analysis by MusicMetric. The band with the pottier mouth wins.
```

I wanted to work with other APIs a bit and figured that this is a funny little idea. When working on it I realized that this can be done frontend-only. So I dived into <a href="https://secure.wikimedia.org/wikipedia/en/wiki/Cross-Origin_Resource_Sharing">CORS</a> a bit and built the site with jQuery. <a href="https://twitter.com/#!/por">@por</a> helped me with the design, thanks for that.

Big advantage of living backend-less is that hosting it becomes dead-easy. My hack is deployed currently on GitHub Pages, just like <a href="https://github.com/robb/Marbleo.us">Robb</a> loves to do it ;)

In the end the hack <a href="http://www.flickr.com/photos/thomasbonte/5842892248/in/set-72157626846893191">won me</a> the <a href="http://www.musicmetric.com/">MusicMetric</a> prize, which is a pair of amazing <a href="http://www.sennheiser.com/sennheiser/home_en.nsf/root/professional_headphones-headsets_headphones_502188">Sennheiser HD 25-1 || headphones</a>. Yay, they will be used a lot!

One hack that really pushed boundaries is <a href="https://github.com/nddrylliog/jsmad">JS Mad</a> by <a href="https://twitter.com/#!/nddrylliog">Amos</a> from official.fm. It is a pure Javascript MP3 decoder that uses the Web Audio API of Firefox or Chrome to output sound. No flash, no audio tag. The <a href="http://news.ycombinator.com/item?id=2665607">internet is excited</a> about this and so are we. Let's hope this turns into a stable audio playback tool with sane CPU consumption.

There were a lot of other great hacks, have a look at the list <a href="http://wiki.musichackday.org/index.php?title=Barcelona_Hacks_2011">here</a>.

<img src="/assets/mhd_bcn_2011_2.png" alt="" title="SoundCloud @ MHD BCN 2011"  class="aligncenter size-full wp-image-1555" />

SoundCloud was a fairly large group with eight people on the Hack Day. We are very committed to Music Hack Days,  send a lot of people and I'm always a bit afraid of us dominating the hack day with presence. But it turns out that we are actually a humble, nice-to-be-around bunch of interesting people that doesn't just preach the SoundCloud gospel. At least this is the feedback I got from others. And for us it is very nice to be able to help others with their hacks but also to learn from them and engage in interesting conversations about everything.

After the Music Hack Day was finished, we started our week-end journey through Sonar-ish Barcelona, which lead me to seeing a <a href="http://instagr.am/p/F4lL_/">protest camp</a>, <a href="http://www.youtube.com/watch?v=QsMF5YwMN6k">party in a fancy villa on the hill side</a> and an abandoned theatre, breakfast on a lake in a park, swimming in the ocean, <a href="http://instagr.am/p/F8Pc9/">party</a> <a href="http://instagr.am/p/F8Y79/">on <a href="http://instagr.am/p/F8Qip/">a</a> <a href="http://instagr.am/p/F8pcl/">hotel</a> <a href="http://instagr.am/p/F8kv7/">roof</a>, dinner in a <a href="http://instagr.am/p/F9JMU/">medieval backyard</a>, party on a <a href="http://www.youtube.com/watch?v=7S4DYcUCNcA">beach</a> and in a <a href="http://www.youtube.com/watch?v=WqNOQAY8Sw8">basement</a>, an early-morning bike ride and spanish breakfast. And a lot of great sound to make me <a href="http://texinberlin.tumblr.com/post/6692624219/barcelona-en-tres-partes-durgell-parc-guell-la">very happy</a>.

On the way home I was sure that there is probably no better company I could work at, with amazing people that perfectly align with the way I want to live my life.
