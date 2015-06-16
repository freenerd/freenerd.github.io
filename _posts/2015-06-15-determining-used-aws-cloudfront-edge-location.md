---
layout:   post
title:    "Determining which AWS CloudFront POP edge location is used"
comments: true
---

Yesterday I had to debug a problem that seemingly involved a faulty [AWS CloudFront](https://aws.amazon.com/cloudfront/) POP (_point-of-presence_ or also called _edge location_). Requests to some objects timed out, but the problem seemed to be limited to a certain geographic region. To debug the problem further, it was crucial to find out which POP was used. In the following example I assume that `example.com` is configured with a CloudFront configuration and the requests are made from the client's location experiencing the problems.

```bash
$ nslookup example.com
Server:		8.8.8.8
Address:	8.8.8.8#53

Non-authoritative answer:
example.com	canonical name = d3eju24r3ptc5d.cloudfront.net.
Name:	d3eju24r3ptc5d.cloudfront.net
Address: 54.230.201.39
```

This gives us the IP address of the CloudFront POP in question. Next we can feed the IP into a reverse dns lookup.

```bash
$ dig -x 54.230.201.39 +short
server-54-230-201-39.fra50.r.cloudfront.net.
```
The `fra50` part is the intersting one. AWS CloudFront follows a convention to name POPs after [IATA airport codes](https://en.wikipedia.org/wiki/International_Air_Transport_Association_airport_code). You can now either do a full-text search for the airport code on [this Wikipedia page](https://en.wikipedia.org/wiki/List_of_airports_by_IATA_code:_F) or do a [Google search for `<airport-code> airport code`](https://encrypted.google.com/search?hl=en&q=fra%20airport%20code). This reveals that the example request from above was full-filled by the POP in Frankfurt, Germany.
