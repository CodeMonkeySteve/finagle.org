---
title: Couch Trouble
tags: [couchdb]
---
I’ve been wrangling with CouchDB for a few weeks now, and it’s starting to feel a bit like this:

<object width="425" height="344">
  <param name="movie" value="http://www.youtube.com/v/vSTJL1ikxXY&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param>
  <embed src="http://www.youtube.com/v/vSTJL1ikxXY&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed>
</object>

(Ooh, my first embedded video. Feel the Web 2.0 Awesome-ness-age-ality).

First, let me say that I can’t really blame CouchDB for any of my troubles, which are essentially:

-   There are a excess of Ruby/Rails gems for accessing CouchDB, all of whom have different dependencies and do things in slightly different ways. I’m sure that eventually a consensus will emerge on the best Ruby/CouchDB way of doing things, but it hasn’t happened yet.
-   CouchDB is not yet 1.0, so the design can support [lots of spiffy features](http://couchdb.apache.org/docs/overview.html) that *don’t actually exist yet*. Specifically, the lack of partial replication stalled my attempts at using Couch for a distributed media server project.
-   CouchDB doesn’t work perfectly for absolutely everything (whoda thunkit?). My other big project (more on that later) isn’t really Document-Oriented, no matter how much I try to beat it flat. I’m now thinking Git is actually be best storage solution, and if you understand Gits internals well enough, you’ll see how mind-warping that concept is.

So I think I’ll put CouchDB down for a while, at least until 1.0, or until I run across a project where it’s appropriate. Of course, it’s still a gazillion times better than any RDBMS …
