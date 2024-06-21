Create database Bank_Analysis;
use bank_analysis;
select count(*) from finance_2;
select count(*) from finance_1;
-- KPI --
/*
> Year wise loan amount Stats
> Grade and sub grade wise revol_bal
> Total Payment for Verified Status Vs Total Payment for Non Verified Status
> State wise and month wise loan status
> Home ownership Vs last payment date stats
*/
select * from finance_1;
select * from finance_2;


-- KPI 1 --
select year(issue_D) as Year_of_issue_d , sum(loan_amnt) as Total_loan_amnt
from finance_1
group by Year_of_issue_d
order by Year_of_issue_d;

-- KPI 2 --
select
grade, sub_grade , sum(revol_bal) as total_revol_bal
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by grade , sub_grade
order by grade , sub_grade;

-- KPI 3 --
Select
finance_1.Verification_status,
ROUND(SUM(finance_2.total_pymnt)) as `Total Payment`
FROM finance_1
JOIN finance_2 ON finance_1.id = finance_2.id
WHERE finance_1.verification_status IN ('Verified', 'Not Verified')
GROUP BY finance_1.Verification_status;

-- KPI 4 --  
SELECT addr_state, last_credit_pull_d, MAX(loan_status) AS loan_status
FROM Finance_1
INNER JOIN Finance_2 ON Finance_1.id = Finance_2.id
GROUP BY addr_state, last_credit_pull_d
ORDER BY addr_state;


-- KPI 5 --
Select
YEAR(STR_TO_DATE(finance_2.last_pymnt_d, "%b-%yy")) as 'Years'
,finance_1.home_ownership
,round(sum(finance_2.last_pymnt_amnt)) as 'Total_Payment'
from finance_1 join finance_2 on finance_1.id = finance_2.id
where finance_1.home_ownership in ('RENT', 'MORTGAGE', 'OWN')
group by finance_1.home_ownership, years
having round(sum(finance_2.last_pymnt_amnt)) != 0
order by YEAR(STR_TO_DATE(finance_2.last_pymnt_d, "%b-%yy")), round(sum(finance_2.last_pymnt_amnt)) desc;

