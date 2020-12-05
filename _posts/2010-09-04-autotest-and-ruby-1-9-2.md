---
title: Autotest and Ruby 1.9.2
tags: [ruby test]
---
There’s a [bug in autotest](http://rubyforge.org/tracker/index.php?func=detail&aid=28113&group_id=419&atid=1678) that prevents it from properly finding a project’s autotest discover file under Ruby 1.9.2. Until an appropriate fix is made, you can work around it on the command line like so:

```ruby
  $ RUBYLIB='.' bundle exec autotest
```
