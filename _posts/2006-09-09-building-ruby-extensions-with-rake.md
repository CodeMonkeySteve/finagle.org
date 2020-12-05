---
title: Building Ruby Extensions with Rake
tags: [ruby extension]
---
At the moment, the tasks are a part of the RDBXML project, hosted by [RubyForge](http://rubyforge.org) . There is [documentation](http://rdbxml.rubyforge.org/classes/Rake.html), and you can view the latest version in [SVN here](http://rubyforge.org/plugins/scmsvn/viewcvs.php/trunk/rake/?root=rdbxml).

Usage is simple enough:

```ruby
require 'rake/swigextensiontask'
desc "Build the BDB interface extension"
Rake::SWIGExtensionTask.new :db do |t|
  t.dir = 'ext'
  t.link_libs += ['db', 'db_cxx']
end
```

This will build `db.so`, from the `db.i` SWIG interface file in the `ext` directory, linking-aginst `db.so` and `db_cxx.so`. For a full usage example, see the [Rakefile for RDBXML](http://rubyforge.org/plugins/scmsvn/viewcvs.php/trunk/Rakefile?root=rdbxml&view=markup).
