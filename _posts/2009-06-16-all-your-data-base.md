---
title: All Your (Data)Base ...
tags: [nosql]
---
[![](/assets/2009/6/16/network-graph.jpg)](http://www.flickr.com/photos/greenem/11696663/)

After failing to make [CouchDB](http://couchdb.apache.org/) doing anything useful, and being completely unwilling to go back to [1974](http://en.wikipedia.org/wiki/Sql) I decided to go back and revisit my assumptions. Both of my current home projects are essentially attempts to treat real-world interactions as [Routing Problems](http://en.wikipedia.org/wiki/Routing), but after doing some research, I decided that was one wheel I didn’t even want to attempt to reinvent (graph theory is not my specialty).

Somewhere along the way, I discovered what I really needed was a *Graph Database*. That led me to apparently the only significant implementation: [Neo4j](http://neo4j.org/), an embedded Java graph database. But I’d rather juggle flaming porcupines than touch Java again … and thanks to [JRuby](http://en.wikipedia.org/wiki/Jruby) and the [neo4j gem](http://github.com/andreasronge/neo4j), I don’t have to! Yay!

So if your problem domain is graph-like, you should definitely checkout [neo4j](http://github.com/andreasronge/neo4j), it’s looking like a seriously sweet storage solution.
