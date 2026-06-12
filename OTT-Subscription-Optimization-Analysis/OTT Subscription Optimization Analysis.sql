CREATE DATABASE ott_case_study;
USE ott_case_study;

show tables;
select * from ott_dataset;


#------------------------------------------------------------------------------------------

# Lets Start the Case Study
/*
====================================================
QUESTION 1:
How do I view the first 10 records from the dataset?
====================================================

WHAT OUTPUT DO WE NEED?

We need to see the first 10 rows of the dataset.

This helps us understand:

1. What columns are available
2. What type of values are present
3. Whether the data imported correctly or not

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First, we need to choose the table from where we want to see the data.

So we use:

FROM ott_subcription_dataset

Step 2:
Now we want to see all columns.

So we use:

SELECT *

Here * means all columns.

Step 3:
But the table may have many records.

We do not want to see all records now.

We only want first 10 records.

So we use:

LIMIT 10

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT *
FROM ott_subcription_dataset
LIMIT 10;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_subcription_dataset
   SQL first goes to this table.

2. LIMIT 10
   SQL takes only first 10 records.

3. SELECT *
   SQL displays all columns from those 10 records.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This query does not give business insight yet.

It gives data understanding.

We can see columns like:

user_id,
user_name,
platform,
monthly_cost,
watch_hours_per_month,
last_used_days_ago,
auto_renewal.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Before solving a business problem, we should first understand the dataset.

For this OTT project, we need to check whether the data has:

1. Customer details
2. Subscription details
3. Usage details
4. Cost details

Only then we can find underutilized subscriptions.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

If data looks correct, continue analysis.

If data has missing columns, wrong values, or duplicate IDs, clean the data first.
====================================================
*/

SELECT *
FROM ott_dataset
LIMIT 10;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 2:
How many total subscription records are there?
====================================================

WHAT OUTPUT DO WE NEED?

We need one number:

Total subscription records

Example output:

total_records
451

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First, we select the table.

FROM ott_subcription_dataset

Step 2:
If we write:

SELECT *

it will show all records.

But we do not want all records.

We want to count the number of records.

Step 3:
So we replace * with COUNT(*).

COUNT(*) means count all rows in the table.

Step 4:
Give a clear name to the output column.

AS total_records

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT COUNT(*) AS total_records
FROM ott_subcription_dataset;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_subcription_dataset
   SQL first reads the table.

2. COUNT(*)
   SQL counts all rows.

3. SELECT
   SQL displays the final count.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This tells how many subscription records exist in the dataset.

Important:

This is not total users.

This is total subscriptions.

One user can have more than one OTT subscription.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

If total records are 451, it means the company is analyzing 451 OTT subscriptions.

But users may be only 250.

That means some users are using multiple OTT platforms.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Use this number as the base for subscription-level analysis.

Later we can calculate:

1. Underutilized subscription percentage
2. Total monthly spending
3. Total possible savings
====================================================
*/

SELECT COUNT(*) AS total_records
FROM ott_dataset;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 3:
How many unique users/customers are there?
====================================================

WHAT OUTPUT DO WE NEED?

We need one number:

Total unique users

Example output:

total_users
250

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First, we select the table.

FROM ott_subcription_dataset

Step 2:
If we use:

SELECT user_id

we will see all user IDs.

But one user_id can repeat because one customer may have multiple OTT subscriptions.

Example:

user_id 1 → Netflix
user_id 1 → Hotstar
user_id 1 → Amazon Prime

So user_id 1 appears 3 times.

Step 3:
If we use:

COUNT(user_id)

it will count repeated users also.

That is wrong for customer count.

Step 4:
We need each customer only once.

So we use:

DISTINCT user_id

DISTINCT removes duplicate user IDs.

Step 5:
Now we count unique users using:

COUNT(DISTINCT user_id)

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT COUNT(DISTINCT user_id) AS total_users
FROM ott_subcription_dataset;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_subcription_dataset
   SQL first reads the table.

2. DISTINCT user_id
   SQL removes duplicate user IDs.

3. COUNT()
   SQL counts only unique users.

4. SELECT
   SQL displays the final result.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This gives the actual customer count.

Example:

451 subscription records
250 unique users

This means 250 customers are using 451 OTT subscriptions.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

This shows that many users have more than one OTT subscription.

That is important because users may be spending unnecessarily on multiple platforms.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Company can target users with multiple subscriptions and provide:

1. Subscription optimization suggestions
2. Bundle offers
3. Downgrade recommendations
4. Personalized engagement offers

