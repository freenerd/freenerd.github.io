---
layout:   post
title:    "Bookmarklet: Better links to GitHub files"
permalink: better-links-to-github-files
comments: true
---

__Update: GitHub has this build in already. Press `y` and you'll get the canonical URL. Nice. 30 minutes of my life wasted to get that insight ...__

When you are sending links around to files on GitHub, these links usually include the branch name. If the branch changes, your link might break. If you link to linenumbers, the link to that line might be useless when the file changes and lines move around. Here is a bookmarklet that transforms a link to a file from going to a branch to the specific current HEAD commit. This allows to keep links consistent, even when files change.

#### Example

Before  
`https://github.com/mapbox/mapbox.js/blob/mb-pages/package.json#L25`

After  
`https://github.com/mapbox/mapbox.js/blob/e13cd8b00072fc208cd4670411292478e0718b91/package.json#L25`

#### Installation

<p>
Either drag this bookmarklet to your bookmarks: <a href="javascript:(function(){
    var a = $('.commit-title a');
    if (a && a.length > 0) {
        s = a[0].href.split('/');
        w = window.location.pathname.split('/');
        w[4] = s[s.length-1];
        window.location.pathname = w.join('/');
    } else {
        alert('Not a Github file site or bookmarklet is broken');
    }
})();">Transform link to GitHub commit</a>
</p>

Or create a new bookmark and copy the code below in there:

```javascript
javascript:(function(){
    var a = $('.commit-title a');
    if (a && a.length > 0) {
        s = a[0].href.split('/');
        w = window.location.pathname.split('/');
        w[4] = s[s.length-1];
        window.location.pathname = w.join('/');
    } else {
        alert('Not a Github file site or bookmarklet is broken');
    }
})();
```
