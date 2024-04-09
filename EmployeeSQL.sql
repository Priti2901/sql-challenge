DROP TABLE departments;

CREATE TABLE departments (
    dept_no VARCHAR(10) NOT NULL,
	dept_name VARCHAR(30) NOT NULL,
	PRIMARY KEY (dept_no)
);

SELECT * FROM departments;

DROP TABLE titles;

CREATE TABLE titles(
    title_id VARCHAR(10) NOT NULL,
	title VARCHAR(30) NOT NULL,
	PRIMARY KEY (title_id)
);

SELECT * FROM titles;

DROP TABLE employees;

CREATE TABLE employees(
    emp_no INT NOT NULL,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	sex VARCHAR (1),
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

SELECT * FROM employees;

DROP TABLE dept_emp;

CREATE TABLE dept_emp(
    emp_no INT NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp;

ALTER TABLE dept_emp
ADD COLUMN id SERIAL PRIMARY KEY;

DROP TABLE dept_manager;

CREATE TABLE dept_manager (
    dept_no VARCHAR(10),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_manager;

ALTER TABLE dept_manager
ADD COLUMN id SERIAL PRIMARY KEY;

DROP TABLE salaries;

CREATE TABLE salaries(
    emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries;

ALTER TABLE salaries
ADD COLUMN id SERIAL PRIMARY KEY;

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' and '1986-12-31';

SELECT dept_manager.dept_no, dept_manager.emp_no, departments.dept_name,
    employees.last_name, employees.first_name
FROM dept_manager
LEFT JOIN departments
ON dept_manager.dept_no=departments.dept_no
LEFT JOIN employees
ON dept_manager.emp_no=employees.emp_no;

SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no=departments.dept_no;

SELECT first_name, last_name, sex
FROM employees
WHERE first_name= 'Hercules' AND last_name LIKE 'B%';

SELECT de.dept_no,d.dept_name,e.emp_no,e.last_name,e.first_name
FROM dept_emp de
JOIN departments d
ON (de.dept_no=d.dept_no)
JOIN employees e
ON (de.emp_no=e.emp_no)
WHERE d.dept_name='Sales';

SELECT de.dept_no,e.emp_no,e.last_name,e.first_name,d.dept_name
FROM dept_emp de
JOIN departments d
ON (de.dept_no=d.dept_no)
JOIN employees e
ON (de.emp_no=e.emp_no)
WHERE d.dept_name='Sales'
OR d.dept_name='Development';










