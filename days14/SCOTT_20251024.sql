select * 
from tabs; 

--2) emp ���̺� ���� Ȯ�� ����
DESCRIBE emp;
DESC emp;

--3) emp ���̺��� ��� ������ ��ȸ�ϴ� ���� �ۼ�
--   �����ȣ, �����, �Ի����� �÷��� ��ȸ
-- FROM ��Ű��.���̺�� �Ǵ� ���
SELECT * 


SELECT emp.*
FROM scott.emp;

--4) madang ������ ���� (��й�ȣ madang)
--5) madang �������� �α��� 
--   ���Ѻο�
--   scott.sql ������ ã�Ƽ� scott ������ �ο��� ���� �ڵ� ����
-- SQL (����ȭ�� ���� ���)
-- 1) DQL ��ȸ
-- 2)

1   [WITH]
6   SELECT
2   FROM
3   [WHERE]
4   [GROUP BY]
5   [HAVING]
7   [ORDER BY]


SELECT empno,ename,hiredate FROM emp;
SELECT emp.*,empno,ename,hiredate FROM emp;

SELECT e.*,empno,ename,hiredate FROM emp e; --emp�̸���� ��Ī e���


--emp ���̺��� ����� ��ȸ�ϴ� ������ �ۼ�
SELECT ename FROM emp;

--�ߺ�����
SELECT DISTINCT job FROM emp;
SELECT job FROM emp;

--������� job�� ���� ���� - COUNT() ����Ŭ�Լ�
SELECT COUNT(DISTINCT job) FROM emp;
--emp ���̺��� �����
SELECT COUNT(empno) FROM emp;

--�� ��� - COUNT(*) null���� ī��Ʈ
--       - COUNT(COMM) NULL���� �����ϰ� ī��Ʈ

--insa ���̺��� ����� ��ȸ
SELECT COUNT(*)
FROM insa;

--emp���̺��� �����ȣ, �����, �Ի�����,�⺻��,Ŀ�̼��� ��ȸ
-- �߰�) �޿� - �⺻�� + Ŀ�̼�
-- (+) ����Ŭ�� ����������
-- ����Ŭ Null ���� �ǹ�
-- comm�� NULL�� ��쿡�� 0���� ó�� (NULL ó��) NVL, NVL2
SELECT empno,ename,hiredate,sal,comm
--        ,sal+comm
--        ,sal+NVL(comm,0) -- ù��° ���� null�̸� �ι�° ��
--        ,NVL(sal+comm,sal)
--        ,NVL2(comm,comm,0)
--        ,NVL(comm,0)
        ,sal+NVL2(comm,comm,0) AS "pay"
        ,sal+NVL2(comm,comm,0) "pay"
        ,sal+NVL2(sal+comm,sal+comm,sal) pay --PAY
FROM emp;

SELECT * FROM emp;
--���� EMP ���̺��� �����ȣ, �����, ���ӻ���� �����ȣ�� ��ȸ
--mgr�� null�̸� CEO
SELECT empno,ename,NVL(to_char(mgr),'CEO')
FROM emp;
CREATE TABLE Imported_Book (
     bookid NUMBER,
     bookname VARCHAR(40),
     publisher VARCHAR(40),
     price NUMBER(8)
 );
 INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
 INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);
 COMMIT
 
SELECT 12345
      , '12345'   -- ����Ŭ ���ڿ��� �� �ڿ� ' ' ���δ�.
      , TO_CHAR(12345) -- ����Ŭ ���ڿ� ��ȯ �Լ�   TO_CHAR() �Լ�
FROM DUAL;

SELECT '�̸��� ' || ename||', ������ '||job||'�Դϴ�.' message
        , CONCAT(CONCAT(CONCAT('�̸��� ',ename),', ������ '),job)
FROM emp;

--employees���̺���
--firstname,lastname�÷� ���
--firstname,lastname�� ���ļ� name��Ī���� ���

--HR���̺��� ���� �޾ƾߵ�

--emp ���̺��� ����� �������
--�μ���ȣ, �����, �Ի�����, pay(sal+comm)
SELECT deptno,ename,hiredate,sal+nvl(comm,0) as pay
FROM emp
WHERE deptno=30;

--���� 20�� �μ����� ������� ���?

SELECT COUNT(*)
FROM emp
WHERE deptno=20;

--���� 10�� �Ǵ� 20�� �Ǵ� 30���� �μ����� �����
SELECT COUNT(*)
FROM emp
WHERE deptno IN(10,20,30); --�÷��� IN(���)
WHERE deptno=20 or deptno=10 or deptno=30;


--�� ��� �μ��� �ִ���

SELECT *
FROM dept;

--emp���̺��� 10�� �μ����� ������ ������ ����������

SELECT deptno, ename, sal+nvl(comm,0) as pay
FROM emp
WHERE deptno!=10;
WHERE deptno^=10;
WHERE deptno<>10;
WHERE NOT deptno=10;

--insa���̺���
--����������� ��������� ����ϴ� ������ �ۼ�
--city �÷� : �������, �̸�, �μ���

SELECT city, name, buseo
FROM insa
WHERE city IN('���', '��õ', '����');

--���� insa���̺��� ��������� ����� ��
SELECT COUNT(*)
FROM insa
WHERE city NOT IN('���', '��õ', '����');

SELECT ename
        ,LOWER(ename) -- �ҹ���
        ,UPPER(ename) -- �빮��
        ,INITCAP(ename) -- ù���ڸ� �빮��
FROM emp;


--���� emp���̺��� comm�� null�� ��� ���� ��ȸ
--� �÷����� nullüũ�ϴ� �������� ��������
SELECT *
FROM emp
WHERE comm IS NULL; --sql ������
WHERE comm IS NOT NULL;

--���� emp ���̺��� �μ���ȣ,�����,������ȸ
-- ����==����*12
-- ���� - ������ 20000 ~ 30000
SELECT deptno, ename,(sal+nvl(comm,0))*12 annualSalary
FROM emp
WHERE (sal+nvl(comm,0))*12 BETWEEN 20000 AND 30000; -- WHERE ��Ī����̾ȵ�

-- 1) WITH�� - annualSalary ��Ī�� WHERE������ ���
WITH annualSalaryEmp AS (
    SELECT deptno, ename,(sal+nvl(comm,0))*12 annualSalary
    FROM emp
)
SELECT * 
FROM annualSalaryEmp
WHERE annualSalary BETWEEN 20000 AND 30000;

-- 2) �������� - annualSalary ��Ī�� WHERE������ ���
-- �ζ��κ�

SELECT e.*

FROM(
     SELECT deptno, ename,(sal+nvl(comm,0))*12 annualSalary
     FROM emp
) e

WHERE e.annualSalary BETWEEN 20000 AND 30000;

--����3) ��ŵ��� ���� ����̸鼭 �⺻���� 150���� �̻��� ��� ��� (name, city, basicpay, ssn)
SELECT name,ssn,basicpay,city
FROM insa
WHERE basicpay>=1500000 AND CITY='����';

--����4) ��ŵ��� ���� ����̰ų� �μ��� ���ߺ��� �ڷ� ��� (name, city, buseo)
 
 SELECT name,city,buseo
 FROM insa
 WHERE buseo='���ߺ�' OR city='����';

--����5) ��ŵ��� ����, ����� ����� ��� (name, city, buseo)
 
 SELECT name,city,buseo
 FROM insa
 WHERE city IN('����','���');
 
--����6) �޿�(basicpay + sudang)�� 250���� �̻��� ���. �� �ʵ���� �ѱ۷� ���. (name, basicpay, sudang, basicpay+sudang) 

SELECT name,basicpay,sudang, basicpay+sudang as �޿�
FROM insa
WHERE basicpay+sudang >=2500000;

--���� insa���̺��� ����ó�� ������ 'O' ��� ���, ������ 'X'

SELECT name,tel,NVL2(to_char(tel),'O','X')
FROM insa;

--���� insa���̺��� 70������ ������� ���

SELECT *
FROM insa
WHERE SUBSTR(ssn,0,1)=7;

1. �������
  1) ��(Role)   
  2) �� ��� ���� 
  3) ��Ű��(Schema)   
  
2. SELECT���� 7���� ���� �����ð�, ó�� ������ ��������. 
    1   [WITH]
    6   SELECT
    2   FROM
    3   [WHERE]
    4   [GROUP BY]
    5   [HAVING]
    7   [ORDER BY]
3. employees ���̺���  �Ʒ��� ���� ��µǵ��� ���� �ۼ��ϼ���. 
   ��. ���ڿ� ���Ῥ���� ���     ||
   ��. ���ڿ� ���� �Լ� ���     CONCAT()
   
    [���� ���]
    FIRST_NAME          LAST_NAME                   NAME                                           
    -------------------- ------------------------- ---------------------------------------------- 
    Samuel               McCain                    Samuel McCain                                  
    Allan                McEwen                    Allan McEwen                                   
    Irene                Mikkilineni               Irene Mikkilineni                              
    Kevin                Mourgos                   Kevin Mourgos                                  
    Julia                Nayer                     Julia Nayer   
    :
    
    ��.
    SELECT first_name,last_name,first_name||' '||last_name
    FROM employees;
    ��.
    SELECT first_name,last_name,CONCAT(CONCAT(first_name,' '),last_name)
    FROM employees;
    
    
4. emp ���̺��� ��,  �����ȣ, �̸�, �Ի����ڸ� ��ȸ�ϴ� SQL�� �ۼ��ϼ���.  
    
    SELECT job,empno,ename,hiredate
    FROM emp;


5. �������� ��� [Oracle �Լ�]�� ���� �����ϼ��� . 
     DISTINCT - �ߺ�����
     COUNT - ī��Ʈ
     CONCAT - ���� ����
     LOWER - �ҹ���
     UPPER - �빮��
     INITCAP - ù���ڸ� �빮��
     IN - ��Ͽ� �ش� ���� �ִ��� ������ �� ���
     BETWEEN - a< value < b
     NVL - null���϶� a��ȯ
     NVL2 - null���϶� a��ȯ �ƴϸ� b��ȯ
     
     select count(empno)
     from emp
     where deptno=30;
     
     select count(distinct job)
     from emp;
     
     
     select SUBSTR(ssn,0,2), SUBSTR(ssn,3,2), SUBSTR(ssn,5,2), SUBSTR(ssn,8,1)
     from insa;
     
     select ssn
     from insa;
     
     
     
5-2. �������� ��� [Oracle �ڷ���]�� ���� �����ϼ���.  
    NUMBER - ����
    char - ������� ���� char(20) - 20 ��ŭ ����
    varchar - ������� ����X varchar(20) - �� ��ŭ�� ����
    
6. �������� ��� ����Ŭ�� ������(operator)�� ��������.   
   1) ��������      
   2) �񱳿�����    
   3) SQL������   IS NULL 
   5) ���������   
   6) ���Ῥ����  +, ||

7. insa ���̺��� ����� ���� �ִ� �μ��� ������ Ȯ���ϴ� ������ �ۼ��ϼ���.

SELECT name,buseo
FROM insa;

7-2. insa ���̺��� ����� ���� �ִ� �μ��� ������ Ȯ���ϴ� ������ �ۼ��ϼ���.

    SELECT count(buseo)
    FROM insa;
8. emp ���̺���
   pay(sal+comm)  1000 �̻�~ 3000 ���� �޴�  
   30�μ����� ������ ��� ����鸸 
   ename�� �������� �������� �����ؼ� ��ȸ�ϴ� ������ �ۼ��ϼ���.  
    ��. �Ϲ� ���� ���.    
    
    SELECT ename,sal+NVL(comm,0) as pay
    FROM emp
    WHERE sal+NVL(comm,0) BETWEEN 1000 AND 3000;
    
    ��. inline view ���  
    
    SELECT e.ename,e.pay
    FROM (
        SELECT ename,sal+NVL(comm,0)as pay 
        FROM emp
    ) e
    WHERE e.pay BETWEEN 1000 AND 3000;
    
    ��. with �� ��� 
    
    SELECT 
    
   
9. emp ���̺��� ���ӻ��(mgr)�� ����  ����� ������ ��ȸ�ϴ� ���� �ۼ��ϼ���.  
    
    SELECT *
    FROM emp
    WHERE mgr IS NULL;

10. emp ���̺��� ���ӻ��(mgr)�� ����  ����� mgr�� 'CEO'�� ����ϴ� ���� �ۼ��ϼ���.
 
   SELECT empno,ename,NVL(to_char(mgr),'CEO')
   FROM emp;
 
11. insa ���̺��� ����ó(tel)�� ���� ����� '����ó ��� �ȵ�' ����ϴ� ������ �ۼ��ϼ���. 
   SELECT name,NVL(to_char(tel),'����ó ��� �ȵ�') as TEL
   FROM insa;
12. insa ���̺��� ���ߺθ� num, name, tel �÷� ����� �� ����ó(tel) ���� ����� X, O ����ϴ� ���� �ۼ�.    
    SELECT name,tel,NVL2(to_char(tel),'O','X') 
    FROM insa;
13. emp ���̺���  �Ʒ��� ���� ��ȸ ����� �������� ������ �ۼ��ϼ���.

    [���� ���]
     EMPNO ENAME             SAL       COMM        PAY
---------- ---------- ---------- ---------- ----------
      7369 SMITH             800          0        800
      7499 ALLEN            1600        300       1900
      7521 WARD             1250        500       1750
      7566 JONES            2975          0       2975
      7654 MARTIN           1250       1400       2650
      7698 BLAKE            2850          0       2850
      7782 CLARK            2450          0       2450
      7839 KING             5000          0       5000
      7844 TURNER           1500          0       1500
      7900 JAMES             950          0        950
      7902 FORD             3000          0       3000
      7934 MILLER           1300          0       1300

   12�� ���� ���õǾ����ϴ�.  
    
    SELECT empno,ename,sal,NVL(comm,0),sal+NVL(comm,0) as pay
    FROM emp;
    
    
14.   emp ���̺��� 10�� �μ��� ���� ��ȸ 
    
    SELECT *
    FROM emp
    WHERE deptno=10;

14-2. emp ���̺��� 10�� �μ����� ������ ��� ������ ��ȸ(���) 

    SELECT *
    FROM emp
    WHERE deptno!=10;

14-3. emp ���̺��� 10�� �Ǵ� 20�� �μ��� ������ ��ȸ 
    SELECT *
    FROM emp
    WHERE deptno=10 or deptno=20;
15. emp ���̺��� ������� 'king' �� ����� ���� ��ȸ 
    SELECT *
    FROM emp
    WHERE LOWER(ename)='king';
16. insa ���̺��� ��������� �������� ����� ������ ��ȸ.   
    SELECT *
    FROM INSA
    WHERE city IN('����','���','��õ');
17. emp ���̺��� �μ���ȣ�� 10���̰�, ���� CLERK  �� ����� ������ ��ȸ�ϴ� ���� �ۼ�.   
    SELECT *
    FROM emp
    WHERE deptno=10 AND job='CLERK';
    
17-2. emp ���̺��� ���� CLERK �̰�, �μ���ȣ�� 10���� �ƴ� ����� ������ ��ȸ�ϴ� ���� �ۼ�. 
    SELECT *
    FROM emp
    WHERE deptno!=10 AND job='CLERK';
17-3.  emp ���̺��� �μ���ȣ�� 30���̰�, Ŀ�̼��� null�� ����� ������ ��ȸ�ϴ� ���� �ۼ�.
  ( ��.  deptno, ename, sal, comm,  pay �÷� ���,  pay= sal+comm )
  ( ��. comm�� null �� ���� 0���� ��ü�ؼ� ó�� )
  ( ��. pay �� ���� ������ ���� )  
  
    SELECT deptno,ename,sal,nvl(comm,0),sal+nvl(comm,0) as pay 
    FROM emp
    WHERE deptno=30 AND comm IS NULL
    ORDER BY pay desc;
  
18. Alias �� �ۼ��ϴ� 3���� ����� ��������.
   SELECT deptno, ename 
     , sal + comm   (��)   
     , sal + comm   (��)    
     , sal + comm   (��)   
    FROM emp; 
  
19. insa ���̺���  �� ������� ����ϴ� ������ �ۼ��ϼ���.  
    
    SELECT COUNT(num)
    FROM insa;

20. hr ������ ��й�ȣ ����� ���� ��� ���� �ϴ� ������ �ۼ��ϼ���.  
    SQL ���� DQL,DDL,DML,DCL,TCL
    CREATE 
    DELETE
    
    ALTER USER hr IDENTIFIED ����й�ȣ ACCOUNT UNLOCK;
    

21. emp ���̺��� ������� ���� ���� ��ȸ �ϴ� ������ �ۼ��ϼ���. 

    SELECT DISTINCT job
    FROM emp;

select *
from insa
--where buseo ='���ߺ�' and substr(ssn,8,1) in('2');
where buseo ='���ߺ�' and MOD(substr(ssn,8,1),2) =0;
 


select *
from insa
where city NOT in('����','���','��õ') and buseo ='���ߺ�';


select *
from emp
where (sal+nvl(comm,0))*12 between 20000 and 30000;



--70����

select *
from emp
where hiredate between '81.1.1' and '81.12.31';

--81�⵵

select *
from emp
where hiredate between '81.1.1' and '81.12.31';
where substr(hiredate,0,2)=81;

--[NOT]LIKE ������
--���������� ��ġ�ϴ����� üũ�ϴ� ������
--���ϵ�ī�带 ����ؼ� ������ ������
--   2�� :     %              _
--����ǥ���� 0�� �̻�         �ѹ���
--instr() �ڹ��� indexOf, lastIndexOf�� ���
--ã���� ��ġ�� ��ȯ, ��ã���� 0��ȯ
SELECT name,ssn,instr(ssn,7)
FROM insa
WHERE instr(ssn,7)=1;

--LIKE���

select *
from insa
where ssn like '7%';
where ssn like '__12__-_______'; -- % _ : ���ϵ� ī��


--���� insa���̺��� �达�� ������� ��ȸ

select count(name)
from insa
where name like '��%';


--���� insa���̺��� �̸��� �� ��° ���ڰ� �� �� �������
select *
from insa
where name like '_��%';

--���� �̸��� ������ ������ ���
select *
from insa
where name like '%����';
where name like '%��';

--LIKE ������ Ȱ�뿹��
--���ϵ�ī�� % _ �� �Ϲ� ����ó�� ���������� ESCAPE

--emp ���̺��� ���ӻ�簡 ���� ����� �μ���ȣ�� Ȯ��
select deptno
from emp
where mgr is null;

--���� ��簡 ���� ����� �μ���ȣ�� null�� ����
update emp
set deptno=null
where mgr is null;

commit;


--LIKE ������
--����ǥ������ ����ϴ� �Լ�
--REGEXP_LIKE()
--REGEXP_INSTR()
--REGEXP_SUBSTR()
--REGEXP_REPLACE()

select empno,ename,job
from emp;

--empno = 7654 ����� �̸��� Martin���� �����ϴ� ���� �ۼ�
update emp
set ename=initcap(ename)
where empno=7654;

commit;
-- emp ���̺��� �����ȸ 'ar'�� �ִ�
select empno,replace(ename,'ar','*ar*'),job
from emp;
--where ename like '%ar%';
--���� emp ���̺��� ename�ӿ� 'ar' ��Һ��� ���������ʰ�  ar���Ե� ������� �˻�
select *
from emp
--where lower(ename) like '%ar%';
--where regexp_like(lower(ename),'ar');
where regexp_like(ename,'ar','i');

--regexp_like ���

--tbl_regexplike
select *
from tbl_regexplike;

--dml ���������ؼ� 2/3 ���ڵ�(��)�� ����
INSERT INTO tbl_regexplike (id,name,email) values(2, '�Ѷ��','hanlasan@abc.co.kr');
INSERT INTO tbl_regexplike (id,name,email) values(3, '�ݰ���','gumgangsan@abc.co.kr');

--�˻� �̸����� �˻�, ���� ��/��
select * 
from tbl_regexplike
--where regexp_like(name,'^(��|��)');
where regexp_like(name,'^[�ѹ�]');

--���� Ǯ��--
1. insa���̺��� ssn �÷��� ���ؼ� year, month, date, gender ���
    [���� ���]
      SSN          YEAR MONTH DATE GENDER  
    ---------- ------ ---- ----- -----
    771212-1022432   77   12   12   1
    801007-1544236   80   10   07   1
    770922-2312547   77   09   22   2
    790304-1788896   79   03   04   1
    811112-1566789   81   11   12   1
    :
    60�� ���� ���õǾ����ϴ�. 
    
    
select ssn
, substr(ssn,1,2) as year
, substr(ssn,3,2) as month
, substr(ssn,5,2) as "DATE"
, substr(ssn,8,1) as gender
from insa;


select substr(ssn,1,6) rrn6,
       to_date(substr(ssn,1,6)) birthday
       ,to_char(to_date(substr(ssn,1,6)),'YYYY') c_year
       
       ,to_char(to_date(substr(ssn,1,6)),'MM') c_month
       ,to_char(to_date(substr(ssn,1,6)),'MONTH') c_month
       ,to_char(to_date(substr(ssn,1,6)),'MON') c_month

       ,to_char(to_date(substr(ssn,1,6)),'DDD') c_day
       ,to_char(to_date(substr(ssn,1,6)),'DD') c_day
       ,to_char(to_date(substr(ssn,1,6)),'D') c_day
       
       ,to_char(to_date(substr(ssn,1,6)),'YY') year
       
       ,extract(year from to_date(substr(ssn,1,6)))e_year
       ,extract(month from to_date(substr(ssn,1,6)))e_month
       ,extract(day from to_date(substr(ssn,1,6)))e_day
       
from insa;

select to_char(sysdate,'DDD')--275
      ,to_char(sysdate,'DD')--02
      ,to_char(sysdate,'D')--5
      ,to_char(sysdate,'HH')--�ð�
      ,to_char(sysdate,'HH12')--�ð�
      ,to_char(sysdate,'HH24')--�ð�
      ,to_char(sysdate,'MI')--��
      ,to_char(sysdate,'SS')--��
      ,to_char(sysdate,'DY')--��
      ,to_char(sysdate,'DAY')--����
from dual; --public �ó��

select to_char(sysdate,'dl')
      ,to_char(sysdate,'ds')
      ,to_char(sysdate,'ts')
      ,to_char(systimestamp,'hh:mi:ss:ff')
--      ,to_char(sysdate,'hh:mi:ss:ff')
from dual;

desc dual;

select * 
from dual;

select 5+3,5-3,5*3,5/3
      ,mod(5,3)
from dual;

--scott -> hr����  emp���̺� select���Ѻο�

grant select on emp to hr; -- ���� �ο�
--revoke select on emp from hr; -- ���� ȸ��

--������ ������������ Ȯ���ϴ� ����
--����Ŭ������ ��¥,���ڴ� ' ' 
select sysdate,to_char(sysdate,'day')
      ,'2025.08.18'
--    ,to_char(to_date('2025.08.18'),'day')
      ,to_char(to_date('2025�� 8�� 18��','yyyy"��" mm"��" dd"��"'),'day')
from dual;

--2. insa ���̺��� 70��� 12���� ��� ��� �Ʒ��� ���� �ֹε�Ϲ�ȣ�� �����ؼ� ����ϼ���.

    NAME                 SSN           
    -------------------- --------------
    �����               721217-1951357
    ���μ�               731211-1214576
    ȫ�浿               771212-1022432   


select name, ssn
from insa
--where substr(ssn,1,1)=7 and substr(ssn,3,2)=12;
--where ssn like '7%' and ssn like '__12%';
--where ssn like '7_12%';
--where regexp_like(ssn,'^7[0-9]12');
where regexp_like(ssn,'^7\d12');

--3. insa ���̺��� 70��� ���� ����� ��ȸ.    
    ��. LIKE ������ ���.    
    
    select *
    from insa
--    where ssn like '7______1%';
--    where ssn like '7%-1%';
    where ssn like '7%' and mod(substr(ssn,-7,1),2)=1;
    ��. REGEXP_LIKE() �Լ� ���  
    
    select *
    from insa
    where regexp_like(ssn,'^7\d{5}-[13579]');

--4. emp ���̺��� �����(ename) �ӿ�  'la' ���ڿ��� �����ϴ� ��� ������ ��ȸ(���)
--   (���� : 'la'���ڴ� ��ҹ��ڸ� �������� �ʴ´�.    la   La  lA  LA )
   
   
   select *
   from emp
-- where lower(ename) like '%la%';
   where ename like '%'|| upper('la') ||'%'; 


   select *
   from emp
   where regexp_like(ename,'la','i');
   
--5.insa ���̺��� ���ڴ� 'X', ���ڴ� 'O' �� ����(gender) ����ϴ� ���� �ۼ�   
    NAME                 SSN            GENDER
    -------------------- -------------- ------
    ȫ�浿               771212-1022432    X
    �̼���               801007-1544236    X
    �̼���               770922-2312547    O
    ������               790304-1788896    X
    �Ѽ���               811112-1566789    X 
    :
 

select name,
       ssn,
       nvl2(nullif(substr(ssn,8,1),'1'),
       nvl(nullif(substr(ssn,8,1),'2'),'O'),'X'
       ) as gender
from insa;

select name,ssn
        , replace(replace(mod(substr(ssn,-7,1),2),1,'X'),0,'O')gender
from insa;

select name,ssn,
--        mod(substr(ssn,-7,1),2),
--        nullif( mod(substr(ssn,-7,1),2),1)gender
          nvl2(nullif( mod(substr(ssn,-7,1),2),1),'O','X')gender
from insa;



select empno,ename,sal,comm,sal+nvl(comm,0) pay
from emp;

select empno,ename,sal,comm,sal+nvl2(comm,comm,0) pay
from emp;

select nullif(100,100)
from dual;

select nullif(100,1000)
from dual;

select nullif('ȫ�浿','��浿')
from dual;

--6. insa ���̺��� 2000�� ���� �Ի��� ���� ��ȸ�ϴ� ���� �ۼ�
    ��. TO_CHAR() �Լ� ����ؼ� Ǯ��
    -- ����,��¥ -> ���ں�ȯ�Լ�
    
    select name, ibsadate
    from insa
    WHERE TO_CHAR(ibsadate, 'yyyy') >= '2000';
    
    ��. EXTRACT() �Լ� ����ؼ� Ǯ��.
    -- ��¥ -> ���� ����
    SELECT name, ibsadate
    FROM insa
    WHERE EXTRACT(YEAR FROM ibsadate) >= 2000;
    
    
    NAME                 IBSADATE
    -------------------- --------
    �̹̼�               00/04/07
    �ɽ���               00/05/05
    �ǿ���               00/06/04
    ������               00/07/07   
    
    
--7. ����ý����� ��¥,�ð����� ��ȸ

select sysdate
--    ,to_char(sysdate,'ds ts')
--      ,extract(hour from systimestamp) as "�ý��۽ð�+9"
--      ,extract(hour from localtimestamp) as �����ð�
--      ,extract(minute from systimestamp) as �ý��ۺ�
--      ,extract(second from systimestamp) as �ý�����
       ,extract(hour from cast(sysdate as timestamp)) ��
       ,extract(minute from cast(sysdate as timestamp)) ��
       ,extract(second from cast(sysdate as timestamp)) ��
from dual;


select
    cast('123.45' as number) as result
   ,cast(sysdate as )
from dual;


--8. ����ý����� ��¥,�ð������� ����ϴ�����

select sysdate,current_timestamp
from dual;

--9. dept�μ� ���̺��� ���� �� �μ����� Ȯ��

desc dept;

