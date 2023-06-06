-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp_no, last_name, first_name, sex,
	(SELECT salaries.salary
	FROM salaries
	WHERE salaries.emp_no = employees.emp_no) as "salary"
FROM employees
;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986'
;

-- List the manager of each department along with their department number, department name,
-- employee number, last name, and first name.
SELECT dept_no, 
	(SELECT departments.dept_name
	FROM departments
	WHERE departments.dept_no = dept_managers.dept_no) as "department name",
emp_no,
	(SELECT employees.last_name
	FROM employees
	WHERE employees.emp_no = dept_managers.emp_no) as "last_name",
	(SELECT employees.first_name
	FROM employees
	WHERE employees.emp_no = dept_managers.emp_no) as "first_name"
FROM dept_managers
;


-- List first name, last name, and sex of each employee whose first name is Hercules and
-- whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'
;

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no,last_name, first_name
FROM employees
WHERE emp_no in(
	select emp_no
	from dept_employees
	where dept_no in(
		select dept_no
		from departments
		where dept_name = 'Sales'
	)
)
;

-- List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.

-- note: switching up to use joins. looked up natural join from https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-natural-join/
SELECT e.emp_no,e.last_name, e.first_name, d.dept_name
FROM employees as e
NATURAL JOIN dept_employees as de 
NATURAL JOIN departments as d 
WHERE dept_name = 'Sales'
OR dept_name = 'Development'
;

-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).

-- I'm glad I remembered aliasing exists. 
Select e.last_name, count(e.last_name) as "count"
FROM employees as e 
group by e.last_name
order by "count" desc



