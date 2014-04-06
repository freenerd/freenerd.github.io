---
layout:   post
title:    Accessing the GitHub API with Golang
comments: true
permalink: accessing-the-github-api-with-golang
---

So you want to access the [Github API](http://developer.github.com]) with [Go](http://golang.org)? This post should give you some pointer on how to do that. It is deliberatly entry level aimed at API beginners (mostly because I want to get better at writing posts for novices).

In this post, I'm not using the [go-github client library](https://github.com/google/go-github/), but instead all interaction is done with go's standard [net/http](http://golang.org/pkg/net/http/) library. I do that to show the exact interaction happening with the API (and because using SDKs [has its own problems](http://blog.programmableweb.com/2013/11/25/runscopes-sheehan-sdks-add-unnecessary-layers-of-abstraction/)).

The first question you have to answer: _What do you want to access?_

  1. Public data
  1. Private data your Github account has access to (like private repos)
  1. Private data from other people's Github accounts

The third case is a bit more complicated, since it requires OAuth 2 for an  authentication flow. I'll cover that in another blog post. So let's focus on the first two cases for now.

## Reading the Github Docs

At [developer.github.com](http://developer.github.com) you'll find the official Github API docs. Go to __Documentation__ or __Reference__ and you'll get infos on all the HTTP endpoints that are available via the API. Find an endpoint you are interested in. Some endpoints may only work when you are logged in. The docs tell you (sometimes) if authentication is needed. Sometimes they don't (note to self: submit a pull request that adds that information to the Github docs). If you are not sure, just see if that information is publicly available on the Github webpage, since the API and the website basically have the same public/private restriction.

So you found an endpoint to query? For example the [user endpoint](http://developer.github.com/v3/users/#get-a-single-user) is a nice starter.

When working with remote APIs, a good idea is to query them "by hand". Everyone's favorite tool for that is the `curl`, use it on your command line like this:

```bash
$ curl -i https://api.github.com/users/freenerd
HTTP/1.1 200 OK
Server: GitHub.com
Date: Sat, 29 Mar 2014 22:39:51 GMT
...
{
  "login": "freenerd",
  "id": 25713,
  ...
}
```

The `-i` flag shows the headers of the Response.

## Accessing public data on Github

So let's do the http request:

```go
// request http api
res, err := http.Get("https://api.github.com/users/freenerd")
if err != nil {
  log.Fatal(err)
}

// read body
body, err := ioutil.ReadAll(res.Body)
res.Body.Close()
if err != nil {
  log.Fatal(err)
}

if res.StatusCode != 200 {
  log.Fatal("Unexpected status code", res.StatusCode)
}

log.Printf("Body: %s\n", body)
}
```

The current `body` is just a string, so we still have to parse it in order to access the data within. The Github API returns json, so let's use Go's [encoding/json](http://golang.org/pkg/encoding/json/) library.

```go
// parse json
type jsonUser struct {
  Name string `json:"login"`
  Blog string `json:"blog"`
}
user := jsonUser{}

err = json.Unmarshal(body, &user)
if err != nil {
  log.Fatal(err)
}

log.Printf("Received user %s with blog %s", user.Name, user.Blog)
```

First we create a new struct that will be filled with the data from the json object. Then we `Unmarshal` the string into the struct. If the naming of the keys in the json and in the struct does not match, use the `json:"<name>"` annotation to fix it.

That's it for accessing public data. Check the whole code [here](http://play.golang.org/p/Ksa2e3es39).

When playing around with the Github API like this, you might all of a sudden be stopped in your work, instead of returning meaningful results, the Github API only returns `403` status codes with a body talking about `API rate limit exceeded`. To prevent abuse of their API, Github only allows a certain number (60 at time of writing) of unauthorized API calls per hour from one IP. But thankfully, the docs on that [rate limiting](http://developer.github.com/v3/#rate-limiting) also point to the solution: more calls per hour (5000 at time of writing) if you do authorized calls, so let's try that next ...

### Authorized calls to private data on Github

Github has several ways of doing [authenticated calls](http://developer.github.com/v3/#authentication). Even though it might seem tempting, please don't use Basic Auth with your username and password, for [many](http://adrianotto.com/2013/02/why-http-basic-auth-is-bad/) [reasons](http://swaggadocio.com/post/48223179207/why-the-hell-does-your-api-still-use-http-basic-auth), but mostly because your passwords should be secret and using them anywhere in code opens the door for making mistakes which might lead to [their exposure](https://github.com/pjlowry/Github-Client/issues/1).

Instead, we opt for using a __personal access token__ that you can create from within the Github web application [here](https://github.com/settings/applications). When generating the token, make sure you give it the appropriate scope for the endpoint you want to query.

Once you have your token (a 40-character string), you can use it with basic auth. For example, I want to look at my [ssh keys](http://developer.github.com/v3/users/keys/#list-your-public-keys) on Github (which requires the `read:public_key` scope).

Let's first do the request via `curl` (where <token> becomes your token and the `-u` flag sets up basic auth):

```bash
$ curl -u <token>:x-oauth-basic https://api.github.com/user/keys
HTTP/1.1 200 OK
Server: GitHub.com
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4983
(...)
[
  {
    "id": 483166,
    (...)
  }
]
```

Again, I've removed some of the output. But note the `X-RateLimit-Remaining` header, which tells us how many calls we still have left for the next hour. Also the username:password for basic auth is `<token>` as username and the string `x-oauth-basic` as password.

Let's do all this in Go. To use basic auth, we have to create an http request object, which is then executed via an http client.

```go
// request http api
req, err := http.NewRequest("GET", "https://api.github.com/user/keys", nil)
if err != nil {
  log.Fatal(err)
}
req.SetBasicAuth("<token>", "x-oauth-basic")

client := http.Client{}
res, err := client.Do(req)
if err != nil {
  log.Fatal(err)
}

log.Println("StatusCode:", res.StatusCode)

// read body
body, err := ioutil.ReadAll(res.Body)
res.Body.Close()
if err != nil {
  log.Fatal(err)
}

log.Printf("Body: %s\n", body)
```

I'll leave the _json_ parsing to you, its similar to the way we did it before. The full code can be found [here](http://play.golang.org/p/8fgeVOUkry).
