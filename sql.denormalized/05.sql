SELECT
    tag,
    COUNT(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        '#' || jsonb_array_elements(
            COALESCE(
                data->'entities'->'hashtags',
                data->'extended_tweet'->'entities'->'hashtags',
                '[]'
            )
        )->>'text' AS tag
    FROM
        tweets_jsonb
    WHERE
        to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
        AND data->>'lang' = 'en'
) AS subq
GROUP BY
    tag
ORDER BY
    count DESC,
    tag
LIMIT
    1000;

