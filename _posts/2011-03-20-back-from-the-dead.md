---
title: Back from the Dead
tags: [blog jekyll heroku]
---

Greetings, everyone! Welcome to my new-and-improved blog.

I’ve decided to merge my coding blog (“One-Banana Problem”), which has gone woefully under-updated, with my website (“finagle.org”), which is gone woefully under-used, and you’re now looking at the result. If you’re thinking it looks a lot like One-Banana Problem …

1.  You actually read my blog? Wow thanks, you’re awesome, that almost doubles my audience!
2.  It looks the same because it’s a port of the original content and style from OBP to a new platform.

Why a new platform? I’m glad you asked, therein lies the story …

##### The Story

It all started a few months back, when I went to compose a long-overdue OBP post, and discovered that Mephisto wasn’t letting me login. How rude. A quick Google not only failed to provide a solution to the problem, but indicated that Mephisto was no longer maintained or supported. The consensus appeared to be to migrate to a combination of [Jekyll](https://github.com/mojombo/jekyll), a static-site generator, and the [Disqus](http://disqus.com/) commenting system. Over the months since, I’ve followed the same path, deploying the new blog on [Heroku](http://heroku.com), my preferred hosting service. Porting the content was fairly easy, but porting the theme not so much.

##### Jekyll

The best I can say about Jekyll is that it works well enough to get things running again. At first, I was considering using it for some static brochure sites for friends and family, but after getting it working I’ve decided it’s not good for me for a few reasons:

-   No [HAML](http://haml-lang.com) support. Although there are lots of hacks and extensions that claim to fix this, I could never get any of them to work.
-   Heroku provides Varnish to automatically cache pages, so generating static HTML content doesn’t give any significant speed improvement.
-   I do have to check-in all that static content to Git, which just needlessly bloats the Heroku slug.
-   Heroku provides a Rack interface, which means I still need to use a (tiny) [Sinatra](http://sinatrarb.com) app to serve that static content.

While I can appreciate the idea of storing the content in the blog code itself, with metadata in a YAML header block and the copy in [Textile](http://en.wikipedia.org/wiki/Textile_(markup_language)), I think I’ll stick to Sinatra for my static sites. I’m already working on a CMS-ish project that will probably replace Jekyll as soon as it’s done enough.

##### Moving Forward

I originally started One-Banana Problem in 2006, after getting laid-off from a failing startup. I wanted to make the switch from a C<span class="underline"></span> developer to a Ruby/Rails guy, and I thought a blog would help not only to share my hard-won knowledge, but also to market myself to the Rails community in hopes of finding a good job. To that end, I tried to keep the tone professional and the content mostly related to Ruby and Rails.

But here we are, five years later, and now I’m living living the dream of a full-time Ruby developer (woo-hoo!). However, having achieved that goal, I find myself with less motivation for blogging, and more importantly, with less time.

To counter this trend I’ve decided that, as part of The Great Blog Renaming, that I would expand the scope from a mostly coding-centric blog, to including hacking of all kinds. I am a geek, after all, and to my brain all problems have technological solutions. I have some interesting ideas for things like secure voting, digital currency, and even improvements to the democratic process (which hasn’t changed significantly in centuries), and I’ll try to find the time to comment on these sorts of political and social issues more freely in the future.

I’ve also come to the conclusion that trying to keep things “professional” is boring and pointless. If you can’t be open an honest bastard with the whole Internet, viewable by all and archive forever, then why bother blogging?