select * 
from dept;
--1. 10�� �μ��� �μ����� QC100% �� �����ϴ� ����

update dept
set dname='QC100%'
where deptno=10;

--2. �μ��� 100% ��� ���ڰ� ���Ե� �μ������� ��ȸ�ϴ� ����

select * 
from dept
--where dname like('%100/%%') escape('/');
where regexp_like(dname,'100%');

rollback;


select *
from tabs;

select id ,name
--,replace(email,'.co.kr','.com') as email

,regexp_replace(email,'co.kr','com')
from tbl_regexplike;

select 'http://arirang.co.kr'
    ,regexp_replace('http://arirang.co.kr','http://([^/]+).*', '\1')
    ,regexp_replace('abc@abc.co.kr', 'abc','seoul',1,2)
    ,regexp_replace ('Kim Loves Cho','(.*) (.*) (.*)', '\3 \2 \1') 
from dual;

select ename
    ,replace(ename,'E','��')
    ,regexp_replace(ename,'E','��')
from emp;

--���� �� 6�ڸ��� *�� ä����
select name, ssn
--    ,substr(ssn,1,8) || '******'
--    ,concat(substr(ssn,1,8),'******')
--    ,replace(ssn,substr(ssn,9),'******') --���� �տ� 6���� ��6���� ������ �տ� * ����
--    ,regexp_replace(ssn,'(\d{6}-\d)(\d{6})','\1******')
--    ,regexp_replace(ssn,'(.{8})(\d{6})','\1******')
--    ,regexp_replace(ssn,'.{6}$','******')
    ,rpad(substr(ssn,1,8),14,'*') -- ���°��� �����ʿ� �ش繮�� ���
    ,lpad(substr(ssn,1,8),14,'*') -- ���°��� ���ʿ� �ش繮�� ���
from insa;


select ename
    ,lpad(sal + nvl(comm,0),10,'#') pay --��ü �ڸ��� 10ĭ
from emp;

--11. emp ���̺��� �Ʒ��� ���� ����ϴ� ������ �ۼ��ϼ���. 
   ��. deptno �������� ���� �� pay �� �������� ����
   ��. pay�� 100 ������ # ���
   ��. pay = sal + comm
   
   ������)
DEPTNO ENAME(PAY) BAR
--- ------------ -------------------------------------------------------------
10   KING(5000)    ##################################################
10   CLARK(2450)    #########################
10   MILLER(1300)    #############
20   FORD(3000)    ##############################
20   JONES(2975)    ##############################
20   SMITH(800)    ########
30   BLAKE(2850)    #############################
30   MARTIN(2650)    ###########################
30   ALLEN(1900)    ###################
30   WARD(1750)    ##################
30   TURNER(1500)    ###############
30   JAMES(950)    ##########


select deptno,ename||'('||(sal+nvl(comm,0))||')' as pay
    ,  rpad(' ',round((sal+nvl(comm,0))/100)+1,'#') bar
from emp
order by deptno asc, sal+nvl(comm,0) desc;


WITH temp AS (
        SELECT deptno , ename,  sal + NVL(comm, 0) pay
        FROM emp
)
select deptno
    ,regexp_replace(ename || pay,'([A-Z]+)(\d+)','\1(\2)')"ENAME(PAY)"
    ,rpad(' ',round((pay)/100)+1,'#') bar
from temp
order by deptno asc,pay desc;


--DML : INSERT, UPDATE, DELETE
--      ������ ���۾��
--      �ݵ�� TCL Ŀ��, �ѹ�
--            Ʈ����� ���� ���
select *
from dept
order by deptno;

insert into ���̺��(�÷���) values(�÷���);
commit;

insert into dept(deptno,dname,loc) values(50,'QC','SEOUL');
commit;

insert into dept(deptno,dname,loc) values(60,'QC2','POHANG');
commit;

insert into dept(deptno,dname,loc) values(99,'QC3',NULL);

update dept
set dname='�μ���' ,loc='����'
where deptno=99;

delete 
from dept
where deptno>=50;



--emp���̺��� ������� �޿�(pay)�� 20% �λ��Ű�� ������ �ۼ�

select sal,comm,
        (sal+nvl(comm,0))*0.2 as "�λ�pay"
        ,(sal+nvl(comm,0))*1.2 as "20%pay"
from emp;

--������ : where ������ ����� �� �ִ� �������� ����
--1) �񱳿����� : ����, ����, ��¥ --> true, false, null
--  =, !=, <>, ^=   
--2) �������� : and, or, not
--3) sql������  
--  ��. [not]in (���)  ==  a or b or c or
--  ��. [not]between a and b   ==   a <=    <= b
--  ��. [not]like      ���ϵ�ī��(% _) ���� �˻�
--  ��. is [not]null
--  ��. any, some, all, exists + ��������
--4) set(����) ������ ( ��� )
--  ��. ������ : union, union all
-- union ������
-- union all ������
--1. insa ���̺��� ���ߺ� ����� �̸�, �������, �μ��� ���
select name, city, buseo
from insa
where buseo='���ߺ�';

--2. ���ߺ� ����� Ȯ��
select 
    --name, city, lower(name),
    count(*)
from insa
where buseo='���ߺ�';

--3. ��������� ��õ�� ����� �̸�, �������, �μ�
select name, city, buseo
from insa
where city='��õ';

--4. ������ : ���ߺ� + ��õ
select name, city, buseo
from insa
where buseo='���ߺ�'
--union -- �ߺ���� X
union all -- �ߺ����
select name, city, buseo
from insa
where city='��õ';

select name, city, buseo
from insa
where city='��õ' and buseo='���ߺ�';

select name, city, buseo
from insa
where city='��õ' or buseo='���ߺ�';

--  ��. ������ : intersect
select name, city, buseo
from insa
where buseo='���ߺ�'
intersect
select name, city, buseo
from insa
where city='��õ';
--  ��. ������ : minus
select name, city, buseo
from insa
where buseo='���ߺ�'
minus
select name, city, buseo
from insa
where city='��õ';
--  ���� - ���� ��� ���̺��� �÷��� ����, �ڷ����� ����

-- ���� - ������
--  0�� ����� : 1��
-- 10�� ����� : 2��
-- 20�� ����� : 3��
-- 30�� ����� : 6��
-- 40�� ����� : 0��
--   �� ����� : 12��


select '0�� ����� : '||count(*)||'��' as �����
from emp
where deptno=null
union all
select '10�� ����� : '||count(*)||'��'
from emp
where deptno=10
union all
select '20�� ����� : '||count(*)||'��'
from emp
where deptno=20
union all
select '30�� ����� : '||count(*)||'��'
from emp
where deptno=30
union all
select '40�� ����� : '||count(*)||'��'
from emp
where deptno=40
union all
select '�� ����� : '||count(*)||'��'
from emp;

--emp ���̺��� ��� �����ȣ, ����� + employees���̺��� ��� �����ȣ,�����

select empno, ename
from emp
union all
select employee_id, first_name||' '||last_name as name
from HR.employees;

SELECT * FROM all_synonyms WHERE synonym_name = 'EMPLOYEES';


SELECT * FROM all_tab_privs WHERE table_name = 'EMPLOYEES' AND owner = 'HR';

SELECT 5+3
        ,5-3
        ,5*3
        ,5/3
        ,MOD(5,3) -- ����Ŭ ������ ������ X 
FROM DUAL;

--
SELECT SYSDATE
    ,CURRENT_TIMESTAMP
FROM DUAL;
-- ����Ŭ�� ������ �켱������ �ֵ�
-- IS [NOT] NAN --���ڿ���
-- IS [NOT] INFINITE ���Ѵ� ����
-- ���� INSA���̺��� �����, �ֹι�ȣ, ���̸� ���

SELECT NAME,SSN
--,getAge(SSN) �ֹε�Ϲ�ȣ�� ���̸� ��ȯ�ϴ� getAge() �Լ�
FROM INSA;

--������ �Լ�
select lower( ename)
from emp;

--���� �Լ� ����
--1. �ݿø�    ROUND()
--2. �ø� (����) CEIL()
--3. ���� (����) FLOOR(), TRUNC()

SELECT 5/3
,ROUND(5/3)
,ROUND(5/3,0)
,ROUND(5/3,1)
,ROUND(5/3,2)
FROM DUAL;

SELECT 
--ROUND(123.456,-1) --�Ҽ����� �������� ���� ���� �ڸ����� �ݿø�
ROUND(123.456,-2) --�Ҽ����� �������� ���� ���� �ڸ����� �ݿø�
FROM DUAL;

SELECT 123.4567
    ,CEIL(123.4567) -- ������ �Ҽ��� ù��° �ڸ����� �ø�
FROM DUAL;

--�Ҽ��� 3��° �ڸ����� �ø�


SELECT 123.4567
    ,CEIL(123.4567*100)/100 
FROM DUAL;

--���� TRUNC,FLOOR
SELECT 1234.567
    ,TRUNC(1234.567)
    ,FLOOR(1234.567)
    ,TRUNC(1234.567,0)
    ,TRUNC(1234.567,1)
    ,TRUNC(1234.567,2)
FROM DUAL;


SELECT MOD(5,0)
    ,5/0
FROM DUAL;

SELECT 100, ABS(100), ABS(-100)
FROM DUAL;

WITH temp
AS 
(
        SELECT ename,  sal + NVL(comm, 0) pay
        --      , AVG(sal + NVL(comm, 0))  avg_pay
               , ( SELECT AVG(sal + NVL(comm, 0))   FROM emp )  avg_pay
        FROM emp
)
SELECT ename, pay
      , ROUND( avg_pay, 3 ) avg_pay
      , SIGN( pay - ROUND( avg_pay, 3 ) ) gap
FROM temp;

select power(2,3),power(2,-3),sqrt(4),sqrt(2)
from dual;

select ename,upper(ename),lower(ename),initcap(ename),length(ename)
from emp;


--���� insa �ֹι�ȣ substr()
--�⵵
--��
--��
--����
--�ֹι�ȣ���ڸ�

select ssn
        ,substr(ssn,1,2)
        ,substr(ssn,3,2)
        ,substr(ssn,5,2)
        ,substr(ssn,8,1)
        ,substr(ssn,1,6)
from insa;


--instr() ã�� ���ڰ� ������ 0 ��ȯ ������ ��ġ�� ��ȯ
select ename
    ,instr(ename,'E') --�̸��ӿ� 'E' ���� ����
from emp;

--rpad(), lpad() �Լ�
--����� ���̸�ŭ ###

select ename,length(ename)
        ,rpad('#',length(ename),'#') as "BAR"
        ,lpad('#',length(ename),'#') as "BAR"
from emp;

select '   admin   '
,'['||ltrim('   admin   ')||']'
,'['||rtrim('   admin   ')||']'
,rtrim('brasdawqonaxyxyxy','xy')--Ư�����ڿ� ���� ����
,'['||trim('   admin   ')||']'
from dual;


--���� emp���̺��� �̸��� ù��°���ڸ� ���
select substr(ename,0,1)
        ,ascii(substr(ename,0,1))
        ,chr(65)
from emp;
--greatest() -- ������ ���ڳ� �����߿��� ���� ū ���� ����
--least()    -- ������ ���ڳ� �����߿��� ���� �������� ����
select greatest(3,5,2,4,1)
        ,least(3,5,2,4,1)
from dual;

select sysdate
    ,round(sysdate)
from dual;


select to_char(sysdate,'ds ts')
    ,to_char(trunc(sysdate),'ds ts')
    ,to_char(trunc(sysdate,'dd'),'ds ts')--�� ����
    ,to_char(trunc(sysdate,'mm'),'ds ts')--�� ����
    ,to_char(trunc(sysdate,'yyyy'),'ds ts')--�⵵ ����
    ,trunc(sysdate)
from dual;

select '2025/08/18'
    ,to_date('2025/08/18')+100
from dual;

select sysdate, sysdate+2,sysdate+2/24 
from dual;

select to_char(sysdate+1/2/24,'ds ts'),--30����
to_char(sysdate+1/24/60,'ds ts') --1����
from dual;


select ename
    ,sysdate
    ,hiredate
    --,��¥-��¥=�γ�¥������ ����
    ,round(sysdate - hiredate) �ٹ��ϼ�
    ,months_between(sysdate,hiredate)/12 �ٹ����
from emp;


select to_char(to_date('2025/08/18','yyyy/mm/dd')+100,'yyyy-mm-dd')
from dual;

select sysdate
    ,add_months(sysdate,3)
    ,add_months(sysdate,-3)
    ,add_months(sysdate,3*12)
from dual;

--last_day Ư����¥�� ���� ���� ���� ������ ��¥�� �����ϴ� �Լ�
--�̹����� ��������¥
select sysdate
    ,last_day(sysdate)
    ,to_char(last_day(sysdate),'dd')
from dual;

--�޷� �׸��� : 2020/02 ��������¥ ? 


select to_char(last_day(to_date('2020/02','yyyy/mm')),'dd')
from dual;

--������ ������������
select to_char(sysdate,'day') 
    ,next_day(sysdate,'�ݿ���')
from dual;

--����ȯ �Լ�
-- to_number() ���� -> ����
select empno
from emp;

select substr(empno,-1)
from emp;

select to_number('432')+5
from dual;

select to_number('1,234','9G999')+5
from dual;

--to_char(����[,����, nls�Ķ����]) -> ���ں�ȯ
--to_char(��¥[,����, nls�Ķ����]) -> ���ں�ȯ


--ȫ�浿 2,810,000 �ݾ��� �� �ڸ����� �޸�(,) �� ���
select name, basicpay+sudang pay
        ,to_char( basicpay + sudang, 'L9,999,999' )
from insa;

--nls �����������
--  �� �پ��� ������ ���, ����, ��������..���� ���
--  �� [RR]/MM/DD
--      YY ������

select *
from v$nls_parameters;

select ename, sal, comm, 
--to_char((sal+comm)*12,'$99,999.99')
to_char((sal+nvl(comm,0))*12,'$99,999.99')
from emp;
--from emp where comm is not null;

select to_char(34,'RN') from dual;
select to_char(34,'rn') from dual;

select to_char(-10000, 'L99G999D99MI'
        , 'NLS_NUMERIC_CHARACTERS= '',.''
      NLS_CURRENCY = ''AusDollars'' ') "Amount"
from dual;

--��¥ -> to_char �Լ����̿��� -> ���ں�ȯ
--to_char(��¥)
select sysdate
    ,to_char(sysdate,'yyyy-mm--dd ts')
    ,to_char(sysdate,'yyyy')
    ,to_char(sysdate,'mm')
    ,to_char(sysdate,'dd')
from dual;
-- ��������
1. dept ���̺�   deptno = 50,  dname = QC,  loc = SEOUL  �� ���ο� �μ����� �߰�

INSERT INTO dept VALUES(50, 'QC', 'SEOUL');
select *
from dept;
1-2. dept ���̺� QC �μ��� ã�Ƽ� �μ���(dname)�� ����(loc)�� 
  dname = ����μ��� 2�� �߰�,  loc = POHANG ���� ����
  
update dept
set dname=dname||'2', loc='POHANG'
where dname='QC';
  
--QC �μ��� 40�� �μ��� �μ���� ���������� �����ϴ� �����ۼ�
update dept
set dname=(
    select dname
    from dept
    where deptno=40
),loc=(
    select loc
    from dept
    where deptno=40
)
--set(dname,loc)=select(dname,loc) from dept where deptno=40
where dname='QC';

rollback;


1-3. dept ���̺��� QC2 �μ��� ã�Ƽ� deptno(PK)�� ����ؼ� ����

delete 
from dept
where deptno=(
    select deptno
    from dept
    where dname='QC2'
);

--dept ���̺��� �μ��� COUNT ��� ���ڰ� ���Ե� �μ��� �μ���ȣ�� 1������Ű�� ����

select *
from dept;

--ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
update dept
set deptno=deptno+1
--where dname like '%COUNT%';
where regexp_like(dname,'COUNT','i');


select *
from emp;

rollback;

2.  insa ���̺��� ���ڴ� 'X', ���ڴ� 'O' �� ����(gender) ����ϴ� ���� �ۼ�
    1. REPLACE() ����ؼ� Ǯ��
    select name,ssn
    , replace(replace(mod(substr(ssn,-7,1),2),1,'X'),0,'O')gender
    from insa;
    
    2. NVL2(), NULLIF() ����ؼ� Ǯ��.
    select name,ssn
    ,nvl2(nullif( mod(substr(ssn,-7,1),2),1),'O','X')gender
    from insa;
    
    NAME                 SSN            GENDER
    -------------------- -------------- ------
    ȫ�浿               771212-1022432    X
    �̼���               801007-1544236    X
    �̼���               770922-2312547    O
    ������               790304-1788896    X
    �Ѽ���               811112-1566789    X 

3.  insa ���̺��� 2000�� ���� �Ի��� ���� ��ȸ�ϴ� ���� �ۼ�
    1. TO_CHAR() �Լ� ����ؼ� Ǯ��
    
    select name,ibsadate
    from insa
    WHERE TO_CHAR(ibsadate, 'yyyy') >= '2000';

    
    2. EXTRACT() �Լ� ����ؼ� Ǯ��.
    
    select name, ibsadate
    from insa
    where extract(year from ibsadate) >= 2000;
    
    NAME                 IBSADATE
    -------------------- --------
    �̹̼�               00/04/07
    �ɽ���               00/05/05
    �ǿ���               00/06/04
    ������               00/07/07    
    
4. ���ݱ��� ��� ����Ŭ �ڷ����� ��������.
   ��.  number(p,s) number(4) 4�ڸ� ����
   ��.  varchar2(14) 14����Ʈ ���ڿ�
   ��.  date ��
   ��.  
 

8.  insa ���̺���  �ֹι�ȣ�� �Ʒ��� ���� '-' ���ڸ� �����ؼ� ���
 
    NAME    SSN             SSN_2
    ȫ�浿   770423-1022432   7704231022432
    �̼���   800423-1544236   8004231544236
    �̼���   770922-2312547   7709222312547    
    
    1) SUBSTR() ���
    
    select name, ssn,substr(ssn,0,6)||substr(ssn,8,7) as SSN_2
    from insa;
    
    2) REPLACE() ���
    
    select name,ssn
    ,replace(ssn,'-')
    from insa;
    
    3) REGEXP_REPLACE() ���

    select 
    name,
    ssn,
    regexp_replace(ssn, '[^0-9]', '') as SSN_2
    from insa;

[�����Լ�]
9. ROUND() 
   1) �Լ� ���� :  �ݿø�
   2) ���� ���� :  round(a,b) �Ҽ��� b��° �ڸ����� ����� �ݿø�
   3) ���� ����
        SELECT    3.141592
               , ROUND(  3.141592 )       a 
               , ROUND(  3.141592,  0 )   b
               , ROUND(  3.141592,  2 )   c
               , ROUND(  3.141592,  -1 ) d
               , ROUND( 12345  , -3 )    e
       FROM dual;
        a�� �⺻������ �Ҽ��� ù°�ڸ����� �ݿø�, ���� 3
        b�� �Ҽ��� 0��°�ڸ� �� ù��¥������ �ݿø�, ���� 3
        c�� �Ҽ��� ��°�ڸ����� ����� �ݿø�, ���� 3.14
        d�� 1���ڸ����� �ݿø�, ���� 3
        e�� �Ҽ��� ���� 3��° �ڸ����� �ݿø�, ���� 12000

    
9-2. TRUNC()�Լ��� FLOOR() �Լ��� ���ؼ� �����ϼ���.  
    �Ѵ� ���� �Լ�
    ������
    trunc�� ������ �ڸ����� ��������
    floor�� ������ �Ҽ��� ù°�ڸ����� ����

9-3. CEIL() �Լ��� ���ؼ� �����ϼ���.  
     
     �����Լ�
     
9-4. ������ ���� �����ϴ� �Լ� :  (  mod    )
9-5. ���밪�� �����ϴ� �Լ� :   (    abs    ) 
 

11. insa ���̺��� ��� ������� 14�� ���� ����� �� �� ���� �������� ������ �ۼ��ϼ���.

select count(*)
from insa;

select ceil(count(*)/14) 
from insa;

12. emp ���̺��� �ְ� �޿���, ���� �޿��� ���� ��� ��ȸ
                                            PAY(sal+comm)
7369   SMITH   CLERK   7902   80/12/17   800          20  �ְ�޿���
7839   KING   PRESIDENT      81/11/17   5000      10  �����޿���

select empno, ename,job,mgr,hiredate,sal+nvl(comm,0) as pay ,deptno
from emp
where sal+nvl(comm,0) in (
    (select max(sal+nvl(comm ,0)) max_pay from emp)
    (select min(sal+nvl(comm ,0)) min_pay from emp)
)

order by pay asc;


where sal+nvl(comm,0)=(select min(sal+nvl(comm,0))from emp);

13. emp ���̺��� 
   comm �� 400 ������ ����� ���� ��ȸ
  ( comm �� null �� ����� ���� )
    
    ENAME   SAL    COMM
    SMITH   800   
    ALLEN   1600   300
    JONES   2975   
    BLAKE   2850   
    CLARK   2450   
    KING   5000   
    TURNER   1500   0
    JAMES   950   
    FORD   3000   
    MILLER   1300   
    
  SELECT ename, sal, comm
  FROM emp
  WHERE LNNVL( comm > 400 );
  WHERE comm <= 400 OR comm IS NULL;
--  WHERE NVL(comm,0) <= 400 ;
    
--
--(�� ������ ������ Ǯ �� ������ Ǯ�����. )    
--14. emp ���̺��� �� �μ��� �޿�(pay)�� ���� ���� �޴� ����� ���� ���.    

select *
from emp;

select empno, ename, job,mgr,hiredate,sal+nvl(comm,0) as pay, deptno
from emp
where deptno=10 and sal+nvl(comm,0) in (
    select max(sal+nvl(comm ,0)) max_pay 
    from emp
    where deptno=10
)
union
select empno, ename, job,mgr,hiredate,sal+nvl(comm,0) as pay, deptno
from emp
where deptno=20 and sal+nvl(comm,0) in (
    select max(sal+nvl(comm ,0)) max_pay 
    from emp
    where deptno=20
)
union
select empno, ename, job,mgr,hiredate,sal+nvl(comm,0) as pay, deptno
from emp
where deptno=30 and sal+nvl(comm,0) in (
    select max(sal+nvl(comm ,0)) max_pay 
    from emp
    where deptno=30
)
order by deptno asc;

--��� ��������
--mainquery + subquery


select empno,ename,job,mgr,hiredate,sal+nvl(comm,0) as pay,deptno
from emp m
where sal+nvl(comm,0)=(
    select max(sal+nvl(comm,0))
    from emp
    where deptno=m.deptno
);


-- all : ��� ���� , any : ������ ����������
select empno,ename,job,mgr,hiredate,sal+nvl(comm,0) as pay,deptno
from emp m
where sal+nvl(comm,0)>=all(
    select sal+nvl(comm,0)
    from emp
    where deptno=m.deptno
);

--0�� �ڸ���ä���
select to_char(sum(sal+nvl(comm,0)),'$9G999G99D00') as total_pay
from emp;

select sum(sal+nvl(comm,0)) total_pay
from emp;


select ename, sal, comm, 
--to_char((sal+comm)*12,'$99,999.99')
to_char((sal+nvl(comm,0))*12,'$99,999.99')
from emp;

select round(sum(sal)/count(*),2)
        ,round(avg(sal),2)
        ,sum(comm)/count(*) -- * -> null����
        ,avg(comm)
from emp;

--���� emp���̺��� ��� �޿�(pay)���� ���� �޿��� �޴� ����� ������
--�μ����� �����ϰ� �� �� �޿����� ����

select empno, ename,sal+nvl(comm,0) as pay ,deptno
from emp
where (sal+nvl(comm,0)) > (
    select avg(sal+nvl(comm,0))
    from emp
)
order by deptno asc, pay desc;

select *
from emp;


--���� �� �μ��� ��� �޿����� ���Թ޴� ����������
-- empno,ename,pay,�ش�μ���ձ޿�,deptno
--�μ�������,�޿�������

select a.empno,a.ename, a.sal+nvl(a.comm,0) as pay,b.avg_pay as "��ձ޿�",a.deptno
from emp a, (select avg(sal+nvl(comm,0))as avg_pay from emp) b
where (a.sal+nvl(a.comm,0)) <b.avg_pay
order by a.deptno asc, pay desc;

--Ǯ��
--1
select avg(sal+nvl(comm,0)) "10����ձ޿�"
from emp
where deptno=10;

--2
select empno, ename,sal+nvl(comm,0) as pay 
    ,(
        select avg(sal+nvl(comm,0))
        from emp
        where deptno=m.deptno
    ) deptno_avg_pay
    ,deptno
from emp m
where (sal+nvl(comm,0)) > (
    select avg(sal+nvl(comm,0))
    from emp
)
order by deptno asc;

--3. KING 5000   null  �μ��� ���� ��� �� �߿� ��� �޿����� ���� ����� ���.
select *
from(
    select empno, ename,sal+nvl(comm,0) as pay 
        ,(
            select round(avg(sal+nvl(comm,0)),2)
            from emp
            where deptno=m.deptno
        ) deptno_avg_pay
        ,deptno
    from emp m
) t
where pay < deptno_avg_pay
order by deptno asc,pay desc;

--���� emp���̺��� �μ���ȣ, �μ���,�����,�Ի����� ��ȸ
--emp  ���̺� : deptno, ename, hiredate
--dept ���̺� : deptno, ename

--������ ������ ��
--���̺� <-����-> ���̺� <-����-> ���̺� ... 


--�μ���ȣ �μ��� �����ȣ ����� �Ի����� �����ؼ� ����ϴ� �����ۼ�

--2 ���̺� join ���̺� on �������� ���� ���
select e.deptno,dname,empno,ename,hiredate
from dept d join emp e on d.deptno=e.deptno;

--emp���� �����ȣ,�����,�μ���
--insa���� �����ȣ,�����,�μ���
--�����̺��� ��������� �������(�����ȣ,�����,�μ���)���

select num,name,buseo
from insa
union
select empno,ename,dname
from emp e,dept d
where e.deptno=d.deptno;

select *
from emp;


--���� emp ���̺��� job�� ���� ���


select count(distinct(job))
from emp;

--���� ��� ���
10 2
20 3
30 6

select '10',count(*)
from emp
where deptno=10
union all
select '20',count(*)
from emp
where deptno=20
union all
select '30',count(*)
from emp
where deptno=30
union all
select '40',count(*)
from emp
where deptno=40
union all
select ' ',count(*)
from emp;

--��� �����������
select to_char(deptno) as deptno,
    (select count(*) from emp where deptno=d.deptno)
from dept d
union all
select ' ', count(*) from emp
order by deptno asc;



select *
from dept;

--group by �� ���
--�� �μ��� ����� �ľ�

select nvl(deptno,0)deptno,count(*) �����
from emp
group by deptno
union all
select null,count(*)
from emp
order by deptno asc;
-- ����
--����� ���� �μ������� ����������� (40���μ�)


select nvl(d.deptno,0) deptno, count(ename)
from emp e, dept d
where e.deptno(+)=d.deptno -- pk == fk [outer join] ������ �������̺� (+)
group by d.deptno
order by d.deptno asc;

select *
from dept;

select nvl(d.deptno,0) deptno, count(ename) 
from emp e right outer join dept d on e.deptno=d.deptno --��� ������ ���� ���̺�  left || right outer ������ ����
group by d.deptno
order by d.deptno asc;

--���� insa ���̺��� �� �μ��� ������� ���

select distinct buseo
from insa;



select buseo,replace(replace(mod(substr(ssn,-7,1),2),1,'��'),0,'��') ����,count(*)
from insa
group by buseo,replace(replace(mod(substr(ssn,-7,1),2),1,'��'),0,'��')
order by buseo asc;


SELECT t.*
FROM (
        SELECT NVL(deptno,0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
        FROM emp 
     ) t
WHERE  pay = (
                SELECT MAX( sal+NVL(comm,0) ) max_pay
                FROM emp
                WHERE NVL(deptno,0) = t.deptno
             )   
ORDER BY t.deptno     ;

UNION ALL
SELECT NVL(deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e
WHERE sal+NVL(comm,0) = (
                            SELECT MAX( sal+NVL(comm,0) )
                            FROM emp
                            WHERE deptno IS NULL
                        ) 


SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e, ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
WHERE e.deptno = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY e.deptno ASC;
-- SCOTT --   
-- [����1] �μ���(�μ���ȣ), �����, �����ȣ, �����, �Ի����� ���
--        ( �μ��� �������� ����, �Ի����� ������ ���� )
-- 1) ����(join) ���� ����
 dept : deptno,  dname
 emp  : deptno, empno, ename, hirecdate
 
-- 2) equi join / outer join ���� ����
SELECT DISTINCT deptno
FROM dept;
FROM emp;

emp.deptno
30
null
20
10
dept.deptno
10
20
30
40

SELECT DISTINCT  d.deptno
FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno;

-- Ǯ��)
SELECT COUNT(*) FROM emp WHERE deptno = 10;
--
SELECT dname  || '(' || d.deptno || ')' dname
, (SELECT COUNT(*) FROM emp WHERE deptno = e.deptno) "COUNT"
, empno, ename, hiredate
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
ORDER BY dname ASC, hiredate ASC;

-- [������]
DNAME              COUNT      EMPNO ENAME      HIREDATE
--------------- ---------- ---------- ---------- --------
ACCOUNTING(10)        2       7782 CLARK      81/06/09
ACCOUNTING(10)        2       7934 MILLER     82/01/23
OPERATIONS(40)         0                               
RESEARCH(20)          3       7369 SMITH      80/12/17
RESEARCH(20)          3       7566 JONES      81/04/02
RESEARCH(20)          3       7902 FORD       81/12/03
SALES(30)             6       7499 ALLEN      81/02/20
SALES(30)             6       7521 WARD       81/02/22
SALES(30)             6       7698 BLAKE      81/05/01
SALES(30)             6       7844 TURNER     81/09/08
SALES(30)             6       7654 Martin     81/09/28
SALES(30)             6       7900 JAMES      81/12/03

12�� ���� ���õǾ����ϴ�. 

-- [����2] �μ��� �����, �ش� �μ��� �޿���� ���
--   ( �޿������ �Ҽ��� 3�ڸ����� �ݿø��ؼ� ��� )
--   ( �������� ��ü ����� �� ��ü �޿���� ���)

    DEPTNO      COUNT    AVG_PAY
---------- ---------- ----------
         0          1       5000
        10          2       1875
        20          3    2258.33
        30          6    1933.33
                   12    2260.42
--                  
SELECT NVL(deptno, 0) deptno
      , COUNT(*) "COUNT"
      , ROUND( AVG( sal+NVL(comm,0) ), 2 ) avg_pay
FROM emp
GROUP BY deptno  -- �����Լ�
UNION ALL -- ����) �÷� ��, �÷� �ڷ��� ����..
SELECT null
      , COUNT(*) 
      , ROUND( AVG( sal+NVL(comm,0) ), 2 ) 
FROM emp
ORDER BY deptno ASC;
--
SELECT 10 "DEPTNO", COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 10
UNION ALL
SELECT 20, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 20
UNION ALL
SELECT 30, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 30
UNION ALL
SELECT 40 deptno, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 40
ORDER BY deptno ASC;

-- [����3] �μ��� , �⺰ ����� ���
--  ( �μ��� ���� ����� 0���� ��� )
SELECT NVL(deptno,0) deptno, job, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno, job
ORDER BY deptno ASC, job ASC;

    DEPTNO JOB            COUNT
---------- --------- ----------
         0 PRESIDENT          1
        10 CLERK              1
        10 MANAGER            1
        20 ANALYST            1
        20 CLERK              1
        20 MANAGER            1
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4

9�� ���� ���õǾ����ϴ�. 

-- [����3-2] insa ���̺��� �� �μ��� ��/���� ������� ���� ���� ����ϴ� ���� �ۼ��ϼ���
SELECT buseo, gender, COUNT(*) "COUNT"
FROM  (  -- �ζ��κ�( inline view )
        SELECT buseo
              , ssn
              , REPLACE(  REPLACE( MOD( SUBSTR( ssn, -7, 1), 2 ), 1, '��'), 0, '��') gender
        --      , NVL2(  NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ), 1 ), '��', '��' ) gender
        FROM insa
     ) i
GROUP BY buseo, gender     
ORDER BY buseo, gender;



BUSEO       GENDER      COUNT
--------------- - ----------
���ߺ�          ��          8
���ߺ�          ��          6
��ȹ��          ��          3
��ȹ��          ��          4
������          ��          8
������          ��          8
�λ��          ��          4
�����          ��          4
�����          ��          2
�ѹ���          ��          3
�ѹ���          ��          3
ȫ����          ��          3
ȫ����          ��          3

13�� ���� ���õǾ����ϴ�. 

-- [����4] �� �μ��� �ְ� �޿��� ���� ��ȸ 
-- ( �μ��� ���� ��� �� �ְ� �޿��� ������ ��� )

-- 1) ORA-00979: not a GROUP BY expression
SELECT deptno
--       , empno
       , MAX( sal+NVL(comm, 0) )  max_pay
       , COUNT(*) "COUNT"
       , SUM( sal+NVL(comm, 0) )  sum_pay
       , AVG( sal+NVL(comm, 0) )  avg_pay
       
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--
UNION ALL
SELECT NVL(deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e
WHERE sal+NVL(comm,0) = (
                            SELECT MAX( sal+NVL(comm,0) )
                            FROM emp
                            WHERE deptno IS NULL
                        ) 
-- 1)
SELECT t.*
FROM (
        SELECT NVL(deptno,0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
        FROM emp 
     ) t
WHERE  pay = (
                SELECT MAX( sal+NVL(comm,0) ) max_pay
                FROM emp
                WHERE NVL(deptno,0) = t.deptno
             )   
ORDER BY t.deptno     ;
--
SELECT MAX( sal+NVL(comm,0) ) max_pay
FROM emp
WHERE deptno = null;

-- 2)
SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e, ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
WHERE NVL(e.deptno, 0) = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY deptno ASC;

-- 2-2) JOIN ~ ON ���� ����
SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e  JOIN ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
ON NVL(e.deptno, 0) = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY deptno ASC;



--
    DEPTNO      EMPNO ENAME      HIREDATE        PAY
---------- ---------- ---------- -------- ----------
         0       7839 KING       81/11/17       5000
        10       7782 CLARK      81/06/09       2450
        20       7902 FORD       81/12/03       3000
        30       7698 BLAKE      81/05/01       2850
        
-- [����5] �ְ� �޿���, ���� �޿��� ���� ��ȸ
-- SQL������  : ALL, ANY, EXISTS
-- 1)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '�����޿���' result
FROM emp
WHERE sal+NVL(comm,0) <= ALL( SELECT sal+NVL(comm,0)  FROM emp )
-- WHERE sal+NVL(comm,0) = ( SELECT MIN(sal+NVL(comm,0))  FROM emp )
UNION ALL
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '�ְ�޿���' result
FROM emp
WHERE sal+NVL(comm,0) >= ALL ( SELECT sal+NVL(comm,0)  FROM emp );
-- WHERE sal+NVL(comm,0) = ( SELECT MAX(sal+NVL(comm,0))  FROM emp );

-- 2)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp
WHERE sal+NVL(comm,0) IN (
      ( SELECT MIN(sal+NVL(comm,0)) FROM emp)
     ,( SELECT MAX(sal+NVL(comm,0)) FROM emp)
);
-- 2-2)
SELECT deptno, ename, hiredate, pay
       , NVL2( NULLIF(pay, max_pay), '����', '�ְ�') || '�޿���' result
FROM (  -- �ζ��κ�
        SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay
            , ( SELECT MIN(sal+NVL(comm,0)) FROM emp) min_pay
            , ( SELECT MAX(sal+NVL(comm,0)) FROM emp) max_pay
        FROM emp
) t
WHERE pay IN (
      ( SELECT MIN(sal+NVL(comm,0)) FROM emp )
     ,( SELECT MAX(sal+NVL(comm,0)) FROM emp )
);

    DEPTNO ENAME      HIREDATE        PAY RESULT
---------- ---------- -------- ---------- --
        20 SMITH      80/12/17        800 �����޿���
           KING       81/11/17       5000 �ְ�޿���


-- SCOTT --   
-- [����1] �μ���(�μ���ȣ), �����, �����ȣ, �����, �Ի����� ���
--        ( �μ��� �������� ����, �Ի����� ������ ���� )
-- 1) ����(join) ���� ����
 dept : deptno,  dname
 emp  : deptno, empno, ename, hirecdate
 
-- 2) equi join / outer join ���� ����
SELECT DISTINCT deptno
FROM dept;
FROM emp;

emp.deptno
30
null
20
10
dept.deptno
10
20
30
40

SELECT DISTINCT  d.deptno
FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno;

-- Ǯ��)
SELECT COUNT(*) FROM emp WHERE deptno = 10;
--
SELECT dname  || '(' || d.deptno || ')' dname
, (SELECT COUNT(*) FROM emp WHERE deptno = e.deptno) "COUNT"
, empno, ename, hiredate
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
ORDER BY dname ASC, hiredate ASC;

-- [������]
DNAME              COUNT      EMPNO ENAME      HIREDATE
--------------- ---------- ---------- ---------- --------
ACCOUNTING(10)        2       7782 CLARK      81/06/09
ACCOUNTING(10)        2       7934 MILLER     82/01/23
OPERATIONS(40)         0                               
RESEARCH(20)          3       7369 SMITH      80/12/17
RESEARCH(20)          3       7566 JONES      81/04/02
RESEARCH(20)          3       7902 FORD       81/12/03
SALES(30)             6       7499 ALLEN      81/02/20
SALES(30)             6       7521 WARD       81/02/22
SALES(30)             6       7698 BLAKE      81/05/01
SALES(30)             6       7844 TURNER     81/09/08
SALES(30)             6       7654 Martin     81/09/28
SALES(30)             6       7900 JAMES      81/12/03

12�� ���� ���õǾ����ϴ�. 

-- [����2] �μ��� �����, �ش� �μ��� �޿���� ���
--   ( �޿������ �Ҽ��� 3�ڸ����� �ݿø��ؼ� ��� )
--   ( �������� ��ü ����� �� ��ü �޿���� ���)

    DEPTNO      COUNT    AVG_PAY
---------- ---------- ----------
         0          1       5000
        10          2       1875
        20          3    2258.33
        30          6    1933.33
                   12    2260.42
--                  
SELECT NVL(deptno, 0) deptno
      , COUNT(*) "COUNT"
      , ROUND( AVG( sal+NVL(comm,0) ), 2 ) avg_pay
FROM emp
GROUP BY deptno  -- �����Լ�
UNION ALL -- ����) �÷� ��, �÷� �ڷ��� ����..
SELECT null
      , COUNT(*) 
      , ROUND( AVG( sal+NVL(comm,0) ), 2 ) 
FROM emp
ORDER BY deptno ASC;
--
SELECT 10 "DEPTNO", COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 10
UNION ALL
SELECT 20, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 20
UNION ALL
SELECT 30, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 30
UNION ALL
SELECT 40 deptno, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 40
ORDER BY deptno ASC;

-- [����3] �μ��� , �⺰ ����� ���
--  ( �μ��� ���� ����� 0���� ��� )
SELECT NVL(deptno,0) deptno, job, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno, job
ORDER BY deptno ASC, job ASC;

    DEPTNO JOB            COUNT
---------- --------- ----------
         0 PRESIDENT          1
        10 CLERK              1
        10 MANAGER            1
        20 ANALYST            1
        20 CLERK              1
        20 MANAGER            1
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4

9�� ���� ���õǾ����ϴ�. 

-- [����3-2] insa ���̺��� �� �μ��� ��/���� ������� ���� ���� ����ϴ� ���� �ۼ��ϼ���
SELECT buseo, gender, COUNT(*) "COUNT"
FROM  (  -- �ζ��κ�( inline view )
        SELECT buseo
              , ssn
              , REPLACE(  REPLACE( MOD( SUBSTR( ssn, -7, 1), 2 ), 1, '��'), 0, '��') gender
        --      , NVL2(  NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ), 1 ), '��', '��' ) gender
        FROM insa
     ) i
GROUP BY buseo, gender     
ORDER BY buseo, gender;



BUSEO       GENDER      COUNT
--------------- - ----------
���ߺ�          ��          8
���ߺ�          ��          6
��ȹ��          ��          3
��ȹ��          ��          4
������          ��          8
������          ��          8
�λ��          ��          4
�����          ��          4
�����          ��          2
�ѹ���          ��          3
�ѹ���          ��          3
ȫ����          ��          3
ȫ����          ��          3

13�� ���� ���õǾ����ϴ�. 

-- [����4] �� �μ��� �ְ� �޿��� ���� ��ȸ 
-- ( �μ��� ���� ��� �� �ְ� �޿��� ������ ��� )

-- 1) ORA-00979: not a GROUP BY expression
SELECT deptno
--       , empno
       , MAX( sal+NVL(comm, 0) )  max_pay
       , COUNT(*) "COUNT"
       , SUM( sal+NVL(comm, 0) )  sum_pay
       , AVG( sal+NVL(comm, 0) )  avg_pay
       
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--
UNION ALL
SELECT NVL(deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e
WHERE sal+NVL(comm,0) = (
                            SELECT MAX( sal+NVL(comm,0) )
                            FROM emp
                            WHERE deptno IS NULL
                        ) 
-- 1)
SELECT t.*
FROM (
        SELECT NVL(deptno,0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
        FROM emp 
     ) t
WHERE  pay = (
                SELECT MAX( sal+NVL(comm,0) ) max_pay
                FROM emp
                WHERE NVL(deptno,0) = t.deptno
             )   
ORDER BY t.deptno     ;
--
SELECT MAX( sal+NVL(comm,0) ) max_pay
FROM emp
WHERE deptno = null;

-- 2)
SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e, ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
WHERE NVL(e.deptno, 0) = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY deptno ASC;

-- 2-2) JOIN ~ ON ���� ����
SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e  JOIN ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
ON NVL(e.deptno, 0) = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY deptno ASC;



--
    DEPTNO      EMPNO ENAME      HIREDATE        PAY
---------- ---------- ---------- -------- ----------
         0       7839 KING       81/11/17       5000
        10       7782 CLARK      81/06/09       2450
        20       7902 FORD       81/12/03       3000
        30       7698 BLAKE      81/05/01       2850
        
-- [����5] �ְ� �޿���, ���� �޿��� ���� ��ȸ
-- SQL������  : ALL, ANY, EXISTS
-- 1)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '�����޿���' result
FROM emp
WHERE sal+NVL(comm,0) <= ALL( SELECT sal+NVL(comm,0)  FROM emp )
-- WHERE sal+NVL(comm,0) = ( SELECT MIN(sal+NVL(comm,0))  FROM emp )
UNION ALL
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '�ְ�޿���' result
FROM emp
WHERE sal+NVL(comm,0) >= ALL ( SELECT sal+NVL(comm,0)  FROM emp );
-- WHERE sal+NVL(comm,0) = ( SELECT MAX(sal+NVL(comm,0))  FROM emp );

-- 2)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp
WHERE sal+NVL(comm,0) IN (
      ( SELECT MIN(sal+NVL(comm,0)) FROM emp)
     ,( SELECT MAX(sal+NVL(comm,0)) FROM emp)
);
-- 2-2)
SELECT deptno, ename, hiredate, pay
       , NVL2( NULLIF(pay, max_pay), '����', '�ְ�') || '�޿���' result
FROM (  -- �ζ��κ�
        SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay
            , ( SELECT MIN(sal+NVL(comm,0)) FROM emp) min_pay
            , ( SELECT MAX(sal+NVL(comm,0)) FROM emp) max_pay
        FROM emp
) t
WHERE pay IN (
      ( SELECT MIN(sal+NVL(comm,0)) FROM emp )
     ,( SELECT MAX(sal+NVL(comm,0)) FROM emp )
);

    DEPTNO ENAME      HIREDATE        PAY RESULT
---------- ---------- -------- ---------- --
        20 SMITH      80/12/17        800 �����޿���
           KING       81/11/17       5000 �ְ�޿���

-- ���� ���� ����~
-- COALESCE �Լ� : ���������� NULL �ƴ� ���� ��ȯ�ϴ� �Լ� 
SELECT ename, sal, comm
    , sal + NVL(comm, 0) pay
    , sal + NVL2(comm, comm, 0)  pay
    , sal + COALESCE(comm, 0) pay
FROM emp;

-- DECODE �Լ� ***
if(���ǽ�){   a = b
   return c; 
}
DECODE( a, b, c )
��)
SELECT DECODE(10, 10, 'X')
FROM dual;
--
-- (���) deptno�� 10���̶�� 100�� �����ϰ� �׷��� ������  null �����Ѵ�. 
SELECT ename, DECODE( deptno, 10, 100)  
FROM emp;
-- 
if( a = b ){
  return c;
}else{
  return d;
}
DECODE( a, b, C, d )
--
SELECT ename,  DECODE( deptno, 10, 'O', 'X') 
FROM emp;
--
if( a = b ){
  return  ��;
}else if( a = c ){
  return  ��;
}else if( a = d ){
  return ��;
}else{
  return ��;
}
DECODE( a,b,��,c,��,d,��,��)
--��) deptno  10  1, 20, 2, 30, 3, 40, 4 , 0
SELECT ename, deptno
     , DECODE( deptno, 10, 1, 20, 2, 30,3, 40,4, 0)
FROM emp;
-- ����   'O'   REPLACE x 2��
-- ����   'X'   NULLIF, NVL2
SELECT name, ssn
    , MOD(  SUBSTR( ssn, -7, 1 ), 2 ) gender
    , NVL2(NULLIF(MOD(SUBSTR(ssn,-7,1),2),0),'O','X')gender
    , REPLACE(REPLACE(MOD(SUBSTR(ssn,-7,1),2),1,'O'),0,'X')gender 
    -- DECODE �Լ��� ����ؼ� ó��
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) gender
FROM insa;
-- emp ���̺��� �� �μ��� ������� ���.
SELECT deptno, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno
ORDER BY deptno  ASC;
-- ���� ������ DECODE �Լ� X �� ����ؼ� ����.

         0         10         20         30         40      ��ü�����
---------- ---------- ---------- ---------- ---------- ----------
         1          2          3          6          0         12
         
SELECT 
   ( SELECT COUNT(*) FROM emp WHERE deptno IS NULL ) "0"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 10 ) "10"  
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 20 ) "20"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 30 ) "30"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 40 ) "40"
 , ( SELECT COUNT(*) FROM emp  ) "��ü�����"
FROM dual; 

-- ���� ������ DECODE �Լ��� ����ؼ� ����.
SELECT 
    COUNT(*) "��ü�����"
    , COUNT( DECODE(deptno, 10, 'XXX' ) )  "10�� �����"
    , SUM( DECODE(deptno, 20, 1 ) )  "20�� �����"
    , COUNT( DECODE(deptno, 30, 'XXX' ) )  "30�� �����"
    , COUNT( DECODE(deptno, 40, 'XXX' ) )  "40�� �����" 
FROM emp;
-- 2���� ��Ȯ�ϰ� ���� X 
SELECT DECODE(deptno, 10, 'XXX' )
FROM emp;

--   2)
if( a = b ){
  return c
}
DECODE( a, b, c )
--
SELECT 
   -- deptno
   -- , DECODE( deptno, 10,  1 )
   COUNT( DECODE( deptno, 10,  1 ) )
   , COUNT( DECODE( deptno, 20,  'XXXXX' ) )
FROM emp;

--   1) �����Լ��� null ���� �����Ѵ�. 
SELECT COUNT(*)
     , COUNT(comm)
     , SUM( comm )
FROM emp;

-- [����] emp ���̺��� pay�� ��� 10% �λ��ϴ� ������ �ۼ�. 
SELECT ename
    , sal + NVL(comm, 0) pay
    , (sal + NVL(comm, 0)) * 0.1 "10% �λ��"
    , (sal + NVL(comm, 0)) * 1.1 "10% �λ�� pay"
FROM emp;

-- [����] emp ���̺��� 10�� �μ������� 10%�λ�
--                     20��    "     20%�λ�
--                �׿� �μ�������      15%�λ�.
-- 1) Ǯ��
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.* , '10%' "�λ� %" , pay * 0.1 "�λ��", pay * 1.1 "�λ�� pay"
FROM temp
WHERE deptno = 10
UNION ALL
SELECT temp.* , '20%' "�λ� %" , pay * 0.2 "�λ��", pay * 1.2 "�λ�� pay"
FROM temp
WHERE deptno = 20
UNION ALL
SELECT temp.* , '15%' "�λ� %" , pay * 0.15 "�λ��", pay * 1.15 "�λ�� pay"
FROM temp
WHERE deptno NOT IN ( 10,20 );

-- DECODE �Լ��� ����ؼ� ... ����.
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.*
     , DECODE( deptno, 10, '10%', 20, '20%', '15%' ) "�λ�%"
     , pay * DECODE( deptno, 10, 0.1, 20, 0.2, 0.15 ) "�λ��"
     , pay * DECODE( deptno, 10, 1.1, 20, 1.2, 1.15 ) "�λ�� pay"
FROM temp;
-- CASE �Լ�
SELECT name, ssn
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) decode_gender
    , CASE MOD(SUBSTR(ssn,-7,1),2)
             WHEN 1 THEN 'O'
             ELSE        'X'
      END case_gender
    , CASE
          WHEN MOD(SUBSTR(ssn,-7,1),2) = 1 THEN 'O'
          --ELSE        'X'   null ó���Ǵ��� ( �ϱ� )
      END case_gender
--    , CASE �÷��� �Ǵ� ���� WHEN ���ǽ� THEN ��ȯ��
--                          WHEN ���ǽ� THEN ��ȯ��
--                          WHEN ���ǽ� THEN ��ȯ��
--                          ELSE  ��ȯ��
--      END
FROM insa;


-- [����] emp ���̺��� 10�� �μ������� 10%�λ�
--                     20��    "     20%�λ�
--                �׿� �μ�������      15%�λ�.
-- ( CASE �Լ��� ����ؼ� Ǯ��� )
SELECT t.*
     -- DECODE �Լ� ��� �ڵ�. 
     , pay * DECODE(deptno, 10, 1.1, 20, 1.2, 1.15) "decode �λ�� pay"
     , pay * CASE deptno 
                 WHEN 10 THEN 1.1
                 WHEN 20 THEN 1.2
                 ELSE         1.15
               END "case �λ�� pay"
FROM ( -- �ζ��κ�(inline view)
        SELECT deptno, ename
             , sal + NVL(comm, 0) pay
        FROM emp
     ) t;
-- sal��� ���̺�
SELECT * 
FROM salgrade;
1   700       1200
2   1201   1400
3   1401   2000
4   2001   3000
5   3001   9999
--
SELECT ename, sal 
      , CASE 
           WHEN sal BETWEEN 700    AND 1200 THEN 1
           WHEN sal BETWEEN 1201 AND 1400 THEN 2
           WHEN sal BETWEEN 1401 AND 2000 THEN 3
           WHEN sal BETWEEN 2001 AND 3000 THEN 4
           WHEN sal BETWEEN 3001 AND 9999 THEN 5
        END grade
FROM emp;
-- ( �ϱ� )   [ �� ���� ���� ]
--       �� �� ���̺��� ���� X -> ���� ����
--       ������������  BETWEEN ~ AND 
SELECT ename, sal, grade
FROM emp e JOIN salgrade s ON sal BETWEEN losal AND hisal ;
       
-- [����] emp ���̺��� �Ի�⵵�� �������. 
--                     1���޿� �Ի��� ������� ��ȸ.
7369   SMITH   80/12/17
7499   ALLEN   81/02/20
7521   WARD   81/02/22
7566   JONES   81/04/02
7654   Martin   81/09/28
7698   BLAKE   81/05/01
7782   CLARK   81/06/09
7839   KING   81/11/17
7844   TURNER   81/09/08
7900   JAMES   81/12/03
7902   FORD   81/12/03
7934   MILLER   82/01/23
-- Ǯ�� 1) 
--SELECT empno, ename, hiredate
--     , TO_CHAR( hiredate, 'MM' ) �Ի��ѿ�
--     , EXTRACT( MONTH FROM hiredate) �Ի��ѿ�
--FROM emp;
-- 1��, 2�� ~ 12�� �Ի��� ����� ���.
SELECT COUNT( * )
FROM emp
WHERE TO_CHAR( hiredate, 'MM' ) = 1;
WHERE TO_CHAR( hiredate, 'MM' ) = '01';

-- Ǯ�� 2) 
SELECT 
      TO_CHAR( hiredate, 'MM' ) ,
      COUNT(*)
FROM emp
-- WHERE TO_CHAR( hiredate, 'MM' ) = 1
GROUP BY TO_CHAR( hiredate, 'MM' )
-- HAVING�� ���...
ORDER BY TO_CHAR( hiredate, 'MM' ) ASC;
-- Ǯ�� 3)
SELECT  
      -- empno, ename, hiredate  ,
      COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 1, 'X') )  month_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 2, 'X') )  month_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 3, 'X') )  month_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 4, 'X') )  month_4
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 5, 'X') )  month_5
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 6, 'X') )  month_6
FROM emp;
-- �� �б⺰�� �Ի��� ����� �ľ�
-- 1~3 1�б�    4~6 2�б�  7~9 3�б� 10~12 4�б�
SELECT  
      -- empno, ename, hiredate  ,
        COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 1, 'X') )  �б�_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 2, 'X') )  �б�_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 3, 'X') )  �б�_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 4, 'X') )  �б�_4 
FROM emp;
      
-- SCOTT --   
-- [����1] �μ���(�μ���ȣ), �����, �����ȣ, �����, �Ի����� ���
--        ( �μ��� �������� ����, �Ի����� ������ ���� )
-- 1) ����(join) ���� ����
 dept : deptno,  dname
 emp  : deptno, empno, ename, hirecdate
 
-- 2) equi join / outer join ���� ����
SELECT DISTINCT deptno
FROM dept;
FROM emp;

emp.deptno
30
null
20
10
dept.deptno
10
20
30
40

SELECT DISTINCT  d.deptno
FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno;

-- Ǯ��)
SELECT COUNT(*) FROM emp WHERE deptno = 10;
--
SELECT dname  || '(' || d.deptno || ')' dname
, (SELECT COUNT(*) FROM emp WHERE deptno = e.deptno) "COUNT"
, empno, ename, hiredate
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
ORDER BY dname ASC, hiredate ASC;

