---
title: How to Use HTTP Caching Like an Idiot
---
I’ve found that it’s pretty easy to run your own custom blog for with zero hosting cost, and even survive some significant traffic spikes, with liberal usage of [HTTP Caching in Rails](http://api.rubyonrails.org/classes/ActionController/ConditionalGet.html#method-i-fresh_when). So it’s somewhat ironic that when I come to update this blog this morning (after giving the last post a good year to really take root in the Collective Unconscious), I noticed that my caching fetish had shot me in the foot.

You see<sup>1</sup>, for logged-in users (i.e. me) the blog pages have an extra
panel in the sidebar for creating new posts. Since all of the blog pages are cached (with `last_modified` set to the update time of the most recent post), that admin panel was getting cached along with the rest of the page, and served to all public visitors (both of them). D’oh!

The quick solution was pretty simple:

    fresh_when(...)  unless current_user

That will at least keep from polluting the publicly-cached page with user- (and, especially, admin-) specific HTML. If that seems like such an obvious thing to do that only an idiot wouldn’t think to do it, then you’re probably reading the wrong blog.

For the rest of us, I’m contemplating more complicated (but safer!) solutions, to keep us from spamming the internet with our private data. The first step might just be a mechanism where the partial that renders users-specific HTML could just cancel the HTTP caching. A more scalable solution would involve [Fragment Caching](http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching) and [Memcached](http://memcached.org/). But part of me wants to go [Full Paranoid](http://knowyourmeme.com/memes/full-retard) with some sort of Frankensteinian melding of [SafeBuffers](http://yehudakatz.com/2010/02/01/safebuffers-and-rails-3-0/) and [CanCan](https://github.com/ryanb/cancan), so no string ever makes it to the response body unless it’s Certified Cache Safe.

[You know, for
idiots!](http://www.urbandictionary.com/define.php?term=You%20know%2C%20for%20kids)

<hr/>

<sup>1</sup> That’s a retroactively-foreshadowing meta-pun. You’re welcome.
