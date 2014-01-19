---
layout: post
status: publish
published: true
title: Simyo and How not to deal with passwords
author: Johan
author_login: johan
author_email:
author_url: http://www.freenerd.de
wordpress_id: 1036
wordpress_url: http://www.freenerd.de/?p=1036
date: 2009-06-23 21:14:13.000000000 +02:00
---
I'm actually pretty happy with my german mobile carrier <a href="http://www.simyo.de/">Simyo</a>. They are prepaid, cheap and have a high degree of plan transparency. Today I had to deal with their hotline. In the beginning the hotline guy asked me to identify myself by telling him the first four letters of my online password. I asked him if Simyo is saving the password in plain text and if they are able to see the whole password. He responded that they do. The password is part of the contract data and therefor saved. I found nothing about this behaviour in the Simyo <a href="http://www.simyo.de/de/unternehmen/bedingungen.html">Terms Of Service</a> and can't remember being told about this during the online registration process.

Passwords and security have always been (and will possibly always be) a delicate subject. Saving passwords in plain text is a security flaw, because people tend to use the same password over and over again. If someone (employee, hacker or by accident) gets access to a password, other accounts are potentially compromised. I think state of the art is saving <a href="http://de.wikipedia.org/wiki/Salted_Hash">salted hashes</a> for passwords. And that's what every company should do!
