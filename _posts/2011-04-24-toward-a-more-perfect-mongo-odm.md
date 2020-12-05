---
layout: post
author: code_monkey_steve
title: Toward a More Perfect Mongo ODM
tags: [mongodb]
---
MongoDB, MongoMapper, and Mongoid
---------------------------------

I’m now well into my third Rails project using the [MongoDB](http://mongodb.org) document database, and while I’m still a big fan of Mongo, I’ve been underwhelmed by the ODM (Object-Document Mapper)s I’ve used. On the first project, I started with [MongoMapper](http://mongomapper.com), which is very mature and well-supported, but was a little klunky and tried a little too hard to be like [ActiveRecord](http://ar.rubyonrails.org).

For the second project, I switched to [Mongoid](http://mongoid.org), which was a huge improvement. It played nicely with ActiveSupport and ActiveModel, and had better support for doing things the Mongo way. But in the end, it had several nasty bugs related to associations and embedded documents, and the better I understood what I wanted from an ODM, the more I realized that Mongoid wasn’t it.

The Alternatives
----------------

##### [Candy](https://github.com/SFEley/candy)

I looked into Candy, and found its approach intriguingly fresh. Models don’t have to specify field names or types, and can be Arrays or Hashes or any other Ruby type. But I don’t like the lack of control over the serialization process (e.g. `find`, `save`, callbacks, validations, etc.), nor the absence of any sort of relational mechanism. Like Mongoid, it does have a nice query Criteria DSL, though.

##### [Mongomatic](http://mongomatic.com)

I’m not sure Mongomatic even qualifies as an ODM, as it doesn’t seem to do any mapping. From what I’ve seen, it’s just a thin wrapper around the Ruby MongoDB driver, adding little. I don’t know why anyone would bother using it.

##### [MongoODM](https://github.com/carlosparamio/mongo_odm) ([my fork](https://github.com/CodeMonkeySteve/mongo_odm/))

It could use a better name, but it’s a nice ODM, if a bit immature. I especially like its support for embedded documents, i.e. you don’t have to do anything special, just assign a variable of the specified Mongo-serializeable type (Document or otherwise) to a field, and it Just Works. It also supports Arrays and Hashes that can take any heterogeneous collection of types.

It’s also better designed under the hood than Mongoid or MongoMapper, taking full advantage of Ruby conventions to be easily hackable. MongoODM is definitely the best candidate for Perfect ODM I’ve yet seen.

The Perfect ODM
---------------

Here’s what I really in my perfect Mongo ODM:

##### Plays Well with Rails

Like it or not, the ActiveRecord API is the standard convention for performing DB operations. And to the extent that SQL and MongoDB are conceptually similar, they should maintain the same API. This makes it easier to integrate with other software that may assume AR conventions, but more importantly, it keeps me from having to learn and remember a whole new set of only-slightly-different APIs.

##### [Duck typing](http://en.wikipedia.org/wiki/Duck_typing) and Other Ruby-isms

This is one big feature that ActiveRecord does not (and cannot) have, but which Mongo gives us almost for free — dynamic typing, just like native Ruby. Mongoid supports this for polymorphism, but MongoODM also supports dynamic types in Hashes and Arrays, and it was this fact that original attracted me to it. I have no problem with declaring document fields, but why should I have to specify the type? For that matter, why should I be constrained to a static type?

##### Schema DSL

Even though I want the freedom to store any value of any type in any field, I know that schemas are still important, both for validation and configuration management. All ODMs provide ActiveRecord-style type-specifiers and validations (Mongoid and MongoODM also use ActiveModel), but I’d like to see document schemata become a top-level object, some superset of [JSON Schema](http://json-schema.org), with a friendly and extensible DSL. Something like this:

    class Person
        schema do
          property(:name) {
            type   String
            length 1..20
            required
          }
          property(:phone) {
            type Phone
            optional
          }
          property(:aliases) {
            type Array.of(String)
            optional
          }
          property(:vehicles) {
            type Array.of(Car, Boat, Spaceship)
            required
            default []
          }
          additional_properties false
        end
      end
    
Once the schema is nestled into object form, there’s a whole bunch of interesting things you can do, in addition to validations:

-   Schema versioning and heterogeneous collections
-   Data migrations and schema management
-   Client-side validations (via JSON Schema)
-   Automatic form generation (think: [ActiveScaffold](http://activescaffold.com) on steroids)

##### References and Associations

This area gets a bit tricky, partially because of SQL’s wretched legacy of foriegn keys and join tables, but also because the problem is just inherently difficult. Ideally, the database or ODM would provide an equivalent to Ruby’s garbage-collected memory management system, where any document field could be a reference to any other object of any type, and all objects would be automatically destroyed when no longer used.

MongoDB actually comes pretty close with their support for [Database References](http://www.mongodb.org/display/DOCS/Database+References). These allow you to assign to a document field a reference to any document in any collection. I’ve expanded MongoODM with a transparent Reference proxy, and assigning a reference to a field is as simple as calling `.reference` (or `.ref`) on a document. I’ve been looking at adding something similar for [GridFS attachments](http://www.mongodb.org/display/DOCS/GridFS+Specification), but with a reference count to allow easy sharing of large binary objects between documents.

The Future — No ODM?
--------------------

This post is mostly just a dump of ideas I’ve had while working to expand MongoODM. But I find myself working more and more in Javascript, these days, and taking advantage of things like [jQuery](http://jquery.com) and [Backbone](http://documentcloud.github.com/backbone) to build rich client applications in the browser. In this situation, which I think will become more common, I don’t need so much ODM support in Ruby/Rails, and more-so in Javascript. So now I’m contemplating a MongoDB interface in JavaScript, passing through some sort of [Rack](http://rack.rubyforge.org) proxy to perform access control. I’ll let you know how it turns out …