This can improve customer satisfaction and reduce subscription waste.
====================================================
*/

SELECT COUNT(DISTINCT user_id) AS total_users
FROM ott_dataset;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 4:
How many OTT subscriptions does each user have?
====================================================

WHAT OUTPUT DO WE NEED?

We want output like:

user_id     user_name       total_subscriptions

1           Aarav Sharma            3
2           Vivaan Patel            2
3           Aditya Verma            1

This tells us how many OTT subscriptions each customer owns.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First select the table.

FROM ott_dataset

Step 2:
We want to see:

user_id
user_name

because we want to identify each customer.

Step 3:
Now we need to count how many subscriptions each customer owns.

Which column uniquely identifies a subscription?

subscription_id

So we use:

COUNT(subscription_id)

Step 4:
But COUNT() alone will count all subscriptions in the table.

We need count for each customer separately.

So we use:

GROUP BY user_id, user_name

GROUP BY creates one group for each customer.

Step 5:
Give a meaningful name.

AS total_subscriptions

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT
    user_id,
    user_name,
    COUNT(subscription_id) AS total_subscriptions

FROM ott_dataset

GROUP BY user_id, user_name;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. GROUP BY user_id, user_name
   SQL creates one group per customer.

3. COUNT(subscription_id)
   SQL counts subscriptions inside each group.

4. SELECT
   SQL displays the result.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This shows which users own:

• 1 subscription
• 2 subscriptions
• 3 subscriptions

Example:

Aarav Sharma = 3 subscriptions

This means he is paying for 3 OTT platforms.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Users with more subscriptions generally spend more money.

These users are more likely to have:

• Duplicate content access
• Subscription waste
• Underutilized plans

Such users become ideal candidates for optimization analysis.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Company can identify:

High Subscription Customers

and provide:

• Bundle plans
• Family plans
• Subscription recommendations
• Cost optimization suggestions

This improves customer satisfaction and retention.
====================================================
*/

SELECT
    user_id,
    user_name,
    COUNT(subscription_id) AS total_subscriptions
FROM ott_dataset
GROUP BY user_id, user_name;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 5:
Which users have the highest number of OTT subscriptions?
====================================================

WHAT OUTPUT DO WE NEED?

We want output like:

user_id    user_name       total_subscriptions

101        Aarav Sharma             3
55         Rahul Kumar              3
78         Priya Patel              3

These users have the highest number of OTT subscriptions.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First we need to count subscriptions for each user.

We already learned this in previous query.

COUNT(subscription_id)

GROUP BY user_id, user_name

Step 2:
Now we want highest subscription holders first.

Currently SQL will show data in random order.

So we use:

ORDER BY total_subscriptions

ORDER BY means sort the results.

Step 3:
By default SQL sorts in ascending order.

Ascending means:

1
2
3

But we want highest first.

So we use:

DESC

DESC means descending order.

Example:

3
2
1

Step 4:
Sometimes table may have 250 users.

We don't want all users.

We only want Top 10 users.

So we use:

LIMIT 10

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT
    user_id,
    user_name,
    COUNT(subscription_id) AS total_subscriptions

FROM ott_dataset

GROUP BY user_id, user_name

ORDER BY total_subscriptions DESC

LIMIT 10;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. GROUP BY user_id, user_name
   SQL creates groups for each user.

3. COUNT(subscription_id)
   SQL counts subscriptions inside each group.

4. ORDER BY total_subscriptions DESC
   SQL sorts highest to lowest.

5. LIMIT 10
   SQL keeps only top 10 rows.

6. SELECT
   SQL displays final output.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This query identifies customers who own the most OTT subscriptions.

Example:

A user may own:

• Netflix
• Amazon Prime
• Hotstar

Total = 3 subscriptions

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Users with multiple subscriptions usually:

• Spend more money
• Consume more content
• Have higher probability of subscription overlap
• Have greater opportunity for savings

These users are important because they generate higher revenue.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Company can target these users with:

• Premium bundles
• Family plans
• Loyalty rewards
• Personalized recommendations

This helps increase retention and customer lifetime value.

INTERVIEW ANSWER:

"I used GROUP BY to calculate total subscriptions per user, ORDER BY DESC to identify the highest subscription holders, and LIMIT to display only the top users for business analysis."
====================================================
*/

SELECT
    user_id,
    user_name,
    COUNT(subscription_id) AS total_subscriptions
