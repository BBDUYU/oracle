CREATE USER scott IDENTIFIED BY tiger;

GRANT CREATE SESSION TO scott;

select * 
from tabs;


SELECT * FROM SCOTT.EMP;
     
CREATE USER madang IDENTIFIED BY madang;

--DCL ��
--CONNECT, RESOURCE ��==����
--UNLIMITED TABLESPACE ����
GRANT CONNECT, RESOURCE,UNLIMITED TABLESPACE TO madang;

SELECT * FROM dba_users;

SELECT * FROM all_users;

SELECT * FROM user_users; --���� �α��ε� �����

ALTER USER HR IDENTIFIED BY HR ACCOUNT UNLOCK;

GRANT CREATE SESSION TO MADANG;
GRANT CREATE TABLE TO MADANG;
ALTER USER MADANG QUOTA UNLIMITED ON USERS;

SELECT *
FROM all_tables
--�ڹ� ���� == , ����Ŭ ���� = 
--WHERE table_name='employees' �˻���� ����

ALTER USER hr IDENTIFIED BY lion ;


--����� ��ȸ -> Ȯ��

select *
from v$reserved_words
where keyword = upper('date');


select *
from user_tables; -- view = ?�� ����� �������ִ� ����Ŭ ��ü
from tabs;

select *
from scott.emp;

--dept,emp ������ Ȯ��
select owner,table_name
from dba_tables
where owner='SCOTT';


CREATE PUBLIC SYNONYM arirang
FOR scott.emp;

--����
drop public synonym arirang;

--SYNONYM ARIRANG��(��) �����Ǿ����ϴ�.
--�ó���� ���� - ���� Ȯ��

select *
from all_synonyms
where synonym_name like 'ARI%';

select *
from arirang;

CREATE PUBLIC SYNONYM employees
FOR HR.EMPLOYEES;

drop public synonym employees;

GRANT SELECT ON HR.EMPLOYEES TO SCOTT;  -- ���� �ο�
REVOKE SELECT ON HR.EMPLOYEES TO SCOTT; -- ���� ȸ��



SELECT 
       NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 1, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 2, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 3, TO_CHAR( dates, 'DD')) ), ' ')  ȭ
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 4, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 5, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 6, TO_CHAR( dates, 'DD')) ), ' ')  ��
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 7, TO_CHAR( dates, 'DD')) ), ' ')  ��
FROM (
        SELECT TO_DATE(:yyyymm , 'YYYYMM') + LEVEL - 1  dates
        FROM dual
        CONNECT BY LEVEL <= EXTRACT ( DAY FROM LAST_DAY(TO_DATE(:yyyymm , 'YYYYMM') ) )
)  t 
GROUP BY CASE 
            WHEN TO_CHAR( dates, 'D' ) < TO_CHAR( TO_DATE( :yyyymm,'YYYYMM' ), 'D' ) 
                 THEN TO_CHAR( dates, 'W' ) + 1
            ELSE TO_NUMBER( TO_CHAR( dates, 'W' ) )
        END
ORDER BY CASE
            WHEN TO_CHAR( dates, 'D' ) < TO_CHAR( TO_DATE( :yyyymm,'YYYYMM' ), 'D' ) THEN TO_CHAR( dates, 'W' ) + 1
            ELSE TO_NUMBER( TO_CHAR( dates, 'W' ) )
        END;
































