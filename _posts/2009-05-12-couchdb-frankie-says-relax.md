---
title: "CouchDB: Frankie Says Relax"
tags: [couchdb]
---
I’m falling in love (or at least lust) with [CouchDB](http://couchdb.apache.org/), especially after seeing this [presentation at AAC](http://aac2009.confreaks.com/07-feb-2009-16-00-relaxing-with-couchdb-will-leinweber.html) and this [presentation for the BBC](http://barkingiguana.com/2008/08/30/jan-lehnardt-talks-to-the-bbc-about-couchdb). My summary: JSON document storage, sliced-and-diced with Javascript [MapReduce](http://en.wikipedia.org/wiki/Map_reduce), all served on a RESTful platter.

As a long-time XML fanboy, the lack of schema in JSON makes me a bit twitchy, and using Javascript as a query language just looks a lttle wrong. But I see the advantages to the document-centric model (versioning, replication, access control) and MapReduce is definitely the Wave of the ~~Future~~ Present. It looks like you can encapsulate all of your model logic in views, so I’m not sure if an explicit schema is really even necessary. The more I learn about [That Way of doing things](http://upstream-berlin.com/2009/03/31/the-case-of-activerecord-vs-couchdb/), the more it grows on me.

So how do we make CouchDB play nicely with Rails? I first tried [activecouch](http://github.com/arunthampi/activecouch), but found its lack of Ruby-type casts and one-database-per-model scheme irritating. [couch\_potato](http://github.com/langalex/couch_potato) definitely looks slicker, but there seems to be quite a few [other CouchDB interfaces](http://github.com/search?type=Repositories&language=rb&q=couchdb) out there that might be just as good or better. I see this as a good sign that many others also see CouchDB’s potential, and are experimenting with ways to deal with it in a Ruby Way.
