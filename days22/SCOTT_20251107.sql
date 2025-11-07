CREATE OR REPLACE PROCEDURE up_idcheck
(
    pid IN emp.empno%TYPE
    , pcheck OUT NUMBER 
)
IS
BEGIN
    SELECT COUNT(*) INTO pcheck
    FROM emp
    WHERE empno=pid;
END;

DECLARE
    vcheck NUMBER(1);
BEGIN
    UP_IDCHECK(9999,vcheck);
    DBMS_OUTPUT.PUT_LINE(vcheck);
END;
----------------------
CREATE OR REPLACE PROCEDURE up_login
(
    pid IN emp.empno%TYPE
    , ppwd IN emp.ename%TYPE
    , pcheck OUT NUMBER -- 0 인증성공,  1 (ID존재 O, pwd X), -1(ID 존재 X)
)
IS
  vpwd emp.ename%TYPE;
BEGIN
  -- 9999 ID(empno) X pcheck=0, 
  --                O pcheck=1
  SELECT COUNT(*) INTO pcheck
  FROM emp
  WHERE empno = pid;
  
  IF pcheck = 1 THEN
     SELECT ename INTO vpwd
     FROM emp
     WHERE empno = pid;
     
     IF vpwd = ppwd THEN
        -- 로그인 성공
        pcheck := 0;
     ELSE
       -- 아이디 존재 O, 비밀번호 X
       pcheck := 1;
     END IF; 
  ELSE
     -- 아이디 존재 X
      pcheck := -1;
  END IF; 
--EXCEPTION
END;
-- Procedure UP_LOGIN이(가) 컴파일되었습니다.

DECLARE
  vcheck NUMBER(1);
BEGIN
  UP_LOGIN( 9999, 'SMITHHH', vcheck );
  DBMS_OUTPUT.PUT_LINE( vcheck );
END;
----------------------
CREATE OR REPLACE PROCEDURE up_selectdept
(
    pdeptcursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN pdeptcursor FOR
        SELECT *
        FROM tbl_dept
        WHERE deptno > 0;
--EXCEPTION
END;

-------------------------------------------
CREATE OR REPLACE PROCEDURE up_insertdept
(
   pdname tbl_dept.dname%TYPE := NULL
   , ploc tbl_dept.loc%TYPE := NULL
)
IS
   vdeptno tbl_dept.deptno%TYPE;
BEGIN 
  SELECT MAX(NVL(deptno,0)) + 10 INTO vdeptno
  FROM tbl_dept;
  
  INSERT INTO tbl_dept  
  VALUES ( vdeptno, pdname , ploc );
  
  COMMIT;
EXCEPTION
   WHEN OTHERS THEN
     ROLLBACK;
     raise_application_error(-20114,'> INSERT Others Error....');
END;    

SELECT *
FROM tbl_dept;
-----------------------------------------
CREATE OR REPLACE PROCEDURE up_deletedept
(
   pdeptno tbl_dept.deptno%TYPE
)
IS
BEGIN 
  DELETE FROM tbl_dept
  WHERE deptno=deptno;
  COMMIT;
EXCEPTION
   WHEN OTHERS THEN
     ROLLBACK;
     raise_application_error(-20115,'> DELETE Others Error....');
END;    
---------------------------------------------------------------
CREATE OR REPLACE PROCEDURE up_searchdept
(
    -- d 부서번호, n 부서명, l 지역명, nl 부서명+지역명
     psearchCondition VARCHAR2
   , psearchWord VARCHAR2
   , pcur OUT SYS_REFCURSOR
)
IS
   vsql VARCHAR2(2000);
BEGIN
  vsql := 'SELECT * ';
  vsql := vsql || ' FROM tbl_dept ';
  vsql := vsql || ' WHERE ';
 
  IF psearchCondition = 'd' THEN
    vsql := vsql || ' deptno = :psearchWord '  ;
  ELSIF psearchCondition = 'n' THEN
    vsql := vsql || ' REGEXP_LIKE( dname , :psearchWord, ''i'' ) ';
  ELSIF psearchCondition = 'l' THEN
    vsql := vsql || ' REGEXP_LIKE( loc , :psearchWord, ''i'' ) ';
  ELSIF psearchCondition = 'nl' THEN
    vsql := vsql || ' REGEXP_LIKE( dname , :psearchWord, ''i'' ) '  || ' OR REGEXP_LIKE( loc , :psearchWord, ''i'' ) ';
  END IF;
  
  vsql := vsql || ' ORDER BY deptno ASC ';
  
  -- vsql 동적 쿼리의 실행결과  1개 행,   여러 개의 행 
  -- X EXECUTE IMMEDIATE 동적쿼리  구문 X
  IF psearchCondition = 'nl' THEN
     OPEN pcur FOR vsql USING psearchWord , psearchWord;
  ELSE
     OPEN pcur FOR vsql USING psearchWord ;
  END IF;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, '> DEPT DATA NOT FOUND...');
  WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20004, '> SEARCH OTHER ERROR...');
END;
-- Procedure UP_SEARCHDEPT이(가) 컴파일되었습니다.
-------------------------------------------------------------
---------------------------------------------------------------
CREATE OR REPLACE PROCEDURE up_updatedept
(
    -- d 부서번호, n 부서명, l 지역명, nl 부서명+지역명
       pdeptno   tbl_dept.deptno%TYPE
     , pdname  tbl_dept.dname%TYPE := null
     , ploc    tbl_dept.loc%TYPE := null
)
IS 
BEGIN
   UPDATE tbl_dept
   SET dname = NVL( pdname, dname ), loc = NVL( ploc, loc )
   WHERE deptno = pdeptno;
   COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE_APPLICATION_ERROR(-20004, '> UPDATE OTHER ERROR...');
END;
-------------
SELECT *
FROM tabs
WHERE table_name LIKE '%BOARD%';

SELECT *
FROM user_sequences
WHERE table_name LIKE '%BOARD%';

SELECT *
FROM tbl_cstvsboard;

desc tbl_cstvsboard;

select seq,title,writer,email,writedate,readed
from tbl_cstvsboard
order by seq desc;
----------------------------------------------------------
INSERT INTO tbl_cstvsboard
(seq,writer,pwd,email,title,readed,tag,content)
VALUES (seq_tbl_cstvsboard.NEXTVAL,?,?,?,?,?,?);

select *
from tbl_cstvsboard;
























