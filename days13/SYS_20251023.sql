CREATE USER scott IDENTIFIED BY tiger;

GRANT CREATE SESSION TO scott;    

select * 
from tabs;


SELECT * FROM SCOTT.EMP;

CREATE USER madang IDENTIFIED BY madang;

--DCL 문
--CONNECT, RESOURCE 롤==역할
--UNLIMITED TABLESPACE 권한
GRANT CONNECT, RESOURCE,UNLIMITED TABLESPACE TO madang;

SELECT * FROM dba_users;

SELECT * FROM all_users;

SELECT * FROM user_users; --현재 로그인된 사용자

ALTER USER HR IDENTIFIED BY HR ACCOUNT UNLOCK;

GRANT CREATE SESSION TO MADANG;
GRANT CREATE TABLE TO MADANG;
ALTER USER MADANG QUOTA UNLIMITED ON USERS;

SELECT *
FROM all_tables
--자바 같다 == , 오라클 같다 = 
--WHERE table_name='employees' 검색결과 없음

ALTER USER hr IDENTIFIED BY lion ;


--예약어 조회 -> 확인

select *
from v$reserved_words
where keyword = upper('date');


select *
from user_tables; -- view = ?의 목록을 가지고있는 오라클 객체
from tabs;

select *
from scott.emp;

--dept,emp 소유자 확인
select owner,table_name
from dba_tables
where owner='SCOTT';


CREATE PUBLIC SYNONYM arirang
FOR scott.emp;

--삭제
drop public synonym arirang;

--SYNONYM ARIRANG이(가) 생성되었습니다.
--시노님이 생성 - 쿼리 확인

select *
from all_synonyms
where synonym_name like 'ARI%';

select *
from arirang;

CREATE PUBLIC SYNONYM employees
FOR HR.EMPLOYEES;

drop public synonym employees;

GRANT SELECT ON HR.EMPLOYEES TO SCOTT;  -- 권한 부여
REVOKE SELECT ON HR.EMPLOYEES TO SCOTT; -- 권한 회수


 
SELECT 
       NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 1, TO_CHAR( dates, 'DD')) ), ' ')  일
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 2, TO_CHAR( dates, 'DD')) ), ' ')  월
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 3, TO_CHAR( dates, 'DD')) ), ' ')  화
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 4, TO_CHAR( dates, 'DD')) ), ' ')  수
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 5, TO_CHAR( dates, 'DD')) ), ' ')  목
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 6, TO_CHAR( dates, 'DD')) ), ' ')  금
     , NVL( MIN( DECODE( TO_CHAR( dates, 'D'), 7, TO_CHAR( dates, 'DD')) ), ' ')  토
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
        

        
        
        