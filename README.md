Documentation
==============

How to use it?
==============

- install gems:
> bundle install

- start memcached (enabled in production env)
> memcached -vv

- install db and populate it:
> RAILS_ENV=production rake db:populate

Note: see seeds.rb to change the number of articles and comments created.
Note 2: You need to restart the server everytime you populate the db with the previous command.

- start server
> RAILS_ENV=production unicorn -p PORT_NAME


You can do the same steps in development where caching is disabled.


- run unit tests:
> rspec spec

- run integration tests:
> cucumber features


Database tables
==============

ARTICLES
-------
user_id
title string
content text
created_at


COMMENTS
--------
user_id integer
content text
is_moderated boolean
opinion (positifs, neutres, négatifs)
article_id integer
created_at Datetime

indexes:
(article_id, created_on, is_moderated )


STATS_ARTICLES_COMMENTS
-----------------------
(used for performances. store the counters for a given day and a given article)

article_id
day Date
nb_com_tot INT
nb_com_pos INT
nb_com_neg INT
nb_com_neutr INT
nb_com_no_mod INT

indexes:
(article_id, day)


Techniques used for increasing performance
==========================================

- db indexing strategy
- sql caching and partial caching using memcache and dallie gem.
- carefull to the N+1 queries problem and use of eager loading
- creation of the table "STATS_ARTICLES_COMMENTS" for statistics updated with the comment observer.
- use of unicorm to increase concurrency
- only the table column necessary where selected when querying the db.
- I use two columns to store the status of a comment, a boolean "is_moderated" and "opinion" for negative/positive/neutral. This way querying with a condition on "is_moderated" only is quicker. If I had only one column status with the values ("not_moderated", "negative", "positive", "neutral")Querying will be a bit slower.
- I decided to store in the stats table only days with comments. The downside is that a day without comments won't appear in the statistic page. The advantage is that there is no "empty" row in the database filled with several zeros. This could be easily changed if requested by running with a cron job that runs every day at midnight which calls a rake task that creates a new empty statistic row for the new day and for each articles.

Techniques that could have been used for better performance:
===========================================================
- I chose Active Record for interacting with the db, Datamapper seems to be a better choice for performances but it isn't well supported among other gems. This can be something to dig more to improve performances.
- hardware wasn't the focus on this exercice but implementing a load balancer and working with several databases will increase performances in the real world.
- In real conditions I would have gone with a NoSQL database like MongoDB instead of SQL. This is quicker and scale really well when working with a lot of data. I was going to use it but the exercice advised to use MySQL. interesting article: http://www.slideshare.net/jrosoff/scalable-event-analytics-with-mongodb-ruby-on-rails
- With more time I would have added some tasks to a background worker using the gem delayed job. Example of tasks that could have been passed: updating the statistic table, deleting associations (at the moment deleting an article with thousands of comments freeze the app)
- more benchmarking and profiling (http://www.dan-manges.com/blog/rails-performance-tuning-workflow)
- adjusting MySQL configuration would help as well.
- use a Sphinx search server for searching
- write more performance tests




CACHES KEYS:
===========
last 10 articles                         : "articles/last_10"
count total articles                     : "articles/count"
one article                              : "article/#{article_id}"

last 20 moderated comments for an article: "article/#{article_id}/comments/moderated/true/last_20"
count total moderated article            : "article/#{article_id}/comments/moderated/true/count"

All these cache are supposed not be invalidated too quickly. I decided not to cache more about comments as the frequency of comments created is supposed to be too high for a cache system to be useful.