FROM ott_dataset
GROUP BY user_id, user_name
ORDER BY total_subscriptions DESC
LIMIT 10;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 6:
What is the total monthly OTT spending?
====================================================

WHAT OUTPUT DO WE NEED?

We want one number:

total_monthly_spend

Example:

total_monthly_spend
125000

This means all customers together are spending ₹1,25,000 per month on OTT subscriptions.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First select the table.

FROM ott_dataset

Step 2:
We need to calculate money spent.

The column that stores subscription price is:

monthly_cost

Step 3:
If we use:

SELECT monthly_cost

it will show all monthly cost values row by row.

But we need total spending.

Step 4:
To add all monthly costs, we use:

SUM(monthly_cost)

SUM() adds all values in a numeric column.

Step 5:
Give the output column a clear name:

AS total_monthly_spend

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT
    SUM(monthly_cost) AS total_monthly_spend
FROM ott_dataset;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. SUM(monthly_cost)
   SQL adds all monthly_cost values.

3. SELECT
   SQL displays the final total.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This query shows total monthly money spent on OTT subscriptions.

This is a subscription-level revenue/spending KPI.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

If total monthly spending is high, it means customers are paying a lot across OTT platforms.

But high spending is not always good for customers.

Some of this spending may be wasted if users are not watching content regularly.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Company can use this KPI to:

1. Understand total market value
2. Identify revenue potential
3. Compare spending with usage
4. Find saving opportunities for users

For customers:

If spending is high but usage is low, they should downgrade or cancel unused plans.

INTERVIEW ANSWER:

"I used SUM(monthly_cost) to calculate total monthly OTT spending because monthly_cost represents the amount paid for each subscription."
====================================================
*/

SELECT
    SUM(monthly_cost) AS total_monthly_spend
FROM ott_dataset;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 7:
What is the average monthly subscription cost?
====================================================

WHAT OUTPUT DO WE NEED?

We want one number:

avg_monthly_cost

Example:

avg_monthly_cost
299.50

This means an average OTT subscription costs ₹299.50 per month.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First identify the table.

FROM ott_dataset

Step 2:
Identify the column containing subscription price.

monthly_cost

Step 3:
If we use:

SELECT monthly_cost

SQL will show all monthly costs.

Example:

199
299
499
649

But we don't want individual costs.

We want average cost.

Step 4:
Use AVG()

AVG() calculates the average value.

Formula:

Average =
Total Sum of Values
/
Total Number of Values

Step 5:
Give meaningful column name.

AS avg_monthly_cost

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT
    AVG(monthly_cost) AS avg_monthly_cost
FROM ott_dataset;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. AVG(monthly_cost)
   SQL calculates average monthly cost.

3. SELECT
   SQL displays the result.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This tells the average amount customers spend on one OTT subscription.

Example:

₹320 average subscription cost

means

Most OTT plans fall around this price range.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

This KPI helps understand pricing levels.

If average cost is high:

• Customers spend more money
• Higher risk of subscription fatigue
• Greater savings opportunity

If average cost is low:

• Customers may be using budget plans
• Lower financial burden

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

OTT companies can:

• Design pricing strategies
• Create bundle offers
• Introduce lower-cost plans

Customers can:

• Compare their spending with average market spending
• Identify expensive subscriptions

INTERVIEW ANSWER:

"I used AVG(monthly_cost) to calculate the average subscription cost because monthly_cost represents the amount paid per OTT subscription."
====================================================
*/

SELECT
    AVG(monthly_cost) AS avg_monthly_cost
FROM ott_dataset;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 8:
Which OTT platform is the most popular?
====================================================

WHAT OUTPUT DO WE NEED?

We want output like:

Platform        Total_Users

NETFLIX             120
HOTSTAR             95
AMAZON PRIME        88
SONYLIV             75
ZEE5                73

This tells us which OTT platform has the highest number of subscriptions.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First identify the table.

FROM ott_dataset

Step 2:
We want to analyse platform popularity.

The platform name is stored in:

platform

So first let's see platform column.

SELECT platform

Step 3:
We need to count how many times each platform appears.

Example:

NETFLIX
NETFLIX
NETFLIX
HOTSTAR
HOTSTAR

Netflix appears 3 times.

Hotstar appears 2 times.

To count occurrences we use:

COUNT(*)

Step 4:
But COUNT(*) will count the entire table.

We want count for each platform separately.

So we use:

GROUP BY platform

GROUP BY creates separate groups.

Group 1 = Netflix

Group 2 = Hotstar

