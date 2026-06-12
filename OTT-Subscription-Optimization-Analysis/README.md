# OTT Subscription Optimization Analysis(SQL Case Study)

<p align="center">
  <img src="https://github.com/HackThePath/SQL/blob/be57be1b904338d14505aba972d2745983628820/OTT-Subscription-Optimization-Analysis/img.webp" width="100%">
</p>

## Business Problem

Many users subscribe to multiple OTT platforms but do not actively use all of them. This leads to unnecessary monthly spending and poor subscription utilization.

The objective of this project is to identify underutilized subscriptions, understand customer behavior, analyze platform performance, and estimate potential cost-saving opportunities using SQL.

---

# Dataset Overview

The dataset contains:

* User Information

  * User ID
  * User Name
  * Age
  * Gender
  * City
  * Income Group

* Subscription Information

  * OTT Platform
  * Plan Type
  * Monthly Cost
  * Watch Hours Per Month
  * Last Used Days Ago
  * Payment Method
  * Auto Renewal Status

---

# Analysis Performed

### 1. Understanding Dataset Structure

### Question

What does the dataset look like?

### SQL Query

```sql
SELECT *
FROM ott_dataset
LIMIT 10;
```

### Sample Output

| user_id | user_name    | platform     | monthly_cost |
| ------- | ------------ | ------------ | ------------ |
| 1       | Aarav Sharma | Netflix      | 649          |
| 2       | Vivaan Patel | Hotstar      | 299          |
| 3       | Aditya Verma | Amazon Prime | 149          |

### Insight

* Dataset contains customer details, platform information, subscription costs, and usage behavior.
* Data was successfully imported and ready for analysis.

### Business Action

* Validate dataset before performing business analysis.

---

## 2. Customer Base Analysis

### Question

How many unique users are present?

### SQL Query

```sql
SELECT COUNT(DISTINCT user_id) AS total_users
FROM ott_dataset;
```

### Sample Output

| total_users |
| ----------- |
| 250         |

### Insight

* 250 unique customers are using OTT platforms.
* Many customers own multiple subscriptions.

### Business Action

* Separate customer-level analysis from subscription-level analysis.

---

## 3. Subscription Ownership Analysis

### Question

How many OTT subscriptions does each customer own?

### SQL Query

```sql
SELECT
    user_id,
    user_name,
    COUNT(subscription_id) AS total_subscriptions
FROM ott_dataset
GROUP BY user_id,user_name;
```

### Insight

* Several customers subscribe to multiple OTT platforms.
* Multi-subscription users have higher monthly spending.

### Business Action

* Recommend bundled plans and subscription optimization opportunities.

---

## 4. Platform Popularity Analysis

### Question

Which OTT platform is most popular?

### SQL Query

```sql
SELECT
    platform,
    COUNT(*) AS total_subscriptions
FROM ott_dataset
GROUP BY platform
ORDER BY total_subscriptions DESC;
```

### Sample Output

| Platform     | Total Subscriptions |
| ------------ | ------------------- |
| Netflix      | 120                 |
| Hotstar      | 95                  |
| Amazon Prime | 88                  |

### Insight

* Netflix has the largest subscriber base.
* Platform popularity differs significantly across OTT services.

### Business Action

* Invest more in high-performing platforms.
* Improve engagement on lower-performing platforms.

---

## 5. Revenue Analysis

### Question

Which OTT platform generates the highest revenue?

### SQL Query

```sql
SELECT
    platform,
    SUM(monthly_cost) AS total_revenue
FROM ott_dataset
GROUP BY platform
ORDER BY total_revenue DESC;
```

### Insight

* Revenue contribution varies by platform.
* Most popular platform is not always the highest revenue platform.

### Business Action

* Prioritize customer retention on high-revenue platforms.
* Improve monetization strategies on low-revenue platforms.

---

## 6. Subscription Utilization Analysis

### Question

Which subscriptions are underutilized?

### SQL Query

```sql
SELECT
    user_name,
    platform,
    watch_hours_per_month,
    last_used_days_ago,
    CASE
        WHEN watch_hours_per_month < 10
             OR last_used_days_ago > 30
        THEN 'Underutilized'
        ELSE 'Active'
    END AS subscription_status
FROM ott_dataset;
```

### Business Rule

A subscription is considered underutilized if:

* Watch Hours Per Month < 10

OR

* Last Used Days Ago > 30

### Insight

* Many customers continue paying for subscriptions they rarely use.

### Business Action

* Recommend cancellation, downgrade, or reactivation campaigns.

---

## 7. Underutilization KPI

### Question

What percentage of subscriptions are underutilized?

### SQL Query

```sql
SELECT
ROUND(
COUNT(
CASE
WHEN watch_hours_per_month < 10
OR last_used_days_ago > 30
THEN 1
END
) * 100.0 / COUNT(*),2)
AS underutilized_percentage
FROM ott_dataset;
```

### Sample Output

| Underutilized Percentage |
| ------------------------ |
| 45.23%                   |

### Insight

* Nearly half of all subscriptions are not actively used.

### Business Action

* Improve customer engagement.
* Reduce unnecessary subscription spending.

---

## 8. Customer Segmentation Analysis

### Question

Which income groups and age groups spend the most on OTT subscriptions?

### Insight

* Spending behavior differs across customer segments.
* Premium plans are more common among higher-spending groups.

### Business Action

* Design targeted pricing strategies.
* Offer personalized subscription plans.

---

## 9. Top Spending Customers

### Question

Who are the highest spending customers?

### SQL Query

```sql
SELECT
    user_id,
    user_name,
    SUM(monthly_cost) AS total_monthly_spend
FROM ott_dataset
GROUP BY user_id,user_name
ORDER BY total_monthly_spend DESC
LIMIT 10;
```

### Insight

* Small group of users contributes significant revenue.

### Business Action

* Provide loyalty rewards.
* Improve retention strategies for premium customers.

---

## 10. Potential Savings Analysis

### Question

How much money can customers save by cancelling underutilized subscriptions?

### SQL Query

```sql
SELECT
    platform,
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
```

### Insight

* Significant monthly savings opportunities exist across OTT platforms.
* Some expensive subscriptions are frequently underutilized.

### Business Action

* Recommend subscription optimization.
* Suggest plan downgrades before cancellation.

---

# Key Insights

* Multiple customers subscribe to more than one OTT platform.
* Significant subscription waste exists due to low platform usage.
* Platform popularity and revenue contribution differ.
* High-value customers contribute a major portion of revenue.
* Underutilized subscriptions create strong savings opportunities.
* Customer behavior varies across age, city, and income groups.

---

# Business Recommendations

* Cancel or downgrade underutilized subscriptions.
* Improve customer engagement using personalized recommendations.
* Offer bundled subscription plans.
* Retain premium customers through loyalty programs.
* Use customer segmentation for targeted marketing.
* Reduce churn using re-engagement campaigns.

---

# SQL Skills Demonstrated

* Data Exploration
* Aggregations (COUNT, SUM, AVG)
* DISTINCT
* GROUP BY
* ORDER BY
* CASE WHEN
* Customer Segmentation
* Revenue Analysis
* Subscription Optimization
* Business KPI Development
* Cost Saving Analysis

---

# Conclusion

This SQL case study analyzed OTT subscription behavior for 250 customers and 450+ subscription records.

The analysis identified underutilized subscriptions, platform performance trends, customer spending patterns, and potential savings opportunities. The insights can help customers reduce unnecessary spending while enabling OTT companies to improve engagement, retention, and revenue generation.

