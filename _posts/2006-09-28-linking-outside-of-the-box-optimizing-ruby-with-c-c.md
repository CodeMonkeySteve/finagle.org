---
title: "Linking Outside of the Box: Optimizing Ruby with C/C++"
tags: [ruby extension]
---
### Prototyping

My first attempt at a routine to XOR blocks (stored as Strings) looked something like this:

```ruby
class String
  def xor!( str1, str2 )
    BLOCK_SIZE = 128.kilobytes
    (0...BLOCK_SIZE).each { |i| self[i] ^= str1[i] ^ str2[i] }
  end
end
```

There may very well be a faster way of doing this in pure Ruby, but I couldn’t find it (and didn’t want to waste the time). This worked well enough to finish the basic implementation and unit tests. And even though this prototype version was way too slow, it allowed me to build-out the higher-level code and tests so that went I went to replace it with the faster version, I had already established extensive code coverage (which revealed several bugs in my optimized implementation). Once the prototype is complete it’s time for …

### Profiling

> Premature optimization is the root of all evil.  &ndash; Donald Knuth

Even though I knew that XOR was going to be the biggest cycle-sink, I decided that now would be a good time to learn about Ruby profiling. [ruby-prof](http://ruby-prof.rubyforge.org/) makes this fairly easy. I chose my biggest, most involved unit test, and wrapped it like so:

```ruby
require 'ruby-prof'
def profile_lotsofstuff
  res = RubyProf.profile do
    test_lotsofstuff
  end
  RubyProf::GraphPrinter.new(res).print(STDOUT, 2)
end
alias_method :test_profile_lotsofstuff, :profile_lotsofstuff   if ENV['PROFILE']
```

This allows me to easily profile by running that unit test from the command line:

```sh
clear ; PROFILE=1 ruby test/unit/stuff_test.rb
```

While I’m still working on tweaking the various output parameters, the result did confirm my suspicions:

      %total   %self     total      self    children             calls   Name
    --------------------------------------------------------------------------------
                          8.04      4.97      3.07                 4/4     String#xor!
      96.87%  59.88%      8.04      4.97      3.07                   4     Range#each
                          1.07      1.07      0.00     1048576/1048576     Fixnum#^
                          1.53      1.53      0.00     1572864/1572880     String#[]
                          0.47      0.47      0.00       524288/524288     String#[]=

### Extending with C

Especially for tight nested loops like this, you quickly take a bit performance hit just from the loop overhead. In this case, I also couldn’t find an easy way to iterate through two strings simultaneously. After a while, it became quite annoying knowing that I could do the whole thing in a short little C function.

So that’s what I did. I created a small Rails plugin (`xor`), with appropriate `init.rb`, and added a `lib/xor.c` that looks something like:

```c
VALUE string_xor( int argc, VALUE *argv, VALUE self ) 
{
  const char *src1 = STR2CSTR(argv[0]);
  const char *src2 = STR2CSTR(argv[1]);
  const char *dest = STR2CSTR(self);
  size_t len = RSTRING(self)->len;

  for ( ; len--; ++dest, ++src1, ++src2 )
    *dest ^= *src ^ *src2;

  return self;
}

void Init_xor( void )
{
  rb_define_method( rb_cString, "xor!", ((VALUE (*)(ANYARGS)) string_xor), -1 );
}
```

Using the [Rake task for Ruby extensions](onebananaproblem.com/articles/2006/09/09/ruby-extensions-with-rake) from my [RDBXML](http:rubyforge.org/projects/rdbxml) project makes it trivial to build with a small Rakefile:

```ruby
require 'rake/extensiontask'
desc "Build the XOR extension"
Rake::ExtensionTask.new :xor do |t|
  t.dir = 'lib'
end
```

Added some test cases for the various XOR identities (e.g. `x^0 = x`, `x^x = 0`, etc.) and that was it. I kept the pure Ruby version of the function for later (renamed to `slow_xor!`).

### Benchmarking

A few runs through the higher-level tests show a **huge** improvement in speed. But just how much is that? It’s easy to tell with Ruby’s built-in benchmarking support. As with the profiling, I find it convenient to hack it onto the existing unit tests, as they already prove a good source of stress-tests.

```ruby
def benchmark_xor
  n = 10
  Benchmark.bm(8) do |bm|
    bm.report( "XOR (c) :" ) {  n.times { test_xor }  }
    String.module_eval { alias_method :xor!, :slow_xor! }
    bm.report( "XOR (rb):" ) {  n.times { test_xor }  }
  end
end
alias_method :test_benchmark_xor, :benchmark_xor  if ENV['BENCHMARK']
```

                  user     system      total        real
    XOR (c) :  1.200000   0.116667   1.316667 (  0.817143)
    XOR (rb): 81.433333   0.683333  82.116667 ( 50.567826)

This shows a speed-up of a little over 60x. This changes the execution
times for just about every operation from “minutes” into “seconds”. Not
bad, eh?

> Your Milleage May Vary
