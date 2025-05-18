-- Assessment_Q4
-- Customer Lifetime Value (CLV) Estimation
-- Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
/* Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
•	Account tenure (months since signup)
•	Total transactions
•	Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
•	Order by estimated CLV from highest to lowest
*/

USE adashi_staging;
SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.created_on, NOW()) AS tenure_months,
    SUM(s.amount) AS total_transactions,
    AVG(s.amount) AS average_transaction,
    (SUM(s.amount) * 0.10) AS profit_per_transaction,
    AVG(SUM(s.amount) * 0.10) OVER () AS avg_profit_per_transaction,
    ((SUM(s.amount) / TIMESTAMPDIFF(MONTH, u.created_on, NOW())) * 12 * AVG(SUM(s.amount) * 0.10) OVER ()) AS CLV    -- Following the  formula given to Compute CLV
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
GROUP BY 1, 2, 3
ORDER BY CLV DESC;
        