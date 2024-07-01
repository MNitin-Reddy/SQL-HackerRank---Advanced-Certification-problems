-- This is question 1 on Certification test, We have to find out the transactions made by each algorithm for each quarter of the year 2020.
WITH Quaters AS (
    SELECT
    c.algorithm,
    Quarter(dt) as Qp,
    SUM(t.volume) as Vol
    FROM
    coins c INNER JOIN transactions t ON c.code = t.coin_code
    WHERE
    YEAR(t.dt) = 2020
    GROUP BY
    c.algorithm, Quarter(dt)
)

SELECT 
Q1.algorithm as algorithm,
Q1.Vol as transactions_Q1,
Q2.Vol as transactions_Q2,
Q3.Vol as transactions_Q3,
Q4.Vol as transactions_Q4
 FROM Quaters Q1 
    LEFT JOIN Quaters Q2 ON Q1.algorithm = Q2.algorithm AND Q2.Qp = 2
    LEFT JOIN Quaters Q3 ON Q1.algorithm = Q3.algorithm AND Q3.Qp = 3
    LEFT JOIN Quaters Q4 ON Q1.algorithm = Q4.algorithm AND Q4.Qp = 4
WHERE
    Q1.Qp = 1
ORDER BY
    Q1.algorithm;