Group 3 = Amazon Prime

Group 4 = SonyLiv

Group 5 = Zee5

Step 5:
Now count records inside each group.

COUNT(*)

Step 6:
Give meaningful name.

AS total_subscriptions

Step 7:
We want highest platform first.

Use:

ORDER BY total_subscriptions DESC

DESC means highest to lowest.

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT

platform,

COUNT(*) AS total_subscriptions

FROM ott_dataset

GROUP BY platform

ORDER BY total_subscriptions DESC;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. GROUP BY platform
   SQL creates one group for each platform.

3. COUNT(*)
   SQL counts records inside each platform.

4. ORDER BY total_subscriptions DESC
   SQL sorts highest to lowest.

5. SELECT
   SQL displays final result.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This query identifies the most popular OTT platform.

Example:

Netflix = 120 subscriptions

Hotstar = 95 subscriptions

This means Netflix has the largest customer base.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

More subscriptions usually means:

• Higher customer preference
• Stronger content library
• Better market position

Popular platforms attract more customers and generate more revenue.

Less popular platforms may struggle with engagement.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For OTT Companies:

If Netflix is highest:

• Continue investing in content
• Maintain customer satisfaction
• Retain existing subscribers

If Zee5 is lowest:

• Improve content quality
• Increase marketing campaigns
• Introduce promotional offers

For Business Analysts:

This insight helps understand market demand and customer preference.

INTERVIEW ANSWER:

"I used GROUP BY platform to create separate platform groups and COUNT(*) to measure popularity. ORDER BY DESC helped identify the most popular OTT platform."
====================================================
*/

SELECT
    platform,
    COUNT(*) AS total_subscriptions
FROM ott_dataset
GROUP BY platform
ORDER BY total_subscriptions DESC;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 9:
Which OTT platform generates the highest revenue?
====================================================

WHAT OUTPUT DO WE NEED?

We want output like:

Platform        Total_Revenue

NETFLIX           45,000
HOTSTAR           32,000
SONYLIV           28,000
ZEE5              20,000

This tells us which platform is earning the most money.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First identify the table.

FROM ott_dataset

Step 2:
We want revenue platform-wise.

So we need:

platform

Step 3:
Revenue comes from subscription fees.

The subscription fee column is:

monthly_cost

Example:

Netflix = 649
Netflix = 499
Netflix = 199

Total Revenue

=

649 + 499 + 199

Step 4:
To add all monthly costs we use:

SUM(monthly_cost)

SUM() means add all values.

Step 5:
But we don't want total revenue of the entire dataset.

We want revenue for each platform separately.

So we use:

GROUP BY platform

This creates separate groups.

Netflix Group

Hotstar Group

SonyLiv Group

Amazon Prime Group

Zee5 Group

Step 6:
Calculate revenue inside each group.

SUM(monthly_cost)

Step 7:
Give meaningful name.

AS total_revenue

Step 8:
Show highest revenue first.

ORDER BY total_revenue DESC

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT

platform,

SUM(monthly_cost) AS total_revenue

FROM ott_dataset

GROUP BY platform

ORDER BY total_revenue DESC;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. GROUP BY platform
   SQL creates separate groups.

3. SUM(monthly_cost)
   SQL adds revenue inside each group.

4. ORDER BY total_revenue DESC
   SQL sorts highest revenue first.

5. SELECT
   SQL displays final result.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This tells which OTT platform contributes the most revenue.

Important:

Most Popular Platform
≠
Highest Revenue Platform

Example:

Netflix = 80 users × ₹649

Hotstar = 120 users × ₹149

Hotstar may have more users.

Netflix may still earn more revenue.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Revenue is more important than subscription count.

Management wants to know:

• Which platform earns the most?
• Which platform contributes the most business value?
• Which platform has premium customers?

This helps understand profitability.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

If Netflix generates highest revenue:

• Continue premium content strategy
• Focus on retention

If Zee5 generates lowest revenue:

• Introduce better plans
• Increase marketing
• Improve content offerings

Business teams can allocate budget based on revenue contribution.

----------------------------------------------------
INTERVIEW ANSWER:

"I used SUM(monthly_cost) to calculate platform-wise revenue. GROUP BY platform allowed me to calculate revenue separately for each OTT platform and ORDER BY DESC helped identify the highest revenue generating platform."
====================================================
*/

SELECT
    platform,
    SUM(monthly_cost) AS total_revenue
FROM ott_dataset
GROUP BY platform
ORDER BY total_revenue DESC;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 10:
Which subscriptions are underutilized?
====================================================

