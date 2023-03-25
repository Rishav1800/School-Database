-- Total Number of student

select count(*) as Total_Students from students;

-- Show all the class names being taught 

select CLASS_NAME from CLASSES
group by CLASS_NAME;

-- Count number of students in each class

select CLASS_ID as 'Class', count(*) from student_classes
group by CLASS_ID
order by CLASS_ID;

-- Return only the records where there are more than 100 students in each class

select CLASS_ID as 'Class', count(*) from student_classes
group by CLASS_ID
having count(*) > 100
order by CLASS_ID;

-- Total Number of staff

select count(*) as Total_Staffs from staff;

-- Total Staff on the basis of Gender

select Gender, count(*) from staff
group by GENDER;

-- Total Number of Teaching & Non-Teaching Staff

select staff_type, count(*) from staff
group by staff_type;

-- Show the first_name, last_name, staff_type, gender, age, DOB, and joining date of staff who is oldest in the school 

select first_name, last_name, staff_type, gender, age, DOB, join_date
from staff
order by JOIN_DATE asc
limit 1;

-- show the staff count by age group
-- select * from staff order by age asc;

select
case when age between '21' and '30' then '21-30'
	when age between '31' and '40' then '31-40'
    when age between '41' and '50' then '41-50'
    else '51-60' end as Age_Group,
count(*) from staff
group by Age_Group
order by 1;

-- show the staff salary in ascending order

select * from staff_salary order by SALARY;

-- Fetch records where staff is female and is over 50 years of age

select * from staff where gender = 'F' and age > 50;

-- Fetch records where subject name has Computer as prefixed

select * from subjects where SUBJECT_NAME like 'Computer%';

-- Fetch record where first name of staff starts with "A" AND last name starts with "S".

select * from staff where FIRST_NAME like 'A%' and LAST_NAME like 'S%';

-- Fetch record where first name of staff starts with "A" OR last name starts with "S"

select * from staff where FIRST_NAME like 'A%' or LAST_NAME like 'S%';

-- Fetch record where staff is over 50 years of age AND has his first name starting with "A" OR his last name starting with "S".

SELECT * FROM STAFF WHERE (FIRST_NAME LIKE 'A%' OR LAST_NAME LIKE 'S%') AND AGE > 50;

SELECT STAFF_TYPE FROM STAFF ; -- Returns lot of duplicate data

SELECT DISTINCT STAFF_TYPE FROM STAFF; -- Returns unique values only

-- show staff_id, if salary >= 10000 then High Salary, if salary between 5000 and 9999 then Average salary, and if salary less than 5000 then Low Salary

SELECT STAFF_ID, SALARY
, CASE WHEN SALARY >= 10000 THEN 'High Salary'
       WHEN SALARY BETWEEN 5000 AND 9999 THEN 'Average Salary'
       WHEN SALARY < 5000 THEN 'Too Low'
  END AS Salary_Range
FROM STAFF_SALARY
ORDER BY 2 DESC;

-- Fetch students whose DOB are in 2014

select * from students where year(DOB) = '2014';

-- Fetch all the class name where Music is thought as a subject

select cl.class_name from classes as cl
join subjects as sub
	on sub.SUBJECT_ID = cl.SUBJECT_ID
where sub.SUBJECT_NAME = 'Music';

-- Fetch the full name of all staff who teach Mathematics

select distinct concat(st.first_name,' ', st.last_name) as Full_Name from staff as st
join classes as cl on cl.TEACHER_ID = st.STAFF_ID
join subjects as sub on sub.SUBJECT_ID = cl.SUBJECT_ID
where sub.SUBJECT_NAME = 'Mathematics';

-- Fetch all staff who teach grade 8, 9, 10 and also fetch all the non-teaching staff

select st.staff_type, concat(st.first_name,' ', st.last_name), st.age, st.gender, st.join_date from staff as st
join classes as cl on st.STAFF_ID = cl.TEACHER_ID
where cl.CLASS_NAME in ('Grade 8','Grade 9','Grade 10')  and st.staff_type = 'Teaching'
union all
select STAFF_TYPE, concat(first_name,' ', last_name), age, gender, join_date from staff
where STAFF_TYPE = 'Non-Teaching';

-- Fetch parents with more than 1 kid in school.

select * from student_parent;
select parent_id, count(*) as No_of_Kids from student_parent
group by PARENT_ID
having count(*) > 1
order by 2 desc;

-- Fetch the details of parents having more than 1 kids going to this school. Also display student details

select concat(p.first_name,' ',p.last_name) as Parent_Name,
concat(st.first_name,' ', st.last_name) as Student_Name,
st.age, st.gender from parents as p
join student_parent as sp on sp.PARENT_ID = p.id
join students as st on st.id = sp.STUDENT_ID
where p.id in (select parent_id from student_parent
					group by PARENT_ID
					having count(*) > 1)
order by 1;

-- Fetch out Parents Name and their total Number of children studying in the school

select * from student_parent;
select concat(p.first_name,' ', last_name) as Parent_Name, count(*) as 'No.of.Kids' from student_parent as sp
join parents p on p.ID = sp.PARENT_ID
group by Parent_Name
having count('No.of.Kids')>1
order by 2 desc;

-- Staff details who’s salary is less than 5000 (Sub Query)

select * from staff_salary where salary < 5000;
select staff_type, first_name, last_name from staff
where staff_id in (select STAFF_ID from staff_salary where salary < 5000);

-- By Join method

select st.staff_type, st.first_name, st.last_name, sal.salary from staff as st
join staff_salary as sal on st.STAFF_ID = sal.STAFF_ID
where sal.salary < 5000;

-- Show the average salary of teaching Staffs

select st.staff_type, round(avg(sl.salary),0) as Average_Salary from staff as st
join staff_salary as sl on st.STAFF_ID = sl.STAFF_ID
group by STAFF_TYPE;





