---
title: Excluding a bad RPM package
tags: [rpm, tips]
---
I’m a big fan of [KDE](http://kde.org), as both a user and a developer, and [Akregator](http://akregator.kde.org) is my RSS feed reader of choice. I’m also a big fan of RSS feeds, using them for almost all my regular daily information consumption.

So imagine my notable lack of delight when, after doing a regular YUM update, I discovered that the latest version of Akregator has [a serious bug that makes it almost unusable](https://bugs.kde.org/show_bug.cgi?id=271149). And I didn’t even want the new version anyway.

Ah, but since I’m using RPM and YUM, the fix for this sort of thing is actually pretty simple, although it took me a few minutes of reading man pages to work it out, so I thought I should share the fruits of my labor. Here’s how you exclude a bad RPM package:

First, find the last good version of the appropriate package:

    $ rpm -qf `which akregator`
    kdepim-4.4.11.1-2.fc14.x86_64

    $ sudo yum list kdepim --showduplicates
    ...
    Installed Packages
    kdepim.x86_64        7:4.4.11.1-2.fc14
    Available Packages
    kdepim.x86_64        6:4.4.6-2.fc14
    kdepim.x86_64        7:4.4.11.1-2.fc14

In this case, the desired version is 4.4.6 (the “6:” is the epoch, the “–2” is the release, and the “fc14” is the architecture).

Next, downgrade the package. If there are any dependency errors, you’ll also need to downgrade those packages too.

    $ sudo yum downgrade kdepim-4.4.6
    ...
    Error: Package: 7:kdepim-libs-4.4.11.1-2.fc14.x86_64
    ...

    $ sudo yum downgrade kdepim-4.4.6 kdepim-libs
    ...
    Removed:
      kdepim.x86_64 7:4.4.11.1-2.fc14                                                   kdepim-libs.x86_64 7:4.4.11.1-2.fc14

    Installed:
      kdepim.x86_64 6:4.4.6-2.fc14                                                      kdepim-libs.x86_64 6:4.4.6-2.fc14

    Complete!

And finally, edit `/etc/yum.conf` and add the offending package version to an `exclude` line:

    [main]
    ...
    exclude=kdepim-4.4.11.1 kdepim-libs-4.4.11.1

Take that, `kdepims-4.4.11`. ***plonk***
