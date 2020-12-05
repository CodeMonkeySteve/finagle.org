---
title: Take my money, please!
tags: [design rant ui]
---
One of the downsides to being a good web developer is that it makes it really hard to ignore bad web developers. Ever since I started building commercial websites with an emphasis on usability, I can’t help but notice when other sites get it completely wrong. Case in point: credit cards. Just about every commercial site accepts credit cards, and since that is arguably the only feature that a for-profit site really needs, I would expect a little more thought would be put into it. But instead, my online shopping experience is often stymied by developers who are apparently either too lazy or too stupid to make it easy for me to *give them my money*. Here are a few of the more annoying mis-features I’ve run across:

### Card number

-   **Wrong**: “enter card number without spaces or punctuation”
-   **Right**: strip invalid characters

Any time you ask a customer to sacrifice their convenience for the sake of your app, things have gone horribly wrong. But especially in this case, where stripping unwanted characters is such a trivial matter, I can’t understand why any self-respecting developer would make such a blunder. Every modern web language - including Ruby, Javascript, and even PHP - supports regular expression substitution. All you have to do is:

```ruby
number.gsub!( /[^\d]/, "" )
```

### Card expiration date

-   **Wrong**: “January”, “February”, “March” etc.
-   **Right**: 01, 02, 03, etc.

This is another no-brainer: the expiration date printed on my card is `03/14` (happy Pi month!), but some sites only give a list of months *by name*, forcing me to do the conversion in my head. Admittedly, the math is trivial, but why make customers do more work then they have to, especially when they are trying to *give you their money*. It’s no more difficult to populate a `select` element with numbers instead of words (in some ways, it’s actually easier), and any decent web framework should provide a function to do this for you; use it! In Rails, it’s just:

```ruby
select_month( ..., :add_month_numbers => true )
```

### Card type

-   **Wrong**: “select card type”
-   **Right**: determine card type from card number

This one involves slightly more effort, but since we’re trying to make it as easy as possible for people to *give us their money*, it’s totally worth it. The crucial piece of information here is the fact that the type of the credit card can be determined from the card number itself, using the same ubiquitous regular expressions we used above. Here’s a mapping of card numbers to (some of the) card types:

```ruby
{
  /^4/:      "Visa",
  /^5[1-5]/: "Mastercard",
  /^3[47]/:  "American Express",
  /^6011/:   "Discover",
}
```
### TL;DR

Put a little extra effort into designing the payment section of your site, you want to make it as easy as possible for your customers to *give you their money*.
