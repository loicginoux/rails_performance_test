Documentation
==============

This is a project to test and put in practice some rails and db performance tasks. 
The app consists on a basic articles and comments application. We imagine that the app can have thousands of articles and for each article, you can have potentially thousands or millions of comments.
The app has four pages:
- a page that list the last 10 articles, that you can destroy.
- a page that show the article and the last 20 moderated comments made. You can also add a comment on this page. A comment is first in a "not moderated" state.
- an admin page for an article that list all comments paginated. The goal of this page is for the admin to change the state of comments, it can destroy one or change the state to either "not moderated", "positive", "negative" or "neutral". In this page you also also filter comments by creation date or by state.
- an admin reporting page for one article. The report is a table where each row is a day. for each day you have: the number of not moderated comments, the number of positive, the number of negative and the number of neutral comments.

The goal is to make the app as quick as possible. The report page should be quick to respond and instantly reflect the comments changes.
The admin page should search and filter fast.

Let's go!

How to use it?
==============

- install gems:
> bundle install

- install db, migrate and and seed it:
> RAILS_ENV=production rake db:populate

Note: see seeds.rb to change the number of articles and comments created.
Note 2: You need to restart the server everytime you populate the db with the previous command to clear the cache.


- start memcached (enabled in production env)
> memcached -vv

- start delayed_job to enable background process
> RAILS_ENV=production script/delayed_job run



- start server:
> RAILS_ENV=production unicorn -p PORT_NAME


You can do the same steps in development where caching is disabled.


- prepare testing environment
> rake db:test:prepare
> RAILS_ENV=test rake db:migrate

- run unit tests:
> rspec spec

- run integration tests:
> cucumber features


Database tables
==============

ARTICLES
-------
| columns     |  type    |
|:------------|:---------|
|user_id      | integer  |
|title        | string   |
|content      | text     |
|created_at   | datetime |

indexes:
(created_at)


COMMENTS
--------
| columns     |  type    |
|:------------|:---------|
|user_id      | integer  |
|article_id   | integer  |
|is_moderated | boolean  |
|content      | text     | (positifs, neutres, négatifs)
|opinion      | string   |
|created_at   | datetime |

indexes:
(article_id, created_at, is_moderated)


STATS_ARTICLES_COMMENTS
-----------------------
(used for performances. store the counters for a given day and a given article)

| columns     |  type    |
|:------------|:---------|
|article_id   | integer  |
|day          | date     |
|nb_com_tot   | integer  |
|nb_com_no_mod| integer  |
|nb_com_pos   | integer  |
|nb_com_neutr | integer  |
|nb_com_neg   | integer  |


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
- when deleting an article, use of background process to delete associated comments and statistics. This is useful in order to not freeze the app when destroying an article with thousands of comments.
- I use two columns to store the status of a comment, a boolean "is_moderated" and "opinion" for negative/positive/neutral. This way querying with a condition on "is_moderated" only is quicker. If I had only one column status with the values ("not_moderated", "negative", "positive", "neutral")Querying will be a bit slower.
- I decided to store in the stats table only days with comments. The downside is that a day without comments won't appear in the statistic page. The advantage is that there is no "empty" row in the database filled with several zeros. This could be easily changed if requested by running with a cron job that runs every day at midnight which calls a rake task that creates a new empty statistic row for the new day and for each articles.

Techniques that could have been used for better performance:
===========================================================

- I chose Active Record for interacting with the db, Datamapper seems to be a better choice for performances but it isn't well supported among other gems. This can be something to dig more to improve performances.
- hardware wasn't the focus on this exercice but implementing a load balancer and working with several databases will increase performances in the real world.
- A NoSQL database like MongoDB instead of MySQL would have been another good choice as it is designed to scale really easily when working with high volume data. interesting article: http://www.slideshare.net/jrosoff/scalable-event-analytics-with-mongodb-ruby-on-rails
- more benchmarking and profiling (http://www.dan-manges.com/blog/rails-performance-tuning-workflow)
- adjusting MySQL configuration would help as well.
- use of Elastic Search for searching
- write more performance tests




CACHES KEYS:
===========

| key                                                     |  explanation                                |
|:--------------------------------------------------------|:--------------------------------------------|
| "articles/last_10"                                      | last 10 articles                            |
| "articles/count"                                        | count total articles                        |
| "article/#{article_id}"                                 | one article                                 |
| "article/#{article_id}/comments/moderated/true/last_20" | last 20 moderated comments for an article   |
| "article/#{article_id}/comments/moderated/true/count"   | count total moderated comments              |


All these cache are supposed not be invalidated too quickly. I decided not to cache more about comments as the frequency of comments created is supposed to be too high for a cache system to be useful.