WHAT OUTPUT DO WE NEED?

We want output like:

subscription_id   user_name      platform    monthly_cost   watch_hours_per_month   last_used_days_ago   subscription_status

1                 Aarav Sharma   Netflix        649                  4                    65              Underutilized
2                 Vivaan Patel   Hotstar        299                 45                     8              Active

This means we want to classify each subscription as:

1. Active
2. Underutilized

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First identify the table.

FROM ott_dataset

Step 2:
Select the important columns needed for analysis:

subscription_id
user_id
user_name
platform
monthly_cost
watch_hours_per_month
last_used_days_ago

Step 3:
Now we need to create a new status column.

The new column should tell whether a subscription is:

Active
or
Underutilized

Step 4:
We need a condition.

Business rule:

If watch_hours_per_month is less than 10

OR

last_used_days_ago is greater than 30

then the subscription is Underutilized.

Why?

Because if the user watches less than 10 hours per month,
the platform is not being used enough.

If the user has not used the platform for more than 30 days,
the subscription is inactive.

Step 5:
To create conditions in SQL, we use:

CASE WHEN

CASE WHEN works like IF condition.

Step 6:
Logic:

CASE
    WHEN watch_hours_per_month < 10
         OR last_used_days_ago > 30
    THEN 'Underutilized'
    ELSE 'Active'
END

Step 7:
Give this new calculated column a name:

AS subscription_status

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT
    subscription_id,
    user_id,
    user_name,
    platform,
    monthly_cost,
    watch_hours_per_month,
    last_used_days_ago,

    CASE
        WHEN watch_hours_per_month < 10
             OR last_used_days_ago > 30
        THEN 'Underutilized'
        ELSE 'Active'
    END AS subscription_status

FROM ott_dataset;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. SELECT columns
   SQL selects required columns.

3. CASE WHEN condition
   SQL checks each row one by one.

4. If condition is true
   SQL marks it as Underutilized.

5. If condition is false
   SQL marks it as Active.

6. SELECT
   SQL displays final output.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This query identifies subscriptions that users are paying for but not actively using.

Example:

Watch Hours = 5
Last Used = 45 days ago

This subscription is underutilized.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Underutilized subscriptions create unnecessary monthly spending for users.

From customer point of view:

They are paying money but not getting value.

From business point of view:

These users are at risk of cancellation because they are not engaged.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For customers:

1. Cancel unused subscriptions
2. Downgrade expensive plans
3. Pause inactive plans

For OTT companies:

1. Send re-engagement offers
2. Recommend personalized content
3. Give limited-time discounts
4. Notify inactive users before cancellation

----------------------------------------------------
INTERVIEW ANSWER:

"I created a subscription_status column using CASE WHEN. If watch hours were below 10 or last used days were above 30, I classified the subscription as underutilized. This helped identify users who are paying for services they rarely use."
====================================================
*/

SELECT
    subscription_id,
    user_id,
    user_name,
    platform,
    monthly_cost,
    watch_hours_per_month,
    last_used_days_ago,

    CASE
        WHEN watch_hours_per_month < 10
             OR last_used_days_ago > 30
        THEN 'Underutilized'
        ELSE 'Active'
    END AS subscription_status

FROM ott_dataset;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 11:
How many subscriptions are Active and Underutilized?
====================================================

WHAT OUTPUT DO WE NEED?

subscription_status      total_subscriptions

Active                          250
Underutilized                   201

This tells us how many subscriptions fall into each category.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First identify the table.

FROM ott_dataset

Step 2:
We already know how to classify subscriptions.

Business Rule:

If watch_hours_per_month < 10

OR

last_used_days_ago > 30

Then

Underutilized

Otherwise

Active

We will use the same CASE WHEN logic.

Step 3:
Now we want to count how many subscriptions belong to each category.

For counting rows we use:

COUNT(*)

Step 4:
But COUNT(*) alone will count the entire table.

We want separate counts for:

Active

and

Underutilized

So we use:

GROUP BY subscription_status

Step 5:
Since subscription_status is not a real column,
it is created using CASE WHEN.

So SQL first creates the status,
then groups the records.

----------------------------------------------------
FINAL CODE:
----------------------------------------------------

SELECT

CASE
    WHEN watch_hours_per_month < 10
         OR last_used_days_ago > 30
    THEN 'Underutilized'

    ELSE 'Active'
END AS subscription_status,

COUNT(*) AS total_subscriptions

