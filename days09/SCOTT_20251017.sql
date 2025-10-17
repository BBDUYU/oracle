select * 
from tabs;

--2) emp 테이블 구조 확인 쿼리
DESCRIBE emp;
DESC emp;

--3) emp 테이블의 사원 정보를 조회하는 쿼리 작성
--   사원번호, 사원명, 입사일자 컬럼만 조회
-- FROM 스키마.테이블명 또는 뷰명
SELECT * 


SELECT emp.*
FROM scott.emp;

--4) madang 계정을 생성 (비밀번호 madang)
--5) madang 계정으로 로그인 
--   권한부여
--   scott.sql 파일을 찾아서 scott 계정에 부여된 권한 코딩 복사
-- SQL (구조화된 질의 언어)
-- 1) DQL 조회
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

SELECT e.*,empno,ename,hiredate FROM emp e; --emp이름대신 별칭 e사용


--emp 테이블에서 사원명만 조회하는 쿼리를 작성
SELECT ename FROM emp;

--중복제거
SELECT DISTINCT job FROM emp;
SELECT job FROM emp;

--사원들의 job의 종류 갯수 - COUNT() 오라클함수
SELECT COUNT(DISTINCT job) FROM emp;
--emp 테이블의 사원수
SELECT COUNT(empno) FROM emp;

--꼭 기억 - COUNT(*) null값도 카운트
--       - COUNT(COMM) NULL값은 제외하고 카운트

--insa 테이블의 사원수 조회
SELECT COUNT(*)
FROM insa;

--emp테이블에서 사원번호, 사원명, 입사일자,기본급,커미션을 조회
-- 추가) 급여 - 기본급 + 커미션
-- (+) 오라클의 덧셈연산자
-- 오라클 Null 값의 의미
-- comm이 NULL인 경우에는 0으로 처리 (NULL 처리) NVL, NVL2
SELECT empno,ename,hiredate,sal,comm
--        ,sal+comm
--        ,sal+NVL(comm,0) -- 첫번째 값이 null이면 두번째 값
--        ,NVL(sal+comm,sal)
--        ,NVL2(comm,comm,0)
--        ,NVL(comm,0)
        ,sal+NVL2(comm,comm,0) AS "pay"
        ,sal+NVL2(comm,comm,0) "pay"
        ,sal+NVL2(sal+comm,sal+comm,sal) pay --PAY
FROM emp;

SELECT * FROM emp;
--문제 EMP 테이블에서 사원번호, 사원명, 직속상사의 사원번호를 조회
--mgr이 null이면 CEO
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
      , '12345'   -- 오라클 문자열은 앞 뒤에 ' ' 붙인다.
      , TO_CHAR(12345) -- 오라클 문자열 변환 함수   TO_CHAR() 함수
FROM DUAL;

SELECT '이름은 ' || ename||', 직업은 '||job||'입니다.' message
        , CONCAT(CONCAT(CONCAT('이름은 ',ename),', 직업은 '),job)
FROM emp;

--employees테이블에서
--firstname,lastname컬럼 출력
--firstname,lastname을 합쳐서 name별칭으로 출력

--HR테이블이 없음 받아야됨

--emp 테이블에서 모든사원 정보출력
--부서번호, 사원명, 입사일자, pay(sal+comm)
SELECT deptno,ename,hiredate,sal+nvl(comm,0) as pay
FROM emp
WHERE deptno=30;

--문제 20번 부서원의 사원수는 몇명?

SELECT COUNT(*)
FROM emp
WHERE deptno=20;

--문제 10번 또는 20번 또는 30번인 부서원의 사원수
SELECT COUNT(*)
FROM emp
WHERE deptno IN(10,20,30); --컬럼명 IN(목록)
WHERE deptno=20 or deptno=10 or deptno=30;


--총 몇개의 부서가 있는지

SELECT *
FROM dept;

--emp테이블에서 10번 부서원을 제외한 나머지 사원정보출력

SELECT deptno, ename, sal+nvl(comm,0) as pay
FROM emp
WHERE deptno!=10;
WHERE deptno^=10;
WHERE deptno<>10;
WHERE NOT deptno=10;

--insa테이블에서
--수도권출신의 사원정보를 출력하는 쿼리를 작성
--city 컬럼 : 출신지역, 이름, 부서명

SELECT city, name, buseo
FROM insa
WHERE city IN('경기', '인천', '서울');

--문제 insa테이블에서 비수도권인 사원의 수
SELECT COUNT(*)
FROM insa
WHERE city NOT IN('경기', '인천', '서울');

SELECT ename
        ,LOWER(ename) -- 소문자
        ,UPPER(ename) -- 대문자
        ,INITCAP(ename) -- 첫문자만 대문자
FROM emp;


--문제 emp테이블에서 comm이 null인 사원 정보 조회
--어떤 컬럼값이 null체크하는 조건절은 주의하자
SELECT *
FROM emp
WHERE comm IS NULL; --sql 연산자
WHERE comm IS NOT NULL;

--문제 emp 테이블에서 부서번호,사원명,연봉조회
-- 연봉==월급*12
-- 조건 - 연봉이 20000 ~ 30000
SELECT deptno, ename,(sal+nvl(comm,0))*12 annualSalary
FROM emp
WHERE (sal+nvl(comm,0))*12 BETWEEN 20000 AND 30000; -- WHERE 별칭사용이안됨

-- 1) WITH절 - annualSalary 별칭을 WHERE절에서 사용
WITH annualSalaryEmp AS (
    SELECT deptno, ename,(sal+nvl(comm,0))*12 annualSalary
    FROM emp
)
SELECT * 
FROM annualSalaryEmp
WHERE annualSalary BETWEEN 20000 AND 30000;

-- 2) 서브쿼리 - annualSalary 별칭을 WHERE절에서 사용
-- 인라인뷰

SELECT e.*

FROM(
     SELECT deptno, ename,(sal+nvl(comm,0))*12 annualSalary
     FROM emp
) e

WHERE e.annualSalary BETWEEN 20000 AND 30000;

--문제3) 출신도가 서울 사람이면서 기본급이 150만원 이상인 사람 출력 (name, city, basicpay, ssn)
SELECT name,ssn,basicpay,city
FROM insa
WHERE basicpay>=1500000 AND CITY='서울';

--문제4) 출신도가 서울 사람이거나 부서가 개발부인 자료 출력 (name, city, buseo)
 
 SELECT name,city,buseo
 FROM insa
 WHERE buseo='개발부' OR city='서울';

--문제5) 출신도가 서울, 경기인 사람만 출력 (name, city, buseo)
 
 SELECT name,city,buseo
 FROM insa
 WHERE city IN('서울','경기');
 
--문제6) 급여(basicpay + sudang)가 250만원 이상인 사람. 단 필드명은 한글로 출력. (name, basicpay, sudang, basicpay+sudang) 

SELECT name,basicpay,sudang, basicpay+sudang as 급여
FROM insa
WHERE basicpay+sudang >=2500000;

--문제 insa테이블에서 연락처가 있으면 'O' 라고 출력, 없으면 'X'

SELECT name,tel,NVL2(to_char(tel),'O','X')
FROM insa;

--문제 insa테이블에서 70년대생인 사원정보 출력

SELECT *
FROM insa
WHERE SUBSTR(ssn,0,1)=7;

1. 용어정리
  1) 롤(Role)   
  2) 롤 사용 순서 
  3) 스키마(Schema)   
  
2. SELECT문의 7가지 절을 적으시고, 처리 순서를 적으세요. 
    1   [WITH]
    6   SELECT
    2   FROM
    3   [WHERE]
    4   [GROUP BY]
    5   [HAVING]
    7   [ORDER BY]
3. employees 테이블에서  아래와 같이 출력되도록 쿼리 작성하세요. 
   ㄱ. 문자열 연결연산자 사용     ||
   ㄴ. 문자열 연결 함수 사용     CONCAT()
   
    [실행 결과]
    FIRST_NAME          LAST_NAME                   NAME                                           
    -------------------- ------------------------- ---------------------------------------------- 
    Samuel               McCain                    Samuel McCain                                  
    Allan                McEwen                    Allan McEwen                                   
    Irene                Mikkilineni               Irene Mikkilineni                              
    Kevin                Mourgos                   Kevin Mourgos                                  
    Julia                Nayer                     Julia Nayer   
    :
    
    ㄱ.
    SELECT first_name,last_name,first_name||' '||last_name
    FROM employees;
    ㄴ.
    SELECT first_name,last_name,CONCAT(CONCAT(first_name,' '),last_name)
    FROM employees;
    
    
4. emp 테이블에서 잡,  사원번호, 이름, 입사일자를 조회하는 SQL를 작성하세요.  
    
    SELECT job,empno,ename,hiredate
    FROM emp;


5. 어제까지 배운 [Oracle 함수]를 적고 설명하세요 . 
     DISTINCT - 중복제거
     COUNT - 카운트
     CONCAT - 문자 연결
     LOWER - 소문자
     UPPER - 대문자
     INITCAP - 첫문자만 대문자
     IN - 목록에 해당 값이 있는지 조건줄 때 사용
     BETWEEN - a< value < b
     NVL - null값일때 a반환
     NVL2 - null값일때 a반환 아니면 b반환
     
     select count(empno)
     from emp
     where deptno=30;
     
     select count(distinct job)
     from emp;
     
     
     select SUBSTR(ssn,0,2), SUBSTR(ssn,3,2), SUBSTR(ssn,5,2), SUBSTR(ssn,8,1)
     from insa;
     
     select ssn
     from insa;
     
     
     
5-2. 어제까지 배운 [Oracle 자료형]을 적고 설명하세요.  
    NUMBER - 숫자
    char - 저장공간 고정 char(20) - 20 만큼 고정
    varchar - 저장공간 고정X varchar(20) - 쓴 만큼만 저장
    
6. 어제까지 배운 오라클의 연산자(operator)를 적으세요.   
   1) 논리연산자      
   2) 비교연산자    
   3) SQL연산자   IS NULL 
   5) 산술연산자   
   6) 연결연산자  +, ||

7. insa 테이블에서 사원이 속해 있는 부서의 종류를 확인하는 쿼리를 작성하세요.

SELECT name,buseo
FROM insa;

7-2. insa 테이블에서 사원이 속해 있는 부서의 갯수를 확인하는 쿼리를 작성하세요.

    SELECT count(buseo)
    FROM insa;
8. emp 테이블에서
   pay(sal+comm)  1000 이상~ 3000 이하 받는  
   30부서원을 제외한 모든 사원들만 
   ename을 기준으로 오름차순 정렬해서 조회하는 쿼리를 작성하세요.  
    ㄱ. 일반 쿼리 사용.    
    
    SELECT ename,sal+NVL(comm,0) as pay
    FROM emp
    WHERE sal+NVL(comm,0) BETWEEN 1000 AND 3000;
    
    ㄴ. inline view 사용  
    
    SELECT e.ename,e.pay
    FROM (
        SELECT ename,sal+NVL(comm,0)as pay 
        FROM emp
    ) e
    WHERE e.pay BETWEEN 1000 AND 3000;
    
    ㄷ. with 절 사용 
    
    SELECT 
    
   
9. emp 테이블에서 직속상사(mgr)가 없는  사원의 정보를 조회하는 쿼리 작성하세요.  
    
    SELECT *
    FROM emp
    WHERE mgr IS NULL;

10. emp 테이블에서 직속상사(mgr)가 없는  사원의 mgr을 'CEO'로 출력하는 쿼리 작성하세요.
 
   SELECT empno,ename,NVL(to_char(mgr),'CEO')
   FROM emp;
 
11. insa 테이블에서 연락처(tel)가 없는 사원은 '연락처 등록 안됨' 출력하는 쿼리를 작성하세요. 
   SELECT name,NVL(to_char(tel),'연락처 등록 안됨') as TEL
   FROM insa;
12. insa 테이블에서 개발부만 num, name, tel 컬럼 출력할 때 연락처(tel) 없는 사람은 X, O 출력하는 쿼리 작성.    
    SELECT name,tel,NVL2(to_char(tel),'O','X') 
    FROM insa;
