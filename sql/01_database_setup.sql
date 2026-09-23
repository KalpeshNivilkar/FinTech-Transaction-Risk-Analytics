SET GLOBAL local_infile = 1;

CREATE DATABASE fintech_analytics;

USE fintech_analytics;

CREATE TABLE transactions (
    transaction_id VARCHAR(50),
    customer_id VARCHAR(50),
    transaction_date DATE,
    transaction_time TIME,
    account_type VARCHAR(50),
    transaction_type VARCHAR(50),
    transaction_amount DECIMAL(15,2),
    transaction_direction VARCHAR(20),
    account_balance DECIMAL(15,2),
    merchant_category VARCHAR(100),
    state VARCHAR(100),
    credit_score INT,
    has_loan VARCHAR(10),
    loan_type VARCHAR(100),
    emi_amount DECIMAL(15,2),
    transaction_status VARCHAR(30),
    channel VARCHAR(50),
    kyc_status VARCHAR(30),
    is_fraud TINYINT,
    transaction_hour INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/indian_banking_transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;