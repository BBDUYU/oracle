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

SELECT ROW_NUMBER() OVER (ORDER BY name) AS 번호
  ,name,국,영,수
FROM (
  SELECT name,
         CASE
           WHEN MOD(no, 3) = 1 THEN 'kor'
           WHEN MOD(no, 3) = 2 THEN 'eng'
           WHEN MOD(no, 3) = 0 THEN 'math'
         END AS 과목, jumsu
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

-- [문제] emp 테이블에서
--       sal 컬럼을 기준으로 상위 20%에 해당 되는 사원 정보 조회.

select *
from emp;

SELECT *
FROM(
SELECT empno,ename,
    PERCENT_RANK() OVER(ORDER BY sal desc) as pr_rank
FROM emp
)
WHERE pr_rank<=0.2;


-- [문제] insa 테이블에서 

select *
from insa;

SELECT 
    g.buseo,
    (SELECT COUNT(*) FROM insa) AS 총사원수,
    d.부서사원수,
    g.성별,
    g.성별사원수,
    ROUND(d.부서사원수 / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "부/전%",
    ROUND(g.성별사원수 / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "부성/전%",
    ROUND(g.성별사원수 / d.부서사원수 * 100, 1) || '%' AS "성/부%"
FROM
    (
        SELECT 
            buseo,
            DECODE(MOD(SUBSTR(ssn, -7, 1), 2), 1, 'M', 'F') AS 성별,
            COUNT(*) AS 성별사원수
        FROM insa
        GROUP BY buseo, DECODE(MOD(SUBSTR(ssn, -7, 1), 2), 1, 'M', 'F')
    ) g
JOIN
    (
        SELECT buseo, COUNT(*) AS 부서사원수
        FROM insa
        GROUP BY buseo
    ) d ON g.buseo = d.buseo
ORDER BY g.buseo, g.성별;

--풀이
WITH a AS(
    SELECT buseo,name,ssn
        ,DECODE(MOD(SUBSTR(ssn,8,1),2),1,'M','F') gender
    FROM insa
),b AS(
    SELECT buseo 부서명
    ,(SELECT COUNT(*) FROM insa) 총사원수
    ,(SELECT COUNT(*) FROM insa WHERE buseo=a.buseo) 부서사원수
    ,gender 성별
    ,COUNT(*) 성별사원수
    FROM a
    GROUP BY buseo, gender
    ORDER BY buseo, gender
)
SELECT b.*
    ,ROUND(부서사원수 / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "부/전%"
    ,ROUND(성별사원수 / (SELECT COUNT(*) FROM insa) * 100, 1) || '%' AS "부성/전%"
    ,ROUND(성별사원수 / 부서사원수 * 100, 1) || '%' AS "성/부%"
FROM b;


SELECT COUNT(*)*0.2
FROM emp;
-- sal 높은순위
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
--PERCENT_RANK() 함수
SELECT *
FROM(
    SELECT emp.*,
        PERCENT_RANK() OVER(ORDER BY sal desc) as sal_rank
    FROM emp
)
WHERE sal_rank<=0.2;
--emp테이블에서 각 사원들의 입사일자를 기준으로 10년 5개월 20일째 되는 날짜를
--계산해서 출력하는 쿼리를 작성
SELECT  
    ename,
    hiredate,
    ADD_MONTHS(hiredate ,10*12+5)+ 20
FROM emp;


[실행결과]
        부서사원수/전체사원수 == 부/전 비율
        부서의 해당성별사원수/전체사원수 == 부성/전%
        부서의 해당성별사원수/부서사원수 == 성/부%

부서명     총사원수 부서사원수        성별  성별사원수  부/전%       부성/전%      성/부%
개발부       60       14         F       8       23.3%   13.3%       57.1%
개발부       60       14         M       6       23.3%   10%       42.9%
기획부       60       7         F       3       11.7%   5%       42.9%
기획부       60       7         M       4       11.7%   6.7%       57.1%
영업부       60       16         F       8       26.7%   13.3%       50%
영업부       60       16         M       8       26.7%   13.3%       50%
인사부       60       4         M       4       6.7%   6.7%       100%
자재부       60       6         F       4       10%           6.7%       66.7%
자재부       60       6         M       2       10%           3.3%       33.3%
총무부       60       7         F       3       11.7%   5%       42.9%
총무부       60       7         M     4       11.7%   6.7%       57.1%
홍보부       60       6         F       3       10%           5%       50%


-- [문제] insa 테이블에서 급여 많이 받는 5명만 출력
-- [1] 풀이  TOP-N 분석 방법
SELECT *
FROM (
    SELECT *
    FROM insa
    ORDER BY basicpay+sudang DESC
)
WHERE ROWNUM <= 5;

-- [2] 풀이  RANK 함수 방법
SELECT *
FROM (
    SELECT
        insa.*,
        RANK() OVER (ORDER BY basicpay + sudang DESC) AS rnk
    FROM insa
)
WHERE rnk <= 5;
-------------------------------------------------------------
-- [문제]emp 테이블에서 
-- 사원수가 가장 많은 부서명(dname), 사원수
-- 사원수가 가장 적은 부서명, 사원수 출력

-- 부서별 사원 수 중 최대/최소 1개씩 출력
WITH dept_count AS (
    SELECT deptno, COUNT(*) AS 사원수
    FROM emp
    GROUP BY deptno
),
ranked_depts AS (
    SELECT 
        d.dname,
        dc.사원수,
        RANK() OVER (ORDER BY dc.사원수 DESC) AS max_rank,
        RANK() OVER (ORDER BY dc.사원수 ASC) AS min_rank
    FROM dept_count dc
    JOIN dept d ON dc.deptno = d.deptno
)
SELECT dname, 사원수
FROM ranked_depts
WHERE max_rank = 1 OR min_rank = 1;
--풀이 1
SELECT s.*
FROM(
    SELECT t.*
        ,RANK() OVER(ORDER BY 사원수 DESC) 사원수_RANK
    FROM(
        SELECT dname,COUNT(ename) 사원수
        FROM emp e RIGHT JOIN dept d ON d.deptno=e.deptno
        GROUP BY dname
        ORDER BY dname asc
    )t
)s
--WHERE 사원수_RANK IN(1,(SELECT MAX(사원수_RANK)FROM t));
WHERE 사원수_RANK IN(1,4);

--풀이2
WITH t AS(
        SELECT dname,COUNT(ename) 사원수
        FROM emp e RIGHT JOIN dept d ON d.deptno=e.deptno
        GROUP BY dname
        ORDER BY dname asc
),s AS(
 SELECT t.*
        ,RANK() OVER(ORDER BY 사원수 DESC) 사원수_RANK
    FROM t
)
SELECT s.*
FROM s
WHERE 사원수_RANK IN(1,(SELECT MAX(사원수_RANK)FROM s));
--풀이3
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

-- [문제] emp 테이블에서
--       각 년도별  월별 입사한 사원수 조회..

SELECT 
    EXTRACT(YEAR FROM hiredate) AS 입사년도,
    EXTRACT(MONTH FROM hiredate) AS 입사월,
    COUNT(*) AS 사원수
FROM emp
GROUP BY 
    EXTRACT(YEAR FROM hiredate),
    EXTRACT(MONTH FROM hiredate)
ORDER BY 
    입사년도,입사월;
    
--풀이
SELECT TO_CHAR(hiredate,'YYYY') h_year
    ,TO_CHAR(hiredate,'MM') h_month
    ,COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY'),TO_CHAR(hiredate,'MM')
ORDER BY h_year,h_month asc;
--풀이2
SELECT *
    FROM(
        SELECT TO_CHAR( hiredate , 'YYYY' ) h_year
              , TO_CHAR( hiredate , 'MM' )  h_month
        FROM emp
        )PIVOT(
            COUNT(*)
            FOR h_month IN ('01','02','03','04','05','06','07','08','09','10','11','12')
        );
--파티션 사용

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


--문제2
--emp 테이블에서 각 부서별, job별 사원수를 출력
SELECT deptno AS 부서번호,
       job AS 직업,
       COUNT(*) AS 사원수
FROM emp
GROUP BY deptno, job
ORDER BY deptno, job;
--emp에 총 job종류 확인하는 쿼리
--오라클 10g부터 새로 추가된 기능 : PARTITION BY + OUTER JOIN 구문 추가사용
--많이쓸듯 - 파티션+조인
SELECT deptno AS 부서번호,
       b.job AS 직업,
       COUNT(ename) AS 사원수
FROM emp a PARTITION BY(deptno) RIGHT JOIN (SELECT DISTINCT job FROM emp) b ON a.job=b.job
GROUP BY deptno, b.job
ORDER BY deptno, b.job;

--emp 테이블에서 각 부서별 급여 순서를 RANK 함수를 사용해서처리

SELECT emp.*
    ,RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_rank
FROM emp;

-- [문제]   
--       emp 테이블에서 sal 가장 많이 받는 사원의 이름, sal 출력
--       emp 테이블에서 sal 가장 적게 받는 사원의 이름, sal 출력

SELECT ename, sal
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp)
   OR sal = (SELECT MIN(sal) FROM emp)
ORDER BY sal DESC;

--풀이
SELECT ename,sal
FROM(
    SELECT ename, sal
        ,RANK()OVER(ORDER BY sal DESC)sal_rank
    FROM emp
)
WHERE sal_rank=1;
--풀이2 집계함수() keep()
SELECT MAX(sal)
FROM emp;


SELECT MAX(ename) KEEP(DENSE_RANK FIRST ORDER BY sal DESC) ename, MAX(sal)
,MIN(ename) KEEP(DENSE_RANK LAST ORDER BY sal DESC) ename, MIN(sal)
FROM emp;

-- [문제] emp 테이블에서 각 부서별 최고sal, empno , 최저sal  , empno 조회

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
    ,COUNT(*) OVER(ORDER BY sal ASC) --누적된 수를 반환하는 쿼리
    ,SUM(sal) OVER(ORDER BY sal ASC) --누적된 합을 반환하는 쿼리
    ,AVG(sal) OVER(ORDER BY sal ASC) --누적된 평균을 반환하는 쿼리
FROM emp;


--문제 EMP테이블에서 사원이 존재하지 않는 부서번호와 부서명을 출력
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

--풀이2 NOT EXISTS

SELECT d.deptno, d.dname
FROM dept d
WHERE NOT EXISTS(
    SELECT 1 FROM emp e WHERE e.deptno = d.deptno
);
--각 부서별 사원수 집계 + 집계된 사원수가 0인 부서번호와 부서명 출력
SELECT d.deptno,dname
--    ,COUNT(empno)
FROM emp e RIGHT JOIN dept d ON d.deptno=e.deptno
GROUP BY d.deptno,dname
HAVING COUNT(empno)=0; --GROUP BY의 조건절


SELECT d.deptno, d.dname
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.empno IS NULL;

--예 emp 테이블 급여 기준으로 상중하 출력

SELECT deptno,ename,sal
    ,DECODE(NTILE(3) OVER(ORDER BY sal ASC),1,'하',2,'중','상') ntiles
    ,NTILE(2) OVER(PARTITION BY deptno ORDER BY sal ASC)
FROM emp
ORDER BY deptno;

--너비 버킷 - 어떤값이 어느구간에 속하는지 반환하는 함수
--WIDTH_BUCKET() 함수
--WIDTH_BUCKET(expr,min_value,max_value,num_buckets)

SELECT ename,sal
    ,WIDTH_BUCKET(sal,0,4000,4) bucket
FROM emp;

--예

SELECT ename,TRUNC(sal/100+50)score
    ,DECODE(TRUNC(TRUNC(sal/100+50)/10),10,'수',9,'수',8,'우',7,'미',6,'양','가')grade
    ,CASE
        WHEN TRUNC(sal/100+50) BETWEEN 90 AND 100 THEN '수'
        WHEN TRUNC(sal/100+50) BETWEEN 80 AND 89 THEN '우'
        WHEN TRUNC(sal/100+50) BETWEEN 70 AND 79 THEN '미'
        WHEN TRUNC(sal/100+50) BETWEEN 60 AND 69 THEN '양'
        ELSE '가'
    END grade

FROM emp;

--LAG(),LEAD()
SELECT ename,sal
    ,LAG(sal)OVER(ORDER BY sal ASC) a
    ,LAG(sal,3)OVER(ORDER BY sal ASC) b
    ,LEAD(sal,3,-1)OVER(ORDER BY sal ASC) c
FROM emp
ORDER BY sal ASC;

--오라클 자료형 정리
-- [오라클 자료형 ( Data Type) 정리 ]
1) CHAR[(size[BYTE ? CHAR])]  고정길이의 문자 데이터, 최대 크기 2KB  
2) VARCHAR2[(size[BYTE ? CHAR])] 가변길이의 문자 데이터, 최대 크기 4KB인  
3) NCHAR[(size)] 여러 언어에 의해서 결정되며, CHAR형과 같다.  
4) NVARCHAR2(size)  여러 언어에 의해서 결정되며,   varchar2 형과 같다.  
5) LONG  최대 2GB까지의 가변길이 문자데이터 
6) RAW(size)  최대 2GB까지의 바이트 문자열 데이터 
7) LONG RAW  최대 2GB까지의 이진 문자열 데이터 
8) NUMBER[(l,d)] 수치 데이터로 전체길이 'l'이고 소수점 자릿수 'd' 예로 number(6,2)=xxxx.xx 
9) BLOB  최대 길이 4GB까지의 구조화되지 않은 이진 데이터  
10) CLOB  최대 길이 4GB까지의 구조화되지 않은 문자 데이터 
11) NCLOB  최대 길이 4GB까지의 여러 언어의 문자 데이터 
12) DATE  날짜, 시간 데이터(BC 4712.1.1∼CE 4712.12.31범위)  
13) TIMESTAMP[(n)] 소숫점 9자리까지의 정밀도를 가진 날짜 정보  
14) BFILE  최대 4GB까지의 이진 파일, DB 외부에 파일로 저장 
15) ROWID  테이블에 행이 저장될 때 ROWID 타입을 이용해서 저장 






