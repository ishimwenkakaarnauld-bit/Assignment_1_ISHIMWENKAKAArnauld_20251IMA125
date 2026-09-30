
# PL/SQL Assignment One: Sunrise Supermarket

- **Student name:** ISHIMWE NKAKA Arnauld
- **Student ID:** 20251IMA125
  
- **DBMS used:** Oracle FreeSQL (Oracle Database 26ai)
  - **Repo name:** `Assignment_1_ISHIMWENKAKAArnauld_20251IMA125`

## Business scenario

Sunrise Supermarket is a shop that sells everyday products like rice, milk, juice and soap. Customers buy from it by placing orders, and each order can have one or more items. The owners want clear answers to three questions: who are our customers, what are they buying, and are our sales going up or down over time?

To answer these, I built a small database with four tables: `customers`, `products`, `orders` and `order_items`. I filled it with sample data for 6 customers (one of them has never bought anything), 8 products in 4 categories (Grocery, Dairy, Beverages and Household), 15 orders placed between January and May 2026, and 25 order items. Then I wrote SQL queries using JOINs, a CTE and window functions to find the answers.

## How to run

1. Open Oracle FreeSQL (freesql.com) and go to the Worksheet.
2. Run `01_schema.sql` to create the tables.
3. Run `02_data.sql` to insert the sample data and commit.
4. Run each query in `03_queries.sql` one at a time (highlight a query and press Ctrl + Enter) and check the Query Result tab.

## Queries

> Full SQL for every query is in `03_queries.sql`.

### Q1. Orders with customer name, city and date (INNER JOIN)

Links each order to the customer who placed it. Only orders with a matching customer appear, so all 15 orders are listed with the customer's name and city.

<img width="568" height="358" alt="q1 png" src="https://github.com/user-attachments/assets/f75f0af7-9342-428a-980c-05a30db5da52" />


### Q2. Order items with product details (JOIN)

Shows what was bought on each order line, with the product name, category, price and quantity ordered. This is the base for calculating revenue later.

<img width="429" height="383" alt="q2 png" src="https://github.com/user-attachments/assets/6bc225b9-a62d-4f82-819a-c0da0d1efb81" />


### Q3. All customers and their orders (LEFT JOIN)

Keeps every customer, even those with no orders. **Patrick Nsengiyumva** appears with NULL order columns because he has never placed an order.

<img width="322" height="293" alt="q3 png" src="https://github.com/user-attachments/assets/4ae780d7-39f0-49c9-b679-34ee75c14ef0" />


### Q4. Customers who spent above average (CTE)

A CTE (`customer_totals`) first calculates each customer's total spend (quantity x price, summed across all their order items). The main query then keeps only customers above the average of those totals.

| Customer       | Total spent (RWF) |
| -------------- | ----------------- |
| Alice Uwase    | 61,200            |
| Eric Mugisha   | 60,700            |
| Grace Ingabire | 45,100            |

Average customer spend = 42,860 (among customers who placed orders).

<img width="583" height="239" alt="q4 png" src="https://github.com/user-attachments/assets/bfd26d83-cd0e-41b2-9450-b74e2df2b3e4" />


### Q5. Rank customers by total spent (RANK)

Uses `RANK() OVER (ORDER BY total_spent DESC)` on the CTE totals, so the biggest spender is ranked 1.

| Rank | Customer             | Total spent (RWF) |
| ---- | -------------------- | ----------------- |
| 1    | Alice Uwase          | 61,200            |
| 2    | Eric Mugisha         | 60,700            |
| 3    | Grace Ingabire       | 45,100            |
| 4    | Jean Claude Habimana | 28,700            |
| 5    | Diane Mukamana       | 18,600            |

<img width="536" height="288" alt="q5 png" src="https://github.com/user-attachments/assets/27ed3e83-614b-4556-9a86-b98e730dcbe9" />


### Q6. Number each customer's orders (ROW_NUMBER)

`ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date, order_id)` restarts at 1 for each customer, giving their 1st, 2nd, 3rd order and so on in the order they were placed.

<img width="329" height="272" alt="q6 png" src="https://github.com/user-attachments/assets/50c362fc-11a6-45a0-a812-5cb6ef66615d" />


### Q7. Running total of revenue (SUM OVER)

Order revenue is calculated in a CTE, then `SUM(order_total) OVER (ORDER BY order_date, order_id ...)` accumulates it. Revenue grows from 16,600 RWF (5 January) to **214,300 RWF** by 20 May 2026.

<img width="405" height="308" alt="q7 png" src="https://github.com/user-attachments/assets/fbfd588c-0797-4386-bb20-dc74525e9adf" />


### Q8. Days between consecutive orders (LAG)

`LAG(order_date)` per customer gives the previous order date. Subtracting it from the current order date gives the gap in days. First orders are excluded, so only customers with two or more orders appear.

| Customer             | Order | Days since previous |
| -------------------- | ----- | ------------------- |
| Alice Uwase          | 4     | 29                  |
| Alice Uwase          | 8     | 29                  |
| Alice Uwase          | 13    | 55                  |
| Diane Mukamana       | 12    | 48                  |
| Eric Mugisha         | 6     | 37                  |
| Eric Mugisha         | 11    | 43                  |
| Eric Mugisha         | 15    | 48                  |
| Grace Ingabire       | 9     | 54                  |
| Grace Ingabire       | 14    | 55                  |
| Jean Claude Habimana | 10    | 40                  |

<img width="543" height="295" alt="q8 png" src="https://github.com/user-attachments/assets/f7638139-c8dc-474a-bcf9-ea5c33dc32dc" />


## Business interpretation

- **Best customers:** Alice (61,200 RWF) and Eric (60,700 RWF) spend the most, then Grace (45,100 RWF). Only these three spend more than the average of 42,860 RWF. Alice and Eric together bring in more than half of all sales (214,300 RWF), so the shop should reward them to keep them.
- **Customer who never bought:** Patrick has signed up but never ordered. A welcome discount could get him to buy.
- **Sales:** Total sales keep growing from January to May. March was the best month (56,400 RWF), so management should find out why and repeat it.
- **How often people buy:** Every customer who ordered came back at least once. But they wait about 44 days between orders, which is a long time for a supermarket. Reminders or weekly offers could bring them back sooner.

## Challenges and solutions

- **Oracle would not install.** My first attempt was the full Oracle 21c installer on my laptop, and it stopped at step 4 with error INS-30014 ("Unable to check whether the location specified is on CFS").
  
- **Making Patrick show up.** I wanted one customer who had never ordered, to prove the LEFT JOIN works. A normal join would have left Patrick out completely, so Q3 uses a LEFT JOIN and his order columns come back empty.
- **What counts as the "average customer"?** Q4 asks for people who spent more than the average, but you can't put an average of totals straight into a grouped query. I solved this by using a CTE to work out each customer's total first, then comparing against the average of those totals. Since only customers with orders appear in the CTE, Patrick is left out of the average, which I think gives a fairer picture of real buyers.
- **Orders on the same day.** Two orders on one date could come out in a different order each time. Adding `order_id` after `order_date` in the window functions keeps the results stable.
  
