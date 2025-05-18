-- Assessment_Q2
-- Transaction Frequency Analysis
-- Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
/* Task: Calculate the average number of transactions per customer per month and categorize them:
•	"High Frequency" (≥10 transactions/month)
•	"Medium Frequency" (3-9 transactions/month)
•	"Low Frequency" (≤2 transactions/month)
*/

USE adashi_staging;
WITH TransactionsPerCustomer AS (
    SELECT s.owner_id, 
           MONTH(s.transaction_date) AS transaction_month, 
           COUNT(s.id) AS transaction_count
    FROM savings_savingsaccount s
    GROUP BY s.owner_id, MONTH(s.transaction_date)
),
`Average Transactions` AS (
    SELECT owner_id, 
           AVG(transaction_count) AS avg_transactions_per_month
    FROM TransactionsPerCustomer
    GROUP BY owner_id
)
SELECT CASE 
           WHEN avg_transactions_per_month >= 10 THEN "High Frequency"
           WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN "Medium Frequency"
           ELSE "Low Frequency"
       END AS frequency_category,
       COUNT(owner_id) AS customer_count,
       AVG(avg_transactions_per_month) AS avg_transactions_per_month
FROM `Average Transactions`
GROUP BY frequency_category
ORDER BY avg_transactions_per_month DESC;