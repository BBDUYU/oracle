-- HR --
SELECT * FROM scott.emp;

SELECT * FROM user_tables;

DESC employees;

SELECT first_name, last_name
       , first_name || ' ' || last_name name
FROM employees;