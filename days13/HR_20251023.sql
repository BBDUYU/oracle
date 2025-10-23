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
    
--LIKE ������ Ȱ�뿹��
--���ϵ�ī�� % _ �� �Ϲ� ����ó�� ���������� ESCAPE
select last_name
from employees
where employee_id = 154;
--����
UPDATE employees
set last_name='c_brault'
where employee_id=154;

commit;

--���� employees���̺��� last_name�� 'c_'���ڿ��� ������ last_name�� �˻��ؼ� ���

select last_name
from employees
where last_name like '%c\_%' ESCAPE '\';

--���� 100,101,102 ������� last_name ���

select *
from employees;

select last_name
from employees
where employee_id in(100,101,102);

--���� 100,101,102 ������� last_name����

update employees
set last_name=substr(last_name,1,1)||'%'||substr(last_name,2)
where employee_id in(100,101,102);



rollback;

commit;


--����Ŭ���� ������ ��
select floor(dbms_random.value(1,length(last_name))) -- �Ҽ��� ���� ����
        ,substr(last_name,1,floor(dbms_random.value(1,length(last_name))))||'%'||substr(last_name,floor(dbms_random.value(1,length(last_name))))
from employees;

--���� last_name�ӿ� %���ڰ� �ִ� ������� ���


select *
from employees
where last_name like '%\%%' escape '\';


--���� 100,101,102 ������� last_name�� %����
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


--LIKE ������
--����ǥ������ ����ϴ� �Լ�
--REGEXP_LIKE()
--REGEXP_INSTR()
--REGEXP_SUBSTR()
--REGEXP_REPLACE()


--scott�����ڷκ��� hr������ select���Ѻο�X
select *
from scott.emp;

--hr������ scott.emp ��ü�� ����Ҽ��ִ� ������ü������
-- ���Ѻο�
select *
from arirang;

   select phone_number 
    ,REGEXP_REPLACE(phone_number,
    '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})',
    '(\1) \2-\3') "REGEXP_REPLACE"
   from employees
   order by "REGEXP_REPLACE";

select 'Hello 123 hi 3453 hello hi HELLO'
    ,regexp_replace('Hello 123 hi 3453 hello hi HELLO','\d+')
    , regexp_replace('Hello hi hello hi HELLO','hello','��ο�',1,0,'i')
from dual;

select employee_id, first_name||' '||last_name as name
        ,concat(concat(first_name,' '),last_name)as name2
from employees; 