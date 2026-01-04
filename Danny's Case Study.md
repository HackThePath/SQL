# SQL Case Study 01 – Danny’s Diner
<img src="https://github.com/HackThePath/Images/blob/4bc69459b0f15307f2aa348d508efadb5eebfde7/Danny%20case%20study%20pic.png">

**Solved and Documented by Karishma Ravindran**

---

## Overview

This case study is part of my **SQL learning journey**, where I practice solving **real-world business problems** using SQL.

My objective is not only to write queries, but to:

* Understand the business requirement
* Select the appropriate SQL concepts
* Clearly explain the logic behind each solution
* Interpret results from a **data analyst’s perspective**

**Dataset Source:** 8 Week SQL Challenge – Case Study 1 (Danny’s Diner)

---

## Business Problem

Danny runs a small restaurant and wants to better understand:

* Customer visit behavior
* Spending patterns
* Popular menu items
* The effectiveness of a customer membership program

Using the available data, I answer business questions that help support **data-driven decision making**.

---

## Dataset Description

<img src="https://github.com/HackThePath/Images/blob/4bc69459b0f15307f2aa348d508efadb5eebfde7/Danny%20database%20desighn.png">

The database consists of the following tables:

* `sales` – records of customer orders
* `menu` – menu items and prices
* `members` – membership join dates

The tables are connected using `customer_id` and `product_id`.

---

## Questions, SQL Queries, and Insights

---

### 1. Total amount spent by each customer

**Business Question:**
How much money has each customer spent at the restaurant?

```sql
SELECT 
    s.customer_id,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
GROUP BY s.customer_id;
```

**Explanation:**

* Joined `sales` and `menu` to access pricing information
* Used `SUM(price)` to calculate total spending
* Grouped the data by customer

**Insight:**

* Customer A spent $76
* Customer B spent $74
* Customer C spent $36

Customer A is the highest spender.

---

### 2. Number of days each customer visited the restaurant

**Business Question:**
How often does each customer visit the restaurant?

```sql
SELECT 
    customer_id,
    COUNT(DISTINCT order_date) AS visit_days
FROM sales
GROUP BY customer_id;
```

**Explanation:**

* Used `COUNT(DISTINCT order_date)` to avoid counting multiple orders on the same day as multiple visits

**Insight:**

* Customer A visited 4 days
* Customer B visited 6 days
* Customer C visited 2 days

Customer B is the most frequent visitor.

---

### 3. First item purchased by each customer

**Business Question:**
What was the first menu item purchased by each customer?

```sql
SELECT customer_id, product_name
FROM (
    SELECT 
        s.customer_id,
        m.product_name,
        DENSE_RANK() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.order_date
        ) AS rnk
    FROM sales s
    JOIN menu m 
    ON s.product_id = m.product_id
) t
WHERE rnk = 1;
```

**Explanation:**

* Used a window function to identify first purchase dates
* Applied `DENSE_RANK()` because multiple items can be ordered on the same day

**Insight:**

* Customer A ordered curry and sushi on the same day
* Customer B first ordered curry
* Customer C first ordered ramen

---

### 4. Most purchased item overall

**Business Question:**
Which menu item was purchased the most?

```sql
SELECT 
    m.product_name,
    COUNT(*) AS order_count
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY order_count DESC
LIMIT 1;
```

**Insight:**

* Ramen is the most purchased item with 8 total orders.

---

### 5. Most popular item for each customer

**Business Question:**
Which menu item does each customer order the most?

```sql
SELECT customer_id, product_name, order_count
FROM (
    SELECT 
        s.customer_id,
        m.product_name,
        COUNT(*) AS order_count,
        DENSE_RANK() OVER (
            PARTITION BY s.customer_id 
            ORDER BY COUNT(*) DESC
        ) AS rnk
    FROM sales s
    JOIN menu m 
    ON s.product_id = m.product_id
    GROUP BY s.customer_id, m.product_name
) t
WHERE rnk = 1;
```

**Explanation:**

* Used `DENSE_RANK()` to allow multiple favorite items per customer when counts are equal

---

### 6. First purchase after becoming a member

**Business Question:**
What was the first item purchased after each customer became a member?

```sql
SELECT customer_id, product_name
FROM (
    SELECT 
        s.customer_id,
        m.product_name,
        ROW_NUMBER() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.order_date
        ) AS rn
    FROM sales s
    JOIN menu m 
    ON s.product_id = m.product_id
    JOIN members mb 
    ON s.customer_id = mb.customer_id
    WHERE s.order_date > mb.join_date
) t
WHERE rn = 1;
```

**Insight:**

* Customer A’s first member purchase was ramen
* Customer B’s first member purchase was sushi

---

### 7. Item purchased just before becoming a member

**Business Question:**
Which item was purchased immediately before membership?

```sql
SELECT customer_id, product_name
FROM (
    SELECT 
        s.customer_id,
        m.product_name,
        ROW_NUMBER() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.order_date DESC
        ) AS rn
    FROM sales s
    JOIN menu m 
    ON s.product_id = m.product_id
    JOIN members mb 
    ON s.customer_id = mb.customer_id
    WHERE s.order_date < mb.join_date
) t
WHERE rn = 1;
```

---

### 8. Total items and amount spent before membership

**Business Question:**
How many items and how much did each customer spend before becoming a member?

```sql
SELECT 
    s.customer_id,
    COUNT(*) AS total_items,
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
JOIN members mb 
ON s.customer_id = mb.customer_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id;
```

---

### 9. Loyalty points calculation

**Business Rule:**

* $1 spent = 10 points
* Sushi earns double points

```sql
SELECT 
    customer_id,
    SUM(
        CASE 
            WHEN product_name = 'sushi' THEN price * 20
            ELSE price * 10
        END
    ) AS points
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
GROUP BY customer_id;
```

---

### 10. Double points during the first week of membership

```sql
SELECT 
    customer_id,
    SUM(
        CASE 
            WHEN order_date BETWEEN join_date 
            AND DATE_ADD(join_date, INTERVAL 7 DAY) 
            THEN price * 20
            WHEN product_name = 'sushi' 
            THEN price * 20
            ELSE price * 10
        END
    ) AS total_points
FROM sales s
JOIN menu m 
ON s.product_id = m.product_id
JOIN members mb 
ON s.customer_id = mb.customer_id
WHERE MONTH(order_date) = 1
GROUP BY customer_id;
```

---

## Key Learnings

* Translating business questions into SQL queries
* Practical use of JOINs, aggregations, CASE statements, and window functions
* Importance of explaining logic clearly
* Thinking analytically rather than writing SQL mechanically



