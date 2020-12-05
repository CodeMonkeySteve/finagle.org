---
title: Back on Rails
tags: [rails]
---

As of today, I’ve been with [Vigilos, Inc.](http://vigilos.com) for exactly four months, a fact I was reminded of when the password expiration policy kicked in and I had to track down the admin to reset it. While my days have been spent slogging through old crappy C code (and replacing it with shiny new C<span class="underline"></span> code), I been spend ing evenings and weekends getting reacquainted with Ruby on Rails. This has been inspired in large part by the Second Edition of [Agile Web Development with Rails](http://www.amazon.com/gp/amabot/?pf_rd_url=%2Fgp%2Fproduct%2F0974514055%2Fref%3Dpd_cp_b_title%2F102-6241858-0226508&pf_rd_p=252362401&pf_rd_s=center-41&pf_rd_t=201&pf_rd_i=0977616630&pf_rd_m=ATVPDKIKX0DER&pf_rd_r=00B19H2M1TJWAHKNJJ56), an excellent book, both as tutorial and reference, and I highly recommend it to anyone doing Rails development.

After perusing the book cover-to-cover on my daily bus commute, I decided it was time to go back and rewrite my nominal web site ([finagle.org](http://finagle.org)). This was my first Rails project, back when Rails was only up to version *0.10*, and had quite a bit of cruft due to the ancient version (lots of stuff has changed since then) and my own lack of Ruby/Rails experience. Starting from scratch, following the book closely, and salvaging chunks of code from the original version, produced a much smaller and cleaner implementation.

Along the way, I also learned some new an interesting Rails development tricks. I’ve been using [RadRails](http://www.radrails.org/) on my PowerBook laptop (*sooo* much more responsive than running KDevelop over X11), which is a nice little IDE. My only gripe is that it doesn’t support [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/), but it’s easy enough to run that in a shell. I’ve also been using some rather spiffy plugins, some new some old:

-   [manage\_fixtures](http://svn.toolbocks.com/plugins/manage_fixtures) allows for easy export/import of YAML fixtures to/from the data base,
-   [acts\_as\_textiled](svn://errtheblog.com/svn/plugins/acts_as_textiled) handles converting models’ Textile markup into HTML,
-   [assert-valid-asset](http://www.realityforge.org/svn/public/code/assert-valid-asset/trunk) is a great tool for automagically validating HTML and CSS.
-   [backgroundrb](svn://rubyforge.org/var/svn/backgroundrb) provides facilities for executing long-running (or persistant) processes, and tying them into Rails.
-   Finally, I’m using the [open\_id\_consumer](http://svn.eastmedia.com/svn/bantay/plugins/open_id_consumer) plugin to handle logins via [OpenID](http://openid.net/). Username/password is *so* Web 1.0. ;)

Next up I need to hone my CSS skills a bit, maybe get a good *Agile Web*-style book on making pretty web themes. Any suggestions?
