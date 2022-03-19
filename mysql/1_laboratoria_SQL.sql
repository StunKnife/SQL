--Laboratório prático. Realizar consultas na base de dados.

--Query 1: Retrieve all employees whose address is in Elgin,IL
;
select f_name, l_name,address from employees where address like '%Elgin,IL%';

-- Query 2: Retrieve all employees who were born during the 1970's.
;
select f_name, l_name,b_date from employees where b_date like '%197%'

;
--Query 3: Retrieve all employees in department 5 whose salary is between 60000 and 70000 .
;
select f_name, l_name,dep_id,salary from employees where dep_id=5 and salary between 60000 and 70000
;
--Query 4A: Retrieve a list of employees ordered by department ID. 
;
select f_name,l_name,dep_id from employees order by dep_id asc
;
--Query 4B: Retrieve a list of employees ordered in descending order bydepartment ID 
--and within each department ordered alphabetically in descending order by last name.
;
select  f_name, l_name,dep_id from employees  order by dep_id desc,  L_name desc, l_name desc
;
--Query 5A: For each department ID retrieve the number of employees in the department.
select  dep_id, count(dep_id) as contagem from employees group by dep_id
;
--Query 5B: For each department retrieve the number of employees in the
--department, and the average employees salary in the department.
select  dep_id, count(dep_id) as contagem, avg(salary) as media_salarial from employees group by dep_id
;
--Query 5C: Label the computed columns in the result set of Query 5B as
--“NUM_EMPLOYEES” and “AVG_SALARY”.
;
select  dep_id, count(dep_id) as NUM_EMPLOYEES, avg(salary) as AVG_SALARY from employees group by dep_id
;
--Query 5D: In Query 5C order the result set by Average Salary.
;
select  dep_id, count(dep_id) as NUM_EMPLOYEES, avg(salary) as AVG_SALARY from employees group by dep_id
order by AVG_SALARY
;
--Query 5E: In Query 5D limit the result to departments with fewer than 4
--employees.
;
select  dep_id, count(dep_id) as NUM_EMPLOYEES, avg(salary) as AVG_SALARY from employees group by dep_id
having count(*)<4 order by AVG_SALARY
;
--BONUS Query 6: Similar to 4B but instead of department ID use 
--department name. Retrieve a list of employees ordered by department 
--name, and within each department ordered alphabetically in descending order 
--by last name.
;
select D.DEP_NAME , E.F_NAME, E.L_NAME
from EMPLOYEES as E, DEPARTMENTS as D
where E.DEP_ID = D.DEPT_ID_DEP
order by D.DEP_NAME, E.L_NAME desc ;
;





