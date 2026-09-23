USE fintech_analytics;
-- =========================================
-- 1. SELECT
-- =========================================
SELECT transaction_id,
customer_id,
transaction_date,
transaction_amount,
transaction_status
FROM transactions
LIMIT 10;

SELECT *
FROM transactions;

-- =========================================
-- 2. WHERE
-- =========================================
SELECT *
FROM transactions
WHERE transaction_status = 'Failed';

SELECT * 
FROM transactions
WHERE transaction_amount >50000
AND transaction_status ='Failed';

-- =========================================
-- 3. DISTINCT
-- =========================================	
SELECT DISTINCT transaction_status
FROM transactions;

SELECT DISTINCT channel
FROM transactions;

SELECT DISTINCT account_type
FROM transactions;

-- =========================================
-- 4. COUNT()
-- =========================================
SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT COUNT(DISTINCT customer_id) AS total_customer
FROM transactions;

SELECT COUNT(*) AS fradulent_transactions
FROM transactions
WHERE is_fraud = 1;

SELECT COUNT(*) AS failed_transactions
FROM transactions
WHERE transaction_status ='Failed';

-- =========================================
-- 5. AGGREGATE FUNCTIONS
-- =========================================
SELECT SUM(transaction_amount) AS total_transaction_value,
AVG(transaction_amount) AS average_transaction_value,
MIN(transaction_amount) AS minimum_transaction_value,
MAX(transaction_amount) AS maximum_transaction_value,
COUNT(transaction_amount) AS total_transactions
FROM transactions;


-- =========================================
-- 6. GROUP BY
-- =========================================
SELECT transaction_status,
COUNT(*) AS transaction_count
FROM transactions
GROUP BY(transaction_status);


SELECT channel,
COUNT(transaction_amount) AS total_transactiona_value
FROM transactions
GROUP BY(channel);

-- =========================================
-- 7. ORDER BY
-- =========================================
 
 SELECT channel,
 COUNT(*) AS transaction_count
 FROM transactions
 GROUP BY channel
 ORDER BY transaction_count DESC;
 
 
 
 -- Practice Question 
 
 SELECT transaction_amount,
 transaction_id,
 customer_id,
 transaction_date
 FROM transactions
 ORDER BY transaction_amount DESC
 LIMIT 10;
 
 
-- =========================================
-- 8. HAVING
-- =========================================
 SELECT customer_id,
 COUNT(*) AS transaction_count
 FROM transactions
 group by customer_id
 HAVING count(*)>=20
 ORDER BY transaction_count DESC;
 

-- =========================================
-- 9. CASE
-- =========================================
 SELECT transaction_amount,
       CASE
           WHEN transaction_amount >= 50000 THEN 'High'
           WHEN transaction_amount >= 10000 THEN 'Medium'
           ELSE 'Low'
       END AS transaction_category
FROM transactions
ORDER BY transaction_amount DESC
LIMIT 20;

 SELECT transaction_id,transaction_amount,
       CASE
           WHEN transaction_amount >= 50000 THEN 'High'
           WHEN transaction_amount >= 10000 THEN 'Medium'
           ELSE 'Low'
       END AS risk_category
FROM transactions;

SELECT customer_id,
		COUNT(*) AS transaction_count,
		CASE
			WHEN count(*) >20 THEN  'High Activity'
            WHEN count(*) >=10 THEN 'Medium Activity'
            ELSE 'Low'
		End AS Activity_Category
        
FROM transactions
GROUP BY customer_id;

SELECT transaction_status,
		COUNT(*) AS total_count,
		CASE
			WHEN COUNT(*) >400000 THEN 'Very High'
            WHEN COUNT(*) >20000 THEN 'High'
            ELSE 'Normal'
		END AS volume_category
FROM transactions
GROUP BY transaction_status;


-- =========================================
-- 10 NULL 
-- ========================================= 

SELECT COUNT(*) AS loan_missing_values
FROM transactions
WHERE loan_type = ' '
LIMIT 10;

SELECT DISTINCT loan_type
FROM transactions
LIMIT 20;

SELECT COUNT(*) AS missing_loan_values
FROM transactions
WHERE loan_type = 'None';

-- =========================================
-- 11 COALESCE()
-- =========================================

SELECT  loan_type,
coalesce(loan_type , 'No Loan') AS cleaned_loan_type
FROM transactions
LIMIT 20;

SELECT customer_id,
COALESCE(NULLIF(loan_type, 'None'), 'No Loan Information')AS loan_type_status
FROM transactions;

