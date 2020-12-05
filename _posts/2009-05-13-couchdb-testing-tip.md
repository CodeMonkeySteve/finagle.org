---
title: CouchDB Testing Tip
tags: [couchdb test]
---
Finished my first stab at converting my current toy project from ActiveRecord to CouchDB, and so far so good. I ran into an issue where associations aren’t getting saved, but I’m most likely just doing something stupid.

One minor annoyance is that, unlike ActiveRecord, the test database doesn’t get purged and after a while can get cluttered with randomly-generated fixtures<sup>1</sup>. No problem, just drop in this little Rake task to recreate the DB on each run:

```ruby
# lib/tasks/couchdb.rake
require File.expand_path( RAILS_ROOT + '/config/environment' )
require 'couch_potato'

task 'couchdb:test:purge'  do
  CouchPotato::Config.database_name =
    YAML::load(File.read(Rails.root.to_s + '/config/couchdb.yml'))['test']
  CouchPotato.couchrest_database.recreate!
end
task 'db:test:purge' => 'couchdb:test:purge'
```

<sup>1</sup> BTW, have I mentioned how cool [factory\_girl](http://github.com/thoughtbot/factory_girl) is? Another new tool for my bag of tricks.