13. emp 테이블에서  아래와 같은 조회 결과가 나오도록 쿼리를 작성하세요.

    [실행 결과]
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

   12개 행이 선택되었습니다.  
    
    SELECT empno,ename,sal,NVL(comm,0),sal+NVL(comm,0) as pay
    FROM emp;
    
    
14.   emp 테이블에서 10번 부서원 정보 조회 
    
    SELECT *
    FROM emp
    WHERE deptno=10;

14-2. emp 테이블에서 10번 부서원을 제외한 사원 정보를 조회(출력) 

    SELECT *
    FROM emp
    WHERE deptno!=10;

14-3. emp 테이블에서 10번 또는 20번 부서원 정보를 조회 
    SELECT *
    FROM emp
    WHERE deptno=10 or deptno=20;
15. emp 테이블에서 사원명이 'king' 인 사원의 정보 조회 
    SELECT *
    FROM emp
    WHERE LOWER(ename)='king';
16. insa 테이블에서 출생지역이 수도권인 사원의 정보를 조회.   
    SELECT *
    FROM INSA
    WHERE city IN('서울','경기','인천');
17. emp 테이블에서 부서번호가 10번이고, 잡이 CLERK  인 사원의 정보를 조회하는 쿼리 작성.   
    SELECT *
    FROM emp
    WHERE deptno=10 AND job='CLERK';
    
17-2. emp 테이블에서 잡이 CLERK 이고, 부서번호가 10번이 아닌 사원의 정보를 조회하는 쿼리 작성. 
    SELECT *
    FROM emp
    WHERE deptno!=10 AND job='CLERK';
17-3.  emp 테이블에서 부서번호가 30번이고, 커미션이 null인 사원의 정보를 조회하는 쿼리 작성.
  ( ㄱ.  deptno, ename, sal, comm,  pay 컬럼 출력,  pay= sal+comm )
  ( ㄴ. comm이 null 인 경우는 0으로 대체해서 처리 )
  ( ㄷ. pay 가 많은 순으로 정렬 )  
  
    SELECT deptno,ename,sal,nvl(comm,0),sal+nvl(comm,0) as pay 
    FROM emp
    WHERE deptno=30 AND comm IS NULL
    ORDER BY pay desc;
  
18. Alias 를 작성하는 3가지 방법을 적으세요.
   SELECT deptno, ename 
     , sal + comm   (ㄱ)   
     , sal + comm   (ㄴ)    
     , sal + comm   (ㄷ)   
    FROM emp; 
  
19. insa 테이블에서  총 사원수를 출력하는 쿼리를 작성하세요.  
    
    SELECT COUNT(num)
    FROM insa;

20. hr 계정의 비밀번호 변경과 계정 잠금 해제 하는 쿼리를 작성하세요.  
    SQL 종류 DQL,DDL,DML,DCL,TCL
    CREATE 
    DELETE
    
    ALTER USER hr IDENTIFIED 새비밀번호 ACCOUNT UNLOCK;
    

21. emp 테이블에서 사원들의 잡의 종류 조회 하는 쿼리를 작성하세요. 

    SELECT DISTINCT job
    FROM emp;

select *
from insa
--where buseo ='개발부' and substr(ssn,8,1) in('2');
where buseo ='개발부' and MOD(substr(ssn,8,1),2) =0;
 


select *
from insa
where city NOT in('서울','경기','인천') and buseo ='개발부';


select *
from emp
where (sal+nvl(comm,0))*12 between 20000 and 30000;



--70년대생

select *
from emp
where hiredate between '81.1.1' and '81.12.31';

--81년도

select *
from emp
where hiredate between '81.1.1' and '81.12.31';
where substr(hiredate,0,2)=81;

--[NOT]LIKE 연산자
--문자패턴이 일치하는지를 체크하는 연산자
--와일드카드를 사용해서 패턴을 지정함
--   2개 :     %              _
--정규표현식 0번 이상         한문자
--instr() 자바의 indexOf, lastIndexOf와 비슷
--찾으면 위치를 반환, 못찾으면 0반환
SELECT name,ssn,instr(ssn,7)
FROM insa
WHERE instr(ssn,7)=1;

--LIKE사용

select *
from insa
where ssn like '7%';
where ssn like '__12__-_______'; -- % _ : 와일드 카드


--문제 insa테이블에서 김씨가 몇명인지 조회

select count(name)
from insa
where name like '김%';


--문제 insa테이블에서 이름의 두 번째 문자가 김 인 사원정보
select *
from insa
where name like '_미%';

--문제 이름이 균으로 끝나는 사원
select *
from insa
where name like '%종범';
where name like '%균';

--LIKE 연산자 활용예제
--와일드카드 % _ 를 일반 문자처럼 쓰고싶은경우 ESCAPE

--emp 테이블에서 직속상사가 없는 사원의 부서번호를 확인
select deptno
from emp
where mgr is null;

--직속 상사가 없는 사원의 부서번호를 null로 수정
update emp
set deptno=null
where mgr is null;

commit;


--LIKE 연산자
--정규표현식을 사용하는 함수
--REGEXP_LIKE()
--REGEXP_INSTR()
--REGEXP_SUBSTR()
--REGEXP_REPLACE()

select empno,ename,job
from emp;

--empno = 7654 사원의 이름을 Martin으로 수정하는 쿼리 작성
update emp
set ename=initcap(ename)
where empno=7654;

commit;
-- emp 테이블에서 사원조회 'ar'이 있는
select empno,replace(ename,'ar','*ar*'),job
from emp;
--where ename like '%ar%';
--문제 emp 테이블에서 ename속에 'ar' 대소분자 구분하지않고  ar포함된 사원정보 검색
select *
from emp
--where lower(ename) like '%ar%';
--where regexp_like(lower(ename),'ar');
where regexp_like(ename,'ar','i');

--regexp_like 사용

--tbl_regexplike
select *
from tbl_regexplike;

--dml 직접구현해서 2/3 레코드(행)을 삽입
INSERT INTO tbl_regexplike (id,name,email) values(2, '한라산','hanlasan@abc.co.kr');
INSERT INTO tbl_regexplike (id,name,email) values(3, '금강산','gumgangsan@abc.co.kr');

--검색 이름으로 검색, 성이 한/백
select * 
from tbl_regexplike
--where regexp_like(name,'^(한|백)');
where regexp_like(name,'^[한백]');

--문제 풀이--
1. insa테이블에서 ssn 컬럼을 통해서 year, month, date, gender 출력
    [실행 결과]
      SSN          YEAR MONTH DATE GENDER  
    ---------- ------ ---- ----- -----
    771212-1022432   77   12   12   1
    801007-1544236   80   10   07   1
    770922-2312547   77   09   22   2
    790304-1788896   79   03   04   1
    811112-1566789   81   11   12   1
    :
    60개 행이 선택되었습니다. 
    
    
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
      ,to_char(sysdate,'HH')--시간
      ,to_char(sysdate,'HH12')--시간
      ,to_char(sysdate,'HH24')--시간
      ,to_char(sysdate,'MI')--분
      ,to_char(sysdate,'SS')--초
      ,to_char(sysdate,'DY')--목
      ,to_char(sysdate,'DAY')--요일
from dual; --public 시노님

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

--scott -> hr계정  emp테이블에 select권한부여

grant select on emp to hr; -- 권한 부여
--revoke select on emp from hr; -- 권한 회수

--개강일 무슨요일인지 확인하는 쿼리
--오라클에서는 날짜,문자는 ' ' 
select sysdate,to_char(sysdate,'day')
      ,'2025.08.18'
--    ,to_char(to_date('2025.08.18'),'day')
      ,to_char(to_date('2025년 8월 18일','yyyy"년" mm"월" dd"일"'),'day')
from dual;

--2. insa 테이블에서 70년대 12월생 모든 사원 아래와 같이 주민등록번호로 정렬해서 출력하세요.

    NAME                 SSN           
    -------------------- --------------
    문길수               721217-1951357
    김인수               731211-1214576
    홍길동               771212-1022432   


select name, ssn
from insa
--where substr(ssn,1,1)=7 and substr(ssn,3,2)=12;
--where ssn like '7%' and ssn like '__12%';
--where ssn like '7_12%';
--where regexp_like(ssn,'^7[0-9]12');
where regexp_like(ssn,'^7\d12');

--3. insa 테이블에서 70년대 남자 사원만 조회.    
    ㄱ. LIKE 연산자 사용.    
    
    select *
    from insa
--    where ssn like '7______1%';
--    where ssn like '7%-1%';
    where ssn like '7%' and mod(substr(ssn,-7,1),2)=1;
    ㄴ. REGEXP_LIKE() 함수 사용  
    
    select *
    from insa
    where regexp_like(ssn,'^7\d{5}-[13579]');

--4. emp 테이블에서 사원명(ename) 속에  'la' 문자열을 포함하는 사원 정보를 조회(출력)
--   (조건 : 'la'문자는 대소문자를 구분하지 않는다.    la   La  lA  LA )
   
   
   select *
   from emp
-- where lower(ename) like '%la%';
   where ename like '%'|| upper('la') ||'%'; 


   select *
   from emp
   where regexp_like(ename,'la','i');
   
--5.insa 테이블에서 남자는 'X', 여자는 'O' 로 성별(gender) 출력하는 쿼리 작성   
    NAME                 SSN            GENDER
    -------------------- -------------- ------
    홍길동               771212-1022432    X
    이순신               801007-1544236    X
    이순애               770922-2312547    O
    김정훈               790304-1788896    X
    한석봉               811112-1566789    X 
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

select nullif('홍길동','김길동')
from dual;

--6. insa 테이블에서 2000년 이후 입사자 정보 조회하는 쿼리 작성
    ㄱ. TO_CHAR() 함수 사용해서 풀기
    -- 숫자,날짜 -> 문자변환함수
    
    select name, ibsadate
    from insa
    WHERE TO_CHAR(ibsadate, 'yyyy') >= '2000';
    
    ㄴ. EXTRACT() 함수 사용해서 풀기.
    -- 날짜 -> 숫자 추출
    SELECT name, ibsadate
    FROM insa
    WHERE EXTRACT(YEAR FROM ibsadate) >= 2000;
    
    
    NAME                 IBSADATE
    -------------------- --------
    이미성               00/04/07
    심심해               00/05/05
    권영미               00/06/04
    유관순               00/07/07   
    
    
--7. 현재시스템의 날짜,시간정보 조회

select sysdate
--    ,to_char(sysdate,'ds ts')
--      ,extract(hour from systimestamp) as "시스템시간+9"
--      ,extract(hour from localtimestamp) as 지역시간
--      ,extract(minute from systimestamp) as 시스템분
--      ,extract(second from systimestamp) as 시스템초
       ,extract(hour from cast(sysdate as timestamp)) 시
       ,extract(minute from cast(sysdate as timestamp)) 분
       ,extract(second from cast(sysdate as timestamp)) 초
from dual;


select
    cast('123.45' as number) as result
   ,cast(sysdate as )
from dual;


--8. 현재시스템의 날짜,시간정보를 출력하는쿼리

select sysdate,current_timestamp
from dual;

--9. dept부서 테이블의 구조 및 부서정보 확인

desc dept;

select * 
from dept;
--1. 10번 부서의 부서명을 QC100% 로 수정하는 쿼리

update dept
set dname='QC100%'
where deptno=10;

--2. 부서명에 100% 라는 문자가 포함된 부서정보를 조회하는 쿼리

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
    ,replace(ename,'E','이')
    ,regexp_replace(ename,'E','이')
from emp;

--문제 뒤 6자리를 *로 채워라
select name, ssn
--    ,substr(ssn,1,8) || '******'
--    ,concat(substr(ssn,1,8),'******')
--    ,replace(ssn,substr(ssn,9),'******') --만약 앞에 6개와 뒤6개가 같으면 앞에 * 찍힘
--    ,regexp_replace(ssn,'(\d{6}-\d)(\d{6})','\1******')
--    ,regexp_replace(ssn,'(.{8})(\d{6})','\1******')
--    ,regexp_replace(ssn,'.{6}$','******')
    ,rpad(substr(ssn,1,8),14,'*') -- 남는공간 오른쪽에 해당문자 출력
    ,lpad(substr(ssn,1,8),14,'*') -- 남는공간 왼쪽에 해당문자 출력
