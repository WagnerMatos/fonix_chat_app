# README

## Fonix Technical Interview Challenge

This document outlines the technical challenge to be completed as part of the job application for Fonix.

### Requirements

- The test must be done using Rails.
- Git must be used as version control (if possible push it to github). 
- Messages should be sent through web sockets (Action Cable).

### Description

We want to create a Web chat.

We'll start with a prototype which will have only one channel/room and all the users subscribed will have access to the only available channel.

Users must be able to create an account providing a valid email address. Once logged in users must be able to send and receive messages.

The system should send to all the users a weekly email specifying how many messages were sent and received in the last week and the total number of messages received since the user has sent his last message.
I.e.:

```html
600 messages have been exchanged in the last week. 750 since your last message on the 1st of February.
```

### Notes

- To install run `bundle install` and `yarn`
- To run the tests run `bundle exec rspec`
- To run the app run `bin/dev`

#### Things I would improve:
- More tests
- Improve on security (stronger passwords, sanitization, etc)
- Use either fixtures or factories
- Better logic around the report and mailer
- Better performance i.e. pagination, memoization, workers, cache, etc
- Better views, helpers
- Spent more time removing unnecessary files

#### Notes
- Generally the approach I've taken is somewhat naive and would need improvements before being released into production
- I've focused on making a prototype that works and could be improved on
- More importantly I've tried not to add much more than what was required. In my experience, making wrong assumptions
based on lack of information generally lead to poor decisions
- I have not used ActionCable before and unfortunately I spent more time than I anticipated making it work with RSpec.
If I hadn't I would have spent more time on general improvements
- Have not spent too much time customizing Devise, RSpec, code formatting, checks, etc
- Have not added quality control gems such as RubyCritic, Brakeman, etc
- In some places where I've worked in the past had some sort of automated versioning and changelog generation 
in place. For personal projects I have been using a little CLI tool I wrote which adds it automatically. In a production
setting however I wouldn't have added the changelog of versioning without discussing with the team first
