SET max_parallel_maintenance_workers TO 60;
SET maintenance_work_mem TO '4 GB';

create index on tweets using GIN(to_tsvector('english', text));
create index on tweet_tags(id_tweets, tag);
create index on tweet_tags(tag, id_tweets);
create index on tweets(id_tweets, lang);
create index on tweets(lang);
