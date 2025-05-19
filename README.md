# DataAnalytics-Assessment

The Cowrywise Data Analysis Assessment test comprises of 4 Assesment questions given a database to query.
DATABASE NAME: adashi_staging.
The database comprises of 4 tables namely: plans_plan, savings_savingsacount, users_customerusers, withdrawals_withdraw.

# Assessment_Q1
-- High-Value Customers with Multiple Products
The query that solved this brings out the user information of each customer that with the total nuumber of times they've saved and the total number of investments.
-- total_deposits = s.confirmed_amount + p.amount
-- This means, the amount deposited in savings account + the amount put into the plan
The COALESCE function was used to relace the ones that may not have anything to their name with 0
Then; WHERE s.confirmed_amount > 0 AND p.amount > 0 AND p.is_a_fund = 1
The above query means, the condition to display those names were when they have a confirmed amount greater than 0  in savings, and have a plan amount greater than 0 and above all, it must be funded.

-- Challenges:
Some of the customers did not have any amount to their name which resulted to using the COALESCE funtion to subtitute the Null value with 0

# Assessment_Q2
-- Transaction Frequency Analysis
The query was to determine how often customers transact by categorizing the frequency at which they transact into Low, High and Medium frequncies with the condition that: •	"High Frequency" (≥10 transactions/month)
•	"Medium Frequency" (3-9 transactions/month)
•	"Low Frequency" (≤2 transactions/month)

The query was made a CTE such that, we can continously categorize the transactions as they proceed( we can easily resuse the query). And above all, to optimize the database. 

The query was broken down to get the number of transactions per customer and then the average of those transactions.
Then, the condtion was used to filter each transaction into low, medium and high frequency.
Then proceeding to count the numbers of each freuency with Low frequency leading with 526 and High and medium with 173 and 174 respectively.


# Assessment_Q3
-- Account Inactivity Alert
The query aim was to detect accounts that has been dormant for the cycle of 365days(1year).
It was approached by first determining the transaction type of each accounts. Then deploying COALESCE funtion to replace inactive days.
-- With this query, I have to specify  the transaction type then Left Join savings_savingsaccount on plans_plan to get the values at which they align. Thereby specifying the conditions (statud_id and the transaction_date) for the query to show where status_id is active and where transaction has not occured in the past 365days.

# Assessment_Q4
-- Customer Lifetime Value (CLV) Estimation
This query solving the CLV tends to know valuable the customer can be to the orgqnization. With CLV, it can be estimated of how much can be genrated from the customer.
Using 0.1 as the percentage profit per transaction, •	Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction).
In the query, total_transactions = SUM(s.amount) i.e Suming all amounts in the savings account for each customer.
tenure = TIMESTAMPDIFF(MONTH, u.created_on, NOW()). Using TIMESTAMPDIFF function to determine the difference between month of registration and the current date to show each customer longetivity.
