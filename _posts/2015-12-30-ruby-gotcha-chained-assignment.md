---
title: "Ruby Gotcha: Chained Assignment"
tags: [ruby]
---
I ran into a tricky bug that involved an obscure bit of Ruby behavior, involving the chained assignment idiom and overloaded assignment operators.

### Chained Assignment Considered Harmful

“Chained Assigned” refers to the idiom of using the value of an assignment expression in another assignment expression, e.g.:

    a = b = 42

This seems simple enough, and it works fine in this case, but it’s an idiom that doesn’t always behave like you might expect. That is, you might expect it to be equivalent to:

    b = 42
    a = b   # WRONG

But it’s actually:

    b = 42
    a = 42  # correct

### Overloaded assignment operators may surprise you

Consider a `Person` class that, for some contrived reason, stores people’s names in uppercase:

    class Person
      attr_reader :name
      def name=(name)
        @name = name.upcase
      end
    end
    person = Person.new

    name = person.name = "Bob"

You might expect both variables (`name` and `person.name`) to have the same value (i.e. `"BOB"`), but after the assignment, `name` will be `"Bob"` and `person.name` will be `"BOB"`. That’s because …

> **Ruby ignores the return value of overloaded assignment operators**

At least in that case the the behavior is consistent, if not obvious, but what about when we use conditional assignment for default values:

    name = (person.name ||= "Unknown")

The first time this expression runs, `name` will be set to the default (`"Unknown"`), but subsequent times it will be the the uppercase value in `person.name` (i.e. `"UNKNOWN"`).

### How this can create subtle bugs

So far we’ve only looked at simple assignments of scalar values, but using Array or Hash values is where things can go very wrong. Consider a blog `Post` that has an array of tags. We want to make sure that each tag is a `String`, so the assignment operator maps the list and casts each value:

    class Post
      attr_reader :tags
      def tags=(tags)
        @tags = tags.map { |tag| tag.to_s }
      end
    end
    post = Post.new

    tags = (post.tags ||= [])
    tags += ['ruby', 'gotchas']

In this case, the conditional assignment means that `tags` will be set to the empty Array passed in the assignment, which is different than the Array (also empty) that’s returned by the `map` call in the assignment operator. Adding the tag strings to the array does nothing, because it’s not the array stored in the `Post`. Once `post.tags` is set, though, the conditional assignment does nothing, `tags` references the same Array as `post.tags`, and things work as expected.

If this seems like an extreme edge-case, you may have a point, but it’s also an actual bug that I ran into in a popular database library. Based on my new understanding on Ruby assignment, I’m inclined to avoid chained assignment all together, and just move the default assignment to its own line.
