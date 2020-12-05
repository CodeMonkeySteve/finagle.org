---
title: A Few of My Favorite Things
---
### Ruby Development

-   [Ruby](http://ruby-lag.org) (1.8.4)
-   [RubyGems](http://rubyforge.org/projects/rubygems/) (0.8.11)
-   [KDevelop](http://kdevelop.org) (3.3.2)
-   [Nano](http://nano-editor.org)
-   [Subversion](http://subversion.tigris.org)

The barest of essentials. If you don’t already have Ruby and RubyGems, you’ve come to the *wrong* place.

I highly recommend the [KDevelop IDE]("KDevelop":http://kdevelop.org) for all of your bit-flinging needs. I grew to love it when doing C<span class="underline"></span> code, and it works just as well for Ruby. For times when you just want to tweak a config file, and a full IDE is overkill, [nano](http://nano-editor.org) is your best bet. An excellent lightweight text editor with syntax highlighting, multiple file buffers, and search-n-replace.

Finally, [Subversion](http://subversion.tigris.org) is by far the best source control system I’ve ever used (including CVS, SourceSafe, Continuus, and Perforce). Aside from its sane handling of symlinks and binary files, the ability to include external Subervsion repositories by reference makes it a must for including Rails plugins.

### Rails

-   [Rails](http://rubyonrails.com) 1.1
-   [Autotest]("Subversion":http://subversion.tigris.org)
-   [assert\_valid\_markup](http://redgreenblu.com/svn/projects/assert_valid_markup/) (plugin)
-   [request\_routing](http://svn.vivabit.net/external/rubylibs/request_routing/) (plugin)

The only-slightly-nude essentials. I don’t bother with EdgeRails as I’m still playing catch-up trying to grok all the spiffy features in 1.1.

If you only use one Rails plugin … you’re an idiot. But if it’s [assert\_valid\_markup](http://redgreenblu.com/svn/projects/assert_valid_markup/), at least you’re an idiot with standards-compliant web sites. Adding assert\_valid\_markup to your functional tests ensures that the XHTML content validates using the W3C validator. I’ve also added an assert\_val id\_css function to validate stylesheets as well (need to get that added, one of these days).

If you’re running multiple websites, you’ll also want the [request\_routing plugin](http://svn.vivabit.net/external/rubylibs/request_routing/). It makes it easy to create routes that look at things like domain (for virtual hosting). Very handy.

### Databases

-   [MySQL](http://mysql.com)
-   [PostgreSQL](http://www.postgresql.org/)
-   [BDB XML](http://dev.sleepycat.com/documentation/bdbxml.html)

I use [MySQL](http://mysql.com) almost exclusively, only because it’s th easiest to setup and administer for small sites. [PostgresQL](http://www.postgresql.org/) is good for that grown-up, Oracle feeling, but also comes with that Oracle footprint.

With Web Services being all the rage these days, big monolithic databases are looking more and more like they’re more trouble than they’re worth. What’s wrong with nimble, embedded DBS? And sure, tables work great for accounting, but if you want that juicy [XQuery](http://www.w3.org/TR/xquery/) goodness, [BDB XML](http://dev.sleepycat.com/documentation/bdbxml.html) is the new hotness.

### Administration

-   [Lighttpd](http://lighttpd.net)
-   [Capistrano](http://manuals.rubyonrails.com/read/book/17)

So you’ve got your Google-killing website writen, tested, validated, and checked-in. Now you actually need to get it on the IntarWeb. First you need a webserver (what, you want Rails to do *everything*?). I’ve used Apache for many many moons, but recently made the switch to [Lighttpd](http://lighttpd.net), and haven’t looked back. With memory usage less than *one-tenth* of Apache, is a must for shared/leased hosts where memory is scarce. It supports virtual hosting, SSL, FastCGI, rewrite/redirect, anti-deep-linking measures, and all with a config format that’s simple and pleasantly script-like.

Now that we have our website and web server, we need to get the former onto the later. That’s where [Capistrano](http://manuals.rubyonrails.com/read/book/17) comes in. With a simple Ruby config file, you can easily deploy your website to any number of web/db/application host machines (and then roll it back when you discover some horrific bug). No professional Rails setup should be without it.

### The IntarWeb

-   [Speakeasy](http://speakeasy.net)
-   [RimuHosting](http://rimuhosting.com)

I have residential DSL services through [Speakeasy](http://speakeasy.net), on which I run my secondary web server. Speakeasy has good prices and service, especially for geeks who have outrageous demands like static IPs.

Once I hit the critical mass of websites such that I didn’t want to host them on my home server, I looked around for a decent hosting company, and discovered [RimuHosting](http://rimuhosting.com). They provide virtual servers, with your choice of OS, for dirt-cheap (e.g. $20/mo.). In fact, I just upgraded my server (MySQL is such a RAM-hog), and they threw in another 32MB free, just because they could. We like free stuff (and companies that aren’t afraid to give it). I recommend highly.
