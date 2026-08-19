# Ecommerce-Customer-Delivery-Analysis
---
## Project Overview
---
In high-volume e-commerce and retail logistics, shipping delays directly impact customer retention, support operational costs, and overall brand trust. 

This project investigates the operational drivers behind shipment delays and quantifies their downstream impact on customer experience. By querying customer demographic, shipping, and fulfillment data, this analysis seeks to answer:

1. **Root Causes of Delays:** Which shipment modes, product priority tiers, and warehouse facilities suffer the highest delay rates?
2. **Operational Prioritization:** Are high-importance orders receiving priority handling over standard orders?
3. **Downstream Business Impact:** How do shipment delays influence customer care call center volume and customer satisfaction

## Data Dictionary (`customer_analytics`)
---
The dataset contains transaction and fulfillment records for 10,999 customer orders.

| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| `ID` | `INT` (PK) | Unique customer tracking identifier |
| `Warehouse_block` | `VARCHAR(1)` | Fulfillment warehouse facility (`A`, `B`, `C`, `D`, `F`) |
| `Mode_of_Shipment` | `VARCHAR(10)`| Primary transit method (`Flight`, `Ship`, `Road`) |
| `Customer_care_calls` | `INT` | Number of inquiries logged with customer support |
| `Customer_rating` | `INT` | Customer satisfaction rating on a scale of 1 (Lowest) to 5 (Highest) |
| `Cost_of_the_Product` | `INT` | Product retail value (USD) |
| `Prior_purchases` | `INT` | Lifetime order count prior to current shipment |
| `Product_importance` | `VARCHAR(10)`| Business priority tier (`low`, `medium`, `high`) |
| `Gender` | `VARCHAR(1)` | Customer gender (`M`, `F`) |
| `Discount_offered` | `INT` | Discount percentage applied to order |
| `Weight_in_gms` | `INT` | Package weight in grams |
| `Reached_on_Time` | `INT` (Binary) | Delivery outcome indicator (`0` = On-Time, `1` = Delayed) |