from insa;


select ename
    ,lpad(sal + nvl(comm,0),10,'#') pay --전체 자리수 10칸
from emp;

--11. emp 테이블에서 아래와 같이 출력하는 쿼리를 작성하세요. 
   ㄱ. deptno 오름차순 정렬 후 pay 로 내림차순 정렬
   ㄴ. pay가 100 단위로 # 출력
   ㄷ. pay = sal + comm
   
   실행결과)
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
--      데이터 조작언어
--      반드시 TCL 커밋, 롤백
--            트랜잭션 제어 언어
select *
from dept
order by deptno;

insert into 테이블명(컬럼명) values(컬럼값);
commit;

insert into dept(deptno,dname,loc) values(50,'QC','SEOUL');
commit;

insert into dept(deptno,dname,loc) values(60,'QC2','POHANG');
commit;

insert into dept(deptno,dname,loc) values(99,'QC3',NULL);

update dept
set dname='부서명' ,loc='포항'
where deptno=99;

delete 
from dept
where deptno>=50;



--emp테이블에서 모든사원의 급여(pay)를 20% 인상시키는 쿼리를 작성

select sal,comm,
        (sal+nvl(comm,0))*0.2 as "인상pay"
        ,(sal+nvl(comm,0))*1.2 as "20%pay"
from emp;

--연산자 : where 절에서 사용할 수 있는 연산자의 종류
--1) 비교연산자 : 숫자, 문자, 날짜 --> true, false, null
--  =, !=, <>, ^=   
--2) 논리연산자 : and, or, not
--3) sql연산자  
--  ㄱ. [not]in (목록)  ==  a or b or c or
--  ㄴ. [not]between a and b   ==   a <=    <= b
--  ㄷ. [not]like      와일드카드(% _) 패턴 검색
--  ㄹ. is [not]null
--  ㅁ. any, some, all, exists + 서브쿼리
--4) set(집합) 연산자 ( 기억 )
--  ㄱ. 합집합 : union, union all
-- union 연산자
-- union all 연산자
--1. insa 테이블에서 개발부 사원의 이름, 출신지역, 부서를 출력
select name, city, buseo
from insa
where buseo='개발부';

--2. 개발부 사원수 확인
select 
    --name, city, lower(name),
    count(*)
from insa
where buseo='개발부';

--3. 출신지역이 인천인 사원의 이름, 출식지역, 부서
select name, city, buseo
from insa
where city='인천';

--4. 합집합 : 개발부 + 인천
select name, city, buseo
from insa
where buseo='개발부'
--union -- 중복허용 X
union all -- 중복허용
select name, city, buseo
from insa
where city='인천';

select name, city, buseo
from insa
where city='인천' and buseo='개발부';

select name, city, buseo
from insa
where city='인천' or buseo='개발부';

--  ㄴ. 교집합 : intersect
select name, city, buseo
from insa
where buseo='개발부'
intersect
select name, city, buseo
from insa
where city='인천';
--  ㄷ. 차집합 : minus
select name, city, buseo
from insa
where buseo='개발부'
minus
select name, city, buseo
from insa
where city='인천';
--  주의 - 집합 대상 테이블의 컬럼수 동일, 자료형이 동일

-- 문제 - 실행결과
--  0번 사원수 : 1명
-- 10번 사원수 : 2명
-- 20번 사원수 : 3명
-- 30번 사원수 : 6명
-- 40번 사원수 : 0명
--   총 사원수 : 12명


select '0번 사원수 : '||count(*)||'명' as 사원수
from emp
where deptno=null
union all
select '10번 사원수 : '||count(*)||'명'
from emp
where deptno=10
union all
select '20번 사원수 : '||count(*)||'명'
from emp
where deptno=20
union all
select '30번 사원수 : '||count(*)||'명'
from emp
where deptno=30
union all
select '40번 사원수 : '||count(*)||'명'
from emp
where deptno=40
union all
select '총 사원수 : '||count(*)||'명'
from emp;

--emp 테이블의 모든 사원번호, 사원명 + employees테이블의 모든 사원번호,사원명

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
        ,MOD(5,3) -- 오라클 나머지 연산자 X 
FROM DUAL;

--
SELECT SYSDATE
    ,CURRENT_TIMESTAMP
FROM DUAL;
-- 오라클도 연산자 우선순위가 있따
-- IS [NOT] NAN --숫자여부
-- IS [NOT] INFINITE 무한대 여부
-- 문제 INSA테이블에서 사원명, 주민번호, 나이를 출력

SELECT NAME,SSN
--,getAge(SSN) 주민등록번호로 나이를 반환하는 getAge() 함수
FROM INSA;

--다일행 함수
select lower( ename)
from emp;

--숫자 함수 정리
--1. 반올림    ROUND()
--2. 올림 (절상) CEIL()
--3. 내림 (절삭) FLOOR(), TRUNC()

SELECT 5/3
,ROUND(5/3)
,ROUND(5/3,0)
,ROUND(5/3,1)
,ROUND(5/3,2)
FROM DUAL;

SELECT 
--ROUND(123.456,-1) --소수점을 기준으로 왼쪽 일의 자리에서 반올림
ROUND(123.456,-2) --소수점을 기준으로 왼쪽 십의 자리에서 반올림
FROM DUAL;

SELECT 123.4567
    ,CEIL(123.4567) -- 무조건 소수점 첫번째 자리에서 올림
FROM DUAL;

--소수점 3번째 자리에서 올림


SELECT 123.4567
    ,CEIL(123.4567*100)/100 
FROM DUAL;

--절삭 TRUNC,FLOOR
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


--문제 insa 주민번호 substr()
--년도
--월
--일
--성별
--주민번호앞자리

select ssn
        ,substr(ssn,1,2)
        ,substr(ssn,3,2)
        ,substr(ssn,5,2)
        ,substr(ssn,8,1)
        ,substr(ssn,1,6)
from insa;


--instr() 찾는 문자가 없으면 0 반환 있으면 위치값 반환
select ename
    ,instr(ename,'E') --이름속에 'E' 문자 여부
from emp;

--rpad(), lpad() 함수
--사원명 길이만큼 ###

select ename,length(ename)
        ,rpad('#',length(ename),'#') as "BAR"
        ,lpad('#',length(ename),'#') as "BAR"
from emp;

select '   admin   '
,'['||ltrim('   admin   ')||']'
,'['||rtrim('   admin   ')||']'
,rtrim('brasdawqonaxyxyxy','xy')--특정문자열 지정 가능
,'['||trim('   admin   ')||']'
from dual;


--문제 emp테이블에서 이름의 첫번째문자만 출력
select substr(ename,0,1)
        ,ascii(substr(ename,0,1))
        ,chr(65)
from emp;
--greatest() -- 나열한 숫자나 문자중에서 가장 큰 값을 리턴
--least()    -- 나열한 숫자나 문자중에서 가장 작은값을 리턴
select greatest(3,5,2,4,1)
        ,least(3,5,2,4,1)
from dual;

select sysdate
    ,round(sysdate)
from dual;


select to_char(sysdate,'ds ts')
    ,to_char(trunc(sysdate),'ds ts')
    ,to_char(trunc(sysdate,'dd'),'ds ts')--일 절삭
    ,to_char(trunc(sysdate,'mm'),'ds ts')--월 절삭
    ,to_char(trunc(sysdate,'yyyy'),'ds ts')--년도 절삭
    ,trunc(sysdate)
from dual;

select '2025/08/18'
    ,to_date('2025/08/18')+100
from dual;

select sysdate, sysdate+2,sysdate+2/24 
from dual;

select to_char(sysdate+1/2/24,'ds ts'),--30분후
to_char(sysdate+1/24/60,'ds ts') --1분후
from dual;


select ename
    ,sysdate
    ,hiredate
    --,날짜-날짜=두날짜사이의 간격
    ,round(sysdate - hiredate) 근무일수
    ,months_between(sysdate,hiredate)/12 근무년수
from emp;


select to_char(to_date('2025/08/18','yyyy/mm/dd')+100,'yyyy-mm-dd')
from dual;

select sysdate
    ,add_months(sysdate,3)
    ,add_months(sysdate,-3)
    ,add_months(sysdate,3*12)
from dual;

--last_day 특정날짜가 속한 달의 가장 마지막 날짜를 리턴하는 함수
--이번달의 마지막날짜
select sysdate
    ,last_day(sysdate)
    ,to_char(last_day(sysdate),'dd')
from dual;

--달력 그리기 : 2020/02 마지막날짜 ? 


select to_char(last_day(to_date('2020/02','yyyy/mm')),'dd')
from dual;

--오늘이 무슨요일인지
select to_char(sysdate,'day') 
    ,next_day(sysdate,'금요일')
from dual;

--형변환 함수
-- to_number() 문자 -> 숫자
select empno
from emp;

select substr(empno,-1)
from emp;

select to_number('432')+5
from dual;

select to_number('1,234','9G999')+5
from dual;

--to_char(숫자[,포맷, nls파라미터]) -> 문자변환
--to_char(날짜[,포맷, nls파라미터]) -> 문자변환


--홍길동 2,810,000 금액이 세 자리마다 콤마(,) 찍어서 출력
select name, basicpay+sudang pay
        ,to_char( basicpay + sudang, 'L9,999,999' )
from insa;

--nls 국가지원언어
--  ㄴ 다양한 국가의 언어, 문자, 지역설정..관련 기능
--  ㄴ [RR]/MM/DD
--      YY 차이점

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

--날짜 -> to_char 함수를이용해 -> 문자변환
--to_char(날짜)
select sysdate
    ,to_char(sysdate,'yyyy-mm--dd ts')
    ,to_char(sysdate,'yyyy')
    ,to_char(sysdate,'mm')
    ,to_char(sysdate,'dd')
from dual;
-- 복습문제
1. dept 테이블에   deptno = 50,  dname = QC,  loc = SEOUL  로 새로운 부서정보 추가

INSERT INTO dept VALUES(50, 'QC', 'SEOUL');
select *
from dept;
1-2. dept 테이블에 QC 부서를 찾아서 부서명(dname)과 지역(loc)을 
  dname = 현재부서명에 2를 추가,  loc = POHANG 으로 수정
  
update dept
set dname=dname||'2', loc='POHANG'
where dname='QC';
  
--QC 부서를 40번 부서의 부서명과 지역명으로 수정하는 쿼리작성
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


1-3. dept 테이블에서 QC2 부서를 찾아서 deptno(PK)를 사용해서 삭제

delete 
from dept
where deptno=(
    select deptno
    from dept
    where dname='QC2'
);

--dept 테이블에서 부서명에 COUNT 라는 문자가 포함된 부서의 부서번호를 1증가시키는 쿼리

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

2.  insa 테이블에서 남자는 'X', 여자는 'O' 로 성별(gender) 출력하는 쿼리 작성
    1. REPLACE() 사용해서 풀기
    select name,ssn
    , replace(replace(mod(substr(ssn,-7,1),2),1,'X'),0,'O')gender
    from insa;
    
    2. NVL2(), NULLIF() 사용해서 풀기.
    select name,ssn
    ,nvl2(nullif( mod(substr(ssn,-7,1),2),1),'O','X')gender
    from insa;
    
    NAME                 SSN            GENDER
    -------------------- -------------- ------
    홍길동               771212-1022432    X
    이순신               801007-1544236    X
    이순애               770922-2312547    O
    김정훈               790304-1788896    X
    한석봉               811112-1566789    X 