-- =========================================
-- 12. NULLIF()
-- =========================================

SELECT loan_type, 
NULLIF(loan_type, 'NONE') AS cleaned_loan_type
FROM transactions;

-- =========================================
-- 13. Combining NULLIF() + COALESCE()
-- =========================================

SELECT customer_id,
       loan_type,
       COALESCE(
           NULLIF(loan_type, 'None'),
           'No Loan Information'
       ) AS cleaned_loan_type
FROM transactions
LIMIT 20;

-- =========================================
-- 14. DATE and TIME
-- =========================================

SELECT transaction_date,
       YEAR(transaction_date) AS transaction_year,
       MONTH(transaction_date) AS transaction_month
FROM transactions
LIMIT 20;


### Filter by Date

SELECT *
FROM transactions
WHERE transaction_date >= '2023-01-01'
LIMIT 10;

-- =========================================
-- 15. DATE_FORMAT()
-- =========================================
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
       COUNT(*) AS transaction_count
FROM transactions
GROUP BY transaction_month
ORDER BY transaction_month;

-- =========================================
-- 16. Time Analysis — transaction_hour
-- =========================================

SELECT transaction_hour,
       COUNT(*) AS transaction_count
FROM transactions
GROUP BY transaction_hour
ORDER BY transaction_count DESC;

-- =========================================
-- 17. WHERE with Dates
-- =========================================
SELECT COUNT(*) AS transaction_count,
       SUM(transaction_amount) AS total_transaction_value
FROM transactions
WHERE transaction_date >= '2023-01-01'
  AND transaction_date < '2024-01-01';
  
  
  
-- =========================================
-- 18. JOINS
-- =========================================


-- =========================================
-- 19. SubQuery with Group BY
-- =========================================
SELECT transaction_id,
	   customer_id,
	   transaction_amount
FROM transactions
WHERE transaction_amount>(
	SELECT AVG(transaction_amount)
	FROM transactions
);

-- =========================================
-- 20. CTE (Common Table Expression)
-- =========================================

WITH  customer_transactions AS(
SELECT customer_id,
COUNT(*) AS transaction_count
FROM transactions
GROUP BY customer_id
)
SELECT *
FROM customer_transactions
ORDER BY transaction_count DESC;

-- =========================================
-- 21. WINDOW Function
-- =========================================

SELECT customer_id,
       transaction_date,
       transaction_amount,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS transaction_number
FROM transactions;

SELECT customer_id,
       transaction_date,
       transaction_amount,
       SUM(transaction_amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS running_total
FROM transactions;

-- =========================================
-- 22. ROW_NUMBER
-- =========================================
SELECT transaction_id,
customer_id,
transaction_amount,
ROW_NUMBER() OVER(
ORDER BY transaction_amount DESC
)  AS transaction_rank
FROM transactions;

-- =========================================
-- 23. RANK
-- =========================================

SELECT transaction_id,
customer_id,
transaction_amount,
RANK() OVER(
ORDER BY transaction_amount DESC
)  AS transaction_rank
FROM transactions;

-- =========================================
-- 24. DENSE_RANK
-- =========================================

SELECT transaction_id,
customer_id,
transaction_amount,
DENSE_RANK() OVER(
ORDER BY transaction_amount DESC
)  AS transaction_rank
FROM transactions;

-- =========================================
-- 25. PARTITION BY
-- =========================================
SELECT transaction_id,
customer_id,
transaction_amount,
DENSE_RANK() OVER(
PARTITION BY customer_id
ORDER BY transaction_amount DESC
)  AS transaction_rank
FROM transactions;

-- =========================================
-- 26. AVG()
-- =========================================

SELECT transaction_id,
customer_id,
transaction_amount,
avg(transaction_amount) OVER(
ORDER BY customer_id 
)  AS customer_avg_trans
FROM transactions;


-- =========================================
-- 27. LAG
-- =========================================
SELECT customer_id,
       transaction_date,
       transaction_amount,
       LAG(transaction_amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS previous_transaction_amount
FROM transactions;

-- =========================================
-- 30. UNION
-- =========================================
SELECT customer_id
FROM transactions
WHERE transaction_status = 'Failed'

UNION

SELECT customer_id
FROM transactions
WHERE is_fraud = 1;

-- =========================================
-- 32. multiple table JOIN
-- =========================================
SELECT c.customer_id,
       c.customer_name,
       t.transaction_id,
       t.transaction_amount
FROM transactions AS c
INNER JOIN transactions AS t
    ON c.customer_id = t.customer_id;
    
    