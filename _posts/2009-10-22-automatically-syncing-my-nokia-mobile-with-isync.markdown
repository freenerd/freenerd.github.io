---
layout: post
status: publish
published: true
title: Automatically syncing my Nokia Mobile with iSync
author: Johan
author_login: johan
author_email:
author_url: http://www.freenerd.de
wordpress_id: 1126
wordpress_url: http://www.freenerd.de/?p=1126
date: 2009-10-22 12:41:59.000000000 +02:00
---
I'm having this <a href="http://www.freenerd.de/archives/2009/901/">Nokia E51</a> mobile phone which basically has become my main <a href="http://www.freenerd.de/archives/2009/999/">brain extension to go</a>, since i have abandoned all paper-based approaches. Best thing about the mobile is, that half of the day I'm on the go and I always have my mobile with me, be it on the train, on my bike or in the club. It is always not more than one quick reach into the pocket away. The other half of the day, I usually sit on my Laptop. Handling my schedule and tasks is easier on the big screen, so I prefer that when I have the chance for it. Problem is, that Laptop and Mobile have to stay in sync.

I use iSync for doing that, but the problem is, that I have to start it on my own (which I do forget always). So this is how to have regular scheduled syncing:

Put this in a file somewhere:
<code>
tell application "iSync"
        synchronize
        repeat while (syncing is true)
                delay 5
        end repeat
quit</code>                 

Now go to your terminal, type in crontab -e (for hourly sync) and add:
<code>
0 * * * * osascript {full script path}
</code>

<em>This did not work for me in the first place, but after calling osascript with <strong>arch -i386 osascript</strong> it worked on my MacBook Pro with Snow Leopard.</em>

Now every full hour iSync pop-up in the background, syncs with my mobile and closes automatically. I do not get disturbed by it, but also do not get any error messages. Bluetooth has to be constantly turned on on mobile and mac. When it is not, sync just fails silently.

As long as I have not moved all my personal data in the cloud, which will make keeping in sync far more easier, this is a pretty convenient way. 

For more infos:
<a href="http://hohle.net/scrap_post.php?post=204">An extended Version I based my approach on</a>
<a href="http://en.wikipedia.org/wiki/AppleScript">Apple Script on Wikipedia</a>
<a href="http://en.wikipedia.org/wiki/Crontab">Crontab on Wikipedia</a>