--예제
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
 INSERT INTO tbl_number VALUES ( '홍길동', 23.22, 199.88, 23, null, null);
 INSERT INTO tbl_number VALUES ( '홍길님', 98, 54, 76, null, null);
 INSERT INTO tbl_number VALUES ( '서주원', 67, 99, 199, null, null);
 COMMIT;

UPDATE tbl_number
SET eng=100
WHERE name='홍길동';

UPDATE tbl_number
SET mat=99
WHERE name='서주원';

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
FROM tabs --REGEXP_LIKE() 함수 사용해서 수정
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
--Table TBL_SAMPLE이(가) 생성되었습니다.

SELECT *
FROM tbl_sample;
--테이블구조확인
DESCRIBE tbl_sample;
DESC tbl_sample;

--테이블 컬럼 추가
ALTER TABLE tbl_sample
ADD(
    tel VARCHAR2(20)
    ,bigo VARCHAR2(255)
);

SELECT *
FROM tbl_sample;

--테이블수정 : 비고 컬럼의 크기를 줄이는 수정
ALTER TABLE tbl_sample
MODIFY (bigo VARCHAR2(100));

DESC tbl_sample;

--컬럼명을 수정 bigo -> memo 컬럼명 수정
ALTER TABLE tbl_sample
RENAME COLUMN bigo TO memo;