3.  insa 테이블에서 2000년 이후 입사자 정보 조회하는 쿼리 작성
    1. TO_CHAR() 함수 사용해서 풀기
    
    select name,ibsadate
    from insa
    WHERE TO_CHAR(ibsadate, 'yyyy') >= '2000';

    
    2. EXTRACT() 함수 사용해서 풀기.
    
    select name, ibsadate
    from insa
    where extract(year from ibsadate) >= 2000;
    
    NAME                 IBSADATE
    -------------------- --------
    이미성               00/04/07
    심심해               00/05/05
    권영미               00/06/04
    유관순               00/07/07    
    
4. 지금까지 배운 오라클 자료형을 적으세요.
   ㄱ.  number(p,s) number(4) 4자리 정수
   ㄴ.  varchar2(14) 14바이트 문자열
   ㄷ.  date 초
   ㄹ.  
 

8.  insa 테이블에서  주민번호를 아래와 같이 '-' 문자를 제거해서 출력
 
    NAME    SSN             SSN_2
    홍길동   770423-1022432   7704231022432
    이순신   800423-1544236   8004231544236
    이순애   770922-2312547   7709222312547    
    
    1) SUBSTR() 사용
    
    select name, ssn,substr(ssn,0,6)||substr(ssn,8,7) as SSN_2
    from insa;
    
    2) REPLACE() 사용
    
    select name,ssn
    ,replace(ssn,'-')
    from insa;
    
    3) REGEXP_REPLACE() 사용

    select 
    name,
    ssn,
    regexp_replace(ssn, '[^0-9]', '') as SSN_2
    from insa;

[숫자함수]
9. ROUND() 
   1) 함수 설명 :  반올림
   2) 형식 설명 :  round(a,b) 소수점 b번째 자리까지 남기고 반올림
   3) 쿼리 설명
        SELECT    3.141592
               , ROUND(  3.141592 )       a 
               , ROUND(  3.141592,  0 )   b
               , ROUND(  3.141592,  2 )   c
               , ROUND(  3.141592,  -1 ) d
               , ROUND( 12345  , -3 )    e
       FROM dual;
        a는 기본적으로 소수점 첫째자리에서 반올림, 값은 3
        b는 소수점 0번째자리 즉 첫재짜리에서 반올림, 값은 3
        c는 소수점 둘째자리까지 남기고 반올림, 값은 3.14
        d는 1의자리에서 반올림, 값은 3
        e는 소수점 왼쪽 3번째 자리에서 반올림, 값은 12000

    
9-2. TRUNC()함수와 FLOOR() 함수에 대해서 설명하세요.  
    둘다 절삭 함수
    하지만
    trunc는 절삭할 자릿수를 결정가능
    floor는 무조건 소수점 첫째자리에서 절삭

9-3. CEIL() 함수에 대해서 설명하세요.  
     
     절상함수
     
9-4. 나머지 값을 리턴하는 함수 :  (  mod    )
9-5. 절대값을 리턴하는 함수 :   (    abs    ) 
 

11. insa 테이블에서 모든 사원들을 14명씩 팀을 만드면 총 몇 팀이 나올지를 쿼리로 작성하세요.

select count(*)
from insa;

select ceil(count(*)/14) 
from insa;

12. emp 테이블에서 최고 급여자, 최저 급여자 정보 모두 조회
                                            PAY(sal+comm)
7369   SMITH   CLERK   7902   80/12/17   800          20  최고급여자
7839   KING   PRESIDENT      81/11/17   5000      10  최저급여자

select empno, ename,job,mgr,hiredate,sal+nvl(comm,0) as pay ,deptno
from emp
where sal+nvl(comm,0) in (
    (select max(sal+nvl(comm ,0)) max_pay from emp)
    (select min(sal+nvl(comm ,0)) min_pay from emp)
)

order by pay asc;


where sal+nvl(comm,0)=(select min(sal+nvl(comm,0))from emp);

13. emp 테이블에서 
   comm 이 400 이하인 사원의 정보 조회
  ( comm 이 null 인 사원도 포함 )
    
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
--(이 문제는 생각만 풀 수 있으면 풀어보세요. )    
--14. emp 테이블에서 각 부서별 급여(pay)를 가장 많이 받는 사원의 정보 출력.    

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

--상관 서브쿼리
--mainquery + subquery


select empno,ename,job,mgr,hiredate,sal+nvl(comm,0) as pay,deptno
from emp m
where sal+nvl(comm,0)=(
    select max(sal+nvl(comm,0))
    from emp
    where deptno=m.deptno
);


-- all : 모든 조건 , any : 조건이 맞을때마다
select empno,ename,job,mgr,hiredate,sal+nvl(comm,0) as pay,deptno
from emp m
where sal+nvl(comm,0)>=all(
    select sal+nvl(comm,0)
    from emp
    where deptno=m.deptno
);

--0이 자릿수채우기
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
        ,sum(comm)/count(*) -- * -> null포함
        ,avg(comm)
from emp;

--문제 emp테이블에서 평균 급여(pay)보다 많이 급여를 받는 사원의 정보를
--부서별로 정렬하고 난 후 급여별로 정렬

select empno, ename,sal+nvl(comm,0) as pay ,deptno
from emp
where (sal+nvl(comm,0)) > (
    select avg(sal+nvl(comm,0))
    from emp
)
order by deptno asc, pay desc;

select *
from emp;


--문제 각 부서별 평균 급여보다 적게받는 사원정보출력
-- empno,ename,pay,해당부서평균급여,deptno
--부서별정렬,급여별정렬

select a.empno,a.ename, a.sal+nvl(a.comm,0) as pay,b.avg_pay as "평균급여",a.deptno
from emp a, (select avg(sal+nvl(comm,0))as avg_pay from emp) b
where (a.sal+nvl(a.comm,0)) <b.avg_pay
order by a.deptno asc, pay desc;

--풀이
--1
select avg(sal+nvl(comm,0)) "10번평균급여"
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

--3. KING 5000   null  부서가 없는 사원 들 중에 평균 급여보다 작은 사람도 출력.
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

--문제 emp테이블에서 부서번호, 부서명,사원명,입사일자 조회
--emp  테이블 : deptno, ename, hiredate
--dept 테이블 : deptno, ename

--관계형 데이터 모델
--테이블 <-관계-> 테이블 <-관계-> 테이블 ... 


--부서번호 부서명 사원번호 사원명 입사일자 조인해서 출력하는 쿼리작성

--2 테이블 join 테이블 on 조인조건 구문 사용
select e.deptno,dname,empno,ename,hiredate
from dept d join emp e on d.deptno=e.deptno;

--emp에서 사원번호,사원명,부서명
--insa에서 사원번호,사원명,부서명
--두테이블의 모든사원들의 사원정보(사원번호,사원명,부서명)출력

select num,name,buseo
from insa
union
select empno,ename,dname
from emp e,dept d
where e.deptno=d.deptno;

select *
from emp;


--문제 emp 테이블의 job의 갯수 출력


select count(distinct(job))
from emp;

--문제 출력 결과
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

--상관 서브쿼리사용
select to_char(deptno) as deptno,
    (select count(*) from emp where deptno=d.deptno)
from dept d
union all
select ' ', count(*) from emp
order by deptno asc;



select *
from dept;

--group by 절 사용
--각 부서별 사원수 파악

select nvl(deptno,0)deptno,count(*) 사원수
from emp
group by deptno
union all
select null,count(*)
from emp
order by deptno asc;
-- 조인
--사원이 없는 부서정보는 출력하지않음 (40번부서)


select nvl(d.deptno,0) deptno, count(ename)
from emp e, dept d
where e.deptno(+)=d.deptno -- pk == fk [outer join] 정보를 넣을테이블에 (+)
group by d.deptno
order by d.deptno asc;

select *
from dept;

select nvl(d.deptno,0) deptno, count(ename) 
from emp e right outer join dept d on e.deptno=d.deptno --모든 정보를 보일 테이블에  left || right outer 교집합 생각
group by d.deptno
order by d.deptno asc;

--문제 insa 테이블에서 각 부서별 사원수를 출력

select distinct buseo
from insa;



select buseo,replace(replace(mod(substr(ssn,-7,1),2),1,'남'),0,'여') 성별,count(*)
from insa
group by buseo,replace(replace(mod(substr(ssn,-7,1),2),1,'남'),0,'여')
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
-- [문제1] 부서명(부서번호), 사원수, 사원번호, 사원명, 입사일자 출력
--        ( 부서별 오름차순 정렬, 입사일자 순으로 정렬 )
-- 1) 조인(join) 개념 이해
 dept : deptno,  dname
 emp  : deptno, empno, ename, hirecdate
 
-- 2) equi join / outer join 개념 이해
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

-- 풀이)
SELECT COUNT(*) FROM emp WHERE deptno = 10;
--
SELECT dname  || '(' || d.deptno || ')' dname
, (SELECT COUNT(*) FROM emp WHERE deptno = e.deptno) "COUNT"
, empno, ename, hiredate
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
ORDER BY dname ASC, hiredate ASC;

-- [실행결과]
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

12개 행이 선택되었습니다. 

-- [문제2] 부서별 사원수, 해당 부서의 급여평균 출력
--   ( 급여평균은 소숫점 3자리에서 반올림해서 출력 )
--   ( 마지막엔 전체 사원수 및 전체 급여평균 출력)

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
GROUP BY deptno  -- 집계함수
UNION ALL -- 주의) 컬럼 수, 컬럼 자료형 동일..
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

-- [문제3] 부서별 , 잡별 사원수 출력
--  ( 부서가 없는 사원은 0으로 출력 )
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

9개 행이 선택되었습니다. 

-- [문제3-2] insa 테이블에서 각 부서별 남/여자 사원수를 위와 같이 출력하는 쿼리 작성하세요
SELECT buseo, gender, COUNT(*) "COUNT"
FROM  (  -- 인라인뷰( inline view )
        SELECT buseo
              , ssn
              , REPLACE(  REPLACE( MOD( SUBSTR( ssn, -7, 1), 2 ), 1, '남'), 0, '여') gender
        --      , NVL2(  NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ), 1 ), '여', '남' ) gender
        FROM insa
     ) i
GROUP BY buseo, gender     
ORDER BY buseo, gender;



BUSEO       GENDER      COUNT
--------------- - ----------
개발부          남          8
개발부          여          6
기획부          남          3
기획부          여          4
영업부          남          8
영업부          여          8
인사부          여          4
자재부          남          4
자재부          여          2
총무부          남          3
총무부          여          3
홍보부          남          3
홍보부          여          3

13개 행이 선택되었습니다. 

-- [문제4] 각 부서별 최고 급여자 정보 조회 
-- ( 부서가 없는 사원 중 최고 급여자 정보도 출력 )

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

-- 2-2) JOIN ~ ON 구문 변경
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
        
-- [문제5] 최고 급여자, 최저 급여자 정보 조회
-- SQL연산자  : ALL, ANY, EXISTS
-- 1)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '최저급여자' result
FROM emp
WHERE sal+NVL(comm,0) <= ALL( SELECT sal+NVL(comm,0)  FROM emp )
-- WHERE sal+NVL(comm,0) = ( SELECT MIN(sal+NVL(comm,0))  FROM emp )
UNION ALL
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '최고급여자' result
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
       , NVL2( NULLIF(pay, max_pay), '최저', '최고') || '급여자' result
FROM (  -- 인라인뷰
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
        20 SMITH      80/12/17        800 최저급여자
           KING       81/11/17       5000 최고급여자


-- SCOTT --   
-- [문제1] 부서명(부서번호), 사원수, 사원번호, 사원명, 입사일자 출력
--        ( 부서별 오름차순 정렬, 입사일자 순으로 정렬 )
-- 1) 조인(join) 개념 이해
 dept : deptno,  dname
 emp  : deptno, empno, ename, hirecdate
 
-- 2) equi join / outer join 개념 이해
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

-- 풀이)
SELECT COUNT(*) FROM emp WHERE deptno = 10;
--
SELECT dname  || '(' || d.deptno || ')' dname
, (SELECT COUNT(*) FROM emp WHERE deptno = e.deptno) "COUNT"
, empno, ename, hiredate
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
ORDER BY dname ASC, hiredate ASC;

-- [실행결과]
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

12개 행이 선택되었습니다. 

