SELECT TOP 5 *
FROM transactions.dbo.creditcard;
USE transactions;

-- Step 1: Add a new column for the converted data type
ALTER TABLE dbo.creditcard ADD Amount_Double FLOAT;
-- Step 2: Update the new column with converted values
UPDATE dbo.creditcard SET AMOUNT_DOUBLE=CAST(["Amount"] AS Float);

-- Step 3: Drop the old varchar column
ALTER TABLE dbo.creditcard DROP COLUMN ["Amount"];

-- Step 4: Rename the new column to the original column name
EXEC sp_rename 'dbo.creditcard.Amount_Double', 'Amount', 'COLUMN';

-- Query that Analyzes the distribution of the Amount column to understand transaction patterns
SELECT AVG(Amount) AS AvgTransactionAmount, 
       SUM(Amount) AS TotalTransactionAmount,
       MIN(Amount) AS MinTransactionAmount,
       MAX(Amount) AS MaxTransactionAmount
FROM transactions.dbo.creditcard;

-- Write a query to determine the time, number of transactions and the average amount spent
-- and order them by transaction and group them by Time
SELECT ["Time"], COUNT(*) AS TransactionCount, AVG(["Amount"]) AS AvgTransactionAmount
FROM transactions.dbo.creditcard
GROUP BY ["Time"]
ORDER BY TransactionCount DESC;

-- Write a query to determine the Class, number of transactions and the average amount spent
-- and group by class
SELECT ["Class"], COUNT(*) AS TransactionCount, AVG(["Amount"]) AS AvgTransactionAmount
FROM transactions.dbo.creditcard
GROUP BY ["Class"];

WITH transaction_summary AS (
    SELECT
        customer_id,
        COUNT(transaction_id) AS transaction_count,
        SUM(transaction_amount) AS total_spent,
        AVG(transaction_amount) AS avg_transaction_amount,
        MAX(transaction_date) - MIN(transaction_date) AS time_span,
        SUM(is_fraud) AS fraud_count
    FROM
        transactions
    GROUP BY
        customer_id
),

customer_segments AS (
    SELECT
        customer_id,
        CASE
            WHEN total_spent > 1000 THEN 'High Spender'
            WHEN total_spent > 500 THEN 'Medium Spender'
            ELSE 'Low Spender'
        END AS spending_segment,
        CASE
            WHEN transaction_count > 20 THEN 'Frequent Transactor'
            WHEN transaction_count > 10 THEN 'Occasional Transactor'
            ELSE 'Rare Transactor'
        END AS frequency_segment,
        CASE
            WHEN fraud_count > 5 THEN 'High Risk'
            WHEN fraud_count > 0 THEN 'Moderate Risk'
            ELSE 'Low Risk'
        END AS fraud_risk_segment
    FROM
        transaction_summary
)

SELECT
    spending_segment,
    frequency_segment,
    fraud_risk_segment,
    COUNT(*) AS number_of_customers
FROM
    customer_segments
GROUP BY
    spending_segment,
    frequency_segment,
    fraud_risk_segment;

	-- Analyze fraudulent transactions by spending segment
SELECT
    spending_segment,
    COUNT(transaction_id) AS fraud_count,
    SUM(transaction_amount) AS total_fraud_amount
FROM
    transactions
JOIN
    customer_segments
ON
    transactions.customer_id = customer_segments.customer_id
WHERE
    is_fraud = 1
GROUP BY
    spending_segment;


-- Analyze fraudulent transactions by frequency segment
SELECT
    frequency_segment,
    COUNT(transaction_id) AS fraud_count,
    SUM(transaction_amount) AS total_fraud_amount
FROM
    transactions
JOIN
    customer_segments
ON
    transactions.customer_id = customer_segments.customer_id
WHERE
    is_fraud = 1
GROUP BY
    frequency_segment;