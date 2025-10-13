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