-- [문제2] 부서별 사원수, 해당 부서의 급여평균 출력
--   ( 급여평균은 소숫점 3자리에서 반올림해서 출력 )
--   ( 마지막엔 전체 사원수 및 전체 급여평균 출력)

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
GROUP BY deptno  -- 집계함수
UNION ALL -- 주의) 컬럼 수, 컬럼 자료형 동일..
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

-- [문제3] 부서별 , 잡별 사원수 출력
--  ( 부서가 없는 사원은 0으로 출력 )
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

9개 행이 선택되었습니다. 

-- [문제3-2] insa 테이블에서 각 부서별 남/여자 사원수를 위와 같이 출력하는 쿼리 작성하세요
SELECT buseo, gender, COUNT(*) "COUNT"
FROM  (  -- 인라인뷰( inline view )
        SELECT buseo
              , ssn
              , REPLACE(  REPLACE( MOD( SUBSTR( ssn, -7, 1), 2 ), 1, '남'), 0, '여') gender
        --      , NVL2(  NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ), 1 ), '여', '남' ) gender
        FROM insa
     ) i
GROUP BY buseo, gender     
ORDER BY buseo, gender;



BUSEO       GENDER      COUNT
--------------- - ----------
개발부          남          8
개발부          여          6
기획부          남          3
기획부          여          4
영업부          남          8
영업부          여          8
인사부          여          4
자재부          남          4
자재부          여          2
총무부          남          3
총무부          여          3
홍보부          남          3
홍보부          여          3

13개 행이 선택되었습니다. 

-- [문제4] 각 부서별 최고 급여자 정보 조회 
-- ( 부서가 없는 사원 중 최고 급여자 정보도 출력 )

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

-- 2-2) JOIN ~ ON 구문 변경
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
        
-- [문제5] 최고 급여자, 최저 급여자 정보 조회
-- SQL연산자  : ALL, ANY, EXISTS
-- 1)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '최저급여자' result
FROM emp
WHERE sal+NVL(comm,0) <= ALL( SELECT sal+NVL(comm,0)  FROM emp )
-- WHERE sal+NVL(comm,0) = ( SELECT MIN(sal+NVL(comm,0))  FROM emp )
UNION ALL
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '최고급여자' result
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
       , NVL2( NULLIF(pay, max_pay), '최저', '최고') || '급여자' result
FROM (  -- 인라인뷰
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
        20 SMITH      80/12/17        800 최저급여자
           KING       81/11/17       5000 최고급여자

-- 오후 수업 시작~
-- COALESCE 함수 : 순차적으로 NULL 아닌 값을 반환하는 함수 
SELECT ename, sal, comm
    , sal + NVL(comm, 0) pay
    , sal + NVL2(comm, comm, 0)  pay
    , sal + COALESCE(comm, 0) pay
FROM emp;

-- DECODE 함수 ***
if(조건식){   a = b
   return c; 
}
DECODE( a, b, c )
예)
SELECT DECODE(10, 10, 'X')
FROM dual;
--
-- (기억) deptno가 10번이라면 100을 리턴하고 그렇지 않으면  null 리턴한다. 
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
  return  ㄱ;
}else if( a = c ){
  return  ㄴ;
}else if( a = d ){
  return ㄷ;
}else{
  return ㄹ;
}
DECODE( a,b,ㄱ,c,ㄴ,d,ㄷ,ㄹ)
--예) deptno  10  1, 20, 2, 30, 3, 40, 4 , 0
SELECT ename, deptno
     , DECODE( deptno, 10, 1, 20, 2, 30,3, 40,4, 0)
FROM emp;
-- 남자   'O'   REPLACE x 2번
-- 여자   'X'   NULLIF, NVL2
SELECT name, ssn
    , MOD(  SUBSTR( ssn, -7, 1 ), 2 ) gender
    , NVL2(NULLIF(MOD(SUBSTR(ssn,-7,1),2),0),'O','X')gender
    , REPLACE(REPLACE(MOD(SUBSTR(ssn,-7,1),2),1,'O'),0,'X')gender 
    -- DECODE 함수를 사용해서 처리
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) gender
FROM insa;
-- emp 테이블의 각 부서별 사원수를 출력.
SELECT deptno, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno
ORDER BY deptno  ASC;
-- 위의 쿼리를 DECODE 함수 X 를 사용해서 수정.

         0         10         20         30         40      전체사원수
---------- ---------- ---------- ---------- ---------- ----------
         1          2          3          6          0         12
         
SELECT 
   ( SELECT COUNT(*) FROM emp WHERE deptno IS NULL ) "0"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 10 ) "10"  
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 20 ) "20"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 30 ) "30"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 40 ) "40"
 , ( SELECT COUNT(*) FROM emp  ) "전체사원수"
FROM dual; 

-- 위의 쿼리를 DECODE 함수를 사용해서 수정.
SELECT 
    COUNT(*) "전체사원수"
    , COUNT( DECODE(deptno, 10, 'XXX' ) )  "10번 사원수"
    , SUM( DECODE(deptno, 20, 1 ) )  "20번 사원수"
    , COUNT( DECODE(deptno, 30, 'XXX' ) )  "30번 사원수"
    , COUNT( DECODE(deptno, 40, 'XXX' ) )  "40번 사원수" 
FROM emp;
-- 2가지 정확하게 이해 X 
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

--   1) 집계함수는 null 값은 제외한다. 
SELECT COUNT(*)
     , COUNT(comm)
     , SUM( comm )
FROM emp;

-- [문제] emp 테이블의 pay를 모두 10% 인상하는 쿼리를 작성. 
SELECT ename
    , sal + NVL(comm, 0) pay
    , (sal + NVL(comm, 0)) * 0.1 "10% 인상액"
    , (sal + NVL(comm, 0)) * 1.1 "10% 인상된 pay"
FROM emp;

-- [문제] emp 테이블에서 10번 부서원들은 10%인상
--                     20번    "     20%인상
--                그외 부서원들은      15%인상.
-- 1) 풀이
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.* , '10%' "인상 %" , pay * 0.1 "인상액", pay * 1.1 "인상된 pay"
FROM temp
WHERE deptno = 10
UNION ALL
SELECT temp.* , '20%' "인상 %" , pay * 0.2 "인상액", pay * 1.2 "인상된 pay"
FROM temp
WHERE deptno = 20
UNION ALL
SELECT temp.* , '15%' "인상 %" , pay * 0.15 "인상액", pay * 1.15 "인상된 pay"
FROM temp
WHERE deptno NOT IN ( 10,20 );

-- DECODE 함수를 사용해서 ... 수정.
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.*
     , DECODE( deptno, 10, '10%', 20, '20%', '15%' ) "인상%"
     , pay * DECODE( deptno, 10, 0.1, 20, 0.2, 0.15 ) "인상액"
     , pay * DECODE( deptno, 10, 1.1, 20, 1.2, 1.15 ) "인상된 pay"
FROM temp;
-- CASE 함수
SELECT name, ssn
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) decode_gender
    , CASE MOD(SUBSTR(ssn,-7,1),2)
             WHEN 1 THEN 'O'
             ELSE        'X'
      END case_gender
    , CASE
          WHEN MOD(SUBSTR(ssn,-7,1),2) = 1 THEN 'O'
          --ELSE        'X'   null 처리되더라 ( 암기 )
      END case_gender
--    , CASE 컬러명 또는 수식 WHEN 조건식 THEN 반환값
--                          WHEN 조건식 THEN 반환값
--                          WHEN 조건식 THEN 반환값
--                          ELSE  반환값
--      END
FROM insa;


-- [문제] emp 테이블에서 10번 부서원들은 10%인상
--                     20번    "     20%인상
--                그외 부서원들은      15%인상.
-- ( CASE 함수를 사용해서 풀어보자 )
SELECT t.*
     -- DECODE 함수 사용 코딩. 
     , pay * DECODE(deptno, 10, 1.1, 20, 1.2, 1.15) "decode 인상된 pay"
     , pay * CASE deptno 
                 WHEN 10 THEN 1.1
                 WHEN 20 THEN 1.2
                 ELSE         1.15
               END "case 인상된 pay"
FROM ( -- 인라인뷰(inline view)
        SELECT deptno, ename
             , sal + NVL(comm, 0) pay
        FROM emp
     ) t;
-- sal등급 테이블
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
-- ( 암기 )   [ 넌 이콜 조인 ]
--       두 개 테이블의 관계 X -> 조인 가능
--       조인조건으로  BETWEEN ~ AND 
SELECT ename, sal, grade
FROM emp e JOIN salgrade s ON sal BETWEEN losal AND hisal ;
       
-- [문제] emp 테이블에서 입사년도는 상관없다. 
--                     1월달에 입사한 사원수를 조회.
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
-- 풀이 1) 
--SELECT empno, ename, hiredate
--     , TO_CHAR( hiredate, 'MM' ) 입사한월
--     , EXTRACT( MONTH FROM hiredate) 입사한월
--FROM emp;
-- 1월, 2월 ~ 12월 입사한 사원수 출력.
SELECT COUNT( * )
FROM emp
WHERE TO_CHAR( hiredate, 'MM' ) = 1;
WHERE TO_CHAR( hiredate, 'MM' ) = '01';

-- 풀이 2) 
SELECT 
      TO_CHAR( hiredate, 'MM' ) ,
      COUNT(*)
FROM emp
-- WHERE TO_CHAR( hiredate, 'MM' ) = 1
GROUP BY TO_CHAR( hiredate, 'MM' )
-- HAVING절 사용...
ORDER BY TO_CHAR( hiredate, 'MM' ) ASC;
-- 풀이 3)
SELECT  
      -- empno, ename, hiredate  ,
      COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 1, 'X') )  month_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 2, 'X') )  month_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 3, 'X') )  month_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 4, 'X') )  month_4
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 5, 'X') )  month_5
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 6, 'X') )  month_6
FROM emp;
-- 각 분기별로 입사한 사원수 파악
-- 1~3 1분기    4~6 2분기  7~9 3분기 10~12 4분기
SELECT  
      -- empno, ename, hiredate  ,
        COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 1, 'X') )  분기_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 2, 'X') )  분기_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 3, 'X') )  분기_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 4, 'X') )  분기_4 
FROM emp;
      
-- SCOTT --   
-- [문제1] 부서명(부서번호), 사원수, 사원번호, 사원명, 입사일자 출력
--        ( 부서별 오름차순 정렬, 입사일자 순으로 정렬 )
-- 1) 조인(join) 개념 이해
 dept : deptno,  dname
 emp  : deptno, empno, ename, hirecdate
 
-- 2) equi join / outer join 개념 이해
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

-- 풀이)
SELECT COUNT(*) FROM emp WHERE deptno = 10;
--
SELECT dname  || '(' || d.deptno || ')' dname
, (SELECT COUNT(*) FROM emp WHERE deptno = e.deptno) "COUNT"
, empno, ename, hiredate
FROM emp e RIGHT JOIN dept d ON e.deptno = d.deptno
ORDER BY dname ASC, hiredate ASC;

-- [실행결과]
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

12개 행이 선택되었습니다. 

-- [문제2] 부서별 사원수, 해당 부서의 급여평균 출력
--   ( 급여평균은 소숫점 3자리에서 반올림해서 출력 )
--   ( 마지막엔 전체 사원수 및 전체 급여평균 출력)

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
GROUP BY deptno  -- 집계함수
UNION ALL -- 주의) 컬럼 수, 컬럼 자료형 동일..
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

-- [문제3] 부서별 , 잡별 사원수 출력
--  ( 부서가 없는 사원은 0으로 출력 )
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

9개 행이 선택되었습니다. 

-- [문제3-2] insa 테이블에서 각 부서별 남/여자 사원수를 위와 같이 출력하는 쿼리 작성하세요
SELECT buseo, gender, COUNT(*) "COUNT"
FROM  (  -- 인라인뷰( inline view )
        SELECT buseo
              , ssn
              , REPLACE(  REPLACE( MOD( SUBSTR( ssn, -7, 1), 2 ), 1, '남'), 0, '여') gender
        --      , NVL2(  NULLIF( MOD( SUBSTR( ssn, -7, 1), 2 ), 1 ), '여', '남' ) gender
        FROM insa
     ) i