--테이블명 변경
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
(1, '홍길동', '1234', 'hong@naver.com', '첫 번째 게시글', SYSDATE, 0, 0, '첫 번째 게시글 내용'); 


--ORA-00001: unique constraint (SCOTT.SYS_C007067) violated
INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, writedate, readed, tag, content)
VALUES
(2, '서영학', '1234', 'seo@naver.com', '두 번째 게시글', SYSDATE, 0, 0, '두 번째 게시글 내용'); 
--기본키 
INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, tag, content)
VALUES
(3, '정창기', '1234', 'jung@naver.com', '세 번째 게시글', 0, '세 번째 게시글 내용'); 

INSERT INTO TBL_CSTVSBOARD
(seq, writer, pwd, email, title, tag, content)
VALUES
(seq_TBL_CSTVSBOARD.NEXTVAL, '관', '1234', 'jung@naver.com', '네 번째 게시글', 0, '세 번째 게시글 내용');


--형식
CREATE SEQUENCE seq_TBL_CSTVSBOARD
   [ INCREMENT BY 정수]
   [ START WITH 정수]
   [ MAXVALUE n ? NOMAXVALUE]
   [ MINVALUE n ? NOMINVALUE]
   [ CYCLE ? NOCYCLE]
   [ CACHE n ? NOCACHE];
   
CREATE SEQUENCE seq_TBL_CSTVSBOARD
START WITH 4
NOCACHE;
--시퀀스 삭제
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


--테이블 생성

CREATE TABLE tbl_emp30(no,name,hdate,dno)
AS
(
    SELECT empno,ename,hiredate,deptno
    FROM emp
    WHERE deptno=30
);

SELECT *
FROM tabs;
--제약조건 확인
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

--서브쿼리를 사용해서 테이블을 생성했을 때 제약조건
--tbl_emp30 테이블의 제약조건 x -> PK 제약조건 추가

ALTER TABLE     ADD/MODIFY/DROP
ALTER TABLE     ADD 문 사용

【형식】constraint추가
   ALTER TABLE 테이블명
   ADD (컬럼명 datatype CONSTRAINT constraint명 constraint실제값
       [,컬럼명 datatype]...);

ALTER TABLE tbl_emp30
--ADD (no NUMBER(4) CONSTRAINT PK_TBL_EMP30_NO);
ADD CONSTRAINT PK_TBL_EMP30_NO PRIMARY KEY(no);

--ALTER TABLE tbl_emp20
--ADD CONSTRAINT PRIMARY KEY(empno);

desc tbl_emp20;

--tbl_emp30 테이블에 존재하는 제약조건을 확인한후에 pk제약조건 제거
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'TBL_EMP30';

【형식】
        ALTER TABLE 테이블명
        DROP [CONSTRAINT] constraint명; 

ALTER TABLE TBL_EMP30
DROP PRIMARY KEY;

--dept 테이블의 pk제약조건을 확인하고 삭제
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT';

ALTER TABLE DEPT
DROP PRIMARY KEY;

--tbl_emp30,tbl_emp20 테이블 삭제
DROP TABLE tbl_emp30 PURGE;
DROP TABLE tbl_emp20 PURGE;

--서브쿼리를 사용해서 테이블 생성 + 결과 (데이터)추가
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
--사원번호 9999번인 사원명을 admin으로수정, 입사일자를 오늘날짜로 수정
UPDATE emp
SET ename = UPPER('admin'),hiredate=SYSDATE
WHERE empno=9999;

--9999 사원의 job,mgr을 7369번의 job, mgr값으로 수정
UPDATE emp 
SET (job, mgr) = (
  SELECT job, mgr
  FROM emp
  WHERE empno = 7369
)
WHERE empno = 9999;

--다중 insert
SELECT *
FROM tbl_emp;

-->emp테이블의 30번 부서원 6명을 --> tbl_emp테이블에 insert
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

--조건이 없는 insert
--unconditional insert all  


【형식】
	INSERT ALL | FIRST
	  [INTO 테이블1 VALUES (컬럼1,컬럼2,...)]
	  [INTO 테이블2 VALUES (컬럼1,컬럼2,...)]
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

--조건이 있는 insert
--conditional insert all 
【형식】
	INSERT ALL
	WHEN 조건절1 THEN
	  INTO [테이블1] VALUES (컬럼1,컬럼2,...)
	WHEN 조건절2 THEN
	  INTO [테이블2] VALUES (컬럼1,컬럼2,...)
	........
	ELSE
	  INTO [테이블3] VALUES (컬럼1,컬럼2,...)
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
WHEN 조건절1 THEN
  INTO [테이블1] VALUES (컬럼1,컬럼2,...)
  INTO [테이블1] VALUES (컬럼1,컬럼2,...)
  ..........
Sub-Query;

create table tbl_sales(
employee_id        number(6),       -- 사원번호
week_id            number(2),       -- 2자리 정수
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
        

--테이블 삭제
DROP TABLE 테이블명 PURGE;
--모든 레코드를 삭제(WHERE 조건절이 없어서)
DELETE FROM 테이블명 + COMMIT, ROLLBACK;
--모든레코드를 삭제
TRUNCATE TABLE 테이블명 + COMMIT, ROLLBACK ;할 수 없음
        
--1 tbl_score 테이블 존재 확인
SELECT *
FROM TABS
WHERE REGEXP_LIKE(table_name,'tbl_score','i');
--2 tbl_score 테이블 삭제
DROP TABLE tbl_core PURGE;
--3 tbl_score 테이블 생성
    --1)CREATE TABLE DDL
    --2)서브쿼리를 사용해서 테이블 생성
        --insa 테이블에서 사원번호 <= 1005의 num,name컬럼만 복사해서
        --tbl_score 테이블을 생성

CREATE TABLE tbl_score
AS
    SELECT num,name
    FROM insa
    WHERE num<=1005;
--4 num컬럼을 pk로 설정

ALTER TABLE tbl_score
ADD CONSTRAINT pk_tbl_score_num PRIMARY KEY(num);
--5 제약 조건 확인
SELECT *
FROM user_constraints
WHERE table_name='TBL_SCORE';
--6) kor,eng,mat,tot,avg,grade,rank 컬럼 추가
--   kor,eng,mat,tot 3자리 정수 기본값 0
--   avg                p 5, s 2 실수 기본값 0
--   grade CHAR(1 CHAR)
--   rank            3자리 정수

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

--7 1001~1005 5명의 학생이 있는데
--KOR,ENG,MAT 모두0점
--오라클 임의의 수를 발생시키는 쿼리

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


--8 1005번 학생의 국,영,수 점수가 1001학생의 국-1,영-1
UPDATE tbl_score
SET (kor,eng)=(
    SELECT kor-1,eng-1
    FROM tbl_score
    WHERE num=1001
)
WHERE num=1005;

