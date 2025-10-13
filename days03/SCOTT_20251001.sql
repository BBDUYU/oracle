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

