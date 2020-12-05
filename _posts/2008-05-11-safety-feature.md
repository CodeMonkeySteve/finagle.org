---
title: Safety Feature
tags: [ruby]
---
```ruby
require 'mathn'
loop do
  puts "Enter an 11 digit prime number to continue:"
  n = $stdin.gets.chomp.to_i
  break  if n.to_s.size == 11  and
            n.prime_division.size == 1
end
```
