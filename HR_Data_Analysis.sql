-- Find the average age of employees in each department and gender group. ( Round average  age up to two decimal places if needed)

select department, gender,round(avg(age),2) average_age 
from employee 
group by department,gender;

-- List the top 3 departments with the highest average training scores. ( Round average scores up to two decimal places if needed)

select department , round(avg(avg_training_score),2) average_training_score 
from employee 
group by department 
order by avg(avg_training_score) desc 
limit 3;

-- Find the percentage of employees who have won awards in each region. (Round percentages up to two decimal places if needed)

select region, 
round(count(awards_won)/(select count(awards_won) from employee where awards_won = 1)*100,2) award_percentage 
from employee 
where awards_won = 1 
group by region;

-- Show the number of employees who have met more than 80% of KPIs for each recruitment channel and education level.

select recruitment_channel, education,count(KPIs_met_more_than_80) 
from employee 
where KPIs_met_more_than_80= 1 
group by recruitment_channel, education;

-- Find the average length of service for employees in each department,
-- considering only employees with previous year ratings greater than or equal to 4. 
-- ( Round average length up to two decimal places if needed)

select department, round(avg(length_of_service),2) 
from employee 
where previous_year_rating >=4 
group by department;

-- List the top 5 regions with the highest average previous year ratings. ( Round average ratings up to two decimal places if needed)


select region, round(avg(previous_year_rating),2) 
from employee 
group by region 
order by avg(previous_year_rating) desc 
limit 5;

-- List the departments with more than 100 employees having a length of service greater than 5 years.


select department, count(employee_id) 
from employee  
where length_of_service > 5  
group by department 
having count(employee_id)>100;

-- Show the average length of service for employees who have attended more than 3 trainings,
-- grouped by department and gender. ( Round average length up to two decimal places if needed)

select department, gender , round(avg(length_of_service),2) 
from employee 
where no_of_trainings> 3 
group by department, gender;

-- Find the percentage of female employees who have won awards, per department.
-- Also show the number of female employees who won awards and total female employees.
-- ( Round percentage up to two decimal places if needed)

select department, 
round(sum(case when gender = "f" and awards_won = 1 then 1 else 0 end)/sum(case when gender = "f" then 1 else 0 end)*100,2) as female_ward_winners_percentage,
sum(case when gender = "f" and awards_won = 1 then 1 else 0 end) as female_award_winners,
sum(case when gender = "f" then 1 else 0 end) as total_female
from employee group by department;

-- Calculate the percentage of employees per department who have a length of service between 5 and 10 years.
-- ( Round percentage up to two decimal places if needed)

select department, 
round(sum(case when length_of_service between 5 and 10 then 1 else 0 end)/count(*)*100,2) as percentage_of_employee
from employee group by department;

-- Find the top 3 regions with the highest number of employees
-- who have met more than 80% of their KPIs and received at least one award,
-- grouped by department and region.

select department, region,
sum(case when KPIs_met_more_than_80 = 1 and awards_won !=0 then 1 else 0 end) as emp_number
from employee group by department, region order by emp_number desc limit 3;

-- Calculate the average length of service for employees per education level and gender,
-- considering only those employees who have completed more than 2 trainings
-- and have an average training score greater than 75 ( Round average length up to two decimal places if needed)

select education, gender, round(avg(length_of_service),2)
from employee where no_of_trainings > 2 and avg_training_score > 75 
group by education, gender;

-- For each department and recruitment channel, find the total number of employees who have met more than 80% of their KPIs,
-- have a previous_year_rating of 5, and have a length of service greater than 10 years.

select department, recruitment_channel,
sum(case when KPIs_met_more_than_80=1 and previous_year_rating = 5 and length_of_service >10 then 1 else 0 end) as total_no_of_emp
from employee
group by department, recruitment_channel;

select department, recruitment_channel, count(*) from employee
where KPIs_met_more_than_80 = 1 and previous_year_rating = 5 and length_of_service>10
group by department, recruitment_channel;

-- Calculate the percentage of employees in each department who have received awards,
-- have a previous_year_rating of 4 or 5, and an average training score above 70,
-- grouped by department and gender ( Round percentage up to two decimal places if needed).

select department, gender, 
round(sum(case when awards_won = 1 and previous_year_rating in (4,5) and avg_training_score > 70 then 1 else 0 end)/count(*)*100,2) as award_percentage
from employee
group by department, gender;

-- List the top 5 recruitment channels with the highest average length of service for employees
-- who have met more than 80% of their KPIs, have a previous_year_rating of 5, and an age between 25 and 45 years,
 -- grouped by department and recruitment channel. ( Round average length up to two decimal places if needed).
 
select department, recruitment_channel , 
round(avg(length_of_service),2) as avg_length_of_service
from employee
where KPIs_met_more_than_80 = 1 and previous_year_rating = 5 and age between 25 and 45 
group by department, recruitment_channel
order by avg_length_of_service desc
limit 5;
