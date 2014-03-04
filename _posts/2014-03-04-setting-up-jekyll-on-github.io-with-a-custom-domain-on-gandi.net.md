---
layout:   post
title:    Setting up Jekyll on Github Pages with a custom domain on Gandi.net
---

[Recently](/blog-refreshed) I've moved my blog to Jekyll. This included moving my domain [freenerd.de](http://freenerd.de), which is now registered with [gandi.net](https://www.gandi.net) and hosted on [github pages](http://pages.github.com/). Here is some experience from my move:

  * **Switching .de domains is fast** The last time I moved a domain, I had to fax (as in _fax machine_) a signed [KK-Antrag](https://de.wikipedia.org/wiki/KK-Antrag) and wait for days until the switch happened. Today, one only has to enter an auth code and wait for the DNS TTL to switch to the new registration, boom, done.
  * **Think of your mail** I'm running my mail through my domain. While switching registration, I also got new mail servers. These have to be configured. Do that before the switch. Also FYI: Gandi allows to forward email (for incoming mail) and still have a mailbox (for outgoing mail) for the same email address.
  * **The CNAME influences all your domain** When you change the [CNAME](https://github.com/freenerd/freenerd.github.io/blob/master/CNAME) file in your Github Pages repo, all other Github Pages from all your other projects will also be redirected to your custom domain. Example: The honeypot [repo](https://github.com/freenerd/honeypot) pages used to live under `http://freenerd.github.io/honeypot` but now are at `http://www.freenerd.de/honeypot`. This is cool. But remember to not re-use these paths in your blog though.
  * **No apex domains with Gandi** I couldn't get them to work, since Gandi does not support `ALIAS` records. So I'm running everything under the `www.` subdomain now.

Github has [good documentation](https://help.github.com/articles/setting-up-a-custom-domain-with-pages) on using a custom domain. Still, for completeness, here is the important bit of my gandi dns zone file:

```
@ 10800 IN A 192.30.252.153
@ 10800 IN A 192.30.252.154
www 10800 IN CNAME freenerd.github.io.
```
