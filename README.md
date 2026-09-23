# FinTech Transaction & Customer Risk Analytics

## Project Overview

This project analyzes financial transaction data to understand transaction performance, customer behavior, and fraud patterns using SQL and Power BI.

The project uses MySQL for data analysis and Power BI for interactive dashboard visualization.

## Dataset

- Dataset: Indian Banking Transactions
- Total Transactions: 550,000
- Unique Customers: 79,916
- Date Range: 2019–2024
- Fraudulent Transactions: 4,873

The raw dataset is included in:

`data/raw/indian_banking_transactions.csv`

## Tools & Technologies

- MySQL
- SQL
- Power BI
- Excel
- Git & GitHub

## SQL Analysis

The SQL analysis covers:

- Transaction volume and transaction value
- Transaction status analysis
- Channel performance
- Transaction type analysis
- Monthly transaction trends
- Customer transaction activity
- Customer transaction value
- Failed transactions
- Fraud transaction analysis
- Fraud rate by channel
- Fraud by transaction type
- High-value fraudulent transactions
- Fraud patterns by transaction hour

SQL concepts used include:

- Aggregations
- GROUP BY
- HAVING
- CASE statements
- JOINs
- Subqueries
- CTEs
- Window Functions
- Date Functions
- Conditional Aggregation

## Power BI Dashboard

The interactive dashboard includes:

- Total Transactions
- Fraud Transactions
- Total Transaction Value
- Average Transaction Value
- Monthly Transaction Volume
- Transaction Status Distribution
- Transaction Volume by Channel
- Transaction Volume by Transaction Type
- Top 10 Customers by Transaction Volume
- Fraudulent Transactions by Channel
- Fraudulent Transactions by Transaction Type
- Risk & Performance Summary

### Dashboard KPIs

- Total Transactions: 550K
- Fraud Transactions: 4,873
- Total Transaction Value: 16.45bn
- Average Transaction Value: 29.91K


## Dashboard Preview

<img src="images/dashboard.png" alt="FinTech Transaction & Customer Risk Analytics Dashboard" width="100%">

## Project Structure 

```text
FinTech-Transaction-Risk-Analytics/
│
├── data/
│   └── raw/
│       └── indian_banking_transactions.csv
│
├── powerbi/
│   └── FinTech_Transaction_Customer_Risk_Analytics.pbix
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_basic_analysis.sql
│   └── 03_transaction_analysis.sql
│
└── README.md


## How to Use

1. Download or clone this repository.
2. Import the CSV dataset into MySQL.
3. Run `01_database_setup.sql`.
4. Run the analysis queries in `02_basic_analysis.sql` and `03_transaction_analysis.sql`.
5. Open the Power BI `.pbix` file to explore the dashboard.

## Project Objective

The objective of this project is to demonstrate practical skills in SQL-based data analysis, customer analytics, fraud analysis, and Power BI dashboard development.