--9 모든 학생 수학점수 + 5 업데이트 (100점 초과가 안되게끔)
UPDATE tbl_score    
SET mat = CASE 
            WHEN mat + 5 > 100 THEN 100
            ELSE mat + 5
          END;
--SET mat=least(mat+5,100);

--10 모든 학생들 총점, 평균
UPDATE tbl_score
SET tot=kor+eng+mat
    ,avg=(kor+eng+mat)/3;
--11 rank 등수
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
--merge 병합 : 한쪽테이블의 정보를 다른쪽 테이블에 추가/수정
--문제 등급컬럼처리
--평균 90~100 수, 80~89 우, 미양가
SELECT *
FROM tbl_score;

UPDATE tbl_score
SET GRADE=CASE 
            WHEN avg BETWEEN 90 AND 100 THEN '수'
            WHEN avg BETWEEN 80 AND 89 THEN '우'
            WHEN avg BETWEEN 70 AND 79 THEN '미'
            WHEN avg BETWEEN 60 AND 69 THEN '양'
            ELSE '가'
        END;



-- ■ [문제1] tbl_score 테이블에서 grade( 등급 ) 처리
--    avg 90 이상 '수', 80 이상 '우'  ~ '가'
UPDATE tbl_score
SET GRADE=CASE 
            WHEN avg BETWEEN 90 AND 100 THEN '수'
            WHEN avg BETWEEN 80 AND 89 THEN '우'
            WHEN avg BETWEEN 70 AND 79 THEN '미'
            WHEN avg BETWEEN 60 AND 69 THEN '양'
            ELSE '가'
        END;


-- ■ [문제2] tbl_score 테이블에서 남학생들만 국어점수 10 감소. ( UPDATE )
--       (문제점) tbl_score 테이블에는 성별을 구분할 수 있는 컬럼 X
--               insa 테이블의 ssn 가지고 성별 파악해서 UPDATE  완성...
UPDATE tbl_score t
SET kor=kor-10
WHERE EXISTS (
    SELECT 1
    FROM insa i
    WHERE t.num=i.num 
        AND REGEXP_LIKE( SUBSTR(i.ssn, 8, 1), '[1379]' )
);
    
    --풀이
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

-- ■ [문제3] result  컬럼 추가 ( '합격', '불합격', '과락')
--   합격 : 평균 60점 이상, 40 미만 X
--  불합격 : 평균 60점 미만
--   과락 : 40 미만 
ALTER TABLE tbl_score
ADD result VARCHAR2(10);

UPDATE tbl_score
SET result = 
    CASE 
        WHEN kor < 40 OR eng < 40 OR mat < 40 THEN '과락'
        WHEN (kor + eng + mat)/3 < 60 THEN '불합격'
        ELSE '합격'
    END;

--merge
--구조가 같은 두개의 테이블을 하나의 테이블로 합치는 


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

【형식】
    MERGE [hint] INTO [schema.] {table ? view} [t_alias]
      USING {{[schema.] {table ? view}} ?
            subquery} [t_alias]
      ON (condition) [merge_update_clause] [merge_insert_clause] [error_logging_clause];

【merge_update_clause 형식】
   WHEN MATCHED THEN UPDATE SET {column = {expr ? DEFAULT},...}
     [where_clause] [DELETE where_clause]

【merge_insert_clause 형식】
   WHEN MATCHED THEN INSERT [(column,...)]
    VALUES ({expr,... ? DEFAULT}) [where_clause]
   
【where_clause 형식】
   WHERE condition

【error_logging_clause 형식】
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

--문제 위아래 MERGE
SELECT num,tot,RANK()OVER(ORDER BY tot DESC) r
FROM tbl_score;

--
UPDATE tbl_score
SET rank=null;
COMMIT;

--제약조건 CONSTRAINTS
--정의 : 데이터의 무결성을 위해 테이블에 데이터 추가/수정/삭제할 때 규칙

--제약조건 선언
--1) CREATE TABLE
--  ㄱ IN-LINE 제약조건 생성
        --테이블 생성시 컬럼뒤에 바로코딩
--  ㄴ OUT-OF-LINE 제약조건 생성
        --테이블 생성시 컬럼을 모두 선언한 뒤에 콤마 제약조건을 나열
--2) ALTER TABLE 테이블 수정
--   테이블 생성 후 따로 PK제약조건을 선언


-- 제약조건 5가지
1) PRIMARY KEY (PK) == UK + NN
2) FOREIGN KEY (FK)
    부모          자식
    dept         emp
    deptno       empno(PK)..deptno(FK)
    10                          
    20
    30
    40
3) UNIQUE KEY  (UK)
                ㄴ 휴대폰, 이메일, 학번, 주민번호
4) NOT NULL    (NN)
                ㄴ 필수입력
5) CHECK       (CK)
    kor NUMBER(3) CK 0<=kor<=100

--emp 테이블에 제약조건 조회
SELECT *
FROM user_constraints
WHERE table_name = 'EMP';
-- 제약조건 5가지
--tbl_constraints 테이블 존재유무확인
CREATE TABLE tbl_constraints
(
    empno NUMBER(4)
    ,ename VARCHAR2(20)
    ,deptno NUMBER(2)
    ,kor NUMBER(3)
    ,email VARCHAR2(250)
    ,city VARCHAR2(20)
);


INSERT INTO tbl_constraints (empno,ename,deptno) VALUES(1111,'홍길동',60);
INSERT INTO tbl_constraints (empno,ename) VALUES(2222,'홍길동');
INSERT INTO tbl_constraints (empno,ename) VALUES(3333,'홍길동');
commit;

SELECT *
FROM tbl_constraints;

UPDATE tbl_constraints
SET ename='서영학'
WHERE empno=1111;

DELETE FROM tbl_constraints
WHERE ename='서영학';

--모든 테이블은 pk설정
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
                        CHECK(city IN('서울','충남','인천','경기'))
);

INSERT INTO tbl_constraints(empno,kor,ename) VALUES(5555,999,'홍씨');
INSERT INTO tbl_constraints(empno,email,ename) VALUES(5555,'hong@naver.com','홍씨');
INSERT INTO tbl_constraints(empno,email,ename) VALUES(6666,'hong@naver.com','홍기수');

commit;

--PK 제약조건명을 선언하지않으면 오라클 서버가 자동으로 SYS_C숫자 
SELECT *
FROM user_constraints
WHERE table_name = 'TBL_CONSTRAINTS';

--컬럼 레벨 방식으로 제약조건 설정한 예
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
    , CONSTRAINT CK_tbl_constraints_city CHECK(city IN('서울','충남','인천','경기'))
    
);
--pk 2개 이상의 칼럼 == 복합키
--예)
사원번호        지급일     지급액
7369        2025/08/25  4,000,000
7369        2025/09/25  4,000,000
7369        2025/10/25  4,000,000


--제약조건 삭제
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
    , CONSTRAINT CK_tbl_constraints_city CHECK(city IN('서울','충남','인천','경기'))
);

-- 제약조건 CK city 비활성화../ 활성화
ALTER TABLE TBL_CONSTRAINTS
    DISABLE CONSTRAINT CK_tbl_constraints_city [CASCADE];
    
ALTER TABLE TBL_CONSTRAINTS
    ENABLE CONSTRAINT CK_tbl_constraints_city [CASCADE];
    
--FK 설정할때
-- ON DELETE CASCADE | ON DELETE SET NULL 옵션의 의미
1) emp -> tbl_emp 테이블 생성 + 데이터 복사
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

