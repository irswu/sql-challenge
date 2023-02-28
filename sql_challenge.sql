
-- create tables
CREATE TABLE departments (
	dept_no VARCHAR primary key,
	dept_name VARCHAR not null
);

select * from departments;

-- create table 2
CREATE TABLE dept_emp (
	emp_no INT ,
	dept_no VARCHAR references departments(dept_no)
);

select * from dept_emp;

-- create table 3
CREATE TABLE dept_manager (
	dept_no VARCHAR references departments(dept_no),
	emp_no INT primary key
);

select * from dept_manager;


-- create table 4
CREATE TABLE employees (
	emp_no INT primary key,
	emp_title_id VARCHAR,
	birth_date VARCHAR,
	first_name VARCHAR not null,
	last_name VARCHAR not null,
	sex VARCHAR,
	hire_date DATE
);

select * from employees;

-- create table 5
CREATE TABLE salaries (
	emp_no INT primary key,
	salary INT
);

select * from salaries;

-- create table 6
CREATE TABLE titles (
	title_id VARCHAR primary key,
	title VARCHAR
);

select * from titles;

-- primary keys : emp_no

--1 .List the employee number, last name, first name, sex, and salary.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s on
e.emp_no = s.emp_no;

--2. List the first name, last name, 
-- and hire date for the employees who were hired in 1986.
select first_name,last_name, hire_date 
from employees 
where extract(year from hire_date) = '1986';

--3. List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
select m.dept_no, d.dept_name, 
e.emp_no, e.last_name, e.first_name
from dept_manager as m
inner join departments as d 
on m.dept_no = d.dept_no
inner join employees as e 
on m.emp_no = e.emp_no;


-- 4.List the department number for each employee along with 
-- that employee’s employee number, last name, first name, and department name.
select d.dept_no, e.emp_no, employees.last_name, 
employees.first_name, d.dept_name
from departments as d
inner join dept_emp as e
on d.dept_no = e.dept_no
inner join employees
on employees.emp_no = e.emp_no;


-- 5. List first name, last name, and sex of each employee 
-- whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name, sex 
from employees
where first_name = 'Hercules' and Left(last_name, 1) In ('B');


-- 6. List each employee in the Sales department, 
-- including their employee number, last name, and first name.
select e.emp_no, employees.last_name, employees.first_name
from departments as d 
inner join dept_emp as e
on d.dept_no = e.dept_no
inner join employees
on employees.emp_no = e.emp_no
where d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select e.emp_no, employees.last_name, employees.first_name, d.dept_name
from departments as d 
inner join dept_emp as e
on d.dept_no = e.dept_no
inner join employees
on employees.emp_no = e.emp_no
where d.dept_name = 'Sales' or d.dept_name = 'Development';


-- 8.List the frequency counts, in descending order, of all the employee last names
-- (that is, how many employees share each last name).
select last_name, count(last_name) as "count" from employees
group by last_name 
order by count desc;