GROUP BY buseo, gender     
ORDER BY buseo, gender;



BUSEO       GENDER      COUNT
--------------- - ----------
개발부          남          8
개발부          여          6
기획부          남          3
기획부          여          4
영업부          남          8
영업부          여          8
인사부          여          4
자재부          남          4
자재부          여          2
총무부          남          3
총무부          여          3
홍보부          남          3
홍보부          여          3

13개 행이 선택되었습니다. 

-- [문제4] 각 부서별 최고 급여자 정보 조회 
-- ( 부서가 없는 사원 중 최고 급여자 정보도 출력 )

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

-- 2-2) JOIN ~ ON 구문 변경
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
        
-- [문제5] 최고 급여자, 최저 급여자 정보 조회
-- SQL연산자  : ALL, ANY, EXISTS
-- 1)
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '최저급여자' result
FROM emp
WHERE sal+NVL(comm,0) <= ALL( SELECT sal+NVL(comm,0)  FROM emp )
-- WHERE sal+NVL(comm,0) = ( SELECT MIN(sal+NVL(comm,0))  FROM emp )
UNION ALL
SELECT deptno, ename, hiredate, sal+NVL(comm,0) pay, '최고급여자' result
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
       , NVL2( NULLIF(pay, max_pay), '최저', '최고') || '급여자' result
FROM (  -- 인라인뷰
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
        20 SMITH      80/12/17        800 최저급여자
           KING       81/11/17       5000 최고급여자

-- 오후 수업 시작~
-- COALESCE 함수 : 순차적으로 NULL 아닌 값을 반환하는 함수 
SELECT ename, sal, comm
    , sal + NVL(comm, 0) pay
    , sal + NVL2(comm, comm, 0)  pay
    , sal + COALESCE(comm, 0) pay
FROM emp;

-- DECODE 함수 ***
if(조건식){   a = b
   return c; 
}
DECODE( a, b, c )
예)
SELECT DECODE(10, 10, 'X')
FROM dual;
--
-- (기억) deptno가 10번이라면 100을 리턴하고 그렇지 않으면  null 리턴한다. 
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
  return  ㄱ;
}else if( a = c ){
  return  ㄴ;
}else if( a = d ){
  return ㄷ;
}else{
  return ㄹ;
}
DECODE( a,b,ㄱ,c,ㄴ,d,ㄷ,ㄹ)
--예) deptno  10  1, 20, 2, 30, 3, 40, 4 , 0
SELECT ename, deptno
     , DECODE( deptno, 10, 1, 20, 2, 30,3, 40,4, 0)
FROM emp;
-- 남자   'O'   REPLACE x 2번
-- 여자   'X'   NULLIF, NVL2
SELECT name, ssn
    , MOD(  SUBSTR( ssn, -7, 1 ), 2 ) gender
    , NVL2(NULLIF(MOD(SUBSTR(ssn,-7,1),2),0),'O','X')gender
    , REPLACE(REPLACE(MOD(SUBSTR(ssn,-7,1),2),1,'O'),0,'X')gender 
    -- DECODE 함수를 사용해서 처리
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) gender
FROM insa;
-- emp 테이블의 각 부서별 사원수를 출력.
SELECT deptno, COUNT(*) "COUNT"
FROM emp
GROUP BY deptno
ORDER BY deptno  ASC;
-- 위의 쿼리를 DECODE 함수 X 를 사용해서 수정.

         0         10         20         30         40      전체사원수
---------- ---------- ---------- ---------- ---------- ----------
         1          2          3          6          0         12
         
SELECT 
   ( SELECT COUNT(*) FROM emp WHERE deptno IS NULL ) "0"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 10 ) "10"  
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 20 ) "20"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 30 ) "30"
 , ( SELECT COUNT(*) FROM emp WHERE deptno = 40 ) "40"
 , ( SELECT COUNT(*) FROM emp  ) "전체사원수"
FROM dual; 

-- 위의 쿼리를 DECODE 함수를 사용해서 수정.
SELECT 
    COUNT(*) "전체사원수"
    , COUNT( DECODE(deptno, 10, 'XXX' ) )  "10번 사원수"
    , SUM( DECODE(deptno, 20, 1 ) )  "20번 사원수"
    , COUNT( DECODE(deptno, 30, 'XXX' ) )  "30번 사원수"
    , COUNT( DECODE(deptno, 40, 'XXX' ) )  "40번 사원수" 
FROM emp;
-- 2가지 정확하게 이해 X 
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

--   1) 집계함수는 null 값은 제외한다. 
SELECT COUNT(*)
     , COUNT(comm)
     , SUM( comm )
FROM emp;

-- [문제] emp 테이블의 pay를 모두 10% 인상하는 쿼리를 작성. 
SELECT ename
    , sal + NVL(comm, 0) pay
    , (sal + NVL(comm, 0)) * 0.1 "10% 인상액"
    , (sal + NVL(comm, 0)) * 1.1 "10% 인상된 pay"
FROM emp;

-- [문제] emp 테이블에서 10번 부서원들은 10%인상
--                     20번    "     20%인상
--                그외 부서원들은      15%인상.
-- 1) 풀이
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.* , '10%' "인상 %" , pay * 0.1 "인상액", pay * 1.1 "인상된 pay"
FROM temp
WHERE deptno = 10
UNION ALL
SELECT temp.* , '20%' "인상 %" , pay * 0.2 "인상액", pay * 1.2 "인상된 pay"
FROM temp
WHERE deptno = 20
UNION ALL
SELECT temp.* , '15%' "인상 %" , pay * 0.15 "인상액", pay * 1.15 "인상된 pay"
FROM temp
WHERE deptno NOT IN ( 10,20 );

-- DECODE 함수를 사용해서 ... 수정.
WITH temp AS
(
   SELECT deptno, ename, sal + NVL(comm, 0) pay
   FROM emp
)
SELECT temp.*
     , DECODE( deptno, 10, '10%', 20, '20%', '15%' ) "인상%"
     , pay * DECODE( deptno, 10, 0.1, 20, 0.2, 0.15 ) "인상액"
     , pay * DECODE( deptno, 10, 1.1, 20, 1.2, 1.15 ) "인상된 pay"
FROM temp;
-- CASE 함수
SELECT name, ssn
    , DECODE(  MOD(SUBSTR(ssn,-7,1),2) , 1 , 'O', 'X' ) decode_gender
    , CASE MOD(SUBSTR(ssn,-7,1),2)
             WHEN 1 THEN 'O'
             ELSE        'X'
      END case_gender
    , CASE
          WHEN MOD(SUBSTR(ssn,-7,1),2) = 1 THEN 'O'
          --ELSE        'X'   null 처리되더라 ( 암기 )
      END case_gender
--    , CASE 컬러명 또는 수식 WHEN 조건식 THEN 반환값
--                          WHEN 조건식 THEN 반환값
--                          WHEN 조건식 THEN 반환값
--                          ELSE  반환값
--      END
FROM insa;


-- [문제] emp 테이블에서 10번 부서원들은 10%인상
--                     20번    "     20%인상
--                그외 부서원들은      15%인상.
-- ( CASE 함수를 사용해서 풀어보자 )
SELECT t.*
     -- DECODE 함수 사용 코딩. 
     , pay * DECODE(deptno, 10, 1.1, 20, 1.2, 1.15) "decode 인상된 pay"
     , pay * CASE deptno 
                 WHEN 10 THEN 1.1
                 WHEN 20 THEN 1.2
                 ELSE         1.15
               END "case 인상된 pay"
FROM ( -- 인라인뷰(inline view)
        SELECT deptno, ename
             , sal + NVL(comm, 0) pay
        FROM emp
     ) t;
-- sal등급 테이블
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
-- ( 암기 )   [ 넌 이콜 조인 ]
--       두 개 테이블의 관계 X -> 조인 가능
--       조인조건으로  BETWEEN ~ AND 
SELECT ename, sal, grade
FROM emp e JOIN salgrade s ON sal BETWEEN losal AND hisal ;
       
-- [문제] emp 테이블에서 입사년도는 상관없다. 
--                     1월달에 입사한 사원수를 조회.
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
-- 풀이 1) 
--SELECT empno, ename, hiredate
--     , TO_CHAR( hiredate, 'MM' ) 입사한월
--     , EXTRACT( MONTH FROM hiredate) 입사한월
--FROM emp;
-- 1월, 2월 ~ 12월 입사한 사원수 출력.
SELECT COUNT( * )
FROM emp
WHERE TO_CHAR( hiredate, 'MM' ) = 1;
WHERE TO_CHAR( hiredate, 'MM' ) = '01';

-- 풀이 2) 
SELECT 
      TO_CHAR( hiredate, 'MM' ) ,
      COUNT(*)
FROM emp
-- WHERE TO_CHAR( hiredate, 'MM' ) = 1
GROUP BY TO_CHAR( hiredate, 'MM' )
-- HAVING절 사용...
ORDER BY TO_CHAR( hiredate, 'MM' ) ASC;
-- 풀이 3)
SELECT  
      -- empno, ename, hiredate  ,
      COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 1, 'X') )  month_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 2, 'X') )  month_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 3, 'X') )  month_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 4, 'X') )  month_4
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 5, 'X') )  month_5
      , COUNT(  DECODE( TO_CHAR( hiredate, 'MM' ), 6, 'X') )  month_6
FROM emp;
-- 각 분기별로 입사한 사원수 파악
-- 1~3 1분기    4~6 2분기  7~9 3분기 10~12 4분기
SELECT  
      -- empno, ename, hiredate  ,
        COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 1, 'X') )  분기_1
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 2, 'X') )  분기_2
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 3, 'X') )  분기_3
      , COUNT(  DECODE( TO_CHAR( hiredate, 'Q' ), 4, 'X') )  분기_4 
FROM emp;
--       
SELECT TO_CHAR( hiredate, 'YYYY'), TO_CHAR( hiredate, 'MM'), COUNT(*) 
FROM emp
GROUP BY TO_CHAR( hiredate, 'YYYY'), TO_CHAR( hiredate, 'MM')
ORDER BY TO_CHAR( hiredate, 'YYYY'), TO_CHAR( hiredate, 'MM');
       
-- [문제]  설문조사
--               시작일   25.10.5.   오전 9시 부터
--               종료일   25.10.15.  낮 12시 까지
--        지금은 설문 가능한지 여부를 체크하는 쿼리를 작성하자..
SELECT SYSDATE
       , TO_CHAR( SYSDATE , 'DS TS' )
       , TO_DATE( '25.10.5 오전 9', 'YY.MM.DD AM HH' )
       , TO_CHAR(  TO_DATE( '25.10.5 오전 9', 'YY.MM.DD AM HH' ), 'DS TS' )
       , TO_DATE( '25.10.15 12', 'YY.MM.DD HH24' )
       , TO_CHAR(  TO_DATE( '25.10.15 12', 'YY.MM.DD HH24' ), 'DS TS' )
       , CASE 
           WHEN SYSDATE BETWEEN TO_DATE( '25.10.5 오전 9', 'YY.MM.DD AM HH' ) AND TO_DATE( '25.10.15 12', 'YY.MM.DD HH24' ) THEN '설문가능'
           ELSE '설문 불가능'
         END
FROM dual;


-- [문제1] emp , salgrade 테이블을 사용해서 아래 출력결과와 같은 쿼리 작성하세요. 
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
 
12개 행이 선택되었습니다. 

--group by절 + having절 설명
--문제 insa 테이블에서 총사원수, 남자사원수, 여자사원수를 조회
select 
    case 
        when substr(ssn, 8, 1) in ('1', '3', '5', '7') then '남자 사원수'
        when substr(ssn, 8, 1) in ('2', '4', '6', '8') then '여자 사원수'
    end as gender,
    count(*) as gender_count
from insa
group by
    case 
        when substr(ssn, 8, 1) in ('1', '3', '5', '7') then '남자 사원수'
        when substr(ssn, 8, 1) in ('2', '4', '6', '8') then '여자 사원수'
    end;

