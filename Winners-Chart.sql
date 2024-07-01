-- This is question 2 on the certification test. We have to make 3 columns for 1st, 2nd, and 3rd rankers for each contest 
-- Given the scores and multiple attempts of each candidate only the maximum-scored attempt has to be considered
WITH ranked AS(
    SELECT 
 event_id, participant_name, MAX(SCORE),
 DENSE_RANK() OVER(PARTITION BY event_id ORDER BY MAX(SCORE) DESC) as Rnk
FROM
scoretable
GROUP BY
event_id, participant_name
)

SELECT 
 event_id,
 GROUP_CONCAT(IF(Rnk = 1,participant_name,NULL) ORDER BY participant_name SEPARATOR ',' ) as first,
 GROUP_CONCAT(IF(Rnk = 2,participant_name,NULL) ORDER BY participant_name SEPARATOR ',' ) as second,
 GROUP_CONCAT(IF(Rnk = 3,participant_name,NULL) ORDER BY participant_name SEPARATOR ',' ) as third
FROM ranked
WHERE
Rnk < 4
GROUP BY
event_id;
