---
layout: post
status: publish
published: true
title: 'Introducing: Downloud'
author: Johan
author_login: johan
author_email:
author_url: http://www.freenerd.de
wordpress_id: 1715
wordpress_url: http://www.freenerd.de/?p=1715
date: 2012-06-01 09:43:15.000000000 +02:00
---
<img src="/assets/downloud.png" alt="" title="Downloud Screenshot" width="500" height="600" class="alignright size-medium wp-image-1716" />Yesterday I coded a small project called Downloud, it's basically a simpler <a href="http://www.fatdrop.co.uk/">Fatdrop</a>. The code is on Github <a href="https://github.com/freenerd/downloud">here</a> and a demo is <a href="http://downloud.herokuapp.com/odd001josht">here</a>.

<strong>The Background</strong>

Two friends of mine are running the label <a href="http://www.oddsocksrecords.com/">Odd Socks Records</a>. They release house music on vinyl and digital. Each release is 2-4 tracks. They send the releases for high quality download to their DJ and music industry friends, so they can play the tracks themselves. Famous people playing and mentioning your tracks is the great promotion for a label. But apart from that the label also wants to know what people think about the tracks. Thus the download can only be done after people left a comment. These comments in turn are used to promote the record and artists again (like seen <a href="http://www.elitemm.co.uk/newsblog/mihalis-safras/mihalis-safras-material030-feat-inglesesimone-tavazzi/">here</a>).

So there are some tools available for this already, most famously <a href="http://www.fatdrop.co.uk/">Fatdrop</a>, but my friends wanted to have their own styled version.

<strong>The Development</strong>

I sat down with both of them, they showed me examples, no big requirement analysis or design phase. Just a small list of features, a design sketch and their logo. The whole creation process took about 6 hours. Another hour for putting this on Github afterwards (mostly writing Readme).

The stack is simple: <a href="http://www.sinatrarb.com/">Sinatra</a>, <a href="http://sendgrid.com/">SendGrid</a> (via <a href="https://github.com/benprew/pony">Pony</a> gem), deployed on <a href="http://www.heroku.com/">Heroku</a>

One of the core decisions to limit scope was to have no own storage. The audio is streamed from SoundCloud, the actual download is hosted elsewhere (e.g. Dropbox' public sharing), the feedback is sent via email and the <a href="https://github.com/freenerd/downloud#configuration">configuration</a> is in a yml file that is deployed with the code.

<strong>The Future</strong>

The obvious thing to do is turning this into a customizable platform where 'everyone' can sign-up. From my experience with turning <a href="http://takesquestions.com/">TakesQuestions</a> into a platform as well as watching Lee developing <a href="http://emailunlock.com/">EmailUnlock</a>, there is quite some work to be done, like account handling, settings and customization storage or security. Maybe I'll do that one day.

SendGrid has a pretty rigid limit of 200 mails/day. To bypass this, gmail could be used, mostly because email is only sent to some exclusive recipients anyhow, so stats and sender score aren't relevant.

Also the feedback should be stored in a database to protect against lost emails and to run statistics.

If you think stuff should be different, please <a href="https://github.com/freenerd/downloud">fork away</a>