select
    (select count(*) "사원수"from insa) "전체사원수"
    ,(select count(*) "사원수"from insa where mod(substr(ssn,8,1),2)=1) "남자사원수"
    ,(select count(*) "사원수"from insa where mod(substr(ssn,8,1),2)=0) "여자사원수"
from dual;

select count(*) "총 사원수"
    ,count(decode(mod(substr(ssn,8,1),2),1,'O'))"남자사원수"
    ,count(decode(mod(substr(ssn,8,1),2),0,'X'))"여자사원수"
from insa;
        
select count(*) "총 사원수"
    ,count(case mod(substr(ssn,8,1),2)when 1 then 'O' end)"남자사원수"
    ,sum(case mod(substr(ssn,8,1),2)when 0 then 1 end)"여자사원수"
from insa;
    
    
select decode( mod(substr(ssn,8,1),2),1,'남자','여자') gender,count(*) "사원수"
from insa
group by mod(substr(ssn,8,1),2)
union all
select '총 사원수',count(*)
from insa;

--group by rollup 또는 cube
select decode( mod(substr(ssn,8,1),2),1,'남자',0,'여자','전체사원수') gender
    ,case mod(substr(ssn,8,1),2)
        when 1 then '남자'
        when 0 then '여자'
        else '전체사원수'
    end gender
    ,count(*) "사원수"
from insa
group by rollup(mod(substr(ssn,8,1),2));

------------------------
--문제 emp 테이블의 각 부서별 급여 합 조회
--부서없는 사원수 나오게끔
--40번 부서원 0 표기

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

-- 완
select dname,nvl(sum_pay,0)
from(
    select deptno,sum(sal+nvl(comm,0))sum_pay
    from emp
    group by deptno
)e full join dept d on e.deptno=d.deptno;

--문제 emp테이블에서 부서별 그룹핑, job별로 그룹핑, 그 급여합 조회

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


--문제 각 부서별 최고 급여액을 받는 사원 정보

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
--문제 emp테이블에서 최고급여액을 받는 사원 정보

select deptno, empno,ename,sal+nvl(comm,0) pay
from emp
where sal+nvl(comm,0) in(
    select max(sal+nvl(comm,0)) 
    from emp   
);

--순위
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

--sql 연산자 : all, any, [exists]

where exists(select deptno from dept where deptno=10); --참
select deptno from dept where deptno=20;
select deptno from dept where deptno=30;
where exists(select deptno from dept where deptno=50);--거짓
--group by + having
--문제 insa테이블에서 부서별 사원수가 10명이상인 부서 조회
select *
from(
    select buseo,count(*) "CNT"
    from insa
    group by buseo
)
where CNT>=10
order by buseo asc;
--group by 절이 실행된 후에 조건절이 필요한 경우 많음 + having절


select buseo,count(*) "CNT"
from insa
    group by buseo 
having count(*)>=10
order by buseo asc;

--문제 insa 테이블에서 여자사원수가 5명 이상인 부서의 부서명과 사원수를 출력

select buseo, count(*) as 여자사원수
from insa
where mod(substr(ssn,8,1),2)=0
group by buseo
having count(*)>=5;



select *
from insa;


--emp 테이블에서 사원의 급여, 사원 전체 평균보다 급여가 많다/적다/같다 출력

SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay,
    CASE
        WHEN sal+NVL(comm,0)>(
            SELECT AVG(sal+NVL(comm,0))
            FROM emp
        )THEN '많다'
        WHEN sal+NVL(comm,0)<(
            SELECT AVG(sal+NVL(comm,0))
            FROM emp
        )THEN '적다'
        ELSE '같다'
        END 비교
FROM emp;

-- 풀이 - case
SELECT empno,ename,pay-avg_pay,
CASE
        WHEN pay-avg_pay>0 THEN '많다'
        WHEN pay-avg_pay<0 THEN '적다'
        ELSE '같다'
        end 급여평가

FROM(
SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay
FROM emp
);
--풀이 - decode
SELECT empno,ename,pay-avg_pay,
    DECODE(SIGN(pay-avg_pay),-1,'적다',1,'많다','같다')평가
FROM(
SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay
FROM emp
);

SELECT empno,ename,sal+NVL(comm,0) pay,(SELECT AVG(sal+NVL(comm,0))FROM emp) avg_pay,
    CASE
        WHEN sal+NVL(comm,0)>(SELECT AVG(sal+NVL(comm,0))FROM emp)THEN '많다'
        WHEN sal+NVL(comm,0)<(SELECT AVG(sal+NVL(comm,0))FROM emp)THEN '적다'
        ELSE '같다'
        END 비교
FROM emp;

-- [문제] insa 테이블에서
--   서울 출신 사원 중에 부서별 남자, 여자 사원수
--                           남자급여총합, 여자 급여총합 조회(출력)
-- [출력 형식]
--BUSEO                남자인원수      여자인원수 남자급여합      여자급여합     
----------------- ---------- ---------- ---------- ----------
--개발부                   0          2             1,790,000
--기획부                   2          1  5,060,000  1,900,000
--영업부                   4          5  6,760,000  6,400,000
--인사부                   1          0  2,300,000           
--자재부                   0          1               960,400
--총무부                   2          1  3,760,000    920,000
--홍보부                   0          1               950,000


SELECT buseo, 
        COUNT( DECODE(  MOD( SUBSTR(ssn, -7,1), 2 ), 1 , 'O') ) "남자사원수",
        COUNT( DECODE(  MOD( SUBSTR(ssn, -7,1), 2 ), 0 , 'O') ) "여자사원수",
        NVL(TO_CHAR(SUM(DECODE(SUBSTR(ssn, 8, 1), '1', basicpay+sudang )), '9,999,999'),' ') AS 남자급여합,
        NVL(TO_CHAR(SUM(DECODE(SUBSTR(ssn, 8, 1), '2', basicpay+sudang )), '9,999,999'),' ') AS 여자급여합
FROM insa
WHERE city='서울'
GROUP BY buseo;


--풀이
WITH temp AS(
    SELECT *
    FROM insa
    WHERE  city='서울'
)
SELECT 
    DISTINCT t.buseo,
    (SELECT COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 1 , 'O')) FROM temp WHERE buseo = t.buseo) 남자사원수,
    (SELECT COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 0 , 'O')) FROM temp WHERE buseo = t.buseo) 여자사원수,
    (SELECT SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 1 , basicpay+sudang)) FROM temp WHERE buseo = t.buseo) 남자급여합,
    (SELECT SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ), 0 , basicpay+sudang)) FROM temp WHERE buseo = t.buseo) 여자급여합
FROM temp t;
    
--풀이2
SELECT buseo    
    ,COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,'O')) 남자사원수
    ,COUNT(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,'O')) 여자사원수
    ,NVL(TO_CHAR(SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,basicpay)),'9G999G999'),' ') 남자총급여합
    ,NVL(TO_CHAR(SUM(DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),0,basicpay)),'9G999G999'),' ') 여자총급여합

FROM insa
WHERE city='서울'
GROUP BY buseo
ORDER BY buseo;
--풀이3
SELECT buseo
    ,DECODE(MOD( SUBSTR(ssn, -7,1), 2 ),1,'남자','여자') as gender
    ,COUNT(*)
    ,TO_CHAR(SUM(basicpay),'9G999G999')
FROM insa
WHERE city='서울'
GROUP BY buseo,MOD( SUBSTR(ssn, -7,1), 2 )
ORDER BY buseo,gender;

--문제 emp테이블에서 급여 순위 TOP 5 사원의 정보 조회

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

--풀이2 - TOP-N 분석방법
--인라인뷰 + ORDER BY
SELECT t.*,ROWNUM
FROM(
    SELECT empno,ename,hiredate,sal+NVL(comm,0) pay
    FROM emp
    ORDER BY sal+NVL(comm,0) DESC
) t
WHERE ROWNUM <=5;

--만약에 
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

--순위 rank
--급여순으로 등수 매기기
select empno, ename, sal+nvl(comm,0) pay
        ,rank() over(order by sal+nvl(comm,0))as "RANK 함수 급여순위"
        ,dense_rank() over(order by sal+nvl(comm,0))as "DENSE_RANK 함수 급여순위"
from emp;

select empno, ename, sal
        ,rank() over(order by sal)as "RANK 함수 급여순위" -- 중복허용 O 순서유지 X 
        ,dense_rank() over(order by sal)as "DENSE_RANK 함수 급여순위" -- 중복허용 O 순서유지 O
        ,row_number() over(order by sal)as "ROW_NUMBER 함수 급여순위" -- 중복허용 X 순서유지 O
from emp;
--문제 emp테이블에서 각 부서별 급여많은 순위를 매겨서 출력

select d.deptno,d.dname
        ,nvl(sum(sal+nvl(comm,0)),0)dept_sum_pay
        ,rank() over(order by nvl(sum(sal+nvl(e.comm,0)),0)desc) as "순위"
from dept d
full join emp e on d.deptno=e.deptno
group by d.deptno,d.dname;


select *
from emp;

select *
from dept;

--풀이 top-n
select t.*,rownum
from(
    select nvl(deptno,0) deptno
        ,sum(sal+nvl(comm,0))dept_sum_pay
        from emp
        group by deptno
        order by dept_sum_pay desc
) t;

--풀이2 순위관련 함수 rank(), dense_rank(),row_number()


    select nvl(deptno,0) deptno
        ,sum(sal+nvl(comm,0))dept_sum_pay
        ,rank() over(order by sum(sal+nvl(comm,0))desc)as "순위"
        from emp
        group by deptno;

--풀이3 group by 절
select deptno,ename
        , sal+nvl(comm,0) pay
from emp
order by deptno asc, pay desc;

SELECT *
FROM(
    SELECT deptno,ename
            , sal+nvl(comm,0) pay
--            , rank() over( partition by(deptno) order by sal+nvl(comm,0) desc )순위
--            , rank() over( partition by deptno order by sal+nvl(comm,0) desc )순위
            , rank() over( order by sal+nvl(comm,0) desc )순위

    FROM emp
)
WHERE 순위 BETWEEN 2 AND 3;
WHERE 순위<=2;
WHERE 순위=1;
--order by deptno asc, pay desc;
---------------------------------
--문제 INSA테이블에서 여자사원수가 가장많은 부서명, 여자사원수를 출력하는 쿼리

SELECT buseo,여자사원수
FROM(
    SELECT buseo,
        COUNT(CASE WHEN MOD(TO_NUMBER(SUBSTR(ssn, -7, 1)), 2) = 0 THEN 1 END) AS 여자사원수,
        RANK() OVER(ORDER BY COUNT(CASE WHEN MOD(TO_NUMBER(SUBSTR(ssn, -7, 1)), 2) = 0 THEN 1 END)DESC)AS 순위
    FROM insa
    GROUP BY buseo
)
WHERE 순위=1;

--풀이1
WITH t AS(
    SELECT buseo,COUNT(*) 여자사원수
    FROM insa
    WHERE MOD(SUBSTR(ssn,8,1),2)=0
    GROUP BY buseo
    ORDER BY 여자사원수 DESC
)
SELECT *
FROM t
WHERE 여자사원수 =(SELECT MAX(여자사원수)FROM t);

--풀이2 순위 함수
SELECT *
FROM(
    SELECT buseo,COUNT(*) 여자사원수,
        RANK() OVER(ORDER BY COUNT(*) DESC)순위
    FROM insa
    WHERE MOD(SUBSTR(ssn,8,1),2)=0
    GROUP BY buseo
)
WHERE 순위=1;
--풀이3
--ORA-00937: not a single-group group function
    SELECT buseo,COUNT(*) 여자사원수,
        RANK() OVER(PARTITION BY buseo ORDER BY COUNT(*) DESC)순위
    FROM insa
    WHERE MOD(SUBSTR(ssn,8,1),2)=0;
    
--insa 테이블에서 basicpay가 상위 10%에 해당하는 사원들의 이름, 기본급을 출력   
    
