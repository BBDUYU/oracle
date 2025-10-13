-- HR --
SELECT * FROM scott.emp;

SELECT * FROM user_tables;

DESC employees;

SELECT first_name, last_name
       , first_name || ' ' || last_name name
FROM employees;


SELECT first_name,last_name,first_name||' '||last_name
    From employees;
    
    SELECT first_name,last_name,CONCAT(CONCAT(first_name,' '),last_name)
    FROM employees;
    
--LIKE 연산자 활용예제
--와일드카드 % _ 를 일반 문자처럼 쓰고싶은경우 ESCAPE
select last_name
from employees
where employee_id = 154;
--수정
UPDATE employees
set last_name='c_brault'
where employee_id=154;

commit;

--문제 employees테이블에서 last_name에 'c_'문자열을 포함한 last_name을 검색해서 출력

select last_name
from employees
where last_name like '%c\_%' ESCAPE '\';

--문제 100,101,102 사원들의 last_name 출력

select *
from employees;

select last_name
from employees
where employee_id in(100,101,102);

--문제 100,101,102 사원들의 last_name수정

update employees
set last_name=substr(last_name,1,1)||'%'||substr(last_name,2)
where employee_id in(100,101,102);



rollback;

commit;


--오라클에서 랜덤한 값
select floor(dbms_random.value(1,length(last_name))) -- 소수점 이하 절삭
        ,substr(last_name,1,floor(dbms_random.value(1,length(last_name))))||'%'||substr(last_name,floor(dbms_random.value(1,length(last_name))))
from employees;

--문제 last_name속에 %문자가 있는 사원정보 출력


select *
from employees
where last_name like '%\%%' escape '\';


--문제 100,101,102 사원들의 last_name속 %제거
select replace(last_name,'%')
from employees
where employee_id in(100,101,102);

update employees
set last_name=replace(last_name,'%')
where employee_id in(100,101,102);

commit;


select *
from employees
where employee_id in(100,101,102);


--LIKE 연산자
--정규표현식을 사용하는 함수
--REGEXP_LIKE()
--REGEXP_INSTR()
--REGEXP_SUBSTR()
--REGEXP_REPLACE()



