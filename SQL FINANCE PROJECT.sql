CREATE DATABASE FINANCE_DB;

USE FINANCE_DB;

CREATE TABLE FINANCIAL_DATA (
ID INT PRIMARY KEY AUTO_INCREMENT,
GENDER VARCHAR(10),
AGE INT,
INVESTMENT_AVENUES VARCHAR(10),
INVESTED_AMT DECIMAL(10,2),
MUTUAL_FUND INT,
EQUITY INT,
DEBENTURE INT,
GOVT_BONDS INT,
FD INT,
PPF INT,
GOLD INT,
RISK_LEVEL VARCHAR(20),
PURPOSE VARCHAR(100),
DURATION VARCHAR(20),
INVESTMENT_MONITOR VARCHAR(50),
EXPECTED_RETURN INT,
AVENUE VARCHAR(50),
SAVING_OBJ VARCHAR(100)
);


INSERT INTO FINANCIAL_DATA 
(ID, GENDER, AGE, INVESTMENT_AVENUES, INVESTED_AMT, MUTUAL_FUND, EQUITY, DEBENTURE, GOVT_BONDS, FD, PPF, GOLD, RISK_LEVEL, PURPOSE, DURATION, INVESTMENT_MONITOR, EXPECTED_RETURN, AVENUE, SAVING_OBJ)
VALUES
(1, 'Male', 25, 'Mutual Fund', 15000.00, 1, 0, 0, 0, 0, 0, 0, 'High Risk', 'Retirement Plan', '10 years', 'Monthly', 12, 'Wealth Growth', 'High Return'),
(2, 'Female', 30, 'Equity', 25000.00, 0, 1, 0, 0, 0, 0, 0, 'High Risk', 'Education', '5 years', 'Quarterly', 15, 'Capital Appreciation', 'Investment'),
(3, 'Male', 40, 'FD', 50000.00, 0, 0, 0, 0, 1, 0, 0, 'Low Risk', 'Pension', '15 years', 'Yearly', 6, 'Fixed Income', 'Safety'),
(4, 'Female', 35, 'PPF', 20000.00, 0, 0, 0, 0, 0, 1, 0, 'Medium Risk', 'Healthcare', '20 years', 'Yearly', 8, 'Tax Saving', 'Savings'),
(5, 'Male', 28, 'Gold', 30000.00, 0, 0, 0, 0, 0, 0, 1, 'Medium Risk', 'Marriage', '7 years', 'Monthly', 10, 'Hedge Against Inflation', 'Safety'),
(6, 'Female', 45, 'Govt Bonds', 40000.00, 0, 0, 0, 1, 0, 0, 0, 'Low Risk', 'Retirement Plan', '12 years', 'Quarterly', 7, 'Stable Returns', 'Savings'),
(7, 'Male', 55, 'Debenture', 60000.00, 0, 0, 1, 0, 0, 0, 0, 'Medium Risk', 'Healthcare', '8 years', 'Monthly', 9, 'Corporate Debt', 'Investment'),
(8, 'Female', 22, 'Mutual Fund', 12000.00, 1, 0, 0, 0, 0, 0, 0, 'High Risk', 'Education', '3 years', 'Weekly', 14, 'Wealth Growth', 'High Return'),
(9, 'Male', 60, 'FD', 70000.00, 0, 0, 0, 0, 1, 0, 0, 'Low Risk', 'Pension', '10 years', 'Yearly', 6, 'Fixed Income', 'Safety'),
(10, 'Female', 50, 'PPF', 35000.00, 0, 0, 0, 0, 0, 1, 0, 'Medium Risk', 'Retirement Plan', '15 years', 'Quarterly', 8, 'Tax Saving', 'Savings');

ALTER TABLE FINANCIAL_DATA 
MODIFY INVESTMENT_AVENUES VARCHAR(100);

SELECT * FROM FINANCIAL_DATA;

-- 1.	Count total records in the dataset.
SELECT COUNT(*) AS TOTAL_RECORDS
FROM FINANCIAL_DATA;

-- 2.	Find distinct investment avenues.
SELECT distinct(INVESTMENT_AVENUES)
FROM FINANCIAL_DATA;

-- 3.	Calculate average age by gender.
SELECT GENDER, AVG(AGE) AS AVG_AGE
FROM FINANCIAL_DATA
group by GENDER;

-- 4.	Count number of investors for each avenue.
SELECT INVESTMENT_AVENUES, COUNT(*)
FROM FINANCIAL_DATA
GROUP BY INVESTMENT_AVENUES;

-- 5.	Find most preferred investment option.
SELECT INVESTMENT_AVENUES, COUNT(*) AS total_investors
FROM FINANCIAL_DATA
GROUP BY INVESTMENT_AVENUES
ORDER BY total_investors DESC
LIMIT 1;

-- 6.	Retrieve records where age < 30.
SELECT GENDER,AGE
FROM FINANCIAL_DATA
WHERE AGE>=30;

-- 7.	Count investors whose objective is “Safety”.
SELECT GENDER, COUNT(SAVING_OBJ)
FROM FINANCIAL_DATA
WHERE SAVING_OBJ="SAFETY"
GROUP BY GENDER;

-- 8.	Display top 4 most common savings objectives.
SELECT SAVING_OBJ, COUNT(*) AS total_count
FROM FINANCIAL_DATA
GROUP BY SAVING_OBJ
ORDER BY total_count DESC
LIMIT 4;


-- 10.	Find number of investors choosing Fixed Deposits.
SELECT GENDER, COUNT(ID)
FROM FINANCIAL_DATA
WHERE INVESTMENT_AVENUES="FD"
GROUP BY GENDER;

-- TASK 2


-- 1.	Group investors by age range and investment avenue.
SELECT 
CASE
WHEN AGE BETWEEN 18 AND 30 THEN '18-30'
WHEN AGE BETWEEN 31 AND 45 THEN '31-45'
WHEN AGE BETWEEN 46 AND 60 THEN '46-60'
ELSE '61-65'
END AS AGE_RANGE, INVESTMENT_AVENUES,COUNT(*) AS TOTAL_INV
FROM FINANCIAL_DATA
GROUP BY AGE_RANGE,INVESTMENT_AVENUES
ORDER BY AGE_RANGE, TOTAL_INV DESC;

-- 2.	Calculate percentage contribution of each avenue.
SELECT INVESTMENT_AVENUES,
       ROUND(SUM(INVESTED_AMT) * 100 / SUM(SUM(INVESTED_AMT)) OVER(),2) AS percentage_contribution
FROM FINANCIAL_DATA
GROUP BY INVESTMENT_AVENUES;

-- 3.	Compare average age for Equity vs Fixed Deposit investors.
SELECT INVESTMENT_AVENUES, AVG(AGE) AS AVG_AGE 
FROM FINANCIAL_DATA
WHERE INVESTMENT_AVENUES IN ('EQUITY','FD')
GROUP BY INVESTMENT_AVENUES;

-- 5.	Analyse purpose vs duration of investment.
SELECT PURPOSE, DURATION , COUNT(*) AS TOTAL_INVESTORS
FROM FINANCIAL_DATA
GROUP BY PURPOSE , DURATION
ORDER BY PURPOSE, TOTAL_INVESTORS;

-- 6.	Rank investment avenues by popularity.
SELECT INVESTMENT_AVENUES, COUNT(*) AS total_investors
FROM FINANCIAL_DATA
GROUP BY INVESTMENT_AVENUES
ORDER BY total_investors DESC;

-- 7.	Count investors monitoring investments frequently.
SELECT GENDER, COUNT(INVESTMENT_MONITOR) 
FROM FINANCIAL_DATA
WHERE INVESTMENT_MONITOR='YEARLY'
GROUP BY GENDER;

-- 8.	Find correlation between objective and avenue.
SELECT SAVING_OBJ,AVENUE, COUNT(*)
FROM FINANCIAL_DATA
GROUP BY SAVING_OBJ,AVENUE;

-- 9.	Identify top reason for Mutual Fund investment.
SELECT PURPOSE, COUNT(*) AS total_investors
FROM FINANCIAL_DATA
WHERE INVESTMENT_AVENUES = 'Mutual Fund'
GROUP BY PURPOSE
ORDER BY total_investors DESC
LIMIT 1;

-- 10.	Create a view for long-term investors.
CREATE VIEW LONG_TERM_INV AS
SELECT DURATION
FROM FINANCIAL_DATA
WHERE DURATION>=10;

SELECT * FROM LONG_TERM_INV;

-- TASK 3

-- 1.	Create CTEs(COMMON TABLE EXPRESSION) for investor segmentation.
WITH AgeSegments AS (
    SELECT ID, AGE,
           CASE 
               WHEN AGE BETWEEN 18 AND 30 THEN 'Young'
               WHEN AGE BETWEEN 31 AND 50 THEN 'Middle-aged'
               ELSE 'Senior'
           END AS AgeGroup
    FROM FINANCIAL_DATA
)
SELECT AgeGroup, COUNT(*) AS total_investors
FROM AgeSegments
GROUP BY AgeGroup;

-- 2.	Rank investors based on risk appetite.
SELECT ID, GENDER, RISK_LEVEL,
       RANK() OVER (ORDER BY 
           CASE RISK_LEVEL 
               WHEN 'High Risk' THEN 3
               WHEN 'Medium Risk' THEN 2
               WHEN 'Low Risk' THEN 1
           END DESC) AS risk_rank
FROM FINANCIAL_DATA;


-- 3.	Identify hidden trends using window functions.
SELECT GENDER, INVESTMENT_AVENUES, INVESTED_AMT,
       AVG(INVESTED_AMT) OVER (PARTITION BY INVESTMENT_AVENUES) AS avg_investment,
       INVESTED_AMT - AVG(INVESTED_AMT) OVER (PARTITION BY INVESTMENT_AVENUES) AS deviation
FROM FINANCIAL_DATA;

-- 4.	Build view for fast reporting.
CREATE VIEW InvestorSummary AS
SELECT INVESTMENT_AVENUES, RISK_LEVEL, PURPOSE, COUNT(*) AS total_investors
FROM FINANCIAL_DATA
GROUP BY INVESTMENT_AVENUES, RISK_LEVEL, PURPOSE;

SELECT * FROM INVESTORSUMMARY;

-- 5.	Perform cohort analysis based on age.
CREATE VIEW Summary AS
SELECT INVESTMENT_AVENUES, RISK_LEVEL, PURPOSE, COUNT(*) AS total_investors
FROM FINANCIAL_DATA
GROUP BY INVESTMENT_AVENUES, RISK_LEVEL, PURPOSE;


