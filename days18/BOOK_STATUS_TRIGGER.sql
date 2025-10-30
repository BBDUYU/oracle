----------------------------------------------------å���º��� Ʈ����
CREATE OR REPLACE TRIGGER trg_update_loan_status
BEFORE INSERT OR UPDATE ON LOAN_INFO
FOR EACH ROW
DECLARE
    v_statusId NUMBER;
BEGIN
    -- ��ü�� �Ǵ�: �ݳ����� ����, ������ + 14���� ���ú��� ����
    IF :NEW.returnDate IS NULL AND :NEW.loanDate + 14 < TRUNC(SYSDATE) THEN
        SELECT statusId INTO v_statusId FROM BOOK_STATUS WHERE statusName = '��ü��';
    
    -- �ݳ���
    ELSIF :NEW.returnDate IS NOT NULL THEN
        SELECT statusId INTO v_statusId FROM BOOK_STATUS WHERE statusName = '�ݳ��Ϸ�';
    
    -- ������
    ELSE
        SELECT statusId INTO v_statusId FROM BOOK_STATUS WHERE statusName = '������';
    END IF;

    :NEW.statusId := v_statusId;
END;

-- 4001��: ���� �ݳ� �� �� (������)
UPDATE LOAN_INFO
SET loanDate = TO_DATE('25/10/30', 'YY/MM/DD'),
    returnDate = NULL
WHERE loanRecordId = 4001;

-- 4002��: �ֱ� �ݳ� (25/10/25)
UPDATE LOAN_INFO
SET returnDate = TO_DATE('25/10/25', 'YY/MM/DD')
WHERE loanRecordId = 4002;

-- 4003��: ��ü������ ����� (������ 25/10/10, ���� �̹ݳ�)
UPDATE LOAN_INFO
SET loanDate = TO_DATE('25/10/10', 'YY/MM/DD'),
    returnDate = NULL
WHERE loanRecordId = 4003;


SELECT
    L.loanRecordId     AS ������ID,
    TO_CHAR(L.loanDate, 'YYYY/MM/DD')  ����,
    TO_CHAR(L.returnDate, 'YYYY/MM/DD') �ݳ���,
    L.ownedBookId      AS ���嵵��ID,
    B.statusName       AS ����,
    L.userId           AS �̿���ID
FROM
    LOAN_INFO L
    JOIN BOOK_STATUS B ON L.statusId = B.statusId
ORDER BY
    L.loanRecordId;





