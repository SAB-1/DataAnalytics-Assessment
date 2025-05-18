--  Assessment_Q1
-- High-Value Customers with Multiple Products

/* Task: Write a query to find customers with at least one funded savings plan 
AND one funded investment plan, sorted by total deposits. */

USE adashi_staging;
SELECT u.id AS owner_id, 
       u.name, 
       COUNT(DISTINCT s.id) AS savings_count, 
       COUNT(DISTINCT p.id) AS investment_count, 
       (COALESCE(SUM(s.confirmed_amount), 0) + COALESCE(SUM(p.amount), 0)) AS total_deposits
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
JOIN plans_plan p ON u.id = p.owner_id
WHERE s.confirmed_amount > 0 AND p.amount > 0 AND p.is_a_fund = 1 -- Funded savings plan & Funded investment plan
GROUP BY u.id, u.name
ORDER BY total_deposits DESC;


-- total_deposits = s.confirmed_amount + p.amount
-- This means, the amount deposited in savings account + the amount put into the plan
