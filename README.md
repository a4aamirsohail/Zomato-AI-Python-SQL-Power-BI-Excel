## Zomato-AI-Python-SQL-Power-BI-Excel Project

This project is a comprehensive analysis of Zomato food delivery data using Python, SQL, Power BI, and Excel. The goal is to extract actionable insights about customer behavior, restaurant performance, cuisine popularity, and delivery trends.

## Platforms Used

## Zomato-AI-Python-SQL-Power-BI-Excel Project

![Zomato Logo](zomato-logo-full.jpg)

This project is a comprehensive analysis of Zomato food delivery data using Python, SQL, Power BI, and Excel. The goal is to extract actionable insights about customer behavior, restaurant performance, cuisine popularity, and delivery trends.

- **Python (Jupyter Notebook):** Data cleaning, exploration, and visualization.
- **SQL:** Data cleaning, querying, and aggregation.
- **Power BI:** Interactive dashboards and reports.
- **Excel:** Tabular summaries and quick calculations.

---

## Data Cleaning Examples

### SQL Data Cleaning

Below is an example of how data is cleaned using SQL in this project:

```sql
-- Remove duplicate rows
DELETE FROM Zomato
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM Zomato
    GROUP BY Order_ID
);

-- Handle missing values
UPDATE Zomato
SET Customer_Name = 'Unknown'
WHERE Customer_Name IS NULL;

-- Standardize payment method values
UPDATE Zomato
SET Payment_Method = 'Online'
WHERE Payment_Method IN ('online', 'Online Payment', 'E-Payment');
```

### Python Data Cleaning

Here’s a sample of Python code used for data cleaning in the Jupyter Notebook:

```python
import pandas as pd

df = pd.read_csv('Zomato.csv')

# Remove duplicates
df = df.drop_duplicates(subset='Order_ID')

# Fill missing customer names
df['Customer_Name'] = df['Customer_Name'].fillna('Unknown')

# Standardize payment method values
df['Payment_Method'] = df['Payment_Method'].replace(
    ['online', 'Online Payment', 'E-Payment'], 'Online'
)
```

---

## Visualizations

Key insights and trends are visualized using Power BI and Python. Example PNG visualizations are included in the project:

- `Top_Cuisines.png`
- `Order_Trends.png`
- `Delivery_Performance.png`

---

## Insights

- Most popular cuisines and items.
- Top-performing restaurants.
- Customer feedback and ratings analysis.
- Delivery time and cancellation trends.
- Impact of discounts on sales.

---

## How to Use

1. Explore and clean data with Python (`Zomato.ipynb`).
2. Run SQL queries for deeper analysis (`Zomato Data Analysis.sql`).
3. View interactive dashboards in Power BI (`Zomato.pbix`).
4. Check summary tables and charts in Excel.

---

This project demonstrates a multi-platform approach to food delivery data analysis, enabling robust and actionable insights.

```git
git init
```
