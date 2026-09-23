USE fintech_analytics;

DESCRIBE transactions;


-- --------xox----------------xox-------------------------
-- Transaction Analysis
-- --------xox----------------xox-------------------------


-----------------------------------------------------
-- Q1. What is the total number of transactions,
-- total transaction value, and average transaction amount?
----------------------------------------------------

SELECT
    COUNT(*) AS total_transactions,
    SUM(transaction_amount) AS total_transaction_value,
    AVG(transaction_amount) AS average_transaction_amount
FROM transactions;

---------------------------------------------------
-- Q2. What is the total number of transactions and
-- total transaction value for each transaction status?
----------------------------------------------------
SELECT transaction_status,
       COUNT(*) AS total_transactions,
       SUM(transaction_amount) AS total_transaction_value
FROM transactions
GROUP BY transaction_status;

----------------------------------------------------
-- Q3. Which transaction channels have the highest 
-- 		number of transactions?
----------------------------------------------------
-- Q3. Which transaction channels have the highest number of transactions?
----------------------------------------------------

SELECT channel,
       COUNT(*) AS total_transactions
FROM transactions
GROUP BY channel
ORDER BY total_transactions DESC;

----------------------------------------------------
-- Q4. Which transaction types generate the highest total transaction value?
----------------------------------------------------

SELECT transaction_type,
       SUM(transaction_amount) AS total_transaction_value
FROM transactions
GROUP BY transaction_type
ORDER BY total_transaction_value DESC;

----------------------------------------------------
-- Q5. What percentage of transactions are successful for each channel?
----------------------------------------------------
SELECT channel,
	count(*) AS total_transactions,
    SUM(CASE
    WHEN transaction_status ='Success' then 1
    ELSE 0
    END) AS successful_transactions,
    ROUND(
    SUM(CASE
    WHEN transaction_status ='Success' THEN 1
    ELSE 0
    END) *100/count(*),
    2
    )AS success_rate

FROM transactions
GROUP BY channel
ORDER BY success_rate DESC;
    
    
----------------------------------------------------
-- Q6. What is the monthly transaction volume and total transaction value?
----------------------------------------------------

SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
       COUNT(*) AS total_transactions,
       SUM(transaction_amount) AS total_transaction_value
FROM transactions
GROUP BY transaction_month
ORDER BY transaction_month;

----------------------------------------------------
-- Q7. How does transaction performance vary by transaction type?
----------------------------------------------------

SELECT transaction_type,
       COUNT(*) AS transactions_count,
       SUM(transaction_amount) AS transaction_value,
       AVG(transaction_amount) AS average_transaction
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_value DESC;

----------------------------------------------------
-- Q8. Find the top 10 customers based on their total transaction value. 
-- Show customer_id, total number of transactions, and total transaction value.
----------------------------------------------------
SELECT customer_id,
       COUNT(*) AS total_transactions,
       SUM(transaction_amount) AS total_transaction_value
FROM transactions
GROUP BY customer_id
ORDER BY total_transaction_value DESC
LIMIT 10;


----------------------------------------------------
-- Q9.
-- Find the transaction success rate for each transaction channel. 
-- Show the channel, total transactions, successful transactions, and success rate. 
-- Sort by success rate from highest to lowest.
----------------------------------------------------
SELECT channel,
       COUNT(*) AS total_transactions,
       SUM(CASE
           WHEN transaction_status = 'Success' THEN 1
           ELSE 0
       END) AS successful_transactions,
       ROUND(
           SUM(CASE
               WHEN transaction_status = 'Success' THEN 1
               ELSE 0
           END) * 100 / COUNT(*),
           2
       ) AS success_rate
FROM transactions
GROUP BY channel
ORDER BY success_rate DESC;

----------------------------------------------------
-- Q10. What is the number and total value of failed transactions for each channel?
----------------------------------------------------

SELECT channel,
       COUNT(*) AS total_transactions,
       SUM(CASE
           WHEN transaction_status = 'Failed' THEN 1
           ELSE 0
       END) AS total_failed_transactions,
       SUM(CASE
           WHEN transaction_status = 'Failed' THEN transaction_amount
           ELSE 0
       END) AS total_failed_transaction_value
FROM transactions
GROUP BY channel
ORDER BY total_failed_transactions DESC;

----------------------------------------------------
-- Q11. What is the transaction status distribution for each channel?
----------------------------------------------------

SELECT 
    channel,
    
    SUM(CASE
        WHEN transaction_status = 'Success' THEN 1
        ELSE 0
    END) AS success_transactions,

    SUM(CASE
        WHEN transaction_status = 'Failed' THEN 1
        ELSE 0
    END) AS failed_transactions,

    SUM(CASE
        WHEN transaction_status = 'Reversed' THEN 1
        ELSE 0
    END) AS reversed_transactions,

    SUM(CASE
        WHEN transaction_status = 'Pending' THEN 1
        ELSE 0
    END) AS pending_transactions

FROM transactions
GROUP BY channel;


----------------------------------------------------
-- Q12. What are the peak transaction hours based on transaction volume?
----------------------------------------------------
SELECT 
    transaction_hour,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_hour
