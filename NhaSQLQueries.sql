
-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no
-- 2. List employees who were hired in 1986.
SELECT e.emp_no, e.last_name, e.first_name, e.hire_date
FROM employees as e
WHERE EXTRACT(YEAR FROM e.hire_date) = 1986;
	   
-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.


SELECT dm.dept_no, dm.emp_no,e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
INNER JOIN employees AS e ON
dm.emp_no = e.emp_no
LIMIT 10;

-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT e.emp_no AS EmployeeNumber, e.last_name AS LastName, e.first_name AS FirstName, d.name AS DeptName
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no


-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT e.first_name, e.last_name
FROM employees AS e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%'

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- Create a view of the department number for Sales
CREATE VIEW SalesDeptNo AS
SELECT *
FROM departments
WHERE name='Sales';


-- Create a view of all employee numbers that are in Sales
CREATE VIEW EmployeeIDsInSales AS
SELECT emp_no
FROM dept_emp, SalesDeptNo
WHERE dept_emp.dept_no = SalesDeptNo.dept_no;


-- List all employees in the Sales department
CREATE VIEW EmployeesInSales AS 
SELECT e.emp_no AS "Employee ID", e.last_name AS "Last Name", e.first_name AS "First Name", SD.name AS "Department Name"
FROM employees AS e, EmployeeIDsInSales as ES, SalesDeptNo as SD
WHERE e.emp_no = ES.emp_no;

DROP VIEW EmployeesInSales

-- 7. List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
-- Create a view of the department number for Development
CREATE VIEW DevelopmentDeptNo AS
SELECT *
FROM departments
WHERE name='Development';


-- Create a view of all employee numbers that are in Development
CREATE VIEW EmployeeIDsInDevelopment AS
SELECT emp_no
FROM dept_emp, DevelopmentDeptNo
WHERE dept_emp.dept_no = DevelopmentDeptNo.dept_no;

CREATE VIEW EmployeesInDevelopment AS 
SELECT e.emp_no AS "Employee ID", e.last_name AS "Last Name", e.first_name AS "First Name", DD.name AS "Department Name"
FROM employees AS e, EmployeeIDsInDevelopment as ED, DevelopmentDeptNo as DD
WHERE e.emp_no = ED.emp_no;

DROP VIEW EmployeesInDevelopment

-- List all employees in the Sales and Development departments combined
SELECT ES."Employee ID", ES."Last Name", ES."First Name", ES."Department Name"
FROM EmployeesInSales AS ES
FULL JOIN EmployeesInDevelopment AS ED
ON ES."Employee ID" = ED."Employee ID"

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT e.last_name, COUNT(e.last_name) AS "last names count"
FROM employees AS e
GROUP BY e.last_name
ORDER BY "last names count" DESC;