-- [������]
DNAME              COUNT      EMPNO ENAME      HIREDATE
--------------- ---------- ---------- ---------- --------
ACCOUNTING(10)        2       7782 CLARK      81/06/09
ACCOUNTING(10)        2       7934 MILLER     82/01/23
OPERATIONS(40)         0                               
RESEARCH(20)          3       7369 SMITH      80/12/17
RESEARCH(20)          3       7566 JONES      81/04/02
RESEARCH(20)          3       7902 FORD       81/12/03
SALES(30)             6       7499 ALLEN      81/02/20
SALES(30)             6       7521 WARD       81/02/22
SALES(30)             6       7698 BLAKE      81/05/01
SALES(30)             6       7844 TURNER     81/09/08
SALES(30)             6       7654 Martin     81/09/28
SALES(30)             6       7900 JAMES      81/12/03

12�� ���� ���õǾ����ϴ�. 

-- [����2] �μ��� �����, �ش� �μ��� �޿���� ���
--   ( �޿������ �Ҽ��� 3�ڸ����� �ݿø��ؼ� ��� )
--   ( �������� ��ü ����� �� ��ü �޿���� ���)

    DEPTNO      COUNT    AVG_PAY
---------- ---------- ----------
         0          1       5000
        10          2       1875
        20          3    2258.33
        30          6    1933.33
                   12    2260.42
--                  
SELECT NVL(deptno, 0) deptno
      , COUNT(*) "COUNT"
      , ROUND( AVG( sal+NVL(comm,0) ), 2 ) avg_pay
FROM emp
GROUP BY deptno  -- �����Լ�
UNION ALL -- ����) �÷� ��, �÷� �ڷ��� ����..
SELECT null
      , COUNT(*) 
      , ROUND( AVG( sal+NVL(comm,0) ), 2 ) 
FROM emp
ORDER BY deptno ASC;
--
SELECT 10 "DEPTNO", COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 10
UNION ALL
SELECT 20, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 20
UNION ALL
SELECT 30, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 30
UNION ALL
SELECT 40 deptno, COUNT(*) "COUNT"
      , AVG(sal+NVL(comm,0)) avg_pay
FROM emp
WHERE deptno = 40
ORDER BY deptno ASC;

-- [����3] �μ��� , �⺰ ����� ���
--  ( �μ��� ���� ����� 0���� ��� )
SELECT NVL(deptno,0) deptno, job, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno, job
ORDER BY deptno ASC, job ASC;

    DEPTNO JOB            COUNT
---------- --------- ----------
         0 PRESIDENT          1
        10 CLERK              1
        10 MANAGER            1
        20 ANALYST            1
        20 CLERK              1
        20 MANAGER            1
        30 CLERK              1
        30 MANAGER            1
        30 SALESMAN           4

9�� ���� ���õǾ����ϴ�. 

-- [����3-2] insa ���̺��� �� �μ��� ��/���� ������� ���� ���� ����ϴ� ���� �ۼ��ϼ���
SELECT buseo, gender, COUNT(*) "COUNT"
FROM  (  -- �ζ��κ�( inline view )
        SELECT buseo
              , ssn
              , REPLACE(  REPLACE( MOD( SUBSTR( ssn, -7, 1), 2 ), 1, '��'), 0, '��') gender
        --      , NVL2(  NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ), 1 ), '��', '��' ) gender
        FROM insa
     ) i
GROUP BY buseo, gender     
ORDER BY buseo, gender;



BUSEO       GENDER      COUNT
--------------- - ----------
���ߺ�          ��          8
���ߺ�          ��          6
��ȹ��          ��          3
��ȹ��          ��          4
������          ��          8
������          ��          8
�λ��          ��          4
�����          ��          4
�����          ��          2
�ѹ���          ��          3
�ѹ���          ��          3
ȫ����          ��          3
ȫ����          ��          3

13�� ���� ���õǾ����ϴ�. 

-- [����4] �� �μ��� �ְ� �޿��� ���� ��ȸ 
-- ( �μ��� ���� ��� �� �ְ� �޿��� ������ ��� )

-- 1) ORA-00979: not a GROUP BY expression
SELECT deptno
--       , empno
       , MAX( sal+NVL(comm, 0) )  max_pay
       , COUNT(*) "COUNT"
       , SUM( sal+NVL(comm, 0) )  sum_pay
       , AVG( sal+NVL(comm, 0) )  avg_pay
       
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--
UNION ALL
SELECT NVL(deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e
WHERE sal+NVL(comm,0) = (
                            SELECT MAX( sal+NVL(comm,0) )
                            FROM emp
                            WHERE deptno IS NULL
                        ) 
-- 1)
SELECT t.*
FROM (
        SELECT NVL(deptno,0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
        FROM emp 
     ) t
WHERE  pay = (
                SELECT MAX( sal+NVL(comm,0) ) max_pay
                FROM emp
                WHERE NVL(deptno,0) = t.deptno
             )   
ORDER BY t.deptno     ;
--
SELECT MAX( sal+NVL(comm,0) ) max_pay
FROM emp
WHERE deptno = null;

-- 2)
SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e, ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
WHERE NVL(e.deptno, 0) = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY deptno ASC;

-- 2-2) JOIN ~ ON ���� ����
SELECT NVL(e.deptno, 0) deptno, empno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp e  JOIN ( 
                SELECT NVL(deptno, 0) deptno, MAX( sal+NVL(comm,0)) max_pay
                FROM emp
                GROUP BY deptno 
            )  t
ON NVL(e.deptno, 0) = t.deptno AND sal+NVL(comm,0) = t.max_pay    
ORDER BY deptno ASC;



--
    DEPTNO      EMPNO ENAME      HIREDATE        PAY
---------- ---------- ---------- -------- ----------
         0       7839 KING       81/11/17       5000
        10       7782 CLARK      81/06/09       2450
        20       7902 FORD       81/12/03       3000
        30       7698 BLAKE      81/05/01       2850
        
-- [����5] �ְ� �޿���, ���� �޿��� ���� ��ȸ
-- SQL������  : ALL, ANY, EXISTS
-- 1)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '�����޿���' result
FROM emp
WHERE sal+NVL(comm,0) <= ALL( SELECT sal+NVL(comm,0)  FROM emp )
-- WHERE sal+NVL(comm,0) = ( SELECT MIN(sal+NVL(comm,0))  FROM emp )
UNION ALL
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '�ְ�޿���' result
FROM emp
WHERE sal+NVL(comm,0) >= ALL ( SELECT sal+NVL(comm,0)  FROM emp );
-- WHERE sal+NVL(comm,0) = ( SELECT MAX(sal+NVL(comm,0))  FROM emp );

-- 2)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay
FROM emp
WHERE sal+NVL(comm,0) IN (
      ( SELECT MIN(sal+NVL(comm,0)) FROM emp)
     ,( SELECT MAX(sal+NVL(comm,0)) FROM emp)
);
-- 2-2)
SELECT deptno, ename, hiredate, pay
       , NVL2( NULLIF(pay, max_pay), '����', '�ְ�') || '�޿���' result
FROM (  -- �ζ��κ�
        SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay
            , ( SELECT MIN(sal+NVL(comm,0)) FROM emp) min_pay
            , ( SELECT MAX(sal+NVL(comm,0)) FROM emp) max_pay
        FROM emp
) t
WHERE pay IN (
      ( SELECT MIN(sal+NVL(comm,0)) FROM emp )
     ,( SELECT MAX(sal+NVL(comm,0)) FROM emp )
);

    DEPTNO ENAME      HIREDATE        PAY RESULT
---------- ---------- -------- ---------- --
        20 SMITH      80/12/17        800 �����޿���
           KING       81/11/17       5000 �ְ�޿���

-- ���� ���� ����~
-- COALESCE �Լ� : ���������� NULL �ƴ� ���� ��ȯ�ϴ� �Լ� 
SELECT ename, sal, comm
    , sal + NVL(comm, 0) pay
    , sal + NVL2(comm, comm, 0)  pay
    , sal + COALESCE(comm, 0) pay
FROM emp;

-- DECODE �Լ� ***
if(���ǽ�){   a = b
   return c; 
}
DECODE( a, b, c )
��)
SELECT DECODE(10, 10, 'X')
FROM dual;
--
-- (���) deptno�� 10���̶�� 100�� �����ϰ� �׷��� ������  null �����Ѵ�. 
SELECT ename, DECODE( deptno, 10, 100)  
FROM emp;
-- 
if( a = b ){
  return c;
}else{
  return d;
}
DECODE( a, b, C, d )
--
SELECT ename,  DECODE( deptno, 10, 'O', 'X') 
FROM emp;
--
if( a = b ){
  return  ��;
}else if( a = c ){
  return  ��;
}else if( a = d ){
  return ��;
}else{
  return ��;
}
DECODE( a,b,��,c,��,d,��,��)
--��) deptno  10  1, 20, 2, 30, 3, 40, 4 , 0
SELECT ename, deptno
     , DECODE( deptno, 10, 1, 20, 2, 30,3, 40,4, 0)
FROM emp;
-- ����   'O'   REPLACE x 2��
-- ����   'X'   NULLIF, NVL2
SELECT name, ssn
    , MOD(  SUBSTR( ssn, -7, 1 ), 2 ) gender
    , NVL2(NULLIF(MOD(SUBSTR(ssn,-7,1),2),0),'O','X')gender
    , REPLACE(REPLACE(MOD(SUBSTR(ssn,-7,1),2),1,'O'),0,'X')gender 
    -- DECODE �Լ��� ����ؼ� ó��
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) gender
FROM insa;
-- emp ���̺��� �� �μ��� ������� ���.
SELECT deptno, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno
ORDER BY deptno  ASC;
-- ���� ������ DECODE �Լ� X �� ����ؼ� ����.

         0         10         20         30         40      ��ü�����
---------- ---------- ---------- ---------- ---------- ----------
         1          2          3          6          0         12
         
SELECT 
   ( SELECT COUNT(*) FROM emp WHERE deptno IS NULL ) "0"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 10 ) "10"  
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 20 ) "20"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 30 ) "30"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 40 ) "40"
 , ( SELECT COUNT(*) FROM emp  ) "��ü�����"
FROM dual; 

-- ���� ������ DECODE �Լ��� ����ؼ� ����.
SELECT 
    COUNT(*) "��ü�����"
    , COUNT( DECODE(deptno, 10, 'XXX' ) )  "10�� �����"
    , SUM( DECODE(deptno, 20, 1 ) )  "20�� �����"
    , COUNT( DECODE(deptno, 30, 'XXX' ) )  "30�� �����"
    , COUNT( DECODE(deptno, 40, 'XXX' ) )  "40�� �����" 
FROM emp;
-- 2���� ��Ȯ�ϰ� ���� X 
SELECT DECODE(deptno, 10, 'XXX' )
FROM emp;

--   2)
if( a = b ){
  return c
}
DECODE( a, b, c )
--
SELECT 
   -- deptno
   -- , DECODE( deptno, 10,  1 )
   COUNT( DECODE( deptno, 10,  1 ) )
   , COUNT( DECODE( deptno, 20,  'XXXXX' ) )
FROM emp;

--   1) �����Լ��� null ���� �����Ѵ�. 
SELECT COUNT(*)
     , COUNT(comm)
     , SUM( comm )
FROM emp;

-- [����] emp ���̺��� pay�� ��� 10% �λ��ϴ� ������ �ۼ�. 
SELECT ename
    , sal + NVL(comm, 0) pay
    , (sal + NVL(comm, 0)) * 0.1 "10% �λ��"
    , (sal + NVL(comm, 0)) * 1.1 "10% �λ�� pay"
FROM emp;

-- [����] emp ���̺��� 10�� �μ������� 10%�λ�
--                     20��    "     20%�λ�
--                �׿� �μ�������      15%�λ�.
-- 1) Ǯ��
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.* , '10%' "�λ� %" , pay * 0.1 "�λ��", pay * 1.1 "�λ�� pay"
FROM temp
WHERE deptno = 10
UNION ALL
SELECT temp.* , '20%' "�λ� %" , pay * 0.2 "�λ��", pay * 1.2 "�λ�� pay"
FROM temp
WHERE deptno = 20
UNION ALL
SELECT temp.* , '15%' "�λ� %" , pay * 0.15 "�λ��", pay * 1.15 "�λ�� pay"
FROM temp
WHERE deptno NOT IN ( 10,20 );

-- DECODE �Լ��� ����ؼ� ... ����.
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.*
     , DECODE( deptno, 10, '10%', 20, '20%', '15%' ) "�λ�%"
     , pay * DECODE( deptno, 10, 0.1, 20, 0.2, 0.15 ) "�λ��"
     , pay * DECODE( deptno, 10, 1.1, 20, 1.2, 1.15 ) "�λ�� pay"
FROM temp;
-- CASE �Լ�
SELECT name, ssn
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) decode_gender
    , CASE MOD(SUBSTR(ssn,-7,1),2)
             WHEN 1 THEN 'O'
             ELSE        'X'
      END case_gender
    , CASE
          WHEN MOD(SUBSTR(ssn,-7,1),2) = 1 THEN 'O'
          --ELSE        'X'   null ó���Ǵ��� ( �ϱ� )
      END case_gender
--    , CASE �÷��� �Ǵ� ���� WHEN ���ǽ� THEN ��ȯ��
--                          WHEN ���ǽ� THEN ��ȯ��
--                          WHEN ���ǽ� THEN ��ȯ��
--                          ELSE  ��ȯ��
--      END
FROM insa;


-- [����] emp ���̺��� 10�� �μ������� 10%�λ�
--                     20��    "     20%�λ�
--                �׿� �μ�������      15%�λ�.
-- ( CASE �Լ��� ����ؼ� Ǯ��� )
SELECT t.*
     -- DECODE �Լ� ��� �ڵ�. 
     , pay * DECODE(deptno, 10, 1.1, 20, 1.2, 1.15) "decode �λ�� pay"
     , pay * CASE deptno 
                 WHEN 10 THEN 1.1
                 WHEN 20 THEN 1.2
                 ELSE         1.15
               END "case �λ�� pay"
FROM ( -- �ζ��κ�(inline view)
        SELECT deptno, ename
             , sal + NVL(comm, 0) pay
        FROM emp
     ) t;
-- sal��� ���̺�
SELECT * 
FROM salgrade;
1   700       1200
2   1201   1400
3   1401   2000
4   2001   3000
5   3001   9999
--
SELECT ename, sal 
      , CASE 
           WHEN sal BETWEEN 700    AND 1200 THEN 1
           WHEN sal BETWEEN 1201 AND 1400 THEN 2
           WHEN sal BETWEEN 1401 AND 2000 THEN 3
           WHEN sal BETWEEN 2001 AND 3000 THEN 4
           WHEN sal BETWEEN 3001 AND 9999 THEN 5
        END grade
FROM emp;
-- ( �ϱ� )   [ �� ���� ���� ]
--       �� �� ���̺��� ���� X -> ���� ����
--       ������������  BETWEEN ~ AND 
SELECT ename, sal, grade
FROM emp e JOIN salgrade s ON sal BETWEEN losal AND hisal ;
       
-- [����] emp ���̺��� �Ի�⵵�� �������. 
--                     1���޿� �Ի��� ������� ��ȸ.
7369   SMITH   80/12/17
7499   ALLEN   81/02/20
7521   WARD   81/02/22
7566   JONES   81/04/02
7654   Martin   81/09/28
7698   BLAKE   81/05/01
7782   CLARK   81/06/09
7839   KING   81/11/17
7844   TURNER   81/09/08
7900   JAMES   81/12/03
7902   FORD   81/12/03
7934   MILLER   82/01/23
-- Ǯ�� 1) 
--SELECT empno, ename, hiredate
--     , TO_CHAR( hiredate, 'MM' ) �Ի��ѿ�
--     , EXTRACT( MONTH FROM hiredate) �Ի��ѿ�
--FROM emp;
-- 1��, 2�� ~ 12�� �Ի��� ����� ���.
SELECT COUNT( * )
FROM emp
WHERE TO_CHAR( hiredate, 'MM' ) = 1;
WHERE TO_CHAR( hiredate, 'MM' ) = '01';

-- Ǯ�� 2) 
SELECT 
      TO_CHAR( hiredate, 'MM' ) ,
      COUNT(*)
FROM emp
-- WHERE TO_CHAR( hiredate, 'MM' ) = 1
GROUP BY TO_CHAR( hiredate, 'MM' )
-- HAVING�� ���...
ORDER BY TO_CHAR( hiredate, 'MM' ) ASC;
-- Ǯ�� 3)
SELECT  
      -- empno, ename, hiredate  ,
      COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 1, 'X') )  month_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 2, 'X') )  month_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 3, 'X') )  month_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 4, 'X') )  month_4
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 5, 'X') )  month_5
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 6, 'X') )  month_6
FROM emp;
-- �� �б⺰�� �Ի��� ����� �ľ�
-- 1~3 1�б�    4~6 2�б�  7~9 3�б� 10~12 4�б�
SELECT  
      -- empno, ename, hiredate  ,
        COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 1, 'X') )  �б�_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 2, 'X') )  �б�_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 3, 'X') )  �б�_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 4, 'X') )  �б�_4 
FROM emp;
--       
SELECT TO_CHAR( hiredate, 'YYYY'), TO_CHAR( hiredate, 'MM'), COUNT(*) 
FROM emp
GROUP BY TO_CHAR( hiredate, 'YYYY'), TO_CHAR( hiredate, 'MM')
ORDER BY TO_CHAR( hiredate, 'YYYY'), TO_CHAR( hiredate, 'MM');
       
-- [����]  ��������
--               ������   25.10.5.   ���� 9�� ����
--               ������   25.10.15.  �� 12�� ����
--        ������ ���� �������� ���θ� üũ�ϴ� ������ �ۼ�����..
SELECT SYSDATE
       , TO_CHAR( SYSDATE , 'DS TS' )
       , TO_DATE( '25.10.5 ���� 9', 'YY.MM.DD AM HH' )
       , TO_CHAR(  TO_DATE( '25.10.5 ���� 9', 'YY.MM.DD AM HH' ), 'DS TS' )
       , TO_DATE( '25.10.15 12', 'YY.MM.DD HH24' )
       , TO_CHAR(  TO_DATE( '25.10.15 12', 'YY.MM.DD HH24' ), 'DS TS' )
       , CASE 
           WHEN SYSDATE BETWEEN TO_DATE( '25.10.5 ���� 9', 'YY.MM.DD AM HH' ) AND TO_DATE( '25.10.15 12', 'YY.MM.DD HH24' ) THEN '��������'
           ELSE '���� �Ұ���'
         END
FROM dual;


-- [����1] emp , salgrade ���̺��� ����ؼ� �Ʒ� ��°���� ���� ���� �ۼ��ϼ���. 
-- 1) NON EQUI JOIN
select *
from emp;

select *
from salgrade;

select
    e.empno,
    e.ename,
    e.sal,
    to_char(sg.losal) || ' ~ ' ||to_char(sg.hisal) as range_grade,
    sg.grade
from emp e
join salgrade sg
on e.sal between sg.losal and sg.hisal
order by e.sal;


-- 2) CASE
select
    empno,
    ename,
    sal,
    case
        when sal between 700 and 1200 then '700 ~ 1200'
        when sal between 1201 and 1400 then '1201 ~ 1400'
        when sal between 1401 and 2000 then '1401 ~ 2000'
        when sal between 2001 and 3000 then '2001 ~ 3000'
        when sal between 3001 and 9999 then '3001 ~ 9999'
    end as range_grade,
    case
        when sal between 700 and 1200 then 1
        when sal between 1201 and 1400 then 2
        when sal between 1401 and 2000 then 3
        when sal between 2001 and 3000 then 4
        when sal between 3001 and 9999 then 5
        else 0
    end as grade
from emp
order by sal;


     EMPNO ENAME             SAL RANGE_GRADE             GRADE
---------- ---------- ---------- ------------------ ----------
      7369 SMITH             800 700 ~ 1200                  1
      7900 JAMES             950 700 ~ 1200                  1
      7521 WARD             1250 1201 ~ 1400                 2
      7654 Martin           1250 1201 ~ 1400                 2
      7934 MILLER           1300 1201 ~ 1400                 2
      7844 TURNER           1500 1401 ~ 2000                 3
      7499 ALLEN            1600 1401 ~ 2000                 3
      7782 CLARK            2450 2001 ~ 3000                 4
      7698 BLAKE            2850 2001 ~ 3000                 4
      7566 JONES            2975 2001 ~ 3000                 4
      7902 FORD             3000 2001 ~ 3000                 4
      7839 KING             5000 3001 ~ 9999                 5
 
12�� ���� ���õǾ����ϴ�. 

--group by�� + having�� ����
--���� insa ���̺��� �ѻ����, ���ڻ����, ���ڻ������ ��ȸ
select 
    case 
        when substr(ssn, 8, 1) in ('1', '3', '5', '7') then '���� �����'
        when substr(ssn, 8, 1) in ('2', '4', '6', '8') then '���� �����'
    end as gender,
    count(*) as gender_count
from insa
group by
    case 
        when substr(ssn, 8, 1) in ('1', '3', '5', '7') then '���� �����'
        when substr(ssn, 8, 1) in ('2', '4', '6', '8') then '���� �����'
    end;

select
    (select count(*) "�����"from insa) "��ü�����"
    ,(select count(*) "�����"from insa where mod(substr(ssn,8,1),2)=1) "���ڻ����"
    ,(select count(*) "�����"from insa where mod(substr(ssn,8,1),2)=0) "���ڻ����"
from dual;

select count(*) "�� �����"
    ,count(decode(mod(substr(ssn,8,1),2),1,'O'))"���ڻ����"
    ,count(decode(mod(substr(ssn,8,1),2),0,'X'))"���ڻ����"
from insa;
        
select count(*) "�� �����"
    ,count(case mod(substr(ssn,8,1),2)when 1 then 'O' end)"���ڻ����"
    ,sum(case mod(substr(ssn,8,1),2)when 0 then 1 end)"���ڻ����"
from insa;
    
    
select decode( mod(substr(ssn,8,1),2),1,'����','����') gender,count(*) "�����"
from insa
group by mod(substr(ssn,8,1),2)
union all
select '�� �����',count(*)
from insa;

--group by rollup �Ǵ� cube
select decode( mod(substr(ssn,8,1),2),1,'����',0,'����','��ü�����') gender
    ,case mod(substr(ssn,8,1),2)
        when 1 then '����'
        when 0 then '����'
        else '��ü�����'
    end gender
    ,count(*) "�����"
from insa
group by rollup(mod(substr(ssn,8,1),2));

------------------------
--���� emp ���̺��� �� �μ��� �޿� �� ��ȸ
--�μ����� ����� �����Բ�
--40�� �μ��� 0 ǥ��

select d.deptno,d.dname,nvl(sum(e.sal),0) as sum_pay
from dept d
left join emp e on d.deptno=e.deptno
group by d.deptno,d.dname

union all

select
  null as deptno,
  job as dname,
  sal as sum_pay
from emp
where deptno is null;

select deptno, dname,nvl(sum(sal),0) as sum_pay
from dept


select *
from emp;

select *
from dept;

-- ��
select dname,nvl(sum_pay,0)
from(
    select deptno,sum(sal+nvl(comm,0))sum_pay
    from emp
    group by deptno
)e full join dept d on e.deptno=d.deptno;

--���� emp���̺��� �μ��� �׷���, job���� �׷���, �� �޿��� ��ȸ

select deptno, job,sum(sal+nvl(comm,0)) sum_pay
from emp
group by deptno,job
union all
select deptno,null as job ,sum(sal+nvl(comm,0)) sum_pay
from emp
group by deptno
union all
select null as deptno ,null as job,sum(sal+nvl(comm,0)) sum_pay
from emp
order by deptno,job;

--rollup
select deptno, job,sum(sal+nvl(comm,0)) sum_pay
from emp
group by rollup(deptno,job);

--cube
select deptno, job,sum(sal+nvl(comm,0)) sum_pay
from emp
group by cube(deptno,job);


--���� �� �μ��� �ְ� �޿����� �޴� ��� ����

select empno,ename,sal+nvl(comm,0) pay, deptno
from emp m
where sal+nvl(comm,0)=(
            select max(sal+nvl(comm,0))
            from emp
--            where deptno=m.deptno
            where nvl(deptno,0)=nvl(m.deptno,0)
            );
            



select *
from emp;
--���� emp���̺��� �ְ�޿����� �޴� ��� ����

select deptno, empno,ename,sal+nvl(comm,0) pay
from emp
where sal+nvl(comm,0) in(
    select max(sal+nvl(comm,0)) 
    from emp   
);

--����
select *
from
(
    select empno,ename,sal+nvl(comm,0) pay, deptno,
            (
                select count(*)+1
                from emp s
                where s.sal+nvl(s.comm,0)>m.sal+nvl(m.comm,0)
             ) emp_pay_rank,
             (
                select count(*)+1
                from emp s
                where s.sal+nvl(s.comm,0)>m.sal+nvl(m.comm,0)
                    and s.deptno=m.deptno
             )dept_pay_rank
    from emp m
    order by deptno,dept_pay_rank
)
where dept_pay_rank<=2;

--sql ������ : all, any, [exists]

where exists(select deptno from dept where deptno=10); --��
select deptno from dept where deptno=20;
select deptno from dept where deptno=30;
where exists(select deptno from dept where deptno=50);--����
--group by + having
--���� insa���̺��� �μ��� ������� 10���̻��� �μ� ��ȸ
select *
from(
    select buseo,count(*) "CNT"
    from insa
    group by buseo
)
where CNT>=10
order by buseo asc;
--group by ���� ����� �Ŀ� �������� �ʿ��� ��� ���� + having��


select buseo,count(*) "CNT"
from insa
    group by buseo 
having count(*)>=10
order by buseo asc;

--���� insa ���̺��� ���ڻ������ 5�� �̻��� �μ��� �μ���� ������� ���

select buseo, count(*) as ���ڻ����
from insa
where mod(substr(ssn,8,1),2)=0
group by buseo
having count(*)>=5;



select *
from insa;


--emp ���̺��� ����� �޿�, ��� ��ü ��պ��� �޿��� ����/����/���� ���

SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay,
    CASE
        WHEN sal+NVL(comm,0)>(
            SELECT AVG(sal+NVL(comm,0))
            FROM emp
        )THEN '����'
        WHEN sal+NVL(comm,0)<(
            SELECT AVG(sal+NVL(comm,0))
            FROM emp
        )THEN '����'
        ELSE '����'
        END ��
FROM emp;

-- Ǯ�� - case
SELECT empno,ename,pay-avg_pay,
CASE
        WHEN pay-avg_pay>0 THEN '����'
        WHEN pay-avg_pay<0 THEN '����'
        ELSE '����'
        end �޿���

FROM(
SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay
FROM emp
);
--Ǯ�� - decode
SELECT empno,ename,pay-avg_pay,
    DECODE(SIGN(pay-avg_pay),-1,'����',1,'����','����')��
FROM(
SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay
FROM emp
);

SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay,
    CASE
        WHEN sal+NVL(comm,0)>(SELECT AVG(sal+NVL(comm,0))FROM emp)THEN '����'
        WHEN sal+NVL(comm,0)<(SELECT AVG(sal+NVL(comm,0))FROM emp)THEN '����'
        ELSE '����'
        END ��
FROM emp;

-- [����] insa ���̺���
--   ���� ��� ��� �߿� �μ��� ����, ���� �����
--                           ���ڱ޿�����, ���� �޿����� ��ȸ(���)
-- [��� ����]
--BUSEO                �����ο���      �����ο��� ���ڱ޿���      ���ڱ޿���     
----------------- ---------- ---------- ---------- ----------
--���ߺ�                   0          2             1,790,000
--��ȹ��                   2          1  5,060,000  1,900,000
--������                   4          5  6,760,000  6,400,000
--�λ��                   1          0  2,300,000           
--�����                   0          1               960,400
--�ѹ���                   2          1  3,760,000    920,000
--ȫ����                   0          1               950,000


SELECT buseo, 
        COUNT( DECODE(  MOD( SUBSTR(ssn, -7,1), 2 ), 1 , 'O') ) "���ڻ����",
        COUNT( DECODE(  MOD( SUBSTR(ssn, -7,1), 2 ), 0 , 'O') ) "���ڻ����",
        NVL(TO_CHAR(SUM(DECODE(SUBSTR(ssn, 8, 1), '1', basicpay+sudang )), '9,999,999'),' ') AS ���ڱ޿���,
        NVL(TO_CHAR(SUM(DECODE(SUBSTR(ssn, 8, 1), '2', basicpay+sudang )), '9,999,999'),' ') AS ���ڱ޿���
FROM insa
WHERE city='����'
GROUP BY buseo;


--Ǯ��
WITH temp AS(
    SELECT *
    FROM insa
    WHERE  city='����'
)
SELECT 
    DISTINCT t.buseo,
    (SELECT COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 1 , 'O')) FROM temp WHERE buseo = t.buseo) ���ڻ����,
    (SELECT COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 0 , 'O')) FROM temp WHERE buseo = t.buseo) ���ڻ����,
    (SELECT SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 1 , basicpay+sudang)) FROM temp WHERE buseo = t.buseo) ���ڱ޿���,
    (SELECT SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 0 , basicpay+sudang)) FROM temp WHERE buseo = t.buseo) ���ڱ޿���
FROM temp t;
    
--Ǯ��2
SELECT buseo    
    ,COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,'O')) ���ڻ����
    ,COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,'O')) ���ڻ����
    ,NVL(TO_CHAR(SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,basicpay)),'9G999G999'),' ') �����ѱ޿���
    ,NVL(TO_CHAR(SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),0,basicpay)),'9G999G999'),' ') �����ѱ޿���

FROM insa
WHERE city='����'
GROUP BY buseo
ORDER BY buseo;
--Ǯ��3
SELECT buseo
    ,DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,'����','����') as gender
    ,COUNT(*)
    ,TO_CHAR(SUM(basicpay),'9G999G999')
FROM insa
WHERE city='����'
GROUP BY buseo,MOD( SUBSTR(ssn, -7,1), 2 )
ORDER BY buseo,gender;

--���� emp���̺��� �޿� ���� TOP 5 ����� ���� ��ȸ

select *
from
(
    select empno,ename,sal+nvl(comm,0) pay, deptno,
            (
                select count(*)+1
                from emp s
                where s.sal+nvl(s.comm,0) > m.sal+nvl(m.comm,0)
             ) emp_pay_rank
    from emp m
    order by deptno
)
where emp_pay_rank<=5
order by emp_pay_rank;

--Ǯ��2 - TOP-N �м����
--�ζ��κ� + ORDER BY
SELECT t.*,ROWNUM
FROM(
    SELECT empno,ename,hiredate,sal+NVL(comm,0) pay
    FROM emp
    ORDER BY sal+NVL(comm,0) DESC
) t
WHERE ROWNUM <=5;

--���࿡ 
SELECT *
FROM(
    SELECT t.*,ROWNUM r
    FROM(
        SELECT empno,ename,hiredate,sal+NVL(comm,0) pay
        FROM emp
        ORDER BY pay DESC
) t
)
WHERE r BETWEEN 3 AND 5;

--���� rank
--�޿������� ��� �ű��
select empno, ename, sal+nvl(comm,0) pay
        ,rank() over(order by sal+nvl(comm,0))as "RANK �Լ� �޿�����"
        ,dense_rank() over(order by sal+nvl(comm,0))as "DENSE_RANK �Լ� �޿�����"
from emp;

select empno, ename, sal
        ,rank() over(order by sal)as "RANK �Լ� �޿�����" -- �ߺ���� O �������� X 
        ,dense_rank() over(order by sal)as "DENSE_RANK �Լ� �޿�����" -- �ߺ���� O �������� O
        ,row_number() over(order by sal)as "ROW_NUMBER �Լ� �޿�����" -- �ߺ���� X �������� O
from emp;
--���� emp���̺��� �� �μ��� �޿����� ������ �Űܼ� ���

select d.deptno,d.dname
        ,nvl(sum(sal+nvl(comm,0)),0)dept_sum_pay
        ,rank() over(order by nvl(sum(sal+nvl(e.comm,0)),0)desc) as "����"
from dept d
full join emp e on d.deptno=e.deptno
group by d.deptno,d.dname;


select *
from emp;

select *
from dept;

--Ǯ�� top-n
select t.*,rownum
from(
    select nvl(deptno,0) deptno
        ,sum(sal+nvl(comm,0))dept_sum_pay
        from emp
        group by deptno
        order by dept_sum_pay desc
) t;

--Ǯ��2 �������� �Լ� rank(), dense_rank(),row_number()


    select nvl(deptno,0) deptno
        ,sum(sal+nvl(comm,0))dept_sum_pay
        ,rank() over(order by sum(sal+nvl(comm,0))desc)as "����"
        from emp
        group by deptno;

--Ǯ��3 group by ��
select deptno,ename
        , sal+nvl(comm,0) pay
from emp
order by deptno asc, pay desc;

SELECT *
FROM(
    SELECT deptno,ename
            , sal+nvl(comm,0) pay
--            , rank() over( partition by(deptno) order by sal+nvl(comm,0) desc )����
--            , rank() over( partition by deptno order by sal+nvl(comm,0) desc )����
            , rank() over( order by sal+nvl(comm,0) desc )����

    FROM emp
)
WHERE ���� BETWEEN 2 AND 3;
WHERE ����<=2;
WHERE ����=1;
--order by deptno asc, pay desc;
---------------------------------
--���� INSA���̺��� ���ڻ������ ���帹�� �μ���, ���ڻ������ ����ϴ� ����

SELECT buseo,���ڻ����
FROM(
    SELECT buseo,
        COUNT(CASE WHEN MOD(TO_NUMBER(SUBSTR(ssn, -7, 1)), 2) = 0 THEN 1 END) AS ���ڻ����,
        RANK() OVER(ORDER BY COUNT(CASE WHEN MOD(TO_NUMBER(SUBSTR(ssn, -7, 1)), 2) = 0 THEN 1 END)DESC)AS ����
    FROM insa
    GROUP BY buseo
)
WHERE ����=1;

--Ǯ��1
WITH t AS(
    SELECT buseo,COUNT(*) ���ڻ����
    FROM insa
    WHERE MOD(SUBSTR(ssn,8,1),2)=0
    GROUP BY buseo
    ORDER BY ���ڻ���� DESC
)
SELECT *
FROM t
WHERE ���ڻ���� =(SELECT MAX(���ڻ����)FROM t);

--Ǯ��2 ���� �Լ�
SELECT *
FROM(
    SELECT buseo,COUNT(*) ���ڻ����,
        RANK() OVER(ORDER BY COUNT(*) DESC)����
    FROM insa
    WHERE MOD(SUBSTR(ssn,8,1),2)=0
    GROUP BY buseo
)
WHERE ����=1;
--Ǯ��3
--ORA-00937: not a single-group group function
    SELECT buseo,COUNT(*) ���ڻ����,
        RANK() OVER(PARTITION BY buseo ORDER BY COUNT(*) DESC)����
    FROM insa
    WHERE MOD(SUBSTR(ssn,8,1),2)=0;
    
--insa ���̺��� basicpay�� ���� 10%�� �ش��ϴ� ������� �̸�, �⺻���� ���   
    
WITH total_cnt as(
    SELECT COUNT(*) as cnt from insa
),ranked as(
SELECT name,basicpay,
    RANK() OVER(ORDER BY basicpay desc) as rnk
FROM insa
)
SELECT name,basicpay
FROM ranked,total_cnt -- ũ�ν� ���� ?
WHERE rnk<=cnt*0.1;

--Ǯ�� 1
SELECT name, basicpay, r_rank
FROM (
        SELECT name, basicpay
               , RANK() OVER(ORDER BY basicpay DESC) r_rank
               , DENSE_RANK() OVER(ORDER BY basicpay DESC) dr_rank
        --     , ROW_NUMBER() OVER(ORDER BY basicpay DESC) rn_rank
        --     , TOP-N �м� ���;
        FROM insa
)
WHERE r_rank <= (SELECT COUNT(*)*0.1 FROM insa);
-- WHERE r_rank <= 6;
    
--Ǯ��2 -PERCENT_RANK
SELECT *
FROM(
SELECT name,basicpay,
    PERCENT_RANK() OVER(ORDER BY basicpay desc) as pr_rank
FROM insa
)
WHERE pr_rank<=0.1;
    
--emp ���̺��� sal �÷����� �����Ϸ� �������

SELECT ename,sal,TRUNC(p_rank,2),
    CASE
        WHEN p_rank BETWEEN 0 AND 0.33  THEN '��'
        WHEN p_rank BETWEEN 0.34 AND 0.66  THEN '��'
        WHEN p_rank BETWEEN 0.67 AND 1  THEN '��'
    END AS ����
FROM(
    SELECT ename, sal,
        PERCENT_RANK() OVER(ORDER BY sal desc) AS p_rank
    FROM emp
);

--Ǯ��

SELECT t.empno,t.ename,t.sal,
    CASE
        WHEN t.pk_rank<=0.33 THEN '��'
        WHEN t.pk_rank BETWEEN 0.34 AND 0.66 THEN '��'
        ELSE '��'
    END grade
FROM(
    SELECT emp.*,
        PERCENT_RANK() OVER(ORDER BY sal desc) pk_rank
    FROM emp
) t;


--Ǯ�� 2
NTILE(n) OVER (
    [PARTITION BY partition_expression]
    ORDER BY order_expression
)
SELECT emp.*
    , NTILE(3) OVER( ORDER BY sal DESC ) grade
    , DECODE(  NTILE(3) OVER( ORDER BY sal DESC ) , 1 , '��', 2, '��', '��' ) grade
FROM emp;

--Ǯ�� 3 NTILE �м��Լ� ���
SELECT *
FROM(
SELECT name, basicpay
    ,NTILE(10)OVER(ORDER BY basicpay DESC) grade
FROM insa
)
WHERE grade=1;

--FIRST_VALUE, LAST_VALUE
--�� �μ��� �ְ� sal�޴� ������� ��ȸ
SELECT deptno,ename,sal
FROM(
SELECT ename,sal,deptno
--    ,FIRST_VALUE(sal) OVER(ORDER BY sal DESC) max_sal
--    ,FIRST_VALUE(ename) OVER(ORDER BY sal DESC) max_ename
    ,FIRST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal DESC)deptno_max_sal
FROM emp
)
WHERE sal=deptno_max_sal;




--insa���̺��� �ֹι�ȣ�� ������ �������� ����

--����1 �����ȣ�� 1002,1005,1008�� ���
--update
UPDATE insa
SET ssn = SUBSTR(ssn, 1, 2)
        || TO_CHAR(SYSDATE, 'MMDD') 
        || SUBSTR(ssn, 7)            
WHERE NUM IN (1002, 1005, 1008);
--Ǯ��
SELECT num, ssn
       , SUBSTR(ssn, 1, 2) || TO_CHAR(SYSDATE, 'MMDD') ||SUBSTR(ssn, INSTR(ssn, '-'))
       , REGEXP_REPLACE(ssn, '^(\d{2})(\d{4})(-\d{7}$)', '\1?\3')
FROM insa
WHERE num IN(1002, 1005, 1008);

--Ȯ��
SELECT num,name,ssn
FROM insa
WHERE NUM IN(1002,1005,1008);
--����Ȯ��

SELECT *
FROM insa;

SELECT NUM, SSN,
        SUBSTR(ssn, 3, 4) AS birthday,
        TO_CHAR(SYSDATE, 'MMDD') AS today,
        CASE
            WHEN SUBSTR(ssn, 3, 4) < TO_CHAR(SYSDATE, 'MMDD') THEN '����'
            WHEN SUBSTR(ssn, 3, 4) > TO_CHAR(SYSDATE, 'MMDD') THEN '������'
            ELSE '����'
        END
FROM insa;

SELECT num,name,ssn
    ,TO_DATE(SUBSTR(ssn,3,4),'MMDD')
    ,TRUNC(SYSDATE,'DD') - TO_DATE(SUBSTR(ssn,3,4),'MMDD')a
    ,DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn,3,4),'MMDD')),0,'����',1,'����','������')
FROM insa;

--���� insa ���̺��� num,name,ssn,�ѱ�����,������ �� ���

���³��� : ���س⵵ - ���ϳ⵵ + 1

������ : ���س⵵ - ���ϳ⵵ 

SELECT num, name, ssn,
       TO_CHAR(SYSDATE, 'YYYY') - 
       (CASE 
            WHEN SUBSTR(ssn, 8, 1) IN ('1','2','5','6') THEN 1900 + TO_NUMBER(SUBSTR(ssn,1,2))
            WHEN SUBSTR(ssn, 8, 1) IN ('3','4','7','8') THEN 2000 + TO_NUMBER(SUBSTR(ssn,1,2))
            ELSE 1800 + TO_NUMBER(SUBSTR(ssn,1,2))
        END) +1 AS ���³���
        ,
        (CASE
            WHEN SUBSTR(ssn, 3, 4) <= TO_CHAR(SYSDATE, 'MMDD') 
                THEN  TO_CHAR(SYSDATE, 'YYYY') - 
                   (CASE 
                        WHEN SUBSTR(ssn, 8, 1) IN ('1','2','5','6') THEN 1900 + TO_NUMBER(SUBSTR(ssn,1,2))
                        WHEN SUBSTR(ssn, 8, 1) IN ('3','4','7','8') THEN 2000 + TO_NUMBER(SUBSTR(ssn,1,2))
                        ELSE 1800 + TO_NUMBER(SUBSTR(ssn,1,2))
                    END) 
            ELSE
                TO_CHAR(SYSDATE, 'YYYY') - 
                    (CASE 
                        WHEN SUBSTR(ssn, 8, 1) IN ('1','2','5','6') THEN 1900 + TO_NUMBER(SUBSTR(ssn,1,2))
                        WHEN SUBSTR(ssn, 8, 1) IN ('3','4','7','8') THEN 2000 + TO_NUMBER(SUBSTR(ssn,1,2))
                        ELSE 1800 + TO_NUMBER(SUBSTR(ssn,1,2))
                    END) -1 
        END) AS ������
FROM insa;

--Ǯ��
WITH t AS 
(
    SELECT insa.*
        , TO_CHAR( SYSDATE, 'YYYY') current_year
        -- RR�� YY�� ������
        -- , TO_CHAR( TO_DATE( SUBSTR( ssn, 0, 2), 'YY'), 'YYYY' ) birth_year
        -- , TO_CHAR( TO_DATE( SUBSTR( ssn, 0, 2), 'RR'), 'YYYY' ) birth_year
        --, SUBSTR(ssn, -7, 1) gender
        --, SUBSTR(ssn, 0, 2)  ssn_year2
        , SUBSTR(ssn, 0, 2) + CASE 
                                WHEN SUBSTR(ssn, -7, 1) IN (1,2,5,6) THEN  1900
                                WHEN REGEXP_LIKE( SUBSTR(ssn, -7, 1), '[3478]' ) THEN 2000
                                ELSE 1800
                              END birth_year
        , SIGN( TRUNC(SYSDATE) - TO_DATE(  SUBSTR( ssn, 3, 4 ) , 'MMDD' ) ) birth_sign                      
    FROM insa 
)
SELECT num, name, ssn
   , current_year - birth_year + 1 korean_age
   , current_year - birth_year +  DECODE( birth_sign,  -1, -1 , 0 ) international_age
FROM t;


SELECT DBMS_RANDOM.VALUE
        ,DBMS_RANDOM.VALUE(1,46)
        ,TRUNC(DBMS_RANDOM.VALUE(1,46))
        ,TRUNC(DBMS_RANDOM.VALUE(0,101))
FROM dual;

--������ȣ : 6�ڸ� ���� -> ���
--������ ������ȣ 6�ڸ��� �߻���Ű�� �����ۼ�

SELECT TRUNC(DBMS_RANDOM.VALUE(100000,100000))
FROM dual;

SELECT 
    DBMS_RANDOM.STRING('X', 10) --�빮��+����
    ,DBMS_RANDOM.STRING('U', 10)--�빮�ڸ�
    ,DBMS_RANDOM.STRING('L', 10)--�ҹ��ڸ�
    ,DBMS_RANDOM.STRING('P', 10)--��+�ҹ���+����+Ư������
    ,DBMS_RANDOM.STRING('A', 10)--��+�ҹ���

FROM dual;

--insa ���̺��� �������� 5���� ����� ��ȸ
SELECT *
    FROM(
            SELECT *
            FROM insa
            ORDER BY DBMS_RANDOM.VALUE
        )
WHERE ROWNUM <=5;

--Ǯ��
-- LEVEL �ǻ� Į��

SELECT LEVEL,TRUNC(DBMS_RANDOM.VALUE(1001,1060+1))
FROM dual
CONNECT BY LEVEL <=5;


SELECT *
FROM insa
WHERE num IN(
    SELECT TRUNC(DBMS_RANDOM.VALUE(1001,1060+1))
    FROM dual
    CONNECT BY LEVEL <=5
);

SELECT t.*,ROWNUM
FROM (
    SELECT *
    FROM insa
    ORDER BY DBMS_RANDOM.VALUE)t
WHERE ROWNUM<=5;

LISTAGG(column_name,'������')
    WITHIN GROUP(ORDER BY column_name);
    
SELECT deptno
    ,COUNT(*)
    ,LISTAGG(ename,', ')WITHIN GROUP(ORDER BY ename ASC) ename_list
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--���� ������ ����� Ȯ���ϸ� 40�� �μ��� �Բ� ���
--outer join (left, right, full)
SELECT d.deptno
    ,COUNT(*)
    ,LISTAGG(ename,', ')WITHIN GROUP(ORDER BY ename ASC) ename_list
FROM emp e FULL OUTER JOIN dept d ON d.deptno=e.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;


-- [����] JOB �� ������� ���(��ȸ)
--     CLERK   SALESMAN  PRESIDENT    MANAGER    ANALYST
------------ ---------- ---------- ---------- ----------
--         3          4          1          3          1

SELECT job
    ,COUNT(*)
FROM emp
GROUP BY job;

SELECT
    COUNT(CASE WHEN job = 'CLERK' THEN 1 END) AS CLERK,
    COUNT(CASE WHEN job = 'SALESMAN' THEN 1 END) AS SALESMAN,
    COUNT(CASE WHEN job = 'PRESIDENT' THEN 1 END) AS PRESIDENT,
    COUNT(CASE WHEN job = 'MANAGER' THEN 1 END) AS MANAGER,
    COUNT(CASE WHEN job = 'ANALYST' THEN 1 END) AS ANALYST
FROM emp;


--pivot
SELECT *
FROM(
    SELECT job
    FROM emp
)
PIVOT(
    COUNT(*)
    FOR job IN ('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST')
);

SELECT *
FROM(
    SELECT TO_CHAR(hiredate,'MM') �Ի��ѿ�
FROM emp
)
PIVOT(
     COUNT(*)
     FOR �Ի��ѿ� in('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
);



-- [����] 
--    DEPTNO DNAME             'CLERK' 'SALESMAN' 'PRESIDENT'  'MANAGER'  'ANALYST'
------------ -------------- ---------- ---------- ----------- ---------- ----------
--        10 ACCOUNTING              1          0           1          1          0
--        20 RESEARCH                1          0           0          1          1
--        30 SALES                   1          4           0          1          0
--        40 OPERATIONS              0          0           0          0          0 

SELECT *
FROM(
    SELECT job
    FROM emp
)
PIVOT(
    COUNT(*)
    FOR job IN ('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST')
);



SELECT *
FROM(
    SELECT d.deptno,d.dname,e.job
    FROM emp e
    RIGHT JOIN dept d ON e.deptno=d.deptno
)
PIVOT(
    COUNT(*)
    FOR job IN ('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST')
)
ORDER BY deptno;

--Ǯ��
SELECT
     d.deptno, dname 
     , COUNT( DECODE( job , 'CLERK', 'O' ) ) "CLERK"
     , COUNT( DECODE( job , 'SALESMAN', 'O' ) ) "SALESMAN"
     , COUNT( DECODE( job , 'PRESIDENT', 'O' ) ) "PRESIDENT"
     , COUNT( DECODE( job , 'MANAGER', 'O' ) ) "MANAGER"
     , COUNT( DECODE( job , 'ANALYST', 'O' ) ) "ANALYST"
FROM emp e FULL JOIN dept d ON d.deptno =  e.deptno
GROUP BY d.deptno, dname 
ORDER BY d.deptno ASC;



SELECT *
FROM(
    SELECT deptno,job
    FROM emp
)
PIVOT(
    COUNT(*)
    FOR job IN('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST')
)
ORDER BY DEPTNO;

--����
--���� �������   ���û����λ��  ���Ͼ��������
--DECODE
SELECT 
       COUNT(DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')),1, 'Y', NULL)) AS ����,
       COUNT(DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')),0, 'Y', NULL)) AS ����,
       COUNT(DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')),-1, 'Y', NULL)) AS ������
FROM insa;

--Ǯ��
WITH t AS(
    SELECT insa.*
        ,SIGN(TO_CHAR(SYSDATE,'MMDD')-SUBSTR(ssn,3,4))birth_sign
        FROM insa
)
--�������
SELECT
    COUNT(DECODE(birth_sign,-1,'O'))"������ ����"
    ,COUNT(DECODE(birth_sign,0,'O'))"����"
    ,COUNT(DECODE(birth_sign,1,'O'))"����"
FROM t;


--�������
--SELECT birth_sign,COUNT(*)
--FROM t
--GROUP BY birth_sign;


--PIVOT
SELECT * 
FROM (
    SELECT
        CASE
            WHEN SUBSTR(SSN, 3, 4) < TO_CHAR(SYSDATE, 'MMDD') THEN '����'
            WHEN SUBSTR(SSN, 3, 4) = TO_CHAR(SYSDATE, 'MMDD') THEN '����'
            ELSE '������'
        END AS ����
    FROM INSA
)
PIVOT (
    COUNT(*) FOR ���� IN ('����' , '����' , '������')
);

--Ǯ��
SELECT *
FROM (
     -- PIVOT ����� �Ǵ� SELECT��
     SELECT 
          --insa.*
           buseo
          , SIGN( TO_CHAR( SYSDATE, 'MMDD' ) - SUBSTR( ssn, 3,4) ) birth_sign
     FROM insa
)
PIVOT(
   COUNT(*)
   FOR birth_sign IN ( -1 AS "����X", 0 AS "����", 1 AS "����O" )
)
ORDER BY buseo ASC;

--����
SELECT *
FROM(
    SELECT deptno,sal+NVL(comm,0) pay
    FROM emp
)
PIVOT(
    SUM(pay)
    FOR deptno IN(10,20,30,40,null)
);

--����
SELECT *
FROM(
    SELECT deptno,sal+nvl(comm,0) pay
    FROM emp
)
PIVOT(
    SUM(pay) as �ѱ޿�
    ,MAX(pay) as �ְ��
    ,MIN(pay) as ������
    ,COUNT(pay) as �����
    FOR deptno IN (10,20,30,40,NULL)
);


--���� �л� ����(��,��,��)�����ϴ� ���̺�
DDL(CREATE,ALTER, DROP)
DROP TABLE tlb_pivot PURGE;

CREATE TABLE tbl_pivot(
    -- �÷���    �ڷ���
      no         NUMBER                PRIMARY KEY
    , name       VARCHAR2(20)          NOT NULL -- �ʼ� �Է� 
    , jumsu      NUMBER(3)
);
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 1, '�ڿ���', 90 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 2, '�ڿ���', 89 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 3, '�ڿ���', 99 );  -- mat
 INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 4, '�Ƚ���', 56 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 5, '�Ƚ���', 45 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 6, '�Ƚ���', 12 );  -- mat 
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 7, '���', 99 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 8, '���', 85 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 9, '���', 100 );  -- mat 

COMMIT; 
--
SELECT * 
FROM tbl_pivot;

--��ȣ �̸� �� �� ��
--1 �ڿ��� 90 89 99
--2 �Ƚ��� 56 45 12
--3 ���  99 85 100

SELECT ROW_NUMBER() OVER (ORDER BY name) AS ��ȣ
  ,name,��,��,��
FROM (
  SELECT name,
         CASE
           WHEN MOD(no, 3) = 1 THEN 'kor'
           WHEN MOD(no, 3) = 2 THEN 'eng'
           WHEN MOD(no, 3) = 0 THEN 'math'
         END AS ����, jumsu
  FROM tbl_pivot
)

PIVOT (
  MAX(jumsu) FOR ���� IN (
    'kor' AS ��,
    'eng' AS ��,
    'math' AS ��
  )
)
ORDER BY name;

-- [����] emp ���̺���
--       sal �÷��� �������� ���� 20%�� �ش� �Ǵ� ��� ���� ��ȸ.

select *
from emp;

SELECT *
FROM(
SELECT empno,ename,
    PERCENT_RANK() OVER(ORDER BY sal desc) as pr_rank
FROM emp
)
WHERE pr_rank<=0.2;


-- [����] insa ���̺��� 

select *
from insa;

SELECT 
    g.buseo,
    (SELECT COUNT(*) FROM insa) AS �ѻ����,
    d.�μ������,
    g.����,
    g.���������,
    ROUND(d.�μ������ / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "��/��%",
    ROUND(g.��������� / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "�μ�/��%",
    ROUND(g.��������� / d.�μ������ * 100, 1) || '%' AS "��/��%"
FROM
    (
        SELECT 
            buseo,
            DECODE(MOD(SUBSTR(ssn, -7, 1), 2), 1, 'M', 'F') AS ����,
            COUNT(*) AS ���������
        FROM insa
        GROUP BY buseo, DECODE(MOD(SUBSTR(ssn, -7, 1), 2), 1, 'M', 'F')
    ) g
JOIN
    (
        SELECT buseo, COUNT(*) AS �μ������
        FROM insa
        GROUP BY buseo
    ) d ON g.buseo = d.buseo
ORDER BY g.buseo, g.����;

--Ǯ��
WITH a AS(
    SELECT buseo,name,ssn
        ,DECODE(MOD(SUBSTR(ssn,8,1),2),1,'M','F') gender
    FROM insa
),b AS(
    SELECT buseo �μ���
    ,(SELECT COUNT(*) FROM insa) �ѻ����
    ,(SELECT COUNT(*) FROM insa WHERE buseo=a.buseo) �μ������
    ,gender ����
    ,COUNT(*) ���������
    FROM a
    GROUP BY buseo, gender
    ORDER BY buseo, gender
)
SELECT b.*
    ,ROUND(�μ������ / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "��/��%"
    ,ROUND(��������� / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "�μ�/��%"
    ,ROUND(��������� / �μ������ * 100, 1) || '%' AS "��/��%"
FROM b;


SELECT COUNT(*)*0.2
FROM emp;
-- sal ��������
--TOP-N
SELECT t.*,ROWNUM
FROM(
SELECT *
FROM  emp
ORDER BY sal desc
) t;

--RANK
SELECT *
FROM(
SELECT emp.*,
    RANK() OVER(ORDER BY sal DESC) sal_rank
FROM emp
)
WHERE sal_rank<=(SELECT COUNT(*)*0.2 FROM emp);
--PERCENT_RANK() �Լ�
SELECT *
FROM(
    SELECT emp.*,
        PERCENT_RANK() OVER(ORDER BY sal desc) as sal_rank
    FROM emp
)
WHERE sal_rank<=0.2;
--emp���̺��� �� ������� �Ի����ڸ� �������� 10�� 5���� 20��° �Ǵ� ��¥��
--����ؼ� ����ϴ� ������ �ۼ�
SELECT  
    ename,
    hiredate,
    ADD_MONTHS(hiredate ,10*12+5)+ 20
FROM emp;


[������]
        �μ������/��ü����� == ��/�� ����
        �μ��� �ش缺�������/��ü����� == �μ�/��%
        �μ��� �ش缺�������/�μ������ == ��/��%

�μ���     �ѻ���� �μ������        ����  ���������  ��/��%       �μ�/��%      ��/��%
���ߺ�       60       14         F       8       23.3%   13.3%       57.1%
���ߺ�       60       14         M       6       23.3%   10%       42.9%
��ȹ��       60       7         F       3       11.7%   5%       42.9%
��ȹ��       60       7         M       4       11.7%   6.7%       57.1%
������       60       16         F       8       26.7%   13.3%       50%
������       60       16         M       8       26.7%   13.3%       50%
�λ��       60       4         M       4       6.7%   6.7%       100%
�����       60       6         F       4       10%           6.7%       66.7%
�����       60       6         M       2       10%           3.3%       33.3%
�ѹ���       60       7         F       3       11.7%   5%       42.9%
�ѹ���       60       7         M     4       11.7%   6.7%       57.1%
ȫ����       60       6         F       3       10%           5%       50%


-- [����] insa ���̺��� �޿� ���� �޴� 5�� ���
-- [1] Ǯ��  TOP-N �м� ���
SELECT *
FROM (
    SELECT *
    FROM insa
    ORDER BY basicpay+sudang DESC
)
WHERE ROWNUM <= 5;

-- [2] Ǯ��  RANK �Լ� ���
SELECT *
FROM (
    SELECT
        insa.*,
        RANK() OVER (ORDER BY basicpay + sudang DESC) AS rnk
    FROM insa
)
WHERE rnk <= 5;
-------------------------------------------------------------
-- [����]emp ���̺��� 
-- ������� ���� ���� �μ���(dname), �����
-- ������� ���� ���� �μ���, ����� ���

-- �μ��� ��� �� �� �ִ�/�ּ� 1���� ���
WITH dept_count AS (
    SELECT deptno, COUNT(*) AS �����
    FROM emp
    GROUP BY deptno
),
ranked_depts AS (
    SELECT 
        d.dname,
        dc.�����,
        RANK() OVER (ORDER BY dc.����� DESC) AS max_rank,
        RANK() OVER (ORDER BY dc.����� ASC) AS min_rank
    FROM dept_count dc
    JOIN dept d ON dc.deptno = d.deptno
)
SELECT dname, �����
FROM ranked_depts
WHERE max_rank = 1 OR min_rank = 1;
--Ǯ�� 1
SELECT s.*
FROM(
    SELECT t.*
        ,RANK() OVER(ORDER BY ����� DESC) �����_RANK
    FROM(
        SELECT dname,COUNT(ename) �����
        FROM emp e RIGHT JOIN dept d ON d.deptno=e.deptno
        GROUP BY dname
        ORDER BY dname asc
    )t
)s
--WHERE �����_RANK IN(1,(SELECT MAX(�����_RANK)FROM t));
WHERE �����_RANK IN(1,4);

--Ǯ��2
WITH t AS(
        SELECT dname,COUNT(ename) �����
        FROM emp e RIGHT JOIN dept d ON d.deptno=e.deptno
        GROUP BY dname
        ORDER BY dname asc
),s AS(
 SELECT t.*
        ,RANK() OVER(ORDER BY ����� DESC) �����_RANK
    FROM t
)
SELECT s.*
FROM s
WHERE �����_RANK IN(1,(SELECT MAX(�����_RANK)FROM s));
--Ǯ��3
WITH a AS(
SELECT dname,COUNT(ename) dept_cnt
        ,RANK() OVER(ORDER BY COUNT(ename) DESC) cnt_rank
FROM dept d LEFT JOIN emp e ON d.deptno=e.deptno
GROUP BY dname
),b AS(
    SELECT MAX(dept_cnt) max_cnt,MIN(dept_cnt) min_cnt
    FROM a
)
SELECT a.dname,a.dept_cnt
FROM a,b
WHERE a.dept_cnt IN(b.max_cnt,b.min_cnt);

-- [����] emp ���̺���
--       �� �⵵��  ���� �Ի��� ����� ��ȸ..

SELECT 
    EXTRACT(YEAR FROM hiredate) AS �Ի�⵵,
    EXTRACT(MONTH FROM hiredate) AS �Ի��,
    COUNT(*) AS �����
FROM emp
GROUP BY 
    EXTRACT(YEAR FROM hiredate),
    EXTRACT(MONTH FROM hiredate)
ORDER BY 
    �Ի�⵵,�Ի��;
    
--Ǯ��
SELECT TO_CHAR(hiredate,'YYYY') h_year
    ,TO_CHAR(hiredate,'MM') h_month
    ,COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY'),TO_CHAR(hiredate,'MM')
ORDER BY h_year,h_month asc;
--Ǯ��2
SELECT *
    FROM(
        SELECT TO_CHAR( hiredate , 'YYYY' ) h_year
              , TO_CHAR( hiredate , 'MM' )  h_month
        FROM emp
        )PIVOT(
            COUNT(*)
            FOR h_month IN ('01','02','03','04','05','06','07','08','09','10','11','12')
        );
--��Ƽ�� ���

SELECT LEVEL  month
FROM dual
CONNECT BY LEVEL <=12;
--
SELECT h_year , b.month
      , COUNT(empno)
FROM (
        SELECT TO_CHAR( hiredate , 'YYYY' ) h_year
              , TO_CHAR( hiredate , 'MM' )  h_month
              , empno
        FROM emp
) a PARTITION BY (h_year) RIGHT JOIN ( 
        SELECT LEVEL  month
        FROM dual
        CONNECT BY LEVEL <=12  
) b ON a.h_month = b.month
GROUP BY  h_year , b.month
ORDER BY h_year , b.month ASC;


--����2
--emp ���̺��� �� �μ���, job�� ������� ���
SELECT deptno AS �μ���ȣ,
       job AS ����,
       COUNT(*) AS �����
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job;
--emp�� �� job���� Ȯ���ϴ� ����
--����Ŭ 10g���� ���� �߰��� ��� : PARTITION BY + OUTER JOIN ���� �߰����
--���̾��� - ��Ƽ��+����
SELECT deptno AS �μ���ȣ,
       b.job AS ����,
       COUNT(ename) AS �����
FROM emp a PARTITION BY(deptno) RIGHT JOIN (SELECT DISTINCT job FROM emp) b ON a.job=b.job
GROUP BY deptno, b.job
ORDER BY deptno, b.job;

--emp ���̺��� �� �μ��� �޿� ������ RANK �Լ��� ����ؼ�ó��

SELECT emp.*
    ,RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_rank
FROM emp;

-- [����]   
--       emp ���̺��� sal ���� ���� �޴� ����� �̸�, sal ���
--       emp ���̺��� sal ���� ���� �޴� ����� �̸�, sal ���

SELECT ename, sal
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp)
   OR sal = (SELECT MIN(sal) FROM emp)
ORDER BY sal DESC;

--Ǯ��
SELECT ename,sal
FROM(
    SELECT ename, sal
        ,RANK()OVER(ORDER BY sal DESC)sal_rank
    FROM emp
)
WHERE sal_rank=1;
--Ǯ��2 �����Լ�() keep()
SELECT MAX(sal)
FROM emp;


SELECT MAX(ename) KEEP(DENSE_RANK FIRST ORDER BY sal DESC) ename, MAX(sal)
,MIN(ename) KEEP(DENSE_RANK LAST ORDER BY sal DESC) ename, MIN(sal)
FROM emp;

-- [����] emp ���̺��� �� �μ��� �ְ�sal, empno , ����sal  , empno ��ȸ

SELECT 
  deptno,
  MAX(empno) KEEP (DENSE_RANK FIRST ORDER BY sal DESC) AS max_sal_empno,
  MAX(sal)  AS max_sal,
  MAX(empno) KEEP (DENSE_RANK LAST ORDER BY sal DESC)  AS min_sal_empno,
  MIN(sal)  AS min_sal
FROM emp
GROUP BY deptno;

--1
SELECT ename,sal
    ,COUNT(*) OVER(ORDER BY sal ASC) --������ ���� ��ȯ�ϴ� ����
    ,SUM(sal) OVER(ORDER BY sal ASC) --������ ���� ��ȯ�ϴ� ����
    ,AVG(sal) OVER(ORDER BY sal ASC) --������ ����� ��ȯ�ϴ� ����
FROM emp;


--���� EMP���̺��� ����� �������� �ʴ� �μ���ȣ�� �μ����� ���
SELECT *
FROM emp;

SELECT *
FROM DEPT;

SELECT d.deptno, d.dname
FROM emp e RIGHT JOIN dept d ON d.deptno = e.deptno
WHERE e.empno IS NULL;

SELECT t.deptno,d.dname
FROM(
    SELECT deptno
    FROM dept
    MINUS
    SELECT DISTINCT deptno
    FROM emp
)t JOIN dept d ON t.deptno=d.deptno;

--Ǯ��2 NOT EXISTS

SELECT d.deptno, d.dname
FROM dept d
WHERE NOT EXISTS(
    SELECT 1 FROM emp e WHERE e.deptno = d.deptno
);
--�� �μ��� ����� ���� + ����� ������� 0�� �μ���ȣ�� �μ��� ���
SELECT d.deptno,dname
--    ,COUNT(empno)
FROM emp e RIGHT JOIN dept d ON d.deptno=e.deptno
GROUP BY d.deptno,dname
HAVING COUNT(empno)=0; --GROUP BY�� ������


SELECT d.deptno, d.dname
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

--�� emp ���̺� �޿� �������� ������ ���

SELECT deptno,ename,sal
    ,DECODE(NTILE(3) OVER(ORDER BY sal ASC),1,'��',2,'��','��') ntiles
    ,NTILE(2) OVER(PARTITION BY deptno ORDER BY sal ASC)
FROM emp
ORDER BY deptno;

--�ʺ� ��Ŷ - ����� ��������� ���ϴ��� ��ȯ�ϴ� �Լ�
--WIDTH_BUCKET() �Լ�
--WIDTH_BUCKET(expr,min_value,max_value,num_buckets)

SELECT ename,sal
    ,WIDTH_BUCKET(sal,0,4000,4) bucket
FROM emp;

--��

SELECT ename,TRUNC(sal/100+50)score
    ,DECODE(TRUNC(TRUNC(sal/100+50)/10),10,'��',9,'��',8,'��',7,'��',6,'��','��')grade
    ,CASE
        WHEN TRUNC(sal/100+50) BETWEEN 90 AND 100 THEN '��'
        WHEN TRUNC(sal/100+50) BETWEEN 80 AND 89 THEN '��'
        WHEN TRUNC(sal/100+50) BETWEEN 70 AND 79 THEN '��'
        WHEN TRUNC(sal/100+50) BETWEEN 60 AND 69 THEN '��'
        ELSE '��'
    END grade

FROM emp;

--LAG(),LEAD()
SELECT ename,sal
    ,LAG(sal)OVER(ORDER BY sal ASC) a
    ,LAG(sal,3)OVER(ORDER BY sal ASC) b
    ,LEAD(sal,3,-1)OVER(ORDER BY sal ASC) c
FROM emp
ORDER BY sal ASC;

--����Ŭ �ڷ��� ����
-- [����Ŭ �ڷ��� ( Data Type) ���� ]
1) CHAR[(size[BYTE ? CHAR])]  ���������� ���� ������, �ִ� ũ�� 2KB  
2) VARCHAR2[(size[BYTE ? CHAR])] ���������� ���� ������, �ִ� ũ�� 4KB��  
3) NCHAR[(size)] ���� �� ���ؼ� �����Ǹ�, CHAR���� ����.  
4) NVARCHAR2(size)  ���� �� ���ؼ� �����Ǹ�,   varchar2 ���� ����.  
5) LONG  �ִ� 2GB������ �������� ���ڵ����� 
6) RAW(size)  �ִ� 2GB������ ����Ʈ ���ڿ� ������ 
7) LONG RAW  �ִ� 2GB������ ���� ���ڿ� ������ 
8) NUMBER[(l,d)] ��ġ �����ͷ� ��ü���� 'l'�̰� �Ҽ��� �ڸ��� 'd' ���� number(6,2)=xxxx.xx 
9) BLOB  �ִ� ���� 4GB������ ����ȭ���� ���� ���� ������  
10) CLOB  �ִ� ���� 4GB������ ����ȭ���� ���� ���� ������ 
11) NCLOB  �ִ� ���� 4GB������ ���� ����� ���� ������ 
12) DATE  ��¥, �ð� ������(BC 4712.1.1��CE 4712.12.31����)  
13) TIMESTAMP[(n)] �Ҽ��� 9�ڸ������� ���е��� ���� ��¥ ����  
14) BFILE  �ִ� 4GB������ ���� ����, DB �ܺο� ���Ϸ� ���� 
15) ROWID  ���̺� ���� ����� �� ROWID Ÿ���� �̿��ؼ� ���� 






--����
   CREATE TABLE tbl_number
    (
       name VARCHAR2(10)
       , kor NUMBER(3)
       , eng NUMBER(3)
       , mat NUMBER(3)
       , tot NUMBER(3)
       , avg NUMBER(5,2)
    );
 --
 SELECT * FROM tbl_number;
 ROLLBACK;
 --
 INSERT INTO tbl_number VALUES ( 'ȫ�浿', 23.22, 199.88, 23, null, null);
 INSERT INTO tbl_number VALUES ( 'ȫ���', 98, 54, 76, null, null);
 INSERT INTO tbl_number VALUES ( '���ֿ�', 67, 99, 199, null, null);
 COMMIT;

UPDATE tbl_number
SET eng=100
WHERE name='ȫ�浿';

UPDATE tbl_number
SET mat=99
WHERE name='���ֿ�';

 UPDATE tbl_number
 SET  kor= CASE 
             WHEN kor NOT BETWEEN 0 AND 100 THEN null
             ELSE kor
         END
     , eng= CASE 
             WHEN eng  NOT BETWEEN 0 AND 100 THEN null
             ELSE eng
         END
     ,mat= CASE 
             WHEN mat  NOT BETWEEN 0 AND 100 THEN null
             ELSE mat
         END 
 -- WHERE
UPDATE  tbl_number
SET  tot= NVL(kor,0) + NVL(eng,0) + NVL(mat , 0)
    , avg= ( NVL(kor,0) + NVL(eng,0) + NVL(mat , 0) )/3;


SELECT *
FROM tabs --REGEXP_LIKE() �Լ� ����ؼ� ����
WHERE REGEXP_LIKE(table_name,'^tbl_s','i');
--WHERE table_name LIKE 'TBL\_S%' ESCAPE '\';
DROP TABLE tbl_sample PURGE;

CREATE TABLE tbl_sample
      ( 
        id  VARCHAR2(10)
       ,name VARCHAR2(20) 
       ,age NUMBER(3)
       ,birth DATE
      ); 
--Table TBL_SAMPLE��(��) �����Ǿ����ϴ�.

SELECT *
FROM tbl_sample;
--���̺���Ȯ��
DESCRIBE tbl_sample;
DESC tbl_sample;

--���̺� �÷� �߰�
ALTER TABLE tbl_sample
ADD(
    tel VARCHAR2(20)
    ,bigo VARCHAR2(255)
);

SELECT *
FROM tbl_sample;

--���̺���� : ��� �÷��� ũ�⸦ ���̴� ����
ALTER TABLE tbl_sample
MODIFY (bigo VARCHAR2(100));

DESC tbl_sample;

--�÷����� ���� bigo -> memo �÷��� ����
ALTER TABLE tbl_sample
RENAME COLUMN bigo TO memo;

--���̺�� ����
RENAME tbl_sample TO tbl_example;

DESC tbl_cstVSBoard;



DROP TABLE tbl_cstVSBoard PURGE;

CREATE TABLE tbl_cstVSBoard (
  seq NUMBER NOT NULL PRIMARY KEY,
  writer VARCHAR2(20) NOT NULL,
  pwd VARCHAR2(20) NOT NULL,
  email VARCHAR2(100),
  title VARCHAR2(200) NOT NULL,
  writedate DATE DEFAULT (SYSDATE),
  readed NUMBER DEFAULT 0 ,
  tag NUMBER NOT NULL,
  content CLOB
);
--CRUD

INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, writedate, readed, tag, content)
VALUES
(1, 'ȫ�浿', '1234', 'hong@naver.com', 'ù ��° �Խñ�', SYSDATE, 0, 0, 'ù ��° �Խñ� ����'); 


--ORA-00001: unique constraint (SCOTT.SYS_C007067) violated
INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, writedate, readed, tag, content)
VALUES
(2, '������', '1234', 'seo@naver.com', '�� ��° �Խñ�', SYSDATE, 0, 0, '�� ��° �Խñ� ����'); 
--�⺻Ű 
INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, tag, content)
VALUES
(3, '��â��', '1234', 'jung@naver.com', '�� ��° �Խñ�', 0, '�� ��° �Խñ� ����'); 

INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, tag, content)
VALUES
(seq_TBL_CSTVSBOARD.NEXTVAL, '��', '1234', 'jung@naver.com', '�� ��° �Խñ�', 0, '�� ��° �Խñ� ����');


--����
CREATE SEQUENCE seq_TBL_CSTVSBOARD
   [ INCREMENT BY ����]
   [ START WITH ����]
   [ MAXVALUE n ? NOMAXVALUE]
   [ MINVALUE n ? NOMINVALUE]
   [ CYCLE ? NOCYCLE]
   [ CACHE n ? NOCACHE];
   
CREATE SEQUENCE seq_TBL_CSTVSBOARD
START WITH 4
NOCACHE;
--������ ����
DROP SEQUENCE seq_TBL_CSTVSBOARD;

SELECT *
--FROM user_sequences;
FROM tabs;
FROM user_tables;

SELECT SEQ_TBL_CSTVSBOARD.CURRVAL
FROM dual;


SELECT *
FROM TBL_CSTVSBOARD
ORDER BY seq DESC;

ALTER TABLE TBL_CSTVSBOARD
RENAME COLUMN title TO subject;


--���̺� ����

CREATE TABLE tbl_emp30(no,name,hdate,dno)
AS
(
    SELECT empno,ename,hiredate,deptno
    FROM emp
    WHERE deptno=30
);

SELECT *
FROM tabs;
--�������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS
--WHERE REGEXP_LIKE(table_name,'^tbl_e','i');
WHERE TABLE_NAME='TBL_EMP30';

CREATE TABLE tbl_emp20
AS
(
    SELECT empno,ename,hiredate,deptno
    FROM emp
    WHERE deptno=20
);

--���������� ����ؼ� ���̺��� �������� �� ��������
--tbl_emp30 ���̺��� �������� x -> PK �������� �߰�

ALTER TABLE     ADD/MODIFY/DROP
ALTER TABLE     ADD �� ���

�����ġ�constraint�߰�
   ALTER TABLE ���̺��
   ADD (�÷��� datatype CONSTRAINT constraint�� constraint������
       [,�÷��� datatype]...);

ALTER TABLE tbl_emp30
--ADD (no NUMBER(4) CONSTRAINT PK_TBL_EMP30_NO);
ADD CONSTRAINT PK_TBL_EMP30_NO PRIMARY KEY(no);

--ALTER TABLE tbl_emp20
--ADD CONSTRAINT PRIMARY KEY(empno);

desc tbl_emp20;

--tbl_emp30 ���̺� �����ϴ� ���������� Ȯ�����Ŀ� pk�������� ����
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'TBL_EMP30';

�����ġ�
        ALTER TABLE ���̺��
        DROP [CONSTRAINT] constraint��; 

ALTER TABLE TBL_EMP30
DROP PRIMARY KEY;

--dept ���̺��� pk���������� Ȯ���ϰ� ����
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT';

ALTER TABLE DEPT
DROP PRIMARY KEY;

--tbl_emp30,tbl_emp20 ���̺� ����
DROP TABLE tbl_emp30 PURGE;
DROP TABLE tbl_emp20 PURGE;

--���������� ����ؼ� ���̺� ���� + ��� (������)�߰�
CREATE TABLE tbl_emp
AS
    SELECT *
    FROM emp
    WHERE 1=0;

--
DESC tbl_emp;
SELECT *
FROM tbl_emp;
DROP TABLE tbl_emp;

--DML(INSERT, UPDATE, DELETE)

SELECT *
FROM emp;

DESC emp;

INSERT INTO emp
VALUES(9999);

DELETE FROM dept
WHERE deptno=50;

rollback;

INSERT INTO dept
VALUES(50,'QC','SEOUL');

INSERT INTO emp (empno)
VALUES(9999);

INSERT INTO emp (empno,hiredate)
VALUES(9999,TO_DATE('01/22/88','MM/DD/YY'));

--update
--�����ȣ 9999���� ������� admin���μ���, �Ի����ڸ� ���ó�¥�� ����
UPDATE emp
SET ename = UPPER('admin'),hiredate=SYSDATE
WHERE empno=9999;

--9999 ����� job,mgr�� 7369���� job, mgr������ ����
UPDATE emp 
SET (job, mgr) = (
  SELECT job, mgr
  FROM emp
  WHERE empno = 7369
)
WHERE empno = 9999;

--���� insert
SELECT *
FROM tbl_emp;

-->emp���̺��� 30�� �μ��� 6���� --> tbl_emp���̺� insert
SELECT *
FROM tbl_emp;


INSERT INTO tbl_emp(
    SELECT *
    FROM emp
    WHERE deptno=30
);
rollback;

INSERT INTO tbl_emp(empno,ename)(
    SELECT empno,ename
    FROM emp
    WHERE deptno=30
);


tbl_emp10,tbl_emp20,tbl_emp30,tbl_emp40


CREATE TABLE tbl_emp10
AS
    SELECT *
    FROM emp
    WHERE 1=0;

DROP TABLE tbl_emp20
DROP TABLE tbl_emp30;


SELECT * FROM tbl_emp10;
SELECT * FROM tbl_emp20;
SELECT * FROM tbl_emp30;
SELECT * FROM tbl_emp40;

--������ ���� insert
--unconditional insert all  


�����ġ�
	INSERT ALL | FIRST
	  [INTO ���̺�1 VALUES (�÷�1,�÷�2,...)]
	  [INTO ���̺�2 VALUES (�÷�1,�÷�2,...)]
	  .......
	Subquery;

INSERT ALL
    INTO tbl_emp10 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
    INTO tbl_emp20 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
    INTO tbl_emp30 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
    INTO tbl_emp40 (empno,ename,job) VALUES(empno,ename,job);

rollback;

DELETE FROM emp
WHERE empno=9999;

--������ �ִ� insert
--conditional insert all 
�����ġ�
	INSERT ALL
	WHEN ������1 THEN
	  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
	WHEN ������2 THEN
	  INTO [���̺�2] VALUES (�÷�1,�÷�2,...)
	........
	ELSE
	  INTO [���̺�3] VALUES (�÷�1,�÷�2,...)
	Subquery;
    
	INSERT ALL
	WHEN deptno=10 THEN
        INTO tbl_emp10 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
	WHEN deptno=20 THEN
        INTO tbl_emp20 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
	WHEN deptno=30 THEN
        INTO tbl_emp30 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
	ELSE
        INTO tbl_emp40 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno);
        
    select *
    from emp;
--conditional first insert 
INSERT FIRST
	WHEN deptno=10 THEN
        INTO tbl_emp10 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
	WHEN sal>=1500 THEN
        INTO tbl_emp20 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
	WHEN deptno=30 THEN
        INTO tbl_emp30 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
	WHEN deptno=40 THEN
        INTO tbl_emp40 VALUES(empno,ename,job,mgr,hiredate,sal,comm,deptno)
    select *
    from emp;
    
    
--pivoting insert 
INSERT ALL
WHEN ������1 THEN
  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
  INTO [���̺�1] VALUES (�÷�1,�÷�2,...)
  ..........
Sub-Query;

create table tbl_sales(
employee_id        number(6),       -- �����ȣ
week_id            number(2),       -- 2�ڸ� ����
sales_mon          number(8,2),     
sales_tue          number(8,2),
sales_wed          number(8,2),
sales_thu          number(8,2),
sales_fri          number(8,2));

INSERT INTO tbl_sales VALUES(1101,4,100,150,80,60,120);
INSERT INTO tbl_sales VALUES(1102,5,300,300,230,120,150);

commit;

SELECT *
FROM tbl_sales;

create table tbl_sales_data(
employee_id        number(6),
week_id            number(2),
sales              number(8,2));

INSERT ALL
    INTO tbl_sales_data VALUES(employee_id,week_id,sales_mon)
    INTO tbl_sales_data VALUES(employee_id,week_id,sales_tue)
    INTO tbl_sales_data VALUES(employee_id,week_id,sales_wed)
    INTO tbl_sales_data VALUES(employee_id,week_id,sales_thu)
    INTO tbl_sales_data VALUES(employee_id,week_id,sales_fri)
select *
from tbl_sales;
        
select *
from tbl_sales_data;

drop table tbl_emp10 purge;
drop table tbl_emp20 purge;
drop table tbl_emp30 purge;
drop table tbl_emp40 purge;
drop table tbl_sales_data purge;
drop table tbl_sales purge;        
        

--���̺� ����
DROP TABLE ���̺�� PURGE;
--��� ���ڵ带 ����(WHERE �������� ���)
DELETE FROM ���̺�� + COMMIT, ROLLBACK;
--��緹�ڵ带 ����
TRUNCATE TABLE ���̺�� + COMMIT, ROLLBACK ;�� �� ����
        
--1 tbl_score ���̺� ���� Ȯ��
SELECT *
FROM TABS
WHERE REGEXP_LIKE(table_name,'tbl_score','i');
--2 tbl_score ���̺� ����
DROP TABLE tbl_core PURGE;
--3 tbl_score ���̺� ����
    --1)CREATE TABLE DDL
    --2)���������� ����ؼ� ���̺� ����
        --insa ���̺��� �����ȣ <= 1005�� num,name�÷��� �����ؼ�
        --tbl_score ���̺��� ����

CREATE TABLE tbl_score
AS
    SELECT num,name
    FROM insa
    WHERE num<=1005;
--4 num�÷��� pk�� ����

ALTER TABLE tbl_score
ADD CONSTRAINT pk_tbl_score_num PRIMARY KEY(num);
--5 ���� ���� Ȯ��
SELECT *
FROM user_constraints
WHERE table_name='TBL_SCORE';
--6) kor,eng,mat,tot,avg,grade,rank �÷� �߰�
--   kor,eng,mat,tot 3�ڸ� ���� �⺻�� 0
--   avg                p 5, s 2 �Ǽ� �⺻�� 0
--   grade CHAR(1 CHAR)
--   rank            3�ڸ� ����

ALTER TABLE TBL_SCORE
ADD (
    kor   NUMBER(3) DEFAULT 0,
    eng   NUMBER(3) DEFAULT 0,
    mat   NUMBER(3) DEFAULT 0,
    tot   NUMBER(3) ,
    avg   NUMBER(5,2) ,
    grade CHAR(1 CHAR),
    rank  NUMBER(3)
);     

--7 1001~1005 5���� �л��� �ִµ�
--KOR,ENG,MAT ���0��
--����Ŭ ������ ���� �߻���Ű�� ����

UPDATE tbl_score
SET kor=ROUND(DBMS_RANDOM.VALUE * 100)
    ,eng=ROUND(DBMS_RANDOM.VALUE * 100)
    ,mat=ROUND(DBMS_RANDOM.VALUE * 100);

select *
from tbl_score;
commit;


SELECT ROUND(DBMS_RANDOM.VALUE * 100)
    , TRUNC(DBMS_RANDOM.VALUE * 101)
    , FLOOR(DBMS_RANDOM.VALUE * 101)
    , DBMS_RANDOM.VALUE(0,101)
FROM dual;


--8 1005�� �л��� ��,��,�� ������ 1001�л��� ��-1,��-1
UPDATE tbl_score
SET (kor,eng)=(
    SELECT kor-1,eng-1
    FROM tbl_score
    WHERE num=1001
)
WHERE num=1005;

--9 ��� �л� �������� + 5 ������Ʈ (100�� �ʰ��� �ȵǰԲ�)
UPDATE tbl_score    
SET mat = CASE 
            WHEN mat + 5 > 100 THEN 100
            ELSE mat + 5
          END;
--SET mat=least(mat+5,100);

--10 ��� �л��� ����, ���
UPDATE tbl_score
SET tot=kor+eng+mat
    ,avg=(kor+eng+mat)/3;
--11 rank ���
UPDATE tbl_score t
SET rank = (
    SELECT rnk FROM (
        SELECT num,
               RANK() OVER (ORDER BY tot DESC) AS rnk
        FROM tbl_score
    ) s
    WHERE s.num = t.num
);

select *
from tbl_score;

commit;
--merge ���� : �������̺��� ������ �ٸ��� ���̺� �߰�/����
--���� ����÷�ó��
--��� 90~100 ��, 80~89 ��, �̾簡
SELECT *
FROM tbl_score;

UPDATE tbl_score
SET GRADE=CASE 
            WHEN avg BETWEEN 90 AND 100 THEN '��'
            WHEN avg BETWEEN 80 AND 89 THEN '��'
            WHEN avg BETWEEN 70 AND 79 THEN '��'
            WHEN avg BETWEEN 60 AND 69 THEN '��'
            ELSE '��'
        END;



-- �� [����1] tbl_score ���̺��� grade( ��� ) ó��
--    avg 90 �̻� '��', 80 �̻� '��'  ~ '��'
UPDATE tbl_score
SET GRADE=CASE 
            WHEN avg BETWEEN 90 AND 100 THEN '��'
            WHEN avg BETWEEN 80 AND 89 THEN '��'
            WHEN avg BETWEEN 70 AND 79 THEN '��'
            WHEN avg BETWEEN 60 AND 69 THEN '��'
            ELSE '��'
        END;


-- �� [����2] tbl_score ���̺��� ���л��鸸 �������� 10 ����. ( UPDATE )
--       (������) tbl_score ���̺��� ������ ������ �� �ִ� �÷� X
--               insa ���̺��� ssn ������ ���� �ľ��ؼ� UPDATE  �ϼ�...
UPDATE tbl_score t
SET kor=kor-10
WHERE EXISTS (
    SELECT 1
    FROM insa i
    WHERE t.num=i.num 
        AND REGEXP_LIKE( SUBSTR(i.ssn, 8, 1), '[1379]' )
);
    
    --Ǯ��
UPDATE tbl_score
SET kor = CASE
            WHEN kor - 10 < 0 THEN 0
            ELSE kor - 10
          END
WHERE num IN (
                SELECT num
                FROM insa
                WHERE MOD(SUBSTR(ssn, -7, 1), 2) = 1 AND num <= 1005
              );
    
select *
from insa;

select *
from tbl_score;

-- �� [����3] result  �÷� �߰� ( '�հ�', '���հ�', '����')
--   �հ� : ��� 60�� �̻�, 40 �̸� X
--  ���հ� : ��� 60�� �̸�
--   ���� : 40 �̸� 
ALTER TABLE tbl_score
ADD result VARCHAR2(10);

UPDATE tbl_score
SET result = 
    CASE 
        WHEN kor < 40 OR eng < 40 OR mat < 40 THEN '����'
        WHEN (kor + eng + mat)/3 < 60 THEN '���հ�'
        ELSE '�հ�'
    END;

--merge
--������ ���� �ΰ��� ���̺��� �ϳ��� ���̺�� ��ġ�� 


drop table tbl_emp purge;

CREATE TABLE tbl_emp
(
    id  NUMBER PRIMARY KEY
    ,name   VARCHAR2(10) NOT NULL
    , salary    NUMBER
    , bonus     NUMBER DEFAULT 100
);

INSERT INTO tbl_emp(id,name,salary) VALUES (1001,'jijoe',150);
INSERT INTO tbl_emp(id,name,salary) VALUES(1002,'cho',130);
INSERT INTO tbl_emp(id,name,salary) VALUES(1003,'kim',140);
COMMIT;
Select * 
from tbl_emp;



CREATE TABLE tbl_bonus
(
    ID NUMBER
    ,bonus NUMBER DEFAULT 100
);

INSERT INTO tbl_bonus(id) (SELECT e.id FROM tbl_emp e);

SELECT *
FROM tbl_bonus;

INSERT INTO tbl_bonus VALUES(1004,50);
COMMIT;

�����ġ�
    MERGE [hint] INTO [schema.] {table ? view} [t_alias]
      USING {{[schema.] {table ? view}} ?
            subquery} [t_alias]
      ON (condition) [merge_update_clause] [merge_insert_clause] [error_logging_clause];

��merge_update_clause ���ġ�
   WHEN MATCHED THEN UPDATE SET {column = {expr ? DEFAULT},...}
     [where_clause] [DELETE where_clause]

��merge_insert_clause ���ġ�
   WHEN MATCHED THEN INSERT [(column,...)]
    VALUES ({expr,... ? DEFAULT}) [where_clause]
   
��where_clause ���ġ�
   WHERE condition

��error_logging_clause ���ġ�
   LOG ERROR [INTO [schema.] table] [(simple_expression)]
     [REJECT LIMIT {integer ? UNLIMITED}]

MERGE INTO tbl_bonus b
USING (SELECT id,salary FROM tbl_emp) e
ON ( b.id=e.id )
WHEN MATCHED THEN
    UPDATE SET b.bonus=b.bonus+e.salary*0.01
WHEN NOT MATCHED THEN
    INSERT(b.id,b.bonus)VALUES(e.id,e.salary*0.01);
    
SELECT *
FROM tbl_bonus;

--���� ���Ʒ� MERGE
SELECT num,tot,RANK()OVER(ORDER BY tot DESC) r
FROM tbl_score;

--
UPDATE tbl_score
SET rank=null;
COMMIT;

--�������� CONSTRAINTS
--���� : �������� ���Ἲ�� ���� ���̺� ������ �߰�/����/������ �� ��Ģ

--�������� ����
--1) CREATE TABLE
--  �� IN-LINE �������� ����
        --���̺� ������ �÷��ڿ� �ٷ��ڵ�
--  �� OUT-OF-LINE �������� ����
        --���̺� ������ �÷��� ��� ������ �ڿ� �޸� ���������� ����
--2) ALTER TABLE ���̺� ����
--   ���̺� ���� �� ���� PK���������� ����


-- �������� 5����
1) PRIMARY KEY (PK) == UK + NN
2) FOREIGN KEY (FK)
    �θ�          �ڽ�
    dept         emp
    deptno       empno(PK)..deptno(FK)
    10                          
    20
    30
    40
3) UNIQUE KEY  (UK)
                �� �޴���, �̸���, �й�, �ֹι�ȣ
4) NOT NULL    (NN)
                �� �ʼ��Է�
5) CHECK       (CK)
    kor NUMBER(3) CK 0<=kor<=100

--emp ���̺� �������� ��ȸ
SELECT *
FROM user_constraints
WHERE table_name = 'EMP';
-- �������� 5����
--tbl_constraints ���̺� ��������Ȯ��
CREATE TABLE tbl_constraints
(
    empno NUMBER(4)
    ,ename VARCHAR2(20)
    ,deptno NUMBER(2)
    ,kor NUMBER(3)
    ,email VARCHAR2(250)
    ,city VARCHAR2(20)
);


INSERT INTO tbl_constraints (empno,ename,deptno) VALUES(1111,'ȫ�浿',60);
INSERT INTO tbl_constraints (empno,ename) VALUES(2222,'ȫ�浿');
INSERT INTO tbl_constraints (empno,ename) VALUES(3333,'ȫ�浿');
commit;

SELECT *
FROM tbl_constraints;

UPDATE tbl_constraints
SET ename='������'
WHERE empno=1111;

DELETE FROM tbl_constraints
WHERE ename='������';

--��� ���̺��� pk����
DROP TABLE tbl_constraints PURGE;

CREATE TABLE tbl_constraints
(
    empno NUMBER(4) NOT NULL CONSTRAINT PK_tbl_constraints_empno PRIMARY KEY
    ,ename VARCHAR2(20) NOT NULL 
    ,deptno NUMBER(2) CONSTRAINT FK_tbl_constraints_deptno
                        REFERENCES dept(deptno)
    ,kor NUMBER(3) CONSTRAINT CK_tbl_constraints_kor
                    CHECK (kor BETWEEN 0 AND 100)
    ,email VARCHAR2(250) CONSTRAINT UK_tbl_constraints_email UNIQUE
    ,city VARCHAR2(20) CONSTRAINT CK_tbl_constraints_city
                        CHECK(city IN('����','�泲','��õ','���'))
);

INSERT INTO tbl_constraints(empno,kor,ename) VALUES(5555,999,'ȫ��');
INSERT INTO tbl_constraints(empno,email,ename) VALUES(5555,'hong@naver.com','ȫ��');
INSERT INTO tbl_constraints(empno,email,ename) VALUES(6666,'hong@naver.com','ȫ���');

commit;

--PK �������Ǹ��� �������������� ����Ŭ ������ �ڵ����� SYS_C���� 
SELECT *
FROM user_constraints
WHERE table_name = 'TBL_CONSTRAINTS';

--�÷� ���� ������� �������� ������ ��
CREATE TABLE tbl_constraints
(
    empno NUMBER(4) NOT NULL
    ,ename VARCHAR2(20) NOT NULL 
    ,deptno NUMBER(2) 
    ,kor NUMBER(3) 
    ,email VARCHAR2(250) 
    ,city VARCHAR2(20) 
    ,  CONSTRAINT PK_tbl_constraints_empno PRIMARY KEY (empno)
    , CONSTRAINT FK_tbl_constraints_deptno 
                FOREIGN KEY(deptno) REFERENCES dept(deptno)
    , CONSTRAINT CK_tbl_constraints_kor CHECK (kor BETWEEN 0 AND 100)
    , CONSTRAINT UK_tbl_constraints_email UNIQUE (email)
    , CONSTRAINT CK_tbl_constraints_city CHECK(city IN('����','�泲','��õ','���'))
    
);
--pk 2�� �̻��� Į�� == ����Ű
--��)
�����ȣ        ������     ���޾�
7369        2025/08/25  4,000,000
7369        2025/09/25  4,000,000
7369        2025/10/25  4,000,000


--�������� ����
ALTER TABLE TBL_CONSTRAINTS
DROP PRIMARY KEY ;

ALTER TABLE TBL_CONSTRAINTS
DROP CONSTRAINT  CK_tbl_constraints_kor ;

ALTER TABLE TBL_CONSTRAINTS
DROP CONSTRAINT FK_tbl_constraints_deptno ;

SELECT *
FROM user_constraints
WHERE table_name = 'TBL_CONSTRAINTS';

ALTER TABLE TBL_CONSTRAINTS
DROP CONSTRAINT UK_tbl_constraints_email;

ALTER TABLE TBL_CONSTRAINTS
ADD(
      CONSTRAINT PK_tbl_constraints_empno PRIMARY KEY (empno)
    , CONSTRAINT FK_tbl_constraints_deptno 
                FOREIGN KEY(deptno) REFERENCES dept(deptno)
    , CONSTRAINT CK_tbl_constraints_kor CHECK (kor BETWEEN 0 AND 100)
    , CONSTRAINT UK_tbl_constraints_email UNIQUE (email)
    , CONSTRAINT CK_tbl_constraints_city CHECK(city IN('����','�泲','��õ','���'))
);

-- �������� CK city ��Ȱ��ȭ../ Ȱ��ȭ
ALTER TABLE TBL_CONSTRAINTS
    DISABLE CONSTRAINT CK_tbl_constraints_city [CASCADE];
    
ALTER TABLE TBL_CONSTRAINTS
    ENABLE CONSTRAINT CK_tbl_constraints_city [CASCADE];
    
--FK �����Ҷ�
-- ON DELETE CASCADE | ON DELETE SET NULL �ɼ��� �ǹ�
1) emp -> tbl_emp ���̺� ���� + ������ ����
DROP TABLE tbl_emp PURGE;

CREATE TABLE tbl_emp
    AS( SELECT * FROM emp ); 

2) 
DROP TABLE tbl_dept PURGE;

CREATE TABLE tbl_dept
    AS( SELECT * FROM dept ); 

3)
SELECT * FROM tbl_emp;
SELECT * FROM tbl_dept;

4) NN �������ǿ��� ���������� ������� �ʴ´�. �������� Ȯ��
SELECT *
FROM user_constraints
WHERE table_name IN ('TBL_DEPT','TBL_EMP');

5) tbl_dept ���̺� deptno �÷��� pk�������� �߰�
    -- ���̺� ������ �� �÷�����,���̺��� ������� �������� �߰�
    -- ALTER TABLE ADD ������ ���� ������ �߰�
ALTER TABLE tbl_dept
ADD(
      CONSTRAINT PK_tbl_constraints_deptno PRIMARY KEY (deptno)   
    );

6) tbl_emp ���̺� �������� 2�� �߰�
    ��. empno  pk
    ��. deptno fk + ON DELETE CASCADE

ALTER TABLE tbl_emp
ADD(
       CONSTRAINT PK_tbl_emp_empno PRIMARY KEY (empno)
      ,CONSTRAINT FK_tbl_emp_deptno FOREIGN KEY(deptno)
            REFERENCES tbl_dept(deptno) ON DELETE CASCADE
    );

--ON DELETE CASCADE
--ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
--���Ἲ ��������
DELETE FROM tbl_dept
WHERE deptno=10;
--dept(deptno PK)   emp(deptno FK)
      10        ����      10/10

SELECT * FROM tbl_dept;
SELECT * FROM tbl_emp;
SELECT * FROM tbl_emp WHERE deptno=30;

--ON DELETE SET NULL�ǹ� 
1) tbl_emp ���̺� �ִ� FK ���������� ����
SELECT *
FROM user_constraints
WHERE table_name IN('TBL_EMP');

ALTER TABLE tbl_emp
DROP CONSTRAINT FK_tbl_emp_deptno;
------
ALTER TABLE tbl_emp
ADD(
      CONSTRAINT FK_tbl_emp_deptno FOREIGN KEY(deptno)
            REFERENCES tbl_dept(deptno) ON DELETE SET NULL
    );

--tbl_dept 30 ����
--tbl_emp 30�� �μ����� 6�� �ִµ� ���� ���� ON DELETE CASCADE
DELETE FROM tbl_dept
WHERE deptno=30;

SELECT * FROM tbl_emp;
COMMIT;

-- JOIN
--�μ���ȣ, �μ���, �����, �Ի����� �÷� ��� emp,dept
--emp : [deptno], ename, hiredate
--dept : [deptno], dname

1)
SELECT dept.deptno, dname, ename, hiredate
FROM dept,emp
WHERE dept.deptno = emp.deptno; -- ��������

2)
SELECT d.deptno, dname, ename, hiredate
FROM dept d ,emp e
WHERE d.deptno = e.deptno; -- ��������

3) JOIN ~ ON ���� ����
SELECT d.deptno, dname, ename, hiredate
FROM dept d JOIN emp e ON d.deptno = e.deptno; -- ��������

4) USING ���
-- (����) ��ü��.�÷��� �Ǵ� ��Ī��.�÷������� ������� ����
SELECT deptno, dname, ename, hiredate
FROM dept JOIN emp USING(deptno);

5) NATURAL JOIN ���� - ��ü���� ������� ����
SELECT deptno, dname, ename, hiredate
FROM dept NATURAL JOIN emp;

--NON-EQUI JOIN
--emp ���̺��� sal�� ������ salgrade �޿�������̺��� grade(1,2,3,4,5)��ȸ

SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT empno,ename,sal,losal || '~'||hisal,grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

--INNER JOIN ���� ������ �����ϴ� �ุ �����´�
SELECT * FROM emp;

SELECT e.*,d.*
FROM emp e FULL OUTER JOIN dept d ON d.deptno=e.deptno;
FROM emp e LEFT OUTER JOIN dept d ON d.deptno=e.deptno;

--SELF JOIN
--A ���̺� + A ���̺�
--��) �����ȣ, �����, ���ӻ���� �����ȣ ���


SELECT a.empno, a.ename,a.mgr,b.ename
FROM emp a JOIN emp b ON a.mgr=b.empno;

--CROSS JOIN ��ī��Ʈ ��
SELECT emp.*
FROM emp,dept;

--ANTIJOIN

--SEMIJOIN



--���� ����
--1 å���̺�
CREATE TABLE book( 
       b_id     VARCHAR2(10)    NOT NULL PRIMARY KEY   -- åID
      ,title      VARCHAR2(100) NOT NULL  -- å ����
      ,c_name  VARCHAR2(100)    NOT NULL     -- c �̸�
     -- ,  price  NUMBER(7) NOT NULL
 );
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '�����ͺ��̽�', '����');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '�����ͺ��̽�', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '�ü��', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '�ü��', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '����', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '����', '�뱸');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '�Ŀ�����Ʈ', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '������', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '������', '����');

COMMIT;

SELECT *
FROM book;

--2 �ܰ� ���̺�
  CREATE TABLE danga(
      b_id  VARCHAR2(10)  NOT NULL  -- PK , FK
      ,price  NUMBER(7) NOT NULL    -- å ����
      
      ,CONSTRAINT PK_danga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_danga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE
);

INSERT INTO danga (b_id, price) VALUES ('a-1', 300);
INSERT INTO danga (b_id, price) VALUES ('a-2', 500);
INSERT INTO danga (b_id, price) VALUES ('b-1', 450);
INSERT INTO danga (b_id, price) VALUES ('b-2', 440);
INSERT INTO danga (b_id, price) VALUES ('c-1', 320);
INSERT INTO danga (b_id, price) VALUES ('d-1', 321);
INSERT INTO danga (b_id, price) VALUES ('e-1', 250);
INSERT INTO danga (b_id, price) VALUES ('f-1', 510);
INSERT INTO danga (b_id, price) VALUES ('f-2', 400);

COMMIT;

--3 ���� ���̺�
CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID
            REFERENCES book(b_id) -- ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL
);
INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '���Ȱ�');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '�տ���');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '�����');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '���ϴ�');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '�ɽ���');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '��÷');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '���ѳ�');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '�̿���');

COMMIT;

SELECT * 
FROM au_book;

--4 �� ���̺�

CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY 
      ,g_name   VARCHAR2(20) NOT NULL
      ,g_tel      VARCHAR2(20)
);
 
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '�츮����', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '���ü���', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '��������', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '���Ｍ��', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '��������', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '��������', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '���ϼ���', '777-7777');

COMMIT;

SELECT *
FROM gogaek;

--5 �Ǹ� ���̺�
CREATE TABLE panmai(
       id         NUMBER(5) NOT NULL PRIMARY KEY
      ,g_id       NUMBER(5) NOT NULL CONSTRAINT FK_PANMAI_GID
                     REFERENCES gogaek(g_id) ON DELETE CASCADE
      ,b_id       VARCHAR2(10)  NOT NULL CONSTRAINT FK_PANMAI_BID
                     REFERENCES book(b_id) ON DELETE CASCADE
      ,p_date     DATE DEFAULT SYSDATE
      ,p_su       NUMBER(5)  NOT NULL
);

INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (1, 1, 'a-1', '2000-10-10', 10);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (2, 2, 'a-1', '2000-03-04', 20);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (3, 1, 'b-1', DEFAULT, 13);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (4, 4, 'c-1', '2000-07-07', 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (5, 4, 'd-1', DEFAULT, 31);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (6, 6, 'f-1', DEFAULT, 21);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (7, 7, 'a-1', DEFAULT, 26);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (8, 6, 'a-1', DEFAULT, 17);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (9, 6, 'b-1', DEFAULT, 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (10, 7, 'a-2', '2000-10-10', 15);

COMMIT;

SELECT *
FROM panmai; 

--���̺�
--book : b_id(PK), title, c_name
--danga : b_id(PK.FK), price
--au_book : id(PK), b_id(FK), name
--gogaek : g_id(PK), g_name, g_tel
--panmai : id(PK), g_id(FK), b_id(FK ), p_date, p_su
--���� åID, å ����, ���ǻ�, å�ܰ� ���

1) JOIN ON ����
SELECT b.b_id,b.title,b.c_name,d.price
FROM book b JOIN danga d ON b.b_id=d.b_id;

2) 
SELECT b.b_id,b.title,b.c_name,d.price
FROM book b , danga d 
WHERE b.b_id=d.b_id;

3)  USING
SELECT b_id,title,c_name,price
FROM book JOIN danga USING (b_id);

4) NATURAL JOIN
SELECT b_id,title,c_name,price
FROM book NATURAL JOIN danga ;


-- [����] *åid, *����, �Ǹż���, *�ܰ�, ������(g_name), �Ǹűݾ�( p_su * price) ���.
--        book   book    panmai  danga    book     <- table      

--1 JOIN ON
SELECT b.b_id, title, p_su, price, g_name, p_su * price
FROM book b 
    JOIN danga d ON b.b_id = d.b_id 
    JOIN panmai p ON d.b_id = p.b_id
    JOIN gogaek g ON g.g_id = p.g_id;

--2 
SELECT b.b_id, title, p_su, price, g_name, p_su * price
FROM book b , danga d,panmai p,gogaek g 
WHERE b.b_id = d.b_id AND d.b_id = p.b_id AND g.g_id = p.g_id;


-- [����1] ���ǵ� å���� ���� �� ����� �ǸŵǾ����� ��ȸ  
--  (    åID, å����, ���ǸűǼ�, �ܰ� �÷� ���   )

SELECT b.b_id,title,SUM(p_su),price
FROM book b 
    JOIN panmai p ON b.b_id = p.b_id
    JOIN danga d ON b.b_id=d.b_id
    GROUP BY b.b_id,title,price;


-- [����2] ���� ���� �ȸ� å ������ ��ȸ...
-- ( åID, ����, �ܰ�, ���ǸűǼ� )

SELECT b.b_id,title,SUM(p_su),price
FROM book b 
    JOIN panmai p ON b.b_id = p.b_id
    JOIN danga d ON b.b_id=d.b_id
    GROUP BY b.b_id,title,price
    HAVING SUM(p_su)=(
        SELECT MAX(s)
        FROM(
            SELECT SUM(p2.p_su) s
            FROM panmai p2
            GROUP BY p2.b_id
        ) 
    );
--Ǯ��
-- 1) TOP-N     ���
SELECT t.*, ROWNUM
FROM ( 
    SELECT b.b_id, title, SUM (p_su ) t_psu, price
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga  d ON b.b_id = d.b_id
    GROUP BY    b.b_id, title, price 
    ORDER BY    t_psu DESC
) t
WHERE ROWNUM = 1; 

-- 2) �����Լ�
SELECT * 
FROM ( 
    SELECT b.b_id, title, SUM (p_su ) t_psu, price
       , RANK() OVER( ORDEr BY SUM (p_su )  DESC ) tpsu_rank
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga  d ON b.b_id = d.b_id
    GROUP BY    b.b_id, title, price 
)
WHERe tpsu_rank <= 3;

-- [����3] book ���̺��� �� ���� �ǸŰ� �� ���� ���� å�� ���� ��ȸ...
-- ( åid, ����, �ܰ� )

SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id IN ( 
    SELECT b_id
    FROM book
    MINUS
    SELECT DISTINCT b_id  
    FROM panmai
);
    
--Ǯ��
    
-- [����4] book ���̺��� �� ���̶� �ǸŰ� �� ���� �ִ� å�� ���� ��ȸ...
-- ( åid, ����, �ܰ� )    

SELECT b.b_id,title,price
FROM book b
    JOIN danga d ON b.b_id = d.b_id
    JOIN panmai p ON p.b_id=b.b_id
WHERE
    p_su>0; 


-- [����5] �⵵, ���� �Ǹ� ��Ȳ ���ϱ�
--    �⵵   ��     �Ǹűݾ�( p_su * price )
--    ---- -- ----------
--  2000   03   6000
--  2000   07   1600
--  2000   10   10500
--  2024   08   41661

SELECT TO_CHAR(p_date,'YYYY')as �⵵ ,TO_CHAR(p_date,'MM')as ��,(p_su*price) as �Ǹűݾ�
FROM panmai p
    JOIN danga d ON p.b_id=d.b_id;

-- [����6] 25�⵵�� ���� �ǸŰ� ���� å ���� ��ȸ ( id, ����, å ���� )
--         ���ؿ� 

SELECT b.b_id,title,SUM(p_su)
FROM book b 
    JOIN panmai p ON b.b_id = p.b_id
    JOIN danga d ON b.b_id=d.b_id
    WHERE TO_CHAR(p.p_date,'YYYY')= TO_CHAR(sysdate,'YYYY')
    GROUP BY b.b_id,title
    HAVING SUM(p_su)=(
        SELECT MAX(s)
        FROM(
            SELECT SUM(p2.p_su) s
            FROM panmai p2
            WHERE TO_CHAR(p2.p_date,'YYYY')= TO_CHAR(sysdate,'YYYY')
            GROUP BY p2.b_id
        ) 
    );

--
-- 1) TOP-N     ���
SELECT t.*, ROWNUM
FROM ( 
    SELECT b.b_id, title, SUM (p_su ) t_psu, price
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga  d ON b.b_id = d.b_id
    WHERE TO_CHAR(p.p_date,'YYYY')= TO_CHAR(sysdate,'YYYY')
    GROUP BY    b.b_id, title, price 
    ORDER BY    t_psu DESC
) t
WHERE ROWNUM = 1 ; 

-- 2) �����Լ�
SELECT * 
FROM ( 
    SELECT b.b_id, title, SUM (p_su ) t_psu, price
       , RANK() OVER( ORDEr BY SUM (p_su )  DESC ) tpsu_rank
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga  d ON b.b_id = d.b_id
    WHERE TO_CHAR(p.p_date,'YYYY')= TO_CHAR(sysdate,'YYYY')

    GROUP BY    b.b_id, title, price 
)
WHERE tpsu_rank <= 3;


-- [����7] ������ �Ǹ���Ȳ ���ϱ�
--�����ڵ�  ������  �Ǹűݾ���  ����(�Ҽ��� ��°�ݿø�)  
-- g_id    g_name
------------ -------------------------- ----------------
--7       ���ϼ���    15300      26%
--4       ���Ｍ��    11551      19%
--2       ���ü���    6000      10%
--6       ��������    18060      30%
--1       �츮����    8850      15%

--å ID, ����,�ܰ� ��ID,����, �Ǹų�¥,�Ǹż��� �÷���ȸ
SELECT b.b_id, title, price, g.g_id, g_name, p_date, p_su
FROM book b
JOIN danga d ON b.b_id = d.b_id
JOIN panmai p ON b.b_id = p.b_id
JOIN gogaek g ON p.g_id = p.g_id;