4) NN 제약조건외의 제약조건은 복사되지 않는다. 제약조건 확인
SELECT *
FROM user_constraints
WHERE table_name IN ('TBL_DEPT','TBL_EMP');

5) tbl_dept 테이블에 deptno 컬럼에 pk제약조건 추가
    -- 테이블 생성할 때 컬럼레벨,테이블레벨 방식으로 제약조건 추가
    -- ALTER TABLE ADD 문으로 제약 조건을 추가
ALTER TABLE tbl_dept
ADD(
      CONSTRAINT PK_tbl_constraints_deptno PRIMARY KEY (deptno)   
    );

6) tbl_emp 테이블에 제약조건 2개 추가
    ㄱ. empno  pk
    ㄴ. deptno fk + ON DELETE CASCADE

ALTER TABLE tbl_emp
ADD(
       CONSTRAINT PK_tbl_emp_empno PRIMARY KEY (empno)
      ,CONSTRAINT FK_tbl_emp_deptno FOREIGN KEY(deptno)
            REFERENCES tbl_dept(deptno) ON DELETE CASCADE
    );

--ON DELETE CASCADE
--ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
--무결성 제약조건
DELETE FROM tbl_dept
WHERE deptno=10;
--dept(deptno PK)   emp(deptno FK)
      10        참조      10/10

SELECT * FROM tbl_dept;
SELECT * FROM tbl_emp;
SELECT * FROM tbl_emp WHERE deptno=30;

--ON DELETE SET NULL의미 
1) tbl_emp 테이블에 있는 FK 제약조건을 삭제
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

--tbl_dept 30 삭제
--tbl_emp 30번 부서원이 6명 있는데 같이 삭제 ON DELETE CASCADE
DELETE FROM tbl_dept
WHERE deptno=30;

SELECT * FROM tbl_emp;
COMMIT;

-- JOIN
--부서번호, 부서명, 사원명, 입사일자 컬럼 출력 emp,dept
--emp : [deptno], ename, hiredate
--dept : [deptno], dname

1)
SELECT dept.deptno, dname, ename, hiredate
FROM dept,emp
WHERE dept.deptno = emp.deptno; -- 조인조건

2)
SELECT d.deptno, dname, ename, hiredate
FROM dept d ,emp e
WHERE d.deptno = e.deptno; -- 조인조건

3) JOIN ~ ON 구문 수정
SELECT d.deptno, dname, ename, hiredate
FROM dept d JOIN emp e ON d.deptno = e.deptno; -- 조인조건

4) USING 사용
-- (주의) 객체명.컬럼명 또는 별칭명.컬럼명으로 사용하지 않음
SELECT deptno, dname, ename, hiredate
FROM dept JOIN emp USING(deptno);

5) NATURAL JOIN 구문 - 객체명을 사용하지 않음
SELECT deptno, dname, ename, hiredate
FROM dept NATURAL JOIN emp;

--NON-EQUI JOIN
--emp 테이블의 sal을 가지고 salgrade 급여등급테이블에서 grade(1,2,3,4,5)조회

SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT empno,ename,sal,losal || '~'||hisal,grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

--INNER JOIN 조인 조건을 만족하는 행만 가져온다
SELECT * FROM emp;

SELECT e.*,d.*
FROM emp e FULL OUTER JOIN dept d ON d.deptno=e.deptno;
FROM emp e LEFT OUTER JOIN dept d ON d.deptno=e.deptno;

--SELF JOIN
--A 테이블 + A 테이블
--예) 사원번호, 사원명, 직속상사의 사원번호 출력


SELECT a.empno, a.ename,a.mgr,b.ename
FROM emp a JOIN emp b ON a.mgr=b.empno;

--CROSS JOIN 데카르트 곱
SELECT emp.*
FROM emp,dept;

--ANTIJOIN

--SEMIJOIN



--조인 예제
--1 책테이블
CREATE TABLE book( 
       b_id     VARCHAR2(10)    NOT NULL PRIMARY KEY   -- 책ID
      ,title      VARCHAR2(100) NOT NULL  -- 책 제목
      ,c_name  VARCHAR2(100)    NOT NULL     -- c 이름
     -- ,  price  NUMBER(7) NOT NULL
 );
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '데이터베이스', '서울');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '데이터베이스', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '운영체제', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '운영체제', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '워드', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '엑셀', '대구');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '파워포인트', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '엑세스', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '엑세스', '서울');

COMMIT;

SELECT *
FROM book;

--2 단가 테이블
  CREATE TABLE danga(
      b_id  VARCHAR2(10)  NOT NULL  -- PK , FK
      ,price  NUMBER(7) NOT NULL    -- 책 가격
      
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

--3 저자 테이블
CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID
            REFERENCES book(b_id) -- ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL
);
INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '저팔개');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '손오공');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '사오정');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '김유신');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '유관순');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '김하늘');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '심심해');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '허첨');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '이한나');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '정말자');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '이영애');

COMMIT;

SELECT * 
FROM au_book;

--4 고객 테이블

CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY 
      ,g_name   VARCHAR2(20) NOT NULL
      ,g_tel      VARCHAR2(20)
);
 
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '우리서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '도시서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '지구서점', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '서울서점', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '수도서점', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '강남서점', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '강북서점', '777-7777');

COMMIT;

SELECT *
FROM gogaek;

--5 판매 테이블
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

--테이블
--book : b_id(PK), title, c_name
--danga : b_id(PK.FK), price
--au_book : id(PK), b_id(FK), name
--gogaek : g_id(PK), g_name, g_tel
--panmai : id(PK), g_id(FK), b_id(FK ), p_date, p_su
--문제 책ID, 책 제목, 출판사, 책단가 출력

1) JOIN ON 구문
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


-- [문제] *책id, *제목, 판매수량, *단가, 서점명(g_name), 판매금액( p_su * price) 출력.
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


-- [문제1] 출판된 책들이 각각 총 몇권이 판매되었는지 조회  
--  (    책ID, 책제목, 총판매권수, 단가 컬럼 출력   )

SELECT b.b_id,title,SUM(p_su),price
FROM book b 
    JOIN panmai p ON b.b_id = p.b_id
    JOIN danga d ON b.b_id=d.b_id
    GROUP BY b.b_id,title,price;


-- [문제2] 가장 많이 팔린 책 정보를 조회...
-- ( 책ID, 제목, 단가, 총판매권수 )

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
--풀이
-- 1) TOP-N     방식
SELECT t.*, ROWNUM
FROM ( 
    SELECT b.b_id, title, SUM (p_su ) t_psu, price
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga  d ON b.b_id = d.b_id
    GROUP BY    b.b_id, title, price 
    ORDER BY    t_psu DESC
) t
WHERE ROWNUM = 1; 

-- 2) 순위함수
SELECT * 
FROM ( 
    SELECT b.b_id, title, SUM (p_su ) t_psu, price
       , RANK() OVER( ORDEr BY SUM (p_su )  DESC ) tpsu_rank
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga  d ON b.b_id = d.b_id
    GROUP BY    b.b_id, title, price 
)
WHERe tpsu_rank <= 3;

-- [문제3] book 테이블에서 한 번도 판매가 된 적이 없는 책의 정보 조회...
-- ( 책id, 제목, 단가 )

SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id IN ( 
    SELECT b_id
    FROM book
    MINUS
    SELECT DISTINCT b_id  
    FROM panmai
);
    
--풀이
    
-- [문제4] book 테이블에서 한 번이라도 판매가 된 적이 있는 책의 정보 조회...
-- ( 책id, 제목, 단가 )    

