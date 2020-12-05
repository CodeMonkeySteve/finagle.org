---
title: Safe Mailing with mail_safe
tags: [rails]
---
Working on a production website can be a bit nerve-wracking, especially when it comes to testing features that send email as a side effect: one little bug could wind up spamming all of your precious users. Of course, Rails has the basic safety feature of simply disabling mail delivery in certain environments (i.e. test and development), but that’s no good because sometimes you do want to test that mail is actually delivered, just without having to worry that it’s delivered to live users.

Enter [mail\_safe](http://github.com/myronmarston/mail_safe), a handy little gem written by my co-worker Myron. Instead of disabling mail delivery environment-wide, mail\_safe allows you to define one or more domains for which mail should be delivered, and a catch-all address for those that shouldn’t. This allows for testing with a real account (if it’s in the appropriate domain), while still keeping you secure against unintentional spam.

Once you’ve started using it, you’ll wonder how you ever slept soundly without it. It’s the sort of thing that should probably be included in the Rails core (IMNSHO).
