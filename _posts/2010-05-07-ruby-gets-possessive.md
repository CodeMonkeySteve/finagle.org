---
title: Ruby Gets Possessive
tags: [ruby]
---
I debated whether this code snippet was significant enough to bother blogging about, but it is useful if for no other reason that as an example of one of the great features of Ruby: the ability to reopen any class, even a standard class, and add methods.

In this case, we needed a method to apply the English rules for the possessive apostrophy to a string, e.g. a person’s name. I looked-up the rules on [Wikipedia](http://en.wikipedia.org/wiki/Apostrophe#Singular_nouns_ending_with_an_.E2.80.9Cs.E2.80.9D_or_.E2.80.9Cz.E2.80.9D_sound) and coded up the following three-liner:

```ruby
class String
  def possessive
    str = self + "'"
    str += 's' unless %r{(s|se|z|ze|ce|x|xe)$}i.match(self)
    str
  end
end
```

Now in my site I can do things like:

```ruby
"Steve".possessive + " Profile"  ==  "Steve's Profile"
"Alex".possessive + " Profile"  ==  "Alex' Profile"
```

(Cross-posted to the [Conceivian Blog](http://conceivian.com/insights))