SELECT b.b_id,title,price
FROM book b
    JOIN danga d ON b.b_id = d.b_id
    JOIN panmai p ON p.b_id=b.b_id
WHERE
    p_su>0; 


-- [문제5] 년도, 월별 판매 현황 구하기
--    년도   월     판매금액( p_su * price )
--    ---- -- ----------
--  2000   03   6000
--  2000   07   1600
--  2000   10   10500
--  2024   08   41661

SELECT TO_CHAR(p_date,'YYYY')as 년도 ,TO_CHAR(p_date,'MM')as 월,(p_su*price) as 판매금액
FROM panmai p
    JOIN danga d ON p.b_id=d.b_id;

-- [문제6] 25년도에 가장 판매가 많은 책 정보 조회 ( id, 제목, 책 수량 )
--         올해에 

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
-- 1) TOP-N     방식
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

-- 2) 순위함수
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


-- [문제7] 서점별 판매현황 구하기
--서점코드  서점명  판매금액합  비율(소수점 둘째반올림)  
-- g_id    g_name
------------ -------------------------- ----------------
--7       강북서점    15300      26%
--4       서울서점    11551      19%
--2       도시서점    6000      10%
--6       강남서점    18060      30%
--1       우리서점    8850      15%

--책 ID, 제목,단가 고객ID,고객명, 판매날짜,판매수량 컬럼조회
SELECT b.b_id, title, price, g.g_id, g_name, p_date, p_su
FROM book b
JOIN danga d ON b.b_id = d.b_id
JOIN panmai p ON b.b_id = p.b_id
JOIN gogaek g ON p.g_id = p.g_id;

【형식】
   CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름
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
-- View UVPAN이(가) 생성되었습니다.
SELECT *
FROM user_views;

SELECT *
FROM uvpan;

SELECT sum(price)
        ,sum(p_su)
FROM uvpan;
--ORDER BY 정렬
DESC uvpan;

-- [문제] 년도, 월, 고객코드, 고객명, 판매금액합
--       년도, 월 오름차순 정렬
--       uvgogaek 뷰를 생성하고 확인.
CREATE VIEW UVGOGAEK 
AS
SELECT TO_CHAR(p_date,'YYYY') 년도,TO_CHAR(p_date,'MM') 월 ,g.g_id,g_name,sum(p_su*price) 판매금액합
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
    년도, 월;

SELECT COUNT (*)
FROM UVGOGAEK
WHERE g_id=2;

DROP VIEW UVPAN;

--뷰의 두가지 종류
--단순뷰

--복합뷰

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

----복합뷰
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

--WITH CHECK OPTION 설명
--  ㄴ 뷰에 의해 접근가능한 행만이 삽입,수정가능
--  ㄴ SCORE가 90점 이상인 결과만 SELECT 뷰를생성
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

--db모델링
--1) db모델링 정의 ? 현실세계의 업무적인 프로세스를 물리적으로 데이터베이스화 시키는 과정
-- 데이터베이스 ? 서로 관련된 데이터의 집합
--예) 쇼핑몰 사이트 주문 업무(일)
--  상품검색 -> 장바구니 -> 주문 -> 결제 -> 배송 -> 상품수령 -> 반품 기타


 DB 모델링 과정( 단계 , 순서)
   1)  업무 프로세스         →   2) 개념적 DB 모델링
    ( 요구분석서 작성 )             ( ERD 작성)            -- eXERD툴
         ↑ 일치성 검토                    ↓
   4) 물리적 DB 모델링      ←    3) 논리적 DB 모델링  
     DBMS                       ( 스키마, 정규화 과정)
     타입, 크기 등등
     인덱서
     역정규화
     등등
 4. 프로젝트 진행 과정
 ※ 계획 → 분석 → 설계 → 구현 → 테스트 → 유지보수
( 1년 프로젝트 중 DataBase 모델링 6개월 정도 소요됨. )   

-------------------------------

--4. db모델링 1단계 ( 업무 프로세스 분석 -> 요구사항명세서 또는 요구분석서 작성 )

   1) 관련 분야에 대한 기본 지식과 상식 필요. 예) 회계프로그램( 대차대조표,자산,손실...)
   2) 신입사원 입장으로 업무 자체와 프로세스 파악에 초점을 두고 분석 필요.
   3) 요령    - 우선, 문서(서류,장표,보고서)를 이용하여 데이터로 관리되어지는 항목들을 
         정확하게 파악 필요.
      ( 현재 업무에 사용되어지고 있는 문서에는 데이터로 관리되어져야 하느 중요한 항목들이 모두 있기에)
   4)    - 담당자와 인터뷰
   5)   - 어떠한 사실이 정의 되기 위한 백그라운드 프로세스 파악 , 하나의 업무에서 다양한 경우의 수 파악 필요.
   6)    - 사용자의 요구 분석.
※ 데이터베이스 모델링에서 가장 중요한 것이 업무 분석 임을 명심하자.

--
 https://terms.naver.com/entry.naver?docId=3431222&ref=y&cid=58430&categoryId=58430
한빛 마트의 데이터베이스를 위한 [요구 사항 명세서]
① 한빛 마트에 회원으로 가입하려면 회원아이디, 비밀번호, 이름, 나이, 직업을 입력해야 한다.
② 가입한 회원에게는 등급과 적립금이 부여된다.
③ 회원은 회원아이디로 식별한다.

④ 상품에 대한 상품번호, 상품명, 재고량, 단가 정보를 유지해야 한다.
⑤ 상품은 상품번호로 식별한다.

⑥ 회원은 여러 상품을 주문할 수 있고, 하나의 상품을 여러 회원이 주문할 수 있다.
⑦ 회원이 상품을 주문하면 주문에 대한 주문번호, 주문수량, 배송지, 주문일자 정보를 유지해야 한다.

⑧ 각 상품은 한 제조업체가 공급하고, 제조업체 하나는 여러 상품을 공급할 수 있다.
⑨ 제조업체가 상품을 공급하면 공급일자와 공급량 정보를 유지해야 한다.
⑩ 제조업체에 대한 제조업체명, 전화번호, 위치, 담당자 정보를 유지해야 한다.
⑪ 제조업체는 제조업체명으로 식별한다.

⑫ 회원은 게시글을 여러 개 작성할 수 있고, 게시글 하나는 한 명의 회원만 작성할 수 있다.
⑬ 게시글에 대한 글번호, 글제목, 글내용, 작성일자 정보를 유지해야 한다.
⑭ 게시글은 글번호로 식별한다.

[네이버 지식백과] 요구 사항 분석 (데이터베이스 개론, 2013. 6. 30., 김연희)

--5. db모델링 1단계

1. 개념적 데이터 베이스 모델링이란 ?
   데이터 베이스 모델링을 함에 있어 가장 먼저 해야될 일은 사용자가 필요로 하는 데이터가 무엇이며
                      어떤 데이터를 데이터베이스에 담아야 하는 지에 대한 충분한 분석이다.
   이러한 것들은 업무 분석, 사용자 요구 분석 등을 통해 얻어지며 수집된 현실 세계의 정보들을 사람들이 이해할 수 있는 
   명확한 형태로 표현하는 단계를 '개념적 데이터베이스 모델링'이라고 한다.

2. ER-Diagram
   현실 세계를 좀 더 명확히 표현하기 위한 여러 방법 중 가장 널리 사용되고 있는 
    개체(E)-관계(R) 모델을 이용해
   개념적 데이터베이스 모델링에 대해 알아보자.

