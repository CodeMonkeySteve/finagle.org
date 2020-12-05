---
title: JSON and the Args (or Not)
tags: [json]
---
(Admittedly not my best work, but it’s hard coming up with JSON puns)

Playing with JSON Document Stores has led me down the path to a few other exciting JSON toys. The first is …

[JSON Schema](http://json-schema.org)
=====================================

Just like [XML Schema](http://www.w3.org/XML/Schema), [JSON Schema](http://json-schema.org) allows you to specify (in JSON form) the semantics of a particular JSON data structure. While in theory the schema is useful for validation, in practice validation just sucks up too much CPU time to be worth the trouble. Where things get really interesting is the possibility of automatically generating user interfaces that compose JSON-based messages behind the scenes. There’s just one thing missing …

[Service Mapping Description (SMD)](http://groups.google.com/group/json-schema/web/service-mapping-description-proposal)
========================================================================================================================

Ta-da! [SMD](http://groups.google.com/group/json-schema/web/service-mapping-description-proposal) allows you to describe all of the methods of a web service using [JSON Schema](http://json-schema.org/) to describe each method’s parameters. It supports a variety of transports and envelopes from simple GETs or POSTs up through RESTful resources and [JSON-RPC](http://en.wikipedia.org/wiki/JSON-RPC).

The beauty of all of this is that it allows for services (web and otherwise) to advertise its functionality in user- and computer-readable ways. It has the potential to be a generic communication mechanism between disparate bits of software (potentially controlling hardware), allowing us to virtually wire-up appliance X to service Y through user interface Z, without any of them having prior knowledge of each other. Pretty sweet.

You Are `'Here':{}` …
=====================

One last bit of JSON goodness: [GeoJSON](http://en.wikipedia.org/wiki/GeoJSON). As you might expect, it’s a standard for representing geographic information in JSON. It’s already the de facto standard, and supported by just about everybody.
