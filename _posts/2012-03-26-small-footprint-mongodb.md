---
title: Small Footprint MongoDB
---
[MongoDB](http://www.mongodb.org/) comes configured out of the box for maximum performance and reliability on production databases. But it can be a bit of a disk hog, and if you’re using a development environment with an [SSD](http://en.wikipedia.org/wiki/Ssd) like me (which I highly recommend), disk space might be scarce. After doing a little research, I found configuration settings that significantly reduce MongoDB’s disk usage.

Edit your MongoDB configuration file (`/etc/mongod.conf`) and add some/all of the following:

### `smallfiles = true`

Uses smaller data file sizes — starting at 16MB instead of 128MB — and create fewer files initially. This can save almost 200MB on small collections (each!).

### `oplogsize = 100` (MB)

If you’re using an oplog for replication (or just for update notifications), you can set the size smaller than the default of “5% of all disk space”.

### `nojournal = true`

MongoDB 2.0 introduced journaling, which is great for production environments, but not very useful in development. You can disable it and save several GB.
