-- Account Inactivity Alert
-- Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
-- Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
USE adashi_staging;
SELECT 
    p.id AS plan_id, 
    p.owner_id, 
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_fixed_investment = 1 THEN 'Investment'
        ELSE 'Other'
    END AS `Transaction type`,
    COALESCE(s.transaction_date, NULL) AS last_transaction_date,
    COALESCE(DATEDIFF(NOW(), s.transaction_date), NULL) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
WHERE p.status_id = 1        		-- Taking '1' to represents active accounts ( the column contains 1s and 2s)
AND (
    s.transaction_date IS NULL OR s.transaction_date < NOW() - INTERVAL 365 DAY
);


-- With this query, I have to specify  the transaction type then Left Join savings_savingsaccount on plans_plan to get
-- the values at which they align. Thereby specifying the conditions (statud_id and the transaction_date) for the query to show where status_id is active and
-- where transaction has not occured in the past 365days.