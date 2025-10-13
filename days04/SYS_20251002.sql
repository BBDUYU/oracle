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









