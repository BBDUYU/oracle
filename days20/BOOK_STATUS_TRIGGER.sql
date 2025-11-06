----------------------------------------------------책상태변경 트리거
CREATE OR REPLACE TRIGGER trg_update_loan_status
BEFORE INSERT OR UPDATE ON LOAN_INFO
FOR EACH ROW
DECLARE
    v_statusId NUMBER;
BEGIN
    -- 연체중 판단: 반납일이 없고, 대출일 + 14일이 오늘보다 이전
    IF :NEW.returnDate IS NULL AND :NEW.loanDate + 14 < TRUNC(SYSDATE) THEN
        SELECT statusId INTO v_statusId FROM BOOK_STATUS WHERE statusName = '연체중';
    
    -- 반납됨
    ELSIF :NEW.returnDate IS NOT NULL THEN
        SELECT statusId INTO v_statusId FROM BOOK_STATUS WHERE statusName = '반납완료';
    
    -- 대출중
    ELSE
        SELECT statusId INTO v_statusId FROM BOOK_STATUS WHERE statusName = '대출중';
    END IF;

    :NEW.statusId := v_statusId;
END;

-- 4001번: 아직 반납 안 함 (대출중)
UPDATE LOAN_INFO
SET loanDate = TO_DATE('25/10/30', 'YY/MM/DD'),
    returnDate = NULL
WHERE loanRecordId = 4001;

-- 4002번: 최근 반납 (25/10/25)
UPDATE LOAN_INFO
SET returnDate = TO_DATE('25/10/25', 'YY/MM/DD')
WHERE loanRecordId = 4002;

-- 4003번: 연체중으로 만들기 (대출은 25/10/10, 아직 미반납)
UPDATE LOAN_INFO
SET loanDate = TO_DATE('25/10/10', 'YY/MM/DD'),
    returnDate = NULL
WHERE loanRecordId = 4003;


SELECT
    L.loanRecordId     AS 대출기록ID,
    TO_CHAR(L.loanDate, 'YYYY/MM/DD')  대출,
    TO_CHAR(L.returnDate, 'YYYY/MM/DD') 반납일,
    L.ownedBookId      AS 소장도서ID,
    B.statusName       AS 상태,
    L.userId           AS 이용자ID
FROM
    LOAN_INFO L
    JOIN BOOK_STATUS B ON L.statusId = B.statusId
ORDER BY
    L.loanRecordId;

--------------------------------------------------------------
--트리거 문제점 해결
CREATE OR REPLACE VIEW VW_LOAN_STATUS AS
SELECT
    L.loanRecordId           AS 대출기록ID,
    TO_CHAR(L.loanDate, 'YYYY/MM/DD')  AS 대출일,
    TO_CHAR(L.returnDate, 'YYYY/MM/DD') AS 반납일,
    L.ownedBookId            AS 소장도서ID,
    L.userId                 AS 이용자ID,
    CASE
        WHEN L.returnDate IS NOT NULL THEN '반납완료'
        WHEN L.loanDate + 14 < TRUNC(SYSDATE) THEN '연체중'
        ELSE '대출중'
    END AS 상태
FROM
    LOAN_INFO L;

SELECT * FROM VW_LOAN_STATUS ORDER BY 대출기록ID;