FROM ott_dataset

GROUP BY subscription_status;

----------------------------------------------------
EXECUTION ORDER:
----------------------------------------------------

1. FROM ott_dataset
   SQL reads the table.

2. CASE WHEN
   SQL creates subscription_status.

3. GROUP BY subscription_status
   SQL creates two groups:

   Active

   Underutilized

4. COUNT(*)
   SQL counts records inside each group.

5. SELECT
   SQL displays final result.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This query shows the health of all subscriptions.

Example:

Active = 250

Underutilized = 201

This means almost half the subscriptions are not being properly used.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

A high number of underutilized subscriptions indicates:

• Subscription waste
• Low engagement
• Possible future cancellations
• Poor customer value realization

This is the core business problem we are solving.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For Customers:

• Cancel unused subscriptions
• Downgrade expensive plans
• Review monthly OTT spending

For OTT Companies:

• Send personalized recommendations
• Trigger re-engagement campaigns
• Offer discounts
• Improve content discovery

----------------------------------------------------
INTERVIEW ANSWER:

"I used CASE WHEN to classify subscriptions into Active and Underutilized categories and GROUP BY to calculate the number of subscriptions in each category. This helped measure overall subscription utilization."
====================================================
*/

SELECT

CASE
    WHEN watch_hours_per_month < 10
         OR last_used_days_ago > 30
    THEN 'Underutilized'

    ELSE 'Active'
END AS subscription_status,

COUNT(*) AS total_subscriptions

FROM ott_dataset

GROUP BY subscription_status;
#Found ~38% subscriptions underutilized, enabling savings opportunities.
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 12:
What percentage of subscriptions are underutilized?
====================================================

WHAT OUTPUT DO WE NEED?

underutilized_percentage

44.57

Meaning:

44.57% of subscriptions are underutilized.

----------------------------------------------------
APPROACH:
----------------------------------------------------

Step 1:
First identify underutilized subscriptions.

Business Rule:

watch_hours_per_month < 10

OR

last_used_days_ago > 30

Step 2:
Count only underutilized subscriptions.

COUNT(CASE WHEN condition THEN 1 END)

Step 3:
Count total subscriptions.

COUNT(*)

Step 4:
Calculate percentage.

Formula:

(Underutilized Subscriptions / Total Subscriptions) * 100

Step 5:
Round to 2 decimal places.

ROUND()

----------------------------------------------------
FINAL CODE:
----------------------------------------------------
*/

SELECT

ROUND(

COUNT(
CASE
WHEN watch_hours_per_month < 10
OR last_used_days_ago > 30
THEN 1
END

) * 100.0

/

COUNT(*)

,2)

AS underutilized_percentage

FROM ott_dataset;
/*
INSIGHT

Example:

Underutilized Percentage = 44.57%

Meaning:

Almost 45 out of every 100 subscriptions are not being properly used.

BUSINESS UNDERSTANDING

This is the main KPI of your project.

Management immediately understands:

There is significant subscription waste.
BUSINESS ACTION
1. Cancel unused subscriptions

2. Downgrade plans

3. Send re-engagement campaigns

4. Build recommendation systems
*/
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 13:
Which OTT platform has the highest underutilized subscriptions?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Group the data platform-wise.

GROUP BY platform

Step 3:
Count total subscriptions for each platform.

COUNT(*) AS total_subscriptions

Step 4:
Count underutilized subscriptions for each platform using CASE WHEN.

Step 5:
Calculate underutilized percentage platform-wise.

Step 6:
Sort highest underutilized percentage first.

ORDER BY underutilized_percentage DESC

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This identifies the OTT platform where customers are least engaged.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

A platform may have many subscribers but poor usage.

That means customers are paying but not watching enough content.

This creates cancellation risk.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For high underutilized platforms:

1. Improve content recommendation
2. Send reactivation campaigns
3. Offer cheaper plans
4. Promote trending shows
5. Reduce cancellation risk
====================================================
*/

