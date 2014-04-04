---
layout:   post
title:    On Measuring the Availability of Services
date: 2014-04-03 20:00:00.000000000 +02:00
comments: true
---

_This post is part of a series of posts in the context of my master's thesis in computer science. Check [this post](/my-masters-thesis) for an overview._

### Context

Given we have a software system that is running as a __Microservices Architecture__ (as recently summarized by Lewis & Fowler [1](#ava-1)). Similar to their definitions, I define the following:

  * A __component__ is a unit of software that is independently replaceable and upgradeable.
  * A __service__ is a component, that provides an interface for other out-of-process components to connect to, via a mechanism such as a web service request or a remote procedue call.
  * At runtime, each service might have many __instances__. That might be on the scale of only one instance to hundreds or thousands.

We assume these instances run in one network on many hosts. Services might depend on each other. For the context of this post we assume all communication happens via HTTP, but all ideas here should be independent of protocol.

### Availability

When discussing the dependability of a software system, availability is a common aspect to evaluate. Let's look at one availability definition (from [2](#ava-2)):

```
Availability is the readiness for a correct [behavior]. It can be also defined as the
probability that a system is able to deliver correctly its service at any given time.
```

Behavior here is seen as fullfilling the expectation of the user, which usually is captured in a specification. Given we have a request/response style communication, the specification would include all possible requests and their valid responses. If the service behaves in a way not specified, we speak of a failure of the service. The specification might also include failures (for example an HTTP response with a `500` status code).

When speaking about the availability of a service in practice, we usually would like to reduce that into one number. This comes out of the desire to compare availability, for example how a certain change impacts the availability of a service. In the definition above, availability is defined as a probability. When measuring availability, we usually base it on historical data with this formula:

```
Availability = Uptime / (Uptime + Downtime)
```

This will give a number between 0 (always down) and 1 (always up). Interpreted as a percentage, this yields the famous _x-nines_, like 99.99% ("4 nines") availability. It is important to note, that availability is always defined over a period of time (called mission time), for example for the last 24 hours or the last calendar month. This implies that we may look at availability only in hindsight, based on historical uptime and downtime data.

Let's look at an example of a day:

```
Mission Time = 24h
Uptime = 23h 50m = 85800s
Downtime = 0h 15m = 900s

Availability = 85800s / (85800s + 900s) ≈ 0,993055 ≈ 99.3 %
```

One assumption from the above definition is, that a service at any given time might be either up or down (if we'd allow both at the same time, we might get availability numbers over 1). So the next question becomes, how do we practically measure this?

### How do we do time?

In the above definition of availability, we used absolute numbers for representing uptime and downtime. But how do we get these numbers?

The usual representation for this is a [time series](https://en.wikipedia.org/wiki/Time_series). It assumes a fixed interval of time. To each interval (or its end therefore) we assign the current availability state. For example, the interval could be 1 second. For each second, we would save if the service was up or down. To calculate the uptime, we sum up all seconds with state _up_ within our mission time.

Here is an example: we have a time interval of 1 second and look at the availability for a mission time of 8 seconds. The time series might then look like this:

```
Mission time = 8s

Time series (u=up/d=down):
time |1|2|3|4|5|6|7|8|
state|u|u|u|u|d|d|u|u|

#up    = 6
uptime = 6s
#down    = 2
downtime = 2s

availability = 6s / (6s + 2s) = 0.75 = 75%
```

Next, we will look at the actual acts of measuring.

### Heartbeat

A [Heartbeat](https://en.wikipedia.org/wiki/Heartbeat_(computing) is a periodic message, signaling the current state of operation. In our context, it usually involves a client (which gives the heartbeat) and a server (which collects the heartbeat). Heartbeat gives us a classic time series: a server notes the client as _up_ when it sees a valid heartbeat message for a given period and _down_ when none at all or only a failure heartbeat message is seen.

There are two communication patterns for the heartbeat:

  * In a _push-based_ heartbeat, the client reports to the server. Thus, the client has to implement the logic for sending that heartbeat message, based on the heartbeat protocol of the server. An example is an HTTP POST to an endpoint on the server.
  * In a _pull-based_ heartbeat, the server requests the client regularly. The server might either query a dedicated heartbeat endpoint on the client or use an existing endpoint defined in the specification.

A problem with a _pull-based_ Heartbeat is, that it only assures the correctness of a subset of functionality by the client. If the heartbeat endpoint works, it is not verified that the whole client adhers to the whole specification. A failure example is, that each service the client exposes, might have different external dependencies. For example endpoint A might depend on a database and endpoint B on an external API. If the database is unreachable, endpoint A will fail whereas endpoint B will work as expected. Depending on which endpoint would be used, the availability measurement would deliver different results.

Especially for web services, there are a multitude of companies doing heartbeats for you. An older list can be found [here](http://blog.programmableweb.com/2012/05/08/48-monitoring-apis-watchmouse-amazon-and-google/). A more sophisticated example is [Runscope Radar](https://www.runscope.com/docs/radar), which does heartbeats by running a whole test suite against the service, therefore verifying the specification.

### How do we do time with events?

Time series are based on regular time intervals. This means each interval may only get assigned one value. This is no good to us if we want to work with event data, which is a common case when request/response communication is involved. There will likely be many clients doing request within each time interval.

To solve this problem, we may aggregate the events for a time period. As an example, let's use [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes), which have the nice property that they include codes for failure.

```
time |  1|  1|  3|  4|  4|  6|  7|  7|  9|
code |200|500|404|200|500|200|500|500|500|

period=5s

period[0-4]status[200] = 2
period[0-4]status[404] = 1
period[0-4]status[500] = 2

period[5-9]status[200] = 1
period[5-9]status[404] = 0
period[5-9]status[500] = 3
```

In this example, we summed up the status codes for each period as a counter. Each status code represents an own time series over these counts.

To use this for availability purposes, we need to condense all these time series to one number. The actual formula for this highly depends on the use case, especially on which behavior is expected and which is not. For the given example we might say that we see the service failed if there are more status codes >= 500 than status codes < 500. For the previous example, period\[0-4\] would be _up_ and period\[5-9\] would be _down_.

As a benefit over heartbeats, this method is based on the actual interaction with the service, therefore providing real-world testing of the specification.

So how do we get hold of these counts?

__Count on the service__

Responses are captured on the service instances, usually within the instance process. This has the problem that the service might fail in a way that no counts are collected anymore. An example is a kernel panic.

__Count on the clients__

Responses are captured on the service clients. This might happen either within the instance process or on the network path (for example on a load balancer like [HAProxy](http://haproxy.1wt.eu/)). This will also detect crash failures of the service.

Both counting methods should gather their data in a central place, given that they will have to run on instances of which we have many. One example for a program doing that aggregation is [statsd](https://github.com/etsy/statsd). It first aggregates counts in each instance process (via a shared library statsd client), then aggregates these aggregates on a statsd server, which eventually writes the time series to a database like [graphite](http://graphite.readthedocs.org/).

### Inherent problem of measuring

Whenever we measure the availability of a system, we are actually measuring many things at the same time:

  * The availability of the measured system (for example a service)
  * The availability of the communication medium (for example network, with switches on the way)
  * The availability of the measuring system (for example the heartbeat system)

In a perfect world, we assume the measuring system and the communication medium to be perfect and never break. In practice, they do fail and their failures might impact the correctness of the gathered data, especially when they are not detected and thus are assumed to be a failures of the measured service.

### Other ways of measuring availability

I'm sure there are more commonly used ways of measuring; please add in the comments.

### References

 * <a name="ava-1">1</a> James Lewis, Martin Fowler. Microservice Architectures. 2013. http://martinfowler.com/articles/microservices.html
 * <a name="ava-2">2</a> Olga Goloubeva et al. Software-Implemented Hardware Fault Tolerance. 2006. [Google Books](http://books.google.de/books?id=qX9GAAAAQBAJ&pg=PA9&lpg=PA9&dq=%22Probability+that+a+system+is+able+to+deliver+correctly+its+service+at+any+given+time%22&source=bl&ots=ovg1Fy8GBy&sig=Ah4jL1RpjqyGffd5X3e0Fb3Fd5g&hl=en&sa=X&ei=4nk-U_iBK8iRswan14CoDg&redir_esc=y#v=onepage&q=%22Probability%20that%20a%20system%20is%20able%20to%20deliver%20correctly%20its%20service%20at%20any%20given%20time%22&f=false)
