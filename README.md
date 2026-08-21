# E-Commerce Customer Delivery Analysis

An end-to-end SQL analysis examining shipping delays, shipment methods, warehouse performance, and their relationship with customer care calls and customer ratings.

---

## Project Overview

This project investigates the factors associated with delivery delays across 10,999 customer shipment records. Using PostgreSQL, the analysis answers core operational questions regarding warehouse throughput, transportation efficiency, order priority, and customer service call volume.

### Core Questions Addressed:
1. Do delayed deliveries result in a higher number of customer care calls?
2. What is the most common mode of shipment for each warehouse?
3. How do delivery status and calls relate to customer ratings across warehouses?
4. What are the on-time and delay percentages across product importance levels?
5. Is there a relationship between the number of customer care calls and customer ratings?
6. How does each warehouse block perform in terms of on-time delivery rates and ratings?
7. What are the on-time and delay percentages across each mode of shipment?

---

## Data Dictionary (`customer_analytics`)

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `ID` | `INT` | Unique customer tracking identifier |
| `Warehouse_block` | `VARCHAR` | Warehouse facility (`A`, `B`, `C`, `D`, `F`) |
| `Mode_of_Shipment` | `VARCHAR` | Shipment method (`Flight`, `Ship`, `Road`) |
| `Customer_care_calls` | `INT` | Number of customer care calls made |
| `Customer_rating` | `INT` | Customer rating score (1 to 5) |
| `Cost_of_the_Product` | `INT` | Product cost in USD |
| `Prior_purchases` | `INT` | Number of prior purchases by customer |
| `Product_importance` | `VARCHAR` | Product importance tier (`low`, `medium`, `high`) |
| `Gender` | `VARCHAR` | Customer gender (`M`, `F`) |
| `Discount_offered` | `INT` | Discount percentage offered |
| `Weight_in_gms` | `INT` | Product weight in grams |
| `Reached_on_Time` | `INT` | Delivery status (`0` = On-Time, `1` = Delayed) |

---

## Key Findings

* **Customer Care Calls Increase with Delays:** Delivery Delays Do Not Drive Support Calls: On-time deliveries average slightly more calls per order (4.15 calls) than delayed deliveries (3.99 calls). High call volumes are steady across all orders regardless of fulfillment outcome, indicating support inquiries stem from general order inquiries rather than delay escalations.
* **Ship is the Dominant Mode:** Across every warehouse block (A, B, C, D, and F), `Ship` is the most common mode of transportation by volume.
* **Product Importance Does Not Prevent Delays:** High-importance products have roughly the same delay rate (~60%) as medium and low-importance products, showing that high-value orders are not being fast-tracked.
* **Consistent Warehouse Performance:** All warehouse blocks perform similarly, with on-time delivery rates hovering around 40% and delayed rates around 60%.
* **Delays Outpace On-Time Deliveries Across All Modes:** Across every transit method, late deliveries significantly outnumber on-time deliveries. `Flight` has the highest delay rate at **60.16%**, followed by `Ship` at **59.76%** (which handles 67.8% of all volume), and `Road` at **58.81%**. This demonstrates that fulfillment bottlenecks are systemic across the entire logistics network rather than isolated to one transport type.

---

## Business Recommendations

* **Prioritize High-Importance Items:** Create an expedited fulfillment process in the warehouse for `high` importance products to ensure they are packed and shipped first.
* **Prepare Support Staff for Delays:** Increase customer care staff availability during peak shipping periods to handle the higher volume of calls caused by delayed orders.
* **Review Shipping Partnerships:** Work with delivery carriers to identify why around 60% of shipments across all modes (Flight, Road, and Ship) are experiencing delays.

---

## Project Structure

```text
├── README.md                           # Project summary and key findings
├── sql/
│   ├── 01_schema_setup.sql             # Table creation and data loading
│   └── 02_analytical_queries.sql       # 8 SQL analysis queries
└── data/
    └── customer_analytics.csv          # Raw dataset