SELECT
    platform,
    COUNT(*) AS total_subscriptions,
    COUNT(
        CASE
            WHEN watch_hours_per_month < 10
                 OR last_used_days_ago > 30
            THEN 1
        END
    ) AS underutilized_subscriptions,
    ROUND(
        COUNT(
            CASE
                WHEN watch_hours_per_month < 10
                     OR last_used_days_ago > 30
                THEN 1
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS underutilized_percentage
FROM ott_dataset
GROUP BY platform
ORDER BY underutilized_percentage DESC;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 14:
Which city spends the most on OTT subscriptions?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Group customers by city.

GROUP BY city

Step 3:
Calculate total monthly spend using:

SUM(monthly_cost)

Step 4:
Count users using:

COUNT(DISTINCT user_id)

Step 5:
Sort highest spending city first.

ORDER BY total_monthly_spend DESC

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This shows which city contributes the highest OTT spending.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Cities with higher spending are strong OTT markets.

They may have higher digital adoption and entertainment demand.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

OTT companies can:

1. Run city-specific campaigns
2. Launch regional content
3. Offer premium bundles in high-spending cities
4. Increase marketing investment in strong cities
====================================================
*/

SELECT
    city,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(*) AS total_subscriptions,
    SUM(monthly_cost) AS total_monthly_spend
FROM ott_dataset
GROUP BY city
ORDER BY total_monthly_spend DESC;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 15:
Which income group spends the most on OTT subscriptions?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Group data by income_group.

GROUP BY income_group

Step 3:
Calculate total spending.

SUM(monthly_cost)

Step 4:
Calculate average spending per subscription.

AVG(monthly_cost)

Step 5:
Sort highest total spending first.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This shows which income group contributes highest OTT revenue.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

High-income customers may prefer premium plans.

Low-income customers may prefer budget plans.

Medium-income customers may be price-sensitive but still active.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For high-income users:

Offer premium bundles.

For medium-income users:

Offer value packs.

For low-income users:

Offer budget plans or mobile-only plans.
====================================================
*/

SELECT
    income_group,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(*) AS total_subscriptions,
    SUM(monthly_cost) AS total_monthly_spend,
    ROUND(AVG(monthly_cost), 2) AS avg_subscription_cost
FROM ott_dataset
GROUP BY income_group
ORDER BY total_monthly_spend DESC;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 16:
Which age group spends the most on OTT subscriptions?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Create age groups using CASE WHEN.

18 to 25  = Young Adults
26 to 35  = Working Professionals
36 to 45  = Mature Adults
46+       = Senior Users

Step 3:
Group data by age_group.

Step 4:
Calculate total users, subscriptions, and spending.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This identifies which age segment is most valuable for OTT business.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Younger users may watch more content.

Working professionals may pay for premium plans.

Older users may have lower usage or specific content preferences.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

OTT companies can:

1. Target young users with trending content
2. Target working professionals with premium bundles
3. Target older users with regional/family content
====================================================
*/

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25 Young Adults'
        WHEN age BETWEEN 26 AND 35 THEN '26-35 Working Professionals'
        WHEN age BETWEEN 36 AND 45 THEN '36-45 Mature Adults'
        ELSE '46+ Senior Users'
    END AS age_group,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(*) AS total_subscriptions,
    SUM(monthly_cost) AS total_monthly_spend,
    ROUND(AVG(watch_hours_per_month), 2) AS avg_watch_hours
FROM ott_dataset
GROUP BY age_group
ORDER BY total_monthly_spend DESC;
#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 17:
Which OTT platform has the highest average watch hours?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Group by platform.

GROUP BY platform

Step 3:
Use AVG(watch_hours_per_month).

This calculates average engagement for each platform.

Step 4:
Sort highest average watch hours first.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This shows which platform has the strongest user engagement.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

High watch hours mean customers are actively consuming content.

Low watch hours mean users may cancel soon.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

High engagement platforms:

1. Retain users with premium plans
2. Promote annual subscriptions

Low engagement platforms:

1. Improve content discovery
2. Send watch recommendations
3. Offer reactivation discounts
====================================================
*/

SELECT
    platform,
    COUNT(*) AS total_subscriptions,
    ROUND(AVG(watch_hours_per_month), 2) AS avg_watch_hours,
    ROUND(AVG(last_used_days_ago), 2) AS avg_last_used_days
FROM ott_dataset
GROUP BY platform
ORDER BY avg_watch_hours DESC;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 18:
Who are the top 10 highest spending users?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Group by user_id and user_name.

Each user may have multiple subscriptions.

Step 3:
Add all monthly costs for each user.

SUM(monthly_cost)

Step 4:
Sort highest spender first.

Step 5:
Show only top 10 users using LIMIT 10.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This identifies premium/high-value customers.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

High spending users are valuable for OTT platforms.

But they may also have unnecessary spending if some subscriptions are underutilized.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For high spenders:

1. Offer loyalty rewards
2. Suggest optimized bundles
3. Give premium support
4. Reduce churn risk
====================================================
*/

SELECT
    user_id,
    user_name,
    COUNT(*) AS total_subscriptions,
    SUM(monthly_cost) AS total_monthly_spend
FROM ott_dataset
GROUP BY user_id, user_name
ORDER BY total_monthly_spend DESC
LIMIT 10;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 19:
How can we rank OTT platforms based on revenue?
====================================================

APPROACH:

Step 1:
First calculate revenue for each platform.

SUM(monthly_cost)

Step 2:
Group by platform.

GROUP BY platform

Step 3:
Use RANK() to assign ranking based on revenue.

Step 4:
Use OVER() to tell SQL how ranking should happen.

Step 5:
Inside OVER(), use:

ORDER BY SUM(monthly_cost) DESC

This means highest revenue gets rank 1.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This gives clear platform revenue ranking.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Rank 1 platform is the strongest revenue contributor.

Lower ranked platforms need business improvement.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Rank 1:

Protect and retain customers.

Lower ranks:

Improve pricing, marketing, content, and engagement.
====================================================
*/

SELECT
    platform,
    SUM(monthly_cost) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(monthly_cost) DESC
    ) AS revenue_rank
FROM ott_dataset
GROUP BY platform;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 20:
How can we separate Active and Underutilized subscriptions using a CTE?
====================================================

APPROACH:

Step 1:
Create a temporary result using WITH.

This is called CTE.

CTE means Common Table Expression.

Step 2:
Inside the CTE, create subscription_status using CASE WHEN.

Step 3:
After creating the CTE, query from it like a normal table.

Step 4:
Group by subscription_status and count records.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

CTE makes the query cleaner and easier to read.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

This helps convert raw subscription data into business categories:

Active
Underutilized

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

Use this segmented data for dashboards, reports, and customer targeting.
====================================================
*/

WITH subscription_status_cte AS (
    SELECT
        subscription_id,
        user_id,
        user_name,
        platform,
        monthly_cost,
        watch_hours_per_month,
        last_used_days_ago,
        CASE
            WHEN watch_hours_per_month < 10
                 OR last_used_days_ago > 30
            THEN 'Underutilized'
            ELSE 'Active'
        END AS subscription_status
    FROM ott_dataset
)

SELECT
    subscription_status,
    COUNT(*) AS total_subscriptions,
    SUM(monthly_cost) AS total_monthly_spend
FROM subscription_status_cte
GROUP BY subscription_status;

#--------------------------------------------------------------------------------------------
/*
====================================================
QUESTION 21:
What is the potential monthly savings by platform?
====================================================

APPROACH:

Step 1:
Select the table.

FROM ott_dataset

Step 2:
Group data platform-wise.

GROUP BY platform

Step 3:
Identify only underutilized subscriptions using CASE WHEN.

Business rule:

watch_hours_per_month < 10
OR
last_used_days_ago > 30

Step 4:
For underutilized subscriptions, take monthly_cost.

Step 5:
For active subscriptions, take 0.

Step 6:
Add all underutilized monthly costs using SUM().

This gives possible savings.

----------------------------------------------------
INSIGHT:
----------------------------------------------------

This shows where users can save the most money.

If Netflix has highest potential savings, it means many expensive Netflix plans are underused.

----------------------------------------------------
BUSINESS UNDERSTANDING:
----------------------------------------------------

Potential savings means money users can save by cancelling, pausing, or downgrading unused subscriptions.

This directly connects SQL analysis to business value.

----------------------------------------------------
BUSINESS ACTION:
----------------------------------------------------

For customers:

1. Cancel unused high-cost platforms
2. Downgrade premium plans
3. Keep only actively used platforms

For OTT companies:

1. Offer downgrade option instead of full cancellation
2. Send personalized engagement campaigns
3. Create cheaper retention plans
4. Improve content recommendation
====================================================
*/

SELECT
    platform,
    COUNT(*) AS total_subscriptions,
    COUNT(
        CASE
            WHEN watch_hours_per_month < 10
                 OR last_used_days_ago > 30
            THEN 1
        END
    ) AS underutilized_subscriptions,
    SUM(
        CASE
            WHEN watch_hours_per_month < 10
                 OR last_used_days_ago > 30
            THEN monthly_cost
            ELSE 0
        END
    ) AS potential_monthly_savings
FROM ott_dataset
GROUP BY platform
ORDER BY potential_monthly_savings DESC;




#---------------------------------------THE END-----------------------------------------------------