WITH total_cnt as(
    SELECT COUNT(*) as cnt from insa
),ranked as(
SELECT name,basicpay,
    RANK() OVER(ORDER BY basicpay desc) as rnk
FROM insa
)
SELECT name,basicpay
FROM ranked,total_cnt -- 크로스 조인 ?
WHERE rnk<=cnt*0.1;

--풀이 1
SELECT name, basicpay, r_rank
FROM (
        SELECT name, basicpay
               , RANK() OVER(ORDER BY basicpay DESC) r_rank
               , DENSE_RANK() OVER(ORDER BY basicpay DESC) dr_rank
        --     , ROW_NUMBER() OVER(ORDER BY basicpay DESC) rn_rank
        --     , TOP-N 분석 방법;
        FROM insa
)
WHERE r_rank <= (SELECT COUNT(*)*0.1 FROM insa);
-- WHERE r_rank <= 6;
    
--풀이2 -PERCENT_RANK
SELECT *
FROM(
SELECT name,basicpay,
    PERCENT_RANK() OVER(ORDER BY basicpay desc) as pr_rank
FROM insa
)
WHERE pr_rank<=0.1;
    
--emp 테이블에서 sal 컬럼으로 상중하로 사원구분

SELECT ename,sal,TRUNC(p_rank,2),
    CASE
        WHEN p_rank BETWEEN 0 AND 0.33  THEN '상'
        WHEN p_rank BETWEEN 0.34 AND 0.66  THEN '중'
        WHEN p_rank BETWEEN 0.67 AND 1  THEN '하'
    END AS 구분
FROM(
    SELECT ename, sal,
        PERCENT_RANK() OVER(ORDER BY sal desc) AS p_rank
    FROM emp
);

--풀이

SELECT t.empno,t.ename,t.sal,
    CASE
        WHEN t.pk_rank<=0.33 THEN '상'
        WHEN t.pk_rank BETWEEN 0.34 AND 0.66 THEN '중'
        ELSE '하'
    END grade
FROM(
    SELECT emp.*,
        PERCENT_RANK() OVER(ORDER BY sal desc) pk_rank
    FROM emp
) t;


--풀이 2
NTILE(n) OVER (
    [PARTITION BY partition_expression]
    ORDER BY order_expression
)
SELECT emp.*
    , NTILE(3) OVER( ORDER BY sal DESC ) grade
    , DECODE(  NTILE(3) OVER( ORDER BY sal DESC ) , 1 , '상', 2, '중', '하' ) grade
FROM emp;

--풀이 3 NTILE 분석함수 사용
SELECT *
FROM(
SELECT name, basicpay
    ,NTILE(10)OVER(ORDER BY basicpay DESC) grade
FROM insa
)
WHERE grade=1;

--FIRST_VALUE, LAST_VALUE
--각 부서별 최고 sal받는 사원정보 조회
SELECT deptno,ename,sal
FROM(
SELECT ename,sal,deptno
--    ,FIRST_VALUE(sal) OVER(ORDER BY sal DESC) max_sal
--    ,FIRST_VALUE(ename) OVER(ORDER BY sal DESC) max_ename
    ,FIRST_VALUE(sal) OVER(PARTITION BY deptno ORDER BY sal DESC)deptno_max_sal
FROM emp
)
WHERE sal=deptno_max_sal;




--insa테이블에서 주민번호로 생일이 지났는지 여부

--문제1 사원번호가 1002,1005,1008인 사원
--update
UPDATE insa
SET ssn = SUBSTR(ssn, 1, 2)
        || TO_CHAR(SYSDATE, 'MMDD') 
        || SUBSTR(ssn, 7)            
WHERE NUM IN (1002, 1005, 1008);
--풀이
SELECT num, ssn
       , SUBSTR(ssn, 1, 2) || TO_CHAR(SYSDATE, 'MMDD') ||SUBSTR(ssn, INSTR(ssn, '-'))
       , REGEXP_REPLACE(ssn, '^(\d{2})(\d{4})(-\d{7}$)', '\1?\3')
FROM insa
WHERE num IN(1002, 1005, 1008);

--확인
SELECT num,name,ssn
FROM insa
WHERE NUM IN(1002,1005,1008);
--생일확인

SELECT *
FROM insa;

SELECT NUM, SSN,
        SUBSTR(ssn, 3, 4) AS birthday,
        TO_CHAR(SYSDATE, 'MMDD') AS today,
        CASE
            WHEN SUBSTR(ssn, 3, 4) < TO_CHAR(SYSDATE, 'MMDD') THEN '지남'
            WHEN SUBSTR(ssn, 3, 4) > TO_CHAR(SYSDATE, 'MMDD') THEN '안지남'
            ELSE '오늘'
        END
FROM insa;

SELECT num,name,ssn
    ,TO_DATE(SUBSTR(ssn,3,4),'MMDD')
    ,TRUNC(SYSDATE,'DD') - TO_DATE(SUBSTR(ssn,3,4),'MMDD')a
    ,DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn,3,4),'MMDD')),0,'오늘',1,'지남','안지남')
FROM insa;

--문제 insa 테이블에서 num,name,ssn,한국나이,만나이 도 출력

세는나이 : 올해년도 - 생일년도 + 1

만나이 : 올해년도 - 생일년도 

SELECT num, name, ssn,
       TO_CHAR(SYSDATE, 'YYYY') - 
       (CASE 
            WHEN SUBSTR(ssn, 8, 1) IN ('1','2','5','6') THEN 1900 + TO_NUMBER(SUBSTR(ssn,1,2))
            WHEN SUBSTR(ssn, 8, 1) IN ('3','4','7','8') THEN 2000 + TO_NUMBER(SUBSTR(ssn,1,2))
            ELSE 1800 + TO_NUMBER(SUBSTR(ssn,1,2))
        END) +1 AS 세는나이
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
        END) AS 만나이
FROM insa;

--풀이
WITH t AS 
(
    SELECT insa.*
        , TO_CHAR( SYSDATE, 'YYYY') current_year
        -- RR과 YY의 차이점
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

--인증번호 : 6자리 숫자 -> 등록
--임의의 인증번호 6자리를 발생시키는 쿼리작성

SELECT TRUNC(DBMS_RANDOM.VALUE(100000,100000))
FROM dual;

SELECT 
    DBMS_RANDOM.STRING('X', 10) --대문자+숫자
    ,DBMS_RANDOM.STRING('U', 10)--대문자만
    ,DBMS_RANDOM.STRING('L', 10)--소문자만
    ,DBMS_RANDOM.STRING('P', 10)--대+소문자+숫자+특수문자
    ,DBMS_RANDOM.STRING('A', 10)--대+소문자

FROM dual;

--insa 테이블에서 무작위로 5명의 사원을 조회
SELECT *
    FROM(
            SELECT *
            FROM insa
            ORDER BY DBMS_RANDOM.VALUE
        )
WHERE ROWNUM <=5;

--풀이
-- LEVEL 의사 칼럼

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

LISTAGG(column_name,'구분자')
    WITHIN GROUP(ORDER BY column_name);
    
SELECT deptno
    ,COUNT(*)
    ,LISTAGG(ename,', ')WITHIN GROUP(ORDER BY ename ASC) ename_list
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--위의 쿼리의 결과를 확인하면 40번 부서도 함께 출력
--outer join (left, right, full)
SELECT d.deptno
    ,COUNT(*)
    ,LISTAGG(ename,', ')WITHIN GROUP(ORDER BY ename ASC) ename_list
FROM emp e FULL OUTER JOIN dept d ON d.deptno=e.deptno
GROUP BY d.deptno
ORDER BY d.deptno ASC;


-- [문제] JOB 별 사원수를 출력(조회)
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
    SELECT TO_CHAR(hiredate,'MM') 입사한월
FROM emp
)
PIVOT(
     COUNT(*)
     FOR 입사한월 in('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12')
);



-- [문제] 
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

--풀이
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

--문제
--생일 지난사람   오늘생일인사람  생일안지난사람
--DECODE
SELECT 
       COUNT(DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')),1, 'Y', NULL)) AS 지남,
       COUNT(DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')),0, 'Y', NULL)) AS 오늘,
       COUNT(DECODE(SIGN(TRUNC(SYSDATE) - TO_DATE(SUBSTR(ssn, 3, 4), 'MMDD')),-1, 'Y', NULL)) AS 안지남
FROM insa;

--풀이
WITH t AS(
    SELECT insa.*
        ,SIGN(TO_CHAR(SYSDATE,'MMDD')-SUBSTR(ssn,3,4))birth_sign
        FROM insa
)
--가로출력
SELECT
    COUNT(DECODE(birth_sign,-1,'O'))"지나지 않음"
    ,COUNT(DECODE(birth_sign,0,'O'))"오늘"
    ,COUNT(DECODE(birth_sign,1,'O'))"지남"
FROM t;


--세로출력
--SELECT birth_sign,COUNT(*)
--FROM t
--GROUP BY birth_sign;


--PIVOT
SELECT * 
FROM (
    SELECT
        CASE
            WHEN SUBSTR(SSN, 3, 4) < TO_CHAR(SYSDATE, 'MMDD') THEN '지남'
            WHEN SUBSTR(SSN, 3, 4) = TO_CHAR(SYSDATE, 'MMDD') THEN '오늘'
            ELSE '안지남'
        END AS 생일
    FROM INSA
)
PIVOT (
    COUNT(*) FOR 생일 IN ('지남' , '오늘' , '안지남')
);

--풀이
SELECT *
FROM (
     -- PIVOT 대상이 되는 SELECT문
     SELECT 
          --insa.*
           buseo
          , SIGN( TO_CHAR( SYSDATE, 'MMDD' ) - SUBSTR( ssn, 3,4) ) birth_sign
     FROM insa
)
PIVOT(
   COUNT(*)
   FOR birth_sign IN ( -1 AS "생일X", 0 AS "오늘", 1 AS "생일O" )
)
ORDER BY buseo ASC;

--문제
SELECT *
FROM(
    SELECT deptno,sal+NVL(comm,0) pay
    FROM emp
)
PIVOT(
    SUM(pay)
    FOR deptno IN(10,20,30,40,null)
);

--문제
SELECT *
FROM(
    SELECT deptno,sal+nvl(comm,0) pay
    FROM emp
)
PIVOT(
    SUM(pay) as 총급여
    ,MAX(pay) as 최고액
    ,MIN(pay) as 최저액
    ,COUNT(pay) as 사원수
    FOR deptno IN (10,20,30,40,NULL)
);


--문제 학생 성적(국,영,수)저장하는 테이블
DDL(CREATE,ALTER, DROP)
DROP TABLE tlb_pivot PURGE;

CREATE TABLE tbl_pivot(
    -- 컬럼명    자료형
      no         NUMBER                PRIMARY KEY
    , name       VARCHAR2(20)          NOT NULL -- 필수 입력 
    , jumsu      NUMBER(3)
);
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 1, '박예린', 90 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 2, '박예린', 89 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 3, '박예린', 99 );  -- mat
 INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 4, '안시은', 56 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 5, '안시은', 45 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 6, '안시은', 12 );  -- mat 
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 7, '김민', 99 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 8, '김민', 85 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 9, '김민', 100 );  -- mat 

COMMIT; 
--
SELECT * 
FROM tbl_pivot;

--번호 이름 국 영 수
--1 박예린 90 89 99
--2 안시은 56 45 12
--3 김민  99 85 100

SELECT ROW_NUMBER() OVER (ORDER BY name) AS 번호,
  name,
  국,
  영,
  수
FROM (
  SELECT name,
         CASE
           WHEN MOD(no, 3) = 1 THEN 'kor'
           WHEN MOD(no, 3) = 2 THEN 'eng'
           WHEN MOD(no, 3) = 0 THEN 'math'
         END AS 과목,
         jumsu
  FROM tbl_pivot
)

PIVOT (
  MAX(jumsu) FOR 과목 IN (
    'kor' AS 국,
    'eng' AS 영,
    'math' AS 수
  )
)
ORDER BY name;






