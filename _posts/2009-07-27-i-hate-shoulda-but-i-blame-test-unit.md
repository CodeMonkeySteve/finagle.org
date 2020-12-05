---
title: I Hate Shoulda (But I Blame Test::Unit)
tags: [ruby test rant]
---
I hate Shoulda.

But I blame Test::Unit.

Because Test::Unit can’t scale.

There, I’ve said it. It wasn’t easy, I drank the [TDD](http://en.wikipedia.org/wiki/Test-driven_development) Cool-Aid a long time ago, and never looked back. But the fact of the matter is that [Test::Unit](http://ruby-doc.org/stdlib/libdoc/test/unit/rdoc/classes/Test/Unit.html) is rotten from the very core, and it makes the seductive [Shoulda](http://thoughtbot.com/projects/shoulda) features nothing but bitter lies. Let me demonstrate:

Hopeful Optimism
----------------

Take a sufficiently-contrived test, where you create some object and verify some of its properties:

```ruby
require 'test/unit'
require 'shoulda'

class Numeric
  def even? ; (self % 2).zero?    ; end
  def odd?  ; (self % 2).nonzero? ; end
end

class OddNumberTest < Test::Unit::TestCase
  context 'an odd number'  do
    setup do
      # create object
      @n = 97 ; sleep 1
    end

    should('be true')     {  assert  @n        }
    should('be odd')      {  assert  @n.odd?   }
    should('not be even') {  assert !@n.even?  }
  end
end
```

Now, someone naive in the ways of Test::Unit, might expect this test to take approximately *one second* to execute, right? After all, it’s only the object creation that takes any time (in these examples, the `sleep 1` represents some non-trivial database or network operation). So we run it, and …

```shell
$ ruby -rubygems ./why_shoulda_sucks.rb
Loaded suite why_shoulda_sucks
Started
...
Finished in 3.006617 seconds.
3 tests, 3 assertions, 0 failures, 0 errors
```

“**Three seconds**? Why did it take so long?!”, our poor naive tester cries. Because, expecting Shoulda to act like a Domain-Specific Language (as all Right-Thinking Rubyists would), he doesn’t realize that under the covers it’s just creating three different Test::Unit tests. So what’s so bad about Test::Unit?

A Sense of Dread
----------------

What’s so bad about Test::Unit is that it makes the following assumptions:

-   Each test may be run in any order, not the order define (in fact, it’s in sorted order by test name)
-   Each test may modify the state at any time, not just in the `setup` function

Therefore, the `setup` (and `teardown`) functions must be called **for every test**, whether they really need it or not.

So instead of:

1.  setup
2.  should be true
3.  should be odd
4.  should not be even
5.  (teardown)

We get:

1.  setup
2.  should be true
3.  (teardown)
4.  (setup)
5.  should be odd
6.  (teardown)
7.  (setup)
8.  should not be even
9.  (teardown)
10. (setup)

That’s a lot of extraneous setting-up and tearing-down, and since those are the parts that actually do stuff (as opposed to the assertions themselves), that’s the slowest part of the test.

Crushing Disappointment
-----------------------

The greatest features in Shoulda (as opposed to, say, [RSpec](http://rspec.info/)) is the ability to use *nested contexts*. This lets us do sub-tests that inherit their parent context’s state, but roll-back their own changes. So let’s add one:

```ruby
class OddNumberTest < Test::Unit::TestCase
  context 'an odd number'  do
    setup do
      # create object
      @n = 97 ; sleep 1
    end
    should('be true')     {  assert  @n        }
    should('be odd')      {  assert  @n.odd?   }
    should('not be even') {  assert !@n.even?  }

    context 'add one' do
      setup do
        # modify object
        @n += 1 ; sleep 1
      end
      should('be true')    {  assert  @n        }
      should('be even')    {  assert  @n.even?  }
      should('not be odd') {  assert !@n.odd?   }
    end

    should('still be odd')  {  assert @n.odd?  }
  end
```

Again, on first glance you might expect this test to take *two seconds*, but actually:

```shell
$ ruby -rubygems ./why_shoulda_sucks.rb
Loaded suite why_shoulda_sucks
Started
.......
Finished in 10.014666 seconds.
7 tests, 7 assertions, 0 failures, 0 errors
```

**Ten seconds**, over **five times** what it really should be if Test::Unit was just smart enough execute the tests in the order given, and perform the `setup` and `teardown` appropriately.

The Test::Unit [Fail Whale](http://en.wikipedia.org/wiki/Fail_whale)
--------------------------------------------------------------------

And that’s just with one level of nesting. If we try an even slight-complicated test, with several contexts nested even only a few deep:

```ruby
class OddNumberTest < Test::Unit::TestCase
  context 'an odd number'  do
    setup do
      # create object
      @n = 97 ; sleep 1
    end
    should('be true')     {  assert  @n        }
    should('be odd')      {  assert  @n.odd?   }
    should('not be even') {  assert !@n.even?  }

    context 'add one' do
      setup do
        # modify object
        @n += 1 ; sleep 1
      end
      should('be true')    {  assert  @n        }
      should('be even')    {  assert  @n.even?   }
      should('not be odd') {  assert !@n.odd?  }

      context 'subtract one' do
        setup do
          # modify object
          @n -= 1 ; sleep 1
        end
        should('be true')     {  assert  @n        }
        should('be odd')      {  assert  @n.odd?   }
        should('not be even') {  assert !@n.even?  }
      end
    end

    should('still be odd')  {  assert @n.odd?  }

    context 'multiply by two' do
      setup do
        # modify object
        @n *= 2 ; sleep 1
      end
      should 'be true'    do  assert  @n        end
      should 'be even'    do  assert  @n.even?  end
      should 'not be odd' do  assert !@n.odd?   end
    end

    should('even still be odd')  {  assert @n.odd?  }
  end
end
```

Can you say “exponential growth”?

```shell
$ ruby -rubygems ./why_shoulda_sucks.rb
Loaded suite why_shoulda_sucks
Started
.......
Finished in 26.048316 seconds.
14 tests, 14 assertions, 0 failures, 0 errors
```

**26 seconds**, that’s **six times** longer than it should take.

You Think That’s Bad?
---------------------

Now that I’m working at a Real Ruby Shop, I’ve gotten to experience the joy of having thousands of tests to make sure I haven’t done something stupid. But I also get to experience the pain of running all these tests under this profoundly inefficient framework:

```sh
$ rake test:units test:functionals test:integration
Finished in 1042.379506 seconds.
2141 tests, 4576 assertions, 0 failures, 0 errors

Finished in 578.284529 seconds.
613 tests, 896 assertions, 0 failures, 0 errors

Finished in 34.538012 seconds.
22 tests, 65 assertions, 0 failures, 0 errors
```

Almost **half an hour** on a decent system, **over 50 minutes** on our Continuous Integration server. That’s an awful lot of waiting.

Screw You Guys, I’m Going Home
------------------------------

[Fork You](http://rubyrags.com/products/10) then, I’ll make my own testing framework that keeps track of dependencies and instantiates them in the most efficient way ([and blackjack, and hookers!](http://www.mahalo.com/bender-quotes)) . And while I’m at it:

-   “Should” is [not the correct word](http://www.faqs.org/rfcs/rfc2119.html) . “Must” is the correct word (plus, less typing).
-   If a test fails, it should not run any other tests in that context. They’ll almost certainly also fail and unhelpfully spam you with error messages.
-   [Autotest](http://www.faqs.org/rfcs/rfc2119.html) should be baked right in, so that if a subset of the tests fail, I should be able to re-run just the failing tests, which will in turn only instantiate the necessary prerequisites, and in the most efficient order.

So far I have a proof-of-concept project on GitHub called [Mustard](http://github.com/CodeMonkeySteve/mustard) . I’m going to start migrating my other projects to it from Shoulda and will write more on the subject later. Watch this space …