�����ġ�
   CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW ���̸�
      [(alias[,alias]...]
   AS subquery
   [WITH CHECK OPTION]
   [WITH READ ONLY];

--
CREATE OR REPLACE VIEW uvpan
AS
    SELECT b.b_id, title, price, g.g_id, g_name, p_date, p_su
    FROM book b
    JOIN danga d ON b.b_id = d.b_id
    JOIN panmai p ON b.b_id = p.b_id
    JOIN gogaek g ON p.g_id = p.g_id;
-- View UVPAN��(��) �����Ǿ����ϴ�.
SELECT *
FROM user_views;

SELECT *
FROM uvpan;

SELECT sum(price)
        ,sum(p_su)
FROM uvpan;
--ORDER BY ����
DESC uvpan;

-- [����] �⵵, ��, ���ڵ�, ����, �Ǹűݾ���
--       �⵵, �� �������� ����
--       uvgogaek �並 �����ϰ� Ȯ��.
CREATE VIEW UVGOGAEK 
AS
SELECT TO_CHAR(p_date,'YYYY') �⵵,TO_CHAR(p_date,'MM') �� ,g.g_id,g_name,sum(p_su*price) �Ǹűݾ���
--FROM book b JOIN panmai p ON b.b_id=p.b_id
--            JOIN gogaek g ON p.g_id=g.g_id
--            JOIN danga d ON b.b_id=d.b_id

FROM danga d JOIN panmai p ON d.b_id=p.b_id
            JOIN gogaek g ON p.g_id=g.g_id
GROUP BY 
    TO_CHAR(p_date, 'YYYY'),
    TO_CHAR(p_date, 'MM'),
    g.g_id,
    g_name        
ORDER BY 
    �⵵, ��;

SELECT COUNT (*)
FROM UVGOGAEK
WHERE g_id=2;

DROP VIEW UVPAN;

--���� �ΰ��� ����
--�ܼ���

--���պ�

CREATE TABLE testa (
   aid     NUMBER                PRIMARY KEY
    ,name   VARCHAR2(20) NOT NULL
    ,tel    VARCHAR2(20) NOT NULL
    ,memo   VARCHAR2(100)
);

CREATE TABLE testb (
    bid NUMBER                          PRIMARY KEY
    ,aid NUMBER CONSTRAINT fk_testb_aid 
                REFERENCES testa(aid)
                ON DELETE CASCADE
    ,score NUMBER(3)
);
  
INSERT INTO testa (aid, NAME, tel) VALUES (1, 'a', '1');
INSERT INTO testa (aid, name, tel) VALUES (2, 'b', '2');
INSERT INTO testa (aid, name, tel) VALUES (3, 'c', '3');
INSERT INTO testa (aid, name, tel) VALUES (4, 'd', '4');

INSERT INTO testb (bid, aid, score) VALUES (1, 1, 80);
INSERT INTO testb (bid, aid, score) VALUES (2, 2, 70);
INSERT INTO testb (bid, aid, score) VALUES (3, 3, 90);
INSERT INTO testb (bid, aid, score) VALUES (4, 4, 100);

COMMIT;
--
SELECT * FROM testa;
SELECT * FROM testB; 

--1) SIMPLE VIEW
CREATE OR REPLACE VIEW aview
as
SELECT aid,name,tel
FROM testa;
--
SELECT *
FROM aview;
-- DML(INSERT,UPDATE,DELETE)
INSERT INTO aview(aid,name,tel)INTO VALUES(5,'f',5);
commit;


--
CREATE OR REPLACE VIEW aview
as
SELECT aid,name,memo
FROM testa;

INSERT INTO aview(aid,name,memo)INTO VALUES(6,'g','memo');
DELETE FROM aview
WHERE aid=5;
rollback;

UPDATE aview
SET memo='X'
WHERE aid=5;

DROP VIEW abview;

----���պ�
CREATE OR REPLACE VIEW abview
as
SELECT a.aid,name,tel
        ,bid,score
FROM testa a JOIN testb b ON a.aid=b.aid
WITH READ ONLY;

SELECT *
FROM abview;

--
INSERT INTO abview(aid,name,tel,bid,score)
VALUES (10,'X',55,20,70);

INSERT INTO abview(aid,name,tel)
VALUES (10,'X',55);

--WITH CHECK OPTION ����
--  �� �信 ���� ���ٰ����� �ุ�� ����,��������
--  �� SCORE�� 90�� �̻��� ����� SELECT �並����
CREATE OR REPLACE VIEW bview
AS 
    SELECT bid,aid,score
    FROM testb
    WHERE score >=90
    WITH CHECK OPTION CONSTRAINT ck_bview_score;
    
    
SELECT bid,aid,score
FROM testb;
--
UPDATE bview
SET score=70
WHERE bid=3;
--
rollback;

--db�𵨸�
--1) db�𵨸� ���� ? ���Ǽ����� �������� ���μ����� ���������� �����ͺ��̽�ȭ ��Ű�� ����
-- �����ͺ��̽� ? ���� ���õ� �������� ����
--��) ���θ� ����Ʈ �ֹ� ����(��)
--  ��ǰ�˻� -> ��ٱ��� -> �ֹ� -> ���� -> ��� -> ��ǰ���� -> ��ǰ ��Ÿ


 DB �𵨸� ����( �ܰ� , ����)
   1)  ���� ���μ���         ��   2) ������ DB �𵨸�
    ( �䱸�м��� �ۼ� )             ( ERD �ۼ�)            -- eXERD��
         �� ��ġ�� ����                    ��
   4) ������ DB �𵨸�      ��    3) ���� DB �𵨸�  
     DBMS                       ( ��Ű��, ����ȭ ����)
     Ÿ��, ũ�� ���
     �ε���
     ������ȭ
     ���
 4. ������Ʈ ���� ����
 �� ��ȹ �� �м� �� ���� �� ���� �� �׽�Ʈ �� ��������
( 1�� ������Ʈ �� DataBase �𵨸� 6���� ���� �ҿ��. )   

-------------------------------

--4. db�𵨸� 1�ܰ� ( ���� ���μ��� �м� -> �䱸���׸��� �Ǵ� �䱸�м��� �ۼ� )

   1) ���� �о߿� ���� �⺻ ���İ� ��� �ʿ�. ��) ȸ�����α׷�( ��������ǥ,�ڻ�,�ս�...)
   2) ���Ի�� �������� ���� ��ü�� ���μ��� �ľǿ� ������ �ΰ� �м� �ʿ�.
   3) ���    - �켱, ����(����,��ǥ,����)�� �̿��Ͽ� �����ͷ� �����Ǿ����� �׸���� 
         ��Ȯ�ϰ� �ľ� �ʿ�.
      ( ���� ������ ���Ǿ����� �ִ� �������� �����ͷ� �����Ǿ����� �ϴ� �߿��� �׸���� ��� �ֱ⿡)
   4)    - ����ڿ� ���ͺ�
   5)   - ��� ����� ���� �Ǳ� ���� ��׶��� ���μ��� �ľ� , �ϳ��� �������� �پ��� ����� �� �ľ� �ʿ�.
   6)    - ������� �䱸 �м�.
�� �����ͺ��̽� �𵨸����� ���� �߿��� ���� ���� �м� ���� �������.

--
 https://terms.naver.com/entry.naver?docId=3431222&ref=y&cid=58430&categoryId=58430
�Ѻ� ��Ʈ�� �����ͺ��̽��� ���� [�䱸 ���� ����]
�� �Ѻ� ��Ʈ�� ȸ������ �����Ϸ��� ȸ�����̵�, ��й�ȣ, �̸�, ����, ������ �Է��ؾ� �Ѵ�.
�� ������ ȸ�����Դ� ��ް� �������� �ο��ȴ�.
�� ȸ���� ȸ�����̵�� �ĺ��Ѵ�.

�� ��ǰ�� ���� ��ǰ��ȣ, ��ǰ��, ���, �ܰ� ������ �����ؾ� �Ѵ�.
�� ��ǰ�� ��ǰ��ȣ�� �ĺ��Ѵ�.

�� ȸ���� ���� ��ǰ�� �ֹ��� �� �ְ�, �ϳ��� ��ǰ�� ���� ȸ���� �ֹ��� �� �ִ�.
�� ȸ���� ��ǰ�� �ֹ��ϸ� �ֹ��� ���� �ֹ���ȣ, �ֹ�����, �����, �ֹ����� ������ �����ؾ� �Ѵ�.

�� �� ��ǰ�� �� ������ü�� �����ϰ�, ������ü �ϳ��� ���� ��ǰ�� ������ �� �ִ�.
�� ������ü�� ��ǰ�� �����ϸ� �������ڿ� ���޷� ������ �����ؾ� �Ѵ�.
�� ������ü�� ���� ������ü��, ��ȭ��ȣ, ��ġ, ����� ������ �����ؾ� �Ѵ�.
�� ������ü�� ������ü������ �ĺ��Ѵ�.

�� ȸ���� �Խñ��� ���� �� �ۼ��� �� �ְ�, �Խñ� �ϳ��� �� ���� ȸ���� �ۼ��� �� �ִ�.
�� �Խñۿ� ���� �۹�ȣ, ������, �۳���, �ۼ����� ������ �����ؾ� �Ѵ�.
�� �Խñ��� �۹�ȣ�� �ĺ��Ѵ�.

[���̹� ���Ĺ��] �䱸 ���� �м� (�����ͺ��̽� ����, 2013. 6. 30., �迬��)

--5. db�𵨸� 1�ܰ�

1. ������ ������ ���̽� �𵨸��̶� ?
   ������ ���̽� �𵨸��� �Կ� �־� ���� ���� �ؾߵ� ���� ����ڰ� �ʿ�� �ϴ� �����Ͱ� �����̸�
                      � �����͸� �����ͺ��̽��� ��ƾ� �ϴ� ���� ���� ����� �м��̴�.
   �̷��� �͵��� ���� �м�, ����� �䱸 �м� ���� ���� ������� ������ ���� ������ �������� ������� ������ �� �ִ� 
   ��Ȯ�� ���·� ǥ���ϴ� �ܰ踦 '������ �����ͺ��̽� �𵨸�'�̶�� �Ѵ�.

2. ER-Diagram
   ���� ���踦 �� �� ��Ȯ�� ǥ���ϱ� ���� ���� ��� �� ���� �θ� ���ǰ� �ִ� 
    ��ü(E)-����(R) ���� �̿���
   ������ �����ͺ��̽� �𵨸��� ���� �˾ƺ���.

3. E-R Model
 1) 1976�� P.Chen�� ������ ��.
 2) ��ü ���� ���� �׷��� �������� �˾ƺ��� ���� ǥ���� ��.
     ��ü  - ���簢��,
   �Ӽ�  - Ÿ����,
   ��ü�� ���� ���� - ������
   �̵��� �����ϴ� ��ũ�� ������.

 3) �� ( �л��� ���� ���踦 ǥ���� ER-Diagrm)

   �л�(��) - �й�(Ÿ) �ĺ��ڼӼ�    - ��ȭ��ȣ(Ÿ) - �̸�(Ÿ)
      ��
   ���(��) �ٴ�� ����(N:M)
       ��
   ����(��) - �����ڵ�(Ÿ)�ĺ��ڼӼ�     - ������(Ÿ) - ��������(Ÿ)

4. ER - Diagrm �� ��� 
   1) ��ü(Entity)
   2) �Ӽ�(Attribute)
   3) �ĺ���(Identifier)
   4) ����(Relational)

   
   4-1.   ��ü(Entity)
   
   SELECT *
   FROM Emp;
   
   1) ���� ������ ���� �����ͷ� �����Ǿ����� �ϴ� ���,�繰,���,��ǵ��� '��ü'�� �Ѵ�.
      �� �� �����ϰ��� �ϴ� ������ ������ ����,������ ���� �����ͷ� �����Ǿ����� �ϴ� �׸��� �ľ��ϴ� ���� �ſ� �߿�.
   2) ��ü�� �л�,���� ��� ���� ���������� �����ϴ� ����
      ����,�а� ��� ���� ���������� �����ϴ� ����� �� �� �ִ�.
    3) ��ü�� ���̺�� ���ǵȴ�.
   4) ��ü�� �ν��Ͻ��� �Ҹ��� �������� ��ü���� �����̴�.
    ��) ���� : �ڷ� ����, �����ͺ��̽�, ���α׷��� ���� �ν��Ͻ����� ����.
        �а� : ��ǻ�Ͱ��а�, ���ڰ���, ������а� ���� �ν��Ͻ����� ����.
   5) ��ü�� �ľ��ϴ� ��� 
    - ���� ������ ���� ����( ���� �߿� )
    ��)
     �п������� �л����� �����¿� �������� ���񺰷� �����ϱ⸦ ���ϰ� �ִ�.. (��� ���� �м��� ����)
      
     - ��ü(���� �ľ�) : �п�(ü������ �ƴ϶�� ���� ), �л�, ������,����, ����
   -  ���� ������ �̿��ؼ� ��ü �ľ��ϴ� �͵� ���� ����̴�. 

   4-2.   �Ӽ�(Attribute)
   1) �Ӽ��̶� ? ������ �ʿ䰡 �ִ� ��ü�� ���� ����.
      ��, �Ӽ��� ��ü�� ����, �з�, ����, ����, Ư��, Ư¡ ���� ��Ÿ���� ���� �׸��� �ǹ��Ѵ�. 
   2) �Ӽ� ���� �� ���� �߿��� �κ��� ������ ������ Ȱ�� ���⿡ �´� �Ӽ��� �����̴�.
   3) �Ӽ��� ���ڴ� 10�� ���ܷ� �ϴ� ���� ����.
   4) �Ӽ��� �÷����� ���ǵȴ�.
   ��)
   �л��̶� ��ü�� �Ӽ� ? �������μ����� ���� �޶���.
          �й�, �̸�, �ֹι�ȣ, ��ȭ��ȣ,�ּ�...
   ����̶� ��ü�� �Ӽ� ?
         �����ȣ, �����, �ֹι�ȣ, ��ȭ��ȣ, �ּ�, �Ի�����, �������, �μ���...
   5) �Ӽ��� ����
      (1) ���� �Ӽ� : ���� ���� �ִ� �Ӽ�
      (2) ���� �Ӽ� : ���� �Ӽ����� ����ó��(���)�� �ؼ� ����� �� �ִ� �Ӽ�
                �ڷ��� �ߺ���,���Ἲ Ȯ���� ���� ��ȣȭ��Ű�� ���� �ٶ����ϴ�.
      (3) ���� �Ӽ� : ������ ���������� ������ �ý����� ȿ������ ���� �����ڰ� 
       ���Ƿ� �ο��ϴ� �Ӽ�.
   ��)
   �ֹ� Entity
   �ֹ���ȣ   ��   �ֹ���ǰ   �ֹ�����   �ܰ�   ����   �ֹ��ѱݾ�   �ֹ�����
   1   ȫ�浿   H302   0204   10000   3   600000      1
   2   ȫ�浿   H302   0204   10000   3   600000      1
   3   ȫ�浿   H302   0204   10000   3   600000      1

   ���⼭)    ����Ӽ� : �ֹ��ѱݾ� = �ܰ� * ����    
      ����Ӽ� : �ֹ�����( �ֹ��� ���� ����:�ֹ�,�����Ϸ�,��ۿϷ�,���) Ȯ�� ���� �Ӽ�

   [���θ��� �ֹ� ���μ���]  
    �ֹ�->���->�ֹ�ó�� �Ϸ�
        ->�����Ϸ� -> ��ۿϷ� -> �ֹ�ó�� �Ϸ�.
 
   6) �Ӽ� �������� ����
    - �Ӽ��� ���� �� �ִ� ������ ����, �ٽ� ���� �Ӽ��� ���� �������� ���� , �������� �� Ư���� 
      ��ü������ ������ �ִ� ���� '�Ӽ��� ������ ����'�̶� �Ѵ�.
       kor   0~100
       
    - ������ ������ ���� ���� �� ��ü�� �����ͺ��̽��� ������ ���� ���α׷� ���� �� �����ϰ� ����ϴ� ���⹰�̴�.
    - ������ ���� �ÿ��� �Ӽ��� �̸�, �ڷ��� ����, ����, ����, ���Ǵ� ���� ���� ����, ���ϼ�(Unique), �� ����,
      ��ȿ��,�ʱⰪ���� ������ �ľ����ָ� �ȴ�. 
    - ������ ���Ἲ. : �������� �Է� �����̳� �Է°����� ���������ν�
             �߸��� �����Ͱ� �ԷµǴ� ����� ���� ����    �ϱ����� �����ϴ� ��. 

   4-3.   �ĺ���(Identifier)
   1) �ĺ��ڶ�?
      �� ��ü ������ ������ �ν��Ͻ��� ����(Unique)�ϰ� ������ �� �ִ� ���� �Ӽ� �Ǵ� �Ӽ� �׷�.
        ��ü ���Ἲ.
        �л�(��ü)- [�й�],�̸�,�ֹι�ȣ,�ּ�...
   2) �ĺ��ڰ� ������ �����͸� ����/���� ���Ѵ�.
      �׷��� ��� ��ü�� �ݵ�� �ϳ� �̻��� �ĺ��ڸ� �����Ͽ����ϸ� ���� ���� ���� �ĺ��ڸ� ������ �� �ִ�.
        
   3) �ĺ����� ����
      (1) �ĺ�Ű(Candidate Key)
         ��ü���� ������ �ν��Ͻ��� ������ �� �ִ� �Ӽ�( �����ȣ,�ֹι�ȣ) 
      ��) ��� - [�����ȣ], [�ֹι�ȣ],�����, �μ�,�ּ�
                     4   >   13
      (2) �⺻Ű(Primary Key)
         �ĺ�Ű �� ���� ������ Ű. ( �����ȣ )
         - �ش� ��ü�� ��ǥ�� �� �ֳ�? 
              ���������� Ȱ�뵵�� ����? 
              ���̰� ª��? 
              ����� �����ϴ� �ĺ�Ű �� �ϳ� ����.
         ( �߿� )
           �⺻Ű�� not null, no duplicate(�ߺ���),unique,clusterd index ������.

      (3) ��üŰ(Alternate Key)
         �ĺ�Ű �� �⺻Ű�� �������� ���� �Ӽ�( �ֹι�ȣ )
         - index(�ε���)�� Ȱ���. 

      (4) ����Ű(Composite Key)
         �ϳ��� �Ӽ����� �⺻Ű�� �� �� ���� ��� �� �̻��� �÷��� ��� �ĺ��ڷ� ������ ���.
         - ����Ű ������ �������. : ����Ű �� � �÷��� ���� �Ѱ��̳�? 
            ����: ����Ű �� ���� ���� �÷��� index,unique�� ����Ǳ⿡ ���� ��� ����.
      ��) �޿� ���� ��ü
        �ĺ���
        (�޿�������+���)  ����Ű
      �޿�������   ���    ��������   �޿���
      200901      1   30   10000   
      200901      2   30   10000   
      200902      1   30   10000   
      200902      2   30   10000   
      
      ���� �⺻Ű�� ? ����. 
      ����Ű : �޿������� + ��� 
      ����� �� ) ��� �÷�(�Ӽ�)�� ���� �ѱ�? 
         - ��ȸ�� ��� : ���, �޿������� �� ��� �÷����� ��ȸ�� ����? 
         - ��ȸ���� ����ϴٸ� �������� �Է� ������ ���� : �翬 �޿���������  �켱 
            ( �Ƹ� �Է��� ��/��/�� �������� ������ ��� ���� �� ���̴�...)


      (5) �븮Ű(Surrogate Key:��������Ʈ)
         - �ĺ��ڰ� �ʹ� ��ų� ���� ���� ����Ű�� �����Ǿ� �ִ� ��� ���������� �߰��� �ĺ���(�ΰ�Ű).
         - �̰͵� ������ȭ �۾��̴�. 
      ��) �޿� ���� ��ü
           PK
      (�Ϸù�ȣ)       �޿�������   ���    ��������   �޿���
      1           200901      1   30   10000   
      2           200901      2   30   10000   
      3           200902      1   30   10000   
      4           200902      2   30   10000   
   
      - �Ϸù�ȣ��� �븮Ű�� �߰��ؼ� �ĺ��ڷ� ���. ( ����,ȿ���� ������ ) 

   4-4.   ����(Relational)
   - �����? ������ �������̴�.  ��ü�� �����ϴٺ��� ���� �����Ǵ� ��ü���� �ִ�. 
   ��)
   ����������      ȸ��
   ����) 
      [�뿩����]
      ȸ���� ������������ �뿩�Ѵ�.
             ������������ ȸ������ �뿩�ȴ�.
      [����ħ����]
      �л��� �������� ����ħ���޴´�.
      ������ �л��� ����ģ��.

   - ���� ǥ��(�ο�)
   
      ȸ��(��)    �Ǽ�   �뿩(��)  �Ǽ�   ����(��)
      1) ���谡 �ִ� �� ��ü�� �Ǽ����� �����ϰ� ���踦 �ο��Ѵ�.
     2) ���� ������ ǥ���Ѵ�. ( 1:1, 1:N, N:M����)
     3) ���ü��� ǥ���Ѵ�. 

   4-4-1) ���� ����
      1) 1:1 ����
       ������ �μ��� �����ϴ� �μ������ ����.
 
      1) 1:N ����
       ������ �μ��� ������� ����

      1) N:M ����
        ���� ��ǰ ��ü ������ �ֹ��̶�� ����. 
       ( �� ���� ���� ��ǰ�� �ֹ��� �� �ְ�, �� ��ǰ�� ���� ������ �ֹ��� �� �ִ�.)

       �ٴ�� ����� ���� ������ ������
         ���� �����ͺ��̽� �𵨸� �ܰ踦 ��ġ�鼭 1:N ����� �ٲ۴�. 

      ���� �����ͺ��̽��� 1:1�� 1:�� ���踸 �����Ѵ�. 


   
�� �ǹ��ڿ� ���� �������� ������ ��� �𵨸��� ������ ����.

   1. ȸ������ �ǽ��ϴ� ���� ����.
   2. ȸ�� ����
      ��) ȸ���̸�, �ֹι�ȣ, ��ȭ��ȣ, �޴�����ȣ, �����ȣ, �ּ�, ����� �� .
   3. ���� ������ ����
      ��) �帣��, ��޺��� ������ ����.
      ��) ������ �Ϸù�ȣ�� �ο��ؼ� ���� �������� ����. 
      ��) ��ȭ����, ������, ���� ����, �ֿ����, ����, ��������, ���� ����� �� �� ���� ����.
      ��) �ļ� ���ο� �뿩 ���� ����.      
   4. ���� ������ �뿩
      ��) ȸ������ �⺻ ��Ʋ
      ��) �̳� ȸ������ ����� �ڵ����� ����.
      ��) ��ü�Ǿ��� ��쿡�� ��ü�Ḧ �޴´�.
      ��) �뿩�� ��/�� ���� ����.
   5. ������ ���� ����
      ��) ȸ������ �뿩 1ȸ�� 1���� ����Ʈ ������ �ο��Ͽ� 10���� �Ǹ� ����� TAPE �ϳ� �뿩 ����
   6. ������ ����
      ��) �Ϻ� , ����, �⺰ ����� �ս��� �ľ�.
      ��) ���� �������� �뿩 ȸ�� �ľ�.
      ��) ��ü�� ����
      ��) �̳� ȸ�� ����.
      ��) ���� ����( �ٹ� �ð�, �ӱ� �ڵ� ��� )
      ��) ü������ Ȯ���� ��ϰ� �� ��. 


   Entity �ľ�
    - ȸ�� 
    - ���� 
    - ��ȭ ������
    - �뿩 ���� 
    - ��ü ����
    - ����Ʈ ����
    - ���� ����
    - ü���� 
    - ����
    
   Atrribute �ľ�
    - ȸ�� 
            ȸ��ID (PK)
            ȸ���̸�
            �ֹε�Ϲ�ȣ
            ��ȭ��ȣ
            �޴�����ȣ
            �����ȣ
            �ּ�
            �������
            ��������Ʈ
            
    - ����
            ����ID (PK)
            ��ȭID (FK)
            �Ϸù�ȣ
            �ļտ���
            �뿩����
            �Ҽ�����ID (FK)
    
    - ��ȭ������ 
            ��ȭID (PK)
            ����
            ������
            ���� ���� 
            �ֿ����
            ����
            ��������
            ���� �����
                   
    - �뿩
            �뿩ID (PK)
            ȸ��ID (FK)
            ������ID (FK)
            �뿩����
            �ݳ������� 
            �ݳ�����
            ��ü����
            ��ü��ID (FK)
            ������åID(FK)
            
    - ���� ��å
            ������åID (PK)
            ����ID (PK)
            ����/���� ����
            �뿩��
            
    - ��ü
            ��üID (PK)
            �뿩ID (FK)
            ��ü�ϼ�
            ��ü��ݾ�
    
    - ����Ʈ
            ����ƮID (PK)
            ȸ��ID (FK)
            ��������
            ��������Ʈ
            �������Ʈ
            ����뿩���񽺰��ɿ���
            
    - ����
            ����ID (PK)
            �����̸�
            ü����ID (FK)
            ����
            �ñ�
            �ӱ� (�ڵ� ���)
    
    - �ٹ����
            ��Ϲ�ȣ(PK)
            ����ID(FK)
            �ٹ���¥
            �ٹ��ð�
    
    - ü����
            ü����ID (PK)
            ü������
            �ּ�
            ��ȭ��ȣ
            ��������
            
    -  ����
            ����ID (PK)
            ����ID (FK)
            ��¥
            �ϸ���
            ������
            ������
    
   Indentifier �ľ�
    - ȸ��            - ȸ��ID (PK)
    - ����          - ����ID (PK)
    - ��ȭ ������    - ��ȭID (PK)
    - �뿩 ����       - �뿩ID (PK)
    - ��ü ����       - ��üID (PK)
    - ����Ʈ ����     - ����ƮID (PK)
    - ���� ����       - ����ID (PK)
    - ü����          - ü����ID (PK)
    - ����            - ����ID (PK)
   
   Relational /����/���ü�
| ����               | ����                                  | ����     | ���ü�              |
| ȸ�� - �뿩        | �� ȸ���� ���� �뿩�� �� �� ����          | 1 : N    | ȸ��(�ʼ�) �� �뿩(�ʼ�)  |
| �뿩 - ���������� | �� �������� ���� �� �뿩�� �� ����        | 1 : N    | ������(�ʼ�) �� �뿩(�ʼ�) |
| �뿩 - ��ü        | �� �뿩���� ��ü�� ���� ���� ����         | ������    | ������ ����           |
| ȸ�� - ����Ʈ      | �� ȸ���� ���� ����Ʈ ������ ���� �� ����  | 1 : N    | ȸ��(�ʼ�) �� ����Ʈ(����) |
| ��ȭ - ���������� | �� ��ȭ�� ���� ������ ���纻�� ����       | 1 : N    | ��ȭ(�ʼ�) �� ������(�ʼ�) |
| ü���� - ����       | �� ü������ ���� ���� ����              | 1 : N    | ü����(�ʼ�) �� ����(�ʼ�)  |
| ü���� - ����������| �� ü�������� ���� ������ ���� ����      | 1 : N    | ü����(�ʼ�) �� ������(�ʼ�) |
| ü���� - ����       | ü������ ���� ����                     | 1 : N    | ü����(�ʼ�) �� ����(�ʼ�)  |

--  ERD ������ db�𵨸� -- 
   

