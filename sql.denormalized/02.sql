SELECT
    tag,
    COUNT(*) AS count
FROM (
    SELECT
        DISTINCT data->>'id' AS id_tweets,
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
        data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
        OR data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) AS t1
GROUP BY
    tag
ORDER BY
    count DESC,
    tag
LIMIT 1000;