3. E-R Model
 1) 1976년 P.Chen이 제안한 것.
 2) 개체 관계 모델을 그래프 형식으로 알아보기 쉽게 표현한 것.
     개체  - 직사각형,
   속성  - 타원형,
   개체들 간의 관계 - 마름모
   이들을 연결하는 링크로 구성됨.

 3) 예 ( 학생과 과정 관계를 표현한 ER-Diagrm)

   학생(사) - 학번(타) 식별자속성    - 전화번호(타) - 이름(타)
      ↕
   등록(마) 다대다 관계(N:M)
       ↕
   과정(사) - 과정코드(타)식별자속성     - 과정명(타) - 과정내용(타)

4. ER - Diagrm 의 용어 
   1) 실체(Entity)
   2) 속성(Attribute)
   3) 식별자(Identifier)
   4) 관계(Relational)

   
   4-1.   실체(Entity)
   
   SELECT *
   FROM Emp;
   
   1) 업무 수행을 위해 데이터로 관리되어져야 하는 사람,사물,장소,사건등을 '실체'라 한다.
      이 때 구축하고자 하는 업무의 목적과 범위,전략에 따라 데이터로 관리되어져야 하는 항목을 파악하는 것이 매우 중요.
   2) 실체는 학생,교수 등과 같이 물리적으로 존재하는 유형
      과목,학과 등과 같이 개념적으로 존재하는 대상이 될 수 있다.
    3) 실체는 테이블로 정의된다.
   4) 실체는 인스턴스라 불리는 개별적인 객체들의 집합이다.
    예) 과목 : 자료 구조, 데이터베이스, 프로그래밍 등의 인스턴스들의 집합.
        학과 : 컴퓨터공학과, 전자공학, 국어교육학과 등의 인스턴스들의 집합.
   5) 실체를 파악하는 요령 
    - 관련 업무에 대한 지식( 가장 중요 )
    예)
     학원에서는 학생들의 출결상태와 성적들을 과목별로 관리하기를 원하고 있다.. (라고 업무 분석한 내용)
      
     - 실체(명사들 파악) : 학원(체인점이 아니라면 뺀다 ), 학생, 출결상태,성적, 과목
   -  각종 서류를 이용해서 실체 파악하는 것도 좋은 방법이다. 

   4-2.   속성(Attribute)
   1) 속성이란 ? 저장할 필요가 있는 실체에 대한 정보.
      즉, 속성은 실체의 성질, 분류, 수량, 상태, 특성, 특징 등을 나타내는 세부 항목을 의미한다. 
   2) 속성 설정 시 가장 중요한 부분은 관리의 목적과 활용 방향에 맞는 속성의 설정이다.
   3) 속성의 숫자는 10개 내외로 하는 것이 좋다.
   4) 속성은 컬럼으로 정의된다.
   예)
   학생이란 실체의 속성 ? 업무프로세스에 따라 달라짐.
          학번, 이름, 주민번호, 전화번호,주소...
   사원이란 실체의 속성 ?
         사원번호, 사원명, 주민번호, 전화번호, 주소, 입사일자, 퇴사일자, 부서명...
   5) 속성의 유형
      (1) 기초 속성 : 원래 갖고 있는 속성
      (2) 추출 속성 : 기초 속성으로 가공처리(계산)를 해서 얻어질 수 있는 속성
                자료의 중복성,무결성 확보를 위해 최호화시키는 것이 바람직하다.
      (3) 설계 속성 : 실제로 존재하지는 않으나 시스템의 효율성을 위해 설계자가 
       임의로 부여하는 속성.
   예)
   주문 Entity
   주문번호   고객   주문상품   주문일자   단가   수량   주문총금액   주문상태
   1   홍길동   H302   0204   10000   3   600000      1
   2   홍길동   H302   0204   10000   3   600000      1
   3   홍길동   H302   0204   10000   3   600000      1

   여기서)    추출속성 : 주문총금액 = 단가 * 수량    
      설계속성 : 주문상태( 주문의 진행 상태:주문,결제완료,배송완료,취소) 확인 위한 속성

   [쇼핑몰의 주문 프로세스]  
    주문->취소->주문처리 완료
        ->결제완료 -> 배송완료 -> 주문처리 완료.
 
   6) 속성 도메인의 설정
    - 속성이 가질 수 있는 값들의 범위, 다시 말해 속성에 대한 세부적인 업무 , 제약조건 및 특성을 
      전체적으로 정의해 주는 것을 '속성의 도메인 설정'이라 한다.
       kor   0~100
       
    - 도메인 설정은 추후 개발 및 실체를 데이터베이스로 생성할 때나 프로그램 구현 시 유용하게 사용하는 산출물이다.
    - 도메인 정의 시에는 속성의 이름, 자료의 형태, 길이, 형식, 허용되는 값의 제약 조건, 유일성(Unique), 널 여부,
      유효값,초기값들의 사항을 파악해주면 된다. 
    - 도메인 무결성. : 데이터의 입력 형식이나 입력값등을 정의함으로써
             잘못된 데이터가 입력되는 경우의 수를 방지    하기위해 설정하는 것. 

   4-3.   식별자(Identifier)
   1) 식별자란?
      한 실체 내에서 각각의 인스턴스를 유일(Unique)하게 구분할 수 있는 단일 속성 또는 속성 그룹.
        실체 무결성.
        학생(실체)- [학번],이름,주민번호,주소...
   2) 식별자가 없으면 데이터를 수정/삭제 못한다.
      그래서 모든 실체는 반드시 하나 이상의 식별자를 보여하여야하며 또한 여러 개의 식별자를 보유할 수 있다.
        
   3) 식별자의 종류
      (1) 후보키(Candidate Key)
         실체에서 각각의 인스턴스를 구분할 수 있는 속성( 사원번호,주민번호) 
      예) 사원 - [사원번호], [주민번호],사원명, 부서,주소
                     4   >   13
      (2) 기본키(Primary Key)
         후보키 중 가장 적합한 키. ( 사원번호 )
         - 해당 실체를 대표할 수 있나? 
              업무적으로 활용도가 높나? 
              길이가 짧나? 
              등등의 만족하는 후보키 중 하나 선택.
         ( 중요 )
           기본키는 not null, no duplicate(중복성),unique,clusterd index 설정됨.

      (3) 대체키(Alternate Key)
         후보키 중 기본키로 설정되지 않은 속성( 주민번호 )
         - index(인덱스)로 활용됨. 

      (4) 복합키(Composite Key)
         하나의 속성으로 기본키가 될 수 없는 경우 둘 이상의 컬럼을 묶어서 식별자로 정의한 경우.
         - 복합키 구성시 고려사항. : 복합키 중 어떤 컬럼을 먼저 둘것이냐? 
            이유: 복합키 중 먼저 오는 컬럼에 index,unique가 적용되기에 성능 고려 때문.
      예) 급여 내역 실체
        식별자
        (급여지급일+사번)  복합키
      급여지급일   사번    지금일자   급여액
      200901      1   30   10000   
      200901      2   30   10000   
      200902      1   30   10000   
      200902      2   30   10000   
      
      위의 기본키는 ? 없다. 
      복합키 : 급여지급일 + 사번 
      고려할 점 ) 어떠한 컬럼(속성)을 먼저 둘까? 
         - 조회의 경우 : 사번, 급여지급일 중 어느 컬럼으로 조회가 많나? 
         - 조회수가 비슷하다면 데이터의 입력 순서로 결정 : 당연 급여지급일자  우선 
            ( 아마 입력은 년/월/일 지급일자 순으로 계속 저장 될 것이다...)


      (5) 대리키(Surrogate Key:서러게이트)
         - 식별자가 너무 길거나 여러 개의 복합키로 구성되어 있는 경우 인위적으로 추가한 식별자(인공키).
         - 이것도 역정규화 작업이다. 
      예) 급여 내역 실체
           PK
      (일련번호)       급여지급일   사번    지금일자   급여액
      1           200901      1   30   10000   
      2           200901      2   30   10000   
      3           200902      1   30   10000   
      4           200902      2   30   10000   
   
      - 일련번호라는 대리키를 추가해서 식별자로 사용. ( 성능,효율성 때문에 ) 

   4-4.   관계(Relational)
   - 관계란? 업무의 연관성이다.  실체를 정의하다보면 서로 연관되는 실체들이 있다. 
   예)
   비디오테이프      회원
   관계) 
      [대여관계]
      회원은 비디오테이프를 대여한다.
             비디오테이프는 회원에게 대여된다.
      [가르침관계]
      학생은 교수에게 가르침을받는다.
      교수는 학생을 가르친다.

   - 관계 표현(부여)
   
      회원(사)    실선   대여(마)  실선   비디오(사)
      1) 관계가 있는 두 실체를 실선으로 연결하고 관계를 부여한다.
     2) 관계 차수를 표현한다. ( 1:1, 1:N, N:M관계)
     3) 선택성을 표시한다. 

   4-4-1) 관계 차수
      1) 1:1 관계
       각각의 부서와 관리하는 부서장과의 관계.
 
      1) 1:N 관계
       각각의 부서와 사원과의 관계

      1) N:M 관계
        고객과 상품 실체 간에는 주문이라는 관계. 
       ( 한 고객은 여러 상품을 주문할 수 있고, 한 상품은 여러 고객에게 주문될 수 있다.)

       다대다 관계는 여러 문제점 때문에
         논리적 데이터베이스 모델링 단계를 거치면서 1:N 관계로 바꾼다. 

      실제 데이터베이스는 1:1과 1:다 관계만 존재한다. 


   
□ 실무자와 같이 업무적인 설명을 듣고 모델링을 시작해 보자.

   1. 회원제를 실시하는 비디오 상점.
   2. 회원 관리
      ㄱ) 회원이름, 주민번호, 전화번호, 휴대폰번호, 우편번호, 주소, 등록일 등 .
   3. 비디오 테이프 관리
      ㄱ) 장르별, 등급별로 나누어 관리.
      ㄴ) 고유한 일련번호를 부여해서 비디오 테이프를 관리. 
      ㄷ) 영화제목, 제작자, 제작 국가, 주연배우, 감독, 개봉일자, 비디오 출시일 등 상세 정보 관리.
      ㄹ) 파손 여부와 대여 여부 관리.      
   4. 비디오 테이프 대여
      ㄱ) 회수일이 기본 이틀
      ㄴ) 미납 회원들의 목록을 자동으로 관리.
      ㄷ) 연체되었을 경우에는 연체료를 받는다.
      ㄹ) 대여료 신/구 차등 관리.
   5. 포인터 관리 서비스
      ㄱ) 회원에게 대여 1회당 1점씩 포인트 점수를 부여하여 10점이 되면 무료로 TAPE 하나 대여 서비스
   6. 관리자 관리
      ㄱ) 일별 , 월별, 년별 매출액 손쉽게 파악.
      ㄴ) 비디오 테이프의 대여 회수 파악.
      ㄷ) 연체료 관리
      ㄹ) 미납 회원 관리.
      ㅂ) 직원 관리( 근무 시간, 임금 자동 계산 )
      ㅅ) 체인점을 확장해 운영하고 자 함. 


   Entity 파악
    - 회원 
    - 비디오 
    - 영화 상세정보
    - 대여 정보 
    - 연체 정보
    - 포인트 정보
    - 직원 정보
    - 체인점 
    - 매출
    
   Atrribute 파악
    - 회원 
            회원ID (PK)
            회원이름
            주민등록번호
            전화번호
            휴대폰번호
            우편번호
            주소
            등록일자
            누적포인트
            
    - 비디오
            비디오ID (PK)
            영화ID (FK)
            일련번호
            파손여부
            대여여부
            소속지점ID (FK)
    
    - 영화상세정보 
            영화ID (PK)
            제목
            제작자
            제작 국가 
            주연배우
            감독
            개봉일자
            비디오 출시일
                   
    - 대여
            대여ID (PK)
            회원ID (FK)
            테이프ID (FK)
            대여일자
            반납예정일 
            반납일자
            연체여부
            연체료ID (FK)
            가격정책ID(FK)
            
    - 가격 정책
            가격정책ID (PK)
            비디오ID (PK)
            신작/구작 구분
            대여료
            
    - 연체
            연체ID (PK)
            대여ID (FK)
            연체일수
            연체료금액
    
    - 포인트
            포인트ID (PK)
            회원ID (FK)
            적립일자
            적립포인트
            사용포인트
            무료대여서비스가능여부
            
    - 직원
            직원ID (PK)
            직원이름
            체인점ID (FK)
            직급
            시급
            임금 (자동 계산)
    
    - 근무기록
            기록번호(PK)
            직원ID(FK)
            근무날짜
            근무시간
    
    - 체인점
            체인점ID (PK)
            체인점명
            주소
            전화번호
            개점일자
            
    -  매출
            매출ID (PK)
            지점ID (FK)
            날짜
            일매출
            월매출
            연매출
    
   Indentifier 파악
    - 회원            - 회원ID (PK)
    - 비디오          - 비디오ID (PK)
    - 영화 상세정보    - 영화ID (PK)
    - 대여 정보       - 대여ID (PK)
    - 연체 정보       - 연체ID (PK)
    - 포인트 정보     - 포인트ID (PK)
    - 직원 정보       - 직원ID (PK)
    - 체인점          - 체인점ID (PK)
    - 매출            - 매출ID (PK)
   
   Relational /차수/선택성
| 관계               | 설명                                  | 차수     | 선택성              |
| 회원 - 대여        | 한 회원은 여러 대여를 할 수 있음          | 1 : N    | 회원(필수) ↔ 대여(필수)  |
| 대여 - 비디오테이프 | 한 테이프는 여러 번 대여될 수 있음        | 1 : N    | 테이프(필수) ↔ 대여(필수) |
| 대여 - 연체        | 한 대여건은 연체가 없을 수도 있음         | 선택적    | 선택적 관계           |
| 회원 - 포인트      | 한 회원은 여러 포인트 내역을 가질 수 있음  | 1 : N    | 회원(필수) ↔ 포인트(선택) |
| 영화 - 비디오테이프 | 한 영화는 여러 테이프 복사본을 가짐       | 1 : N    | 영화(필수) ↔ 테이프(필수) |
| 체인점 - 직원       | 한 체인점에 여러 직원 존재              | 1 : N    | 체인점(필수) ↔ 직원(필수)  |
| 체인점 - 비디오테이프| 한 체인점에서 여러 테이프 보유 가능      | 1 : N    | 체인점(필수) ↔ 테이프(필수) |
| 체인점 - 매출       | 체인점별 매출 집계                     | 1 : N    | 체인점(필수) ↔ 매출(필수)  |

--  ERD 개념적 db모델링 -- 
   