ORDER BY total_transactions DESC
LIMIT 5;


-- -------------xox----------------------xox---------------
-- Customer Analysis
-- -------------xox----------------------xox---------------

----------------------------------------------------
-- Q13. Which customers have the highest number of transactions?
----------------------------------------------------
SELECT customer_id,
COUNT(*) AS total_transactions
FROM transactions
GROUP BY customer_id
ORDER BY total_transactions DESC;

----------------------------------------------------
-- Q14. Which customers generate the highest total transaction value?
----------------------------------------------------

SELECT 
    customer_id,
    SUM(transaction_amount) AS total_transaction_value
FROM transactions
GROUP BY customer_id
ORDER BY total_transaction_value DESC;

----------------------------------------------------
-- Q15. Which customers have the highest average transaction amount?
----------------------------------------------------
SELECT customer_id,
AVG(transaction_amount) AS average_transaction_amount
FROM transactions
GROUP BY customer_id
ORDER BY average_transaction_amount DESC;

----------------------------------------------------
-- Q16. Which customers have the highest number of failed transactions?
----------------------------------------------------

SELECT 
    customer_id,
    SUM(CASE
        WHEN transaction_status = 'Failed' THEN 1
        ELSE 0
    END) AS failed_transaction_count
FROM transactions
GROUP BY customer_id
ORDER BY failed_transaction_count DESC;

----------------------------------------------------
-- Q17. How many transactions has each customer made for each transaction type?
----------------------------------------------------

SELECT 
    customer_id,
    transaction_type,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY customer_id, transaction_type
ORDER BY customer_id, total_transactions DESC;

----------------------------------------------------
-- Q18. What is the total transaction value for each customer across each transaction type?
----------------------------------------------------

SELECT 
    customer_id,
    transaction_type,
    SUM(transaction_amount) AS total_transaction
FROM transactions
GROUP BY customer_id, transaction_type
ORDER BY customer_id, total_transaction DESC;

----------------------------------------------------
-- Q19. Which customers have never made a successful transaction?
----------------------------------------------------
SELECT 
    customer_id
FROM transactions
GROUP BY customer_id
HAVING SUM(CASE
    WHEN transaction_status = 'Success' THEN 1
    ELSE 0
END) = 0; -- HAVING ... = 0 keeps only customers with zero successful transactions

-- ----------xox----------------------xox------------------
-- Risk/Fraud Analysis
-- ----------xox----------------------xox------------------

----------------------------------------------------
-- Q20. What is the total number of fraudulent transactions and their total transaction value?
----------------------------------------------------
select 
SUM(CASE
WHEN is_fraud = 1 then 1
else 0
END ) AS total_fraud_transactions,

SUM(CASE
WHEN is_fraud = 1 then transaction_amount
else 0
END) AS total_transaction_value
FROM transactions;

----------------------------------------------------
-- Q21. How does fraudulent transaction activity vary across different channels?
----------------------------------------------------
SELECT channel,
SUM(CASE
WHEN is_fraud = 1 then 1
else 0
END ) AS total_fraud_transactions,

SUM(CASE
WHEN is_fraud = 1 then transaction_amount
else 0
END) AS total_transaction_value
FROM transactions
GROUP BY channel;



----------------------------------------------------
 -- Q22. What percentage of transactions are fraudulent for each channel?
----------------------------------------------------

SELECT 
    channel,
    COUNT(*) AS total_transactions,

    SUM(CASE
        WHEN is_fraud = 1 THEN 1
        ELSE 0
    END) AS fraud_transactions,

    ROUND(
        SUM(CASE
            WHEN is_fraud = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS fraud_rate

FROM transactions
GROUP BY channel
ORDER BY fraud_rate DESC;

----------------------------------------------------
-- Q23. Which transaction types have the highest number of fraudulent transactions?
----------------------------------------------------

SELECT 
    transaction_type,
    
    SUM(CASE
        WHEN is_fraud = 1 THEN 1
        ELSE 0
    END) AS fraud_transactions

FROM transactions
GROUP BY transaction_type
ORDER BY fraud_transactions DESC;

----------------------------------------------------
-- Q24. What are the highest-value fraudulent transactions?
----------------------------------------------------

SELECT 
    transaction_id,
    customer_id,
    transaction_date,
    transaction_amount,
    transaction_type,
    channel
FROM transactions
WHERE is_fraud = 1
ORDER BY transaction_amount DESC
LIMIT 10;

----------------------------------------------------
-- Q25. Which customers have the highest number of fraudulent transactions?
----------------------------------------------------

SELECT 
    customer_id,

    SUM(CASE
        WHEN is_fraud = 1 THEN 1
        ELSE 0
    END) AS fraud_transactions

FROM transactions
GROUP BY customer_id
ORDER BY fraud_transactions DESC;

----------------------------------------------------
-- Q26. During which transaction hours do fraudulent transactions occur most frequently?
----------------------------------------------------

SELECT 
    transaction_hour,

    SUM(CASE
        WHEN is_fraud = 1 THEN 1
        ELSE 0
    END) AS fraud_transactions

FROM transactions
GROUP BY transaction_hour
ORDER BY fraud_transactions DESC;

