use employees; -- use database 

with temp_table_emp  as (select e.emp_no , 
-- age  birthdate ( need substract from current date  )
e.first_name , e.last_name , -- need a full_name using of concate func
e.gender ,
-- year_of_ex 
e.hire_date,
de.dept_no,
dm.dept_name,
tit.title,sal.salary,e.birth_date
 from employees as  e  
inner join dept_emp de  on de.emp_no = e.emp_no
inner join departments dm on dm.dept_no = de.dept_no
left  join  titles tit on tit.emp_no = e.emp_no
inner join salaries sal on sal.emp_no = e.emp_no
-- where e.first_name like  '%AA%' 
)
-- ------ 
select * from temp_table_emp ;
SELECT 
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,

    -- Latest Salary
    s.salary AS latest_salary,

    -- Recent Department
    d.dept_name AS recent_department,

    -- Latest Title
    t.title AS max_title,

    -- Years of Experience
    TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) AS years_of_exp,

    -- Age
    TIMESTAMPDIFF(YEAR, e.birth_date, CURDATE()) AS age

FROM employees e

-- Latest Salary
JOIN salaries s 
    ON e.emp_no = s.emp_no 
    AND s.to_date = (
        SELECT MAX(s2.to_date)
        FROM salaries s2
        WHERE s2.emp_no = e.emp_no
    )

-- Latest Department
JOIN dept_emp de 
    ON e.emp_no = de.emp_no 
    AND de.to_date = (
        SELECT MAX(de2.to_date)
        FROM dept_emp de2
        WHERE de2.emp_no = e.emp_no
    )

JOIN departments d 
    ON de.dept_no = d.dept_no

-- Latest Title
JOIN titles t 
    ON e.emp_no = t.emp_no 
    AND t.to_date = (
        SELECT MAX(t2.to_date)
        FROM titles t2
        WHERE t2.emp_no = e.emp_no
    ); 



