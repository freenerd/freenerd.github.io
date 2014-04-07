---
layout:   post
title:    Modeling Dependencies in a Microservice Architecture
comments: true
---

_This post summarizes my master's thesis at a high level. More info on the thesis is [here](/my-masters-thesis)._

(Note: This post is a work-in-progress. I will update it in April/May 2014, as the thesis work is concluded)

### Introduction

When reasoning about the availability of a service in a microservice architecture, the basis for discussion often are the opinions of the engineers involved. Information used are the assumptions made while building the service, experience from operations (often visualized through graphs) and the occasional diagram (of dataflow or dependencies). This data tends to be (by its nature or the way it is selected) subjective and makes it difficult to get a holistic view.

In my thesis I tried to investigate a more structured approach, that should deliver more objective data.

My starting point was to find out which services exist and how these depend on each other. This can be modeled as a directed graph of dependencies. This graph allows the construction of faul trees for individual service failures. When these are annotated with failure probabilites, it is possible to calculate the probability of failure for the service.

I investigated to which extent it is possible to run this process automatically in an existing microservice architecture. I did this in a case study with a company from Berlin.

### Building a Dependency Graph

I model dependencies between applications (service providers and service consumers) as a [directed graph](https://en.wikipedia.org/wiki/Directed_graph). Nodes are applications and edges are dependencies.

A dependency from `A->B` implicates, that for A to work correctly, B has to work correctly. Following is a very simplified example of a web application:

```
Web -> MySQL
Web -> Recommendations
Recommendations -> ElasticSearch
```

<img src="/assets/master-directed-graph.png" alt="Directed Graph" title="Directed Graph" />

So how might this graph be generated? Following are some of the approaches I tried.

__Manual annotation__ The dependencies might be written down by the engineers themselves. Given that each application has a repository, a practical implementation of this approach could be to host a dependency annotation file in each application's repository. The problem with this method is, that the correctness of the graph depends on people maintainting the annotation files. Thus there might always be a (actually existing or at least feared) gap between reality and the graph. _It's not a technical, but a human problem._ In my case study, I did the manual annotation for most applications.

__From source code__ I did not find a fitting method to derive service dependencies from source code. One approach assumed that all service dependencies are encapsulated in shared libraries. That is not the case (think http calls via standard library), but even if it would be true, we'd still need to map the actual service to the library, like "shared library _mysql2_ encapsulates a service dependency to application _MySQL_". Another approach depended on how [service discovery](http://jasonwilder.com/blog/2014/02/04/service-discovery-in-the-cloud/) happens. Given service discovery happens via static identifiers in the code, we could parse these out. We then know the service dependency, if it is possible to derive the service name from that static identifier. An example is [service discovery via DNS](http://labs.spotify.com/2013/02/25/in-praise-of-boring-technology/), where it is also assumed that the domain names follow a specific schema. For my case, that schema should include the service name, like `<service>.internal.example.com`. In my case study, the source code mostly did not include service discovery identifiers, but got them assigned through the environment.

__From application deployment environment__ Given that the application gets its service discovery identifiers from the environment, we can use the same mechanism as in the previous section to detect the service dependency. The environment (also called configuration) is usually compiled during the deploy of the application. Examples for this are via [chef](http://www.getchef.com/) (with configuration files read by the application) or via a deployment system (with environment variables read by the application). In my case study, only some services went through service discovery but a majority of services was addressed through "physical addresses" (hostname and port). I attribute the low coverage of service discovery to the fact that it was only recently introduced in the company and sees slow adoption by the engineers.

__From network connections__ Given that the applications are deployed and communicate with each other on the network, we might use that traffic to identify dependencies. For example we might capture network connections via [sockstat](http://www.unix.com/man-page/all/0/sockstat/) or [netstat](http://www.unix.com/man-page/all/1/netstat/) on application hosts. A connection might then look like this: `source_pid source_ip:port -> destination_ip:port`. To determine the source application, we may use the source process id. In my case study, I was able to derive the application name from the process id through an implementation detail of the deployment system. To determine the destination application, we need inverse service discovery, which turns an `ip:port` pair into a semantic service name. As mentioned before, in my case study I found a low adoption of service discovery, therefore this approach yielded sparse resuls as well.

To conclude, only the manual annotation resulted in a usable graph.

More approaches do exist: For example using a traceing system like Google's [Dapper](http://research.google.com/pubs/pub36356.html) that tracks all network calls and is annotated with application identifiers might allow the extraction of service dependencies.

### Constructing a Fault Tree

Before we construct the Fault Tree, we have to set some assumptions: As failure semantics we assume, that there is no fault tolerance. The failure of a service leads to the failure of all applications that depend on it. Also, an application might have two reasons for failure: either because one of the services it depends on fails, or because of "inherent" failure, e.g. a bug in the software.

Let's construct a fault tree, based on our previous dependency graph. The node, whose failure we are interested in, becomes the top event (in our example `Web`). From there, we create the "inherent" basic event for that service and an intermediate event for each dependency. All are connected to the top event via an `OR-gate`. We recursively continue this process for all dependencies. Here is the fault tree graphic:

<img src="/assets/master-fault-tree.png" alt="Directed Graph" title="Directed Graph" />

Due to the assumed failure semantics and the resulting algorithm, every application constitutes a single point of failure. Also the fault tree is significantly larger than the dependency graph. Thus, I conclude that such a fault tree alone is not a meaningful tool for modeling availability. But what if the Fault Tree had failure probabilities on it?

### Putting numbers on a Fault Tree

Basic events in a fault tree may get failure probabilities assigned. Based on these and the structure of the fault tree, the failure probability of the top event can be calculated.

I investigated two approaches:

 * __Historical availability data__ I wrote about the problem of measuring availability [here](/on-measuring-availability-for-services/). In my case study, collecting availability data was difficult, since there is no conclusive measurement regime for internal services in place.
 * __Code churn__ There is some evidence [1](#thesis-nut-1) that code churn might be a reasonable metric to predict defects in code. I'm still evaluating this approach.

Both approaches seem to be able to support monitoring the availability threats an application faces from its dependent applications. This in turn could aid architectural design decisions.

### Conclusion

Generating the dependency graph is the core of this modeling process. I showed several approaches that should enable the automated generationg of that graph from an existing microservice architecture. In my case study, these were inhibited by a heterogenous environment, especially in regards to using service discovery.

The structural fault tree seems to have less usefulness in practice than the dependency graph. On the other hand, a fault tree with failure rates might be a helpful tool in monitoring changes to the availability of an application.

The thesis operates under strong assumptions regarding application failure propagation. Extending it with fault tolerance mechanisms will be an interesting future work, as well as using a more homogenous environment for a case study.

<!--The history of the microservice architecture I investigated was that a monolithic application was broken into smaller services. But the monolith is still there, most importantly keeping the master data and core business logic. This leads to all microservices depending on the monolith still. -->

<!--For the future: more paas, devops, building programmable infrastructure means, that we can not only create it from code, but should also be able to reason about it, once it is created. That is part of controling complexity.-->

### References

  * <a name="thesis-nut-1">1</a> Nachiappan Nagappan, Thomas Ball. Use of relative code churn measures to predict system defect density. 2005. [pdf](https://research.microsoft.com/pubs/69126/icse05churn.pdf)
