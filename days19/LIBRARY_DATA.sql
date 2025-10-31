-- CODE_GROUP (�����ڵ�_�׷�)
INSERT INTO CODE_GROUP (groupId, groupName) VALUES (100, '����ڵ�');
INSERT INTO CODE_GROUP (groupId, groupName) VALUES (200, '������ڵ�');
INSERT INTO CODE_GROUP (groupId, groupName) VALUES (300, '���������ڵ�');
INSERT INTO CODE_GROUP (groupId, groupName) VALUES (400, '�ڷ��̿��ڵ�');

-- CODE_VALUE (�����ڵ�_�ڵ�)
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (101, 'KOR', '�ѱ���', NULL, 100);
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (102, 'ENG', '����', NULL, 100);
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (201, 'ANL', '����', NULL, 200);
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (202, 'QRT', '�б⺰', NULL, 200);
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (301, 'FST', '����', NULL, 300);
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (401, 'RFR', '��������', NULL, 400);
INSERT INTO CODE_VALUE (codeId, code, codeName, parentCodeId, groupId) VALUES (402, 'LNG', '���Ⱑ��', NULL, 400);

-- CATEGORY (ī�װ�)
INSERT INTO CATEGORY (categoryCode, categoryName) VALUES (100, 'ö��');
INSERT INTO CATEGORY (categoryCode, categoryName) VALUES (200, '��ȸ����');
INSERT INTO CATEGORY (categoryCode, categoryName) VALUES (300, '�������');

-- BOOK_STATUS (å����)
INSERT INTO BOOK_STATUS (statusId, statusName) VALUES (1, '������');
INSERT INTO BOOK_STATUS (statusId, statusName) VALUES (2, '��ü��');
INSERT INTO BOOK_STATUS (statusId, statusName) VALUES (3, '�ݳ��Ϸ�');

-- USER_INFO (�̿���)
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (1, '��ö��', 'pass123', 'cs.kim@mail.com', DATE '2023-01-10', '010-1234-5678', '����� ������', DATE '1990-05-15');
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (2, '�̿���', 'pass456', 'yh.lee@mail.com', DATE '2023-03-20', '010-9876-5432', '��⵵ ������', DATE '1995-11-22');
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (3, '�ڹ���', 'pass789', 'mj.park@mail.com', DATE '2023-05-01', '010-3333-4444', '��õ�� ������', DATE '1998-08-10');
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (4, '���켺', 'pass000', 'ws.jung@mail.com', DATE '2024-01-15', '010-5555-6666', '�λ�� �ؿ�뱸', DATE '1985-12-25');

-- EMPLOYEE (����)
INSERT INTO EMPLOYEE (employeeId, employeeName, employeeTel, employeeEmail, employeePosition, employeeDivision) VALUES (1, '������', '02-1111-2222', 'jm.park@lib.org', '�缭', '���������');
INSERT INTO EMPLOYEE (employeeId, employeeName, employeeTel, employeeEmail, employeePosition, employeeDivision) VALUES (2, '������', '02-3333-4444', 'hw.choi@lib.org', '����', '���������');

-- AUTHOR (����)
INSERT INTO AUTHOR (authorId, authorName, insi, nationalityCode, birthYear, deathYear, gender) VALUES (1, 'ȫ�浿', 'KOR12345', 'KOR', 1980, NULL, 'M');
INSERT INTO AUTHOR (authorId, authorName, insi, nationalityCode, birthYear, deathYear, gender) VALUES (2, 'Jane Doe', 'USA67890', 'USA', 1975, NULL, 'F');
INSERT INTO AUTHOR (authorId, authorName, insi, nationalityCode, birthYear, deathYear, gender) VALUES (3, '������', 'KOR33333', 'KOR', 1992, NULL, 'F');

-- PUBLISHER (����������)
INSERT INTO PUBLISHER (publisherId, name, countryCode, cityCode) VALUES (1, '���ĳ���', 'KOR', 'SEL');
INSERT INTO PUBLISHER (publisherId, name, countryCode, cityCode) VALUES (2, 'World Books', 'USA', 'NYC');

-- PARTICIPATING_LIBRARY (����������)
INSERT INTO PARTICIPATING_LIBRARY (libraryId, libraryName, region, contactNumber, email, managerName) VALUES (10, '�߾ӵ�����', '����', '02-5555-1111', 'main@lib.org', '����');

-- BOOK_INFO (��������)
INSERT INTO BOOK_INFO (bookInfoId, title, publisherName, publishingCountry, publishingYear, isbn, materialType, coverImagePath, libraryId, categoryCode) 
VALUES (1001, '�����ͺ��̽� ����', '���ĳ���', 'KOR', 2022, '9788912345678', '���ົ', '/images/book/1001.jpg', 10, 300);
INSERT INTO BOOK_INFO (bookInfoId, title, publisherName, publishingCountry, publishingYear, isbn, materialType, coverImagePath, libraryId, categoryCode) 
VALUES (1002, '�ູ�� ����', 'World Books', 'USA', 2021, '9780123456789', '���ົ', '/images/book/1002.jpg', 10, 100);
INSERT INTO BOOK_INFO (bookInfoId, title, publisherName, publishingCountry, publishingYear, isbn, materialType, coverImagePath, libraryId, categoryCode) 
VALUES (1003, '�ѱ� ��ȸ�� ����', '�̷�����', 'KOR', 2023, '9788954321098', '���ົ', '/images/book/1003.jpg', 10, 200);

-- BOOK_AUTHOR (����_����)
INSERT INTO BOOK_AUTHOR (bookAuthorId, roleCode, authorId, bookInfoId) VALUES (1, '����', 1, 1001);
INSERT INTO BOOK_AUTHOR (bookAuthorId, roleCode, authorId, bookInfoId) VALUES (2, '����', 2, 1002);
INSERT INTO BOOK_AUTHOR (bookAuthorId, roleCode, authorId, bookInfoId) VALUES (3, '����', 3, 1003);

-- MATERIAL (�����ڷ�)
INSERT INTO MATERIAL (materialId, title, subTitle, keyword, publishYear, url, stdCodeType, stdCodeValue, classSchemeCode, classSymbolValue, callNo, mainLangCode, summaryLangCode, frequencyCode, editionCode, usageCode, regDate, updateDate, summary, publisherId, bookInfoId)
VALUES (2001, '�����ͺ��̽� ����', 'DBMS ����', 'DB, SQL, ������', 2022, NULL, 'ISBN', '9788912345678', 'KDC', '004.6', 'KDC 004.6', 'KOR', 'KOR', 'ANL', 'FST', 'LNG', DATE '2023-05-10', NULL, '�����ͺ��̽��� �⺻ ������ �����Ѵ�.', 1, 1001);
INSERT INTO MATERIAL (materialId, title, subTitle, keyword, publishYear, url, stdCodeType, stdCodeValue, classSchemeCode, classSymbolValue, callNo, mainLangCode, summaryLangCode, frequencyCode, editionCode, usageCode, regDate, updateDate, summary, publisherId, bookInfoId)
VALUES (2002, '�ູ�� ����', '������ �ູ ã��', '�ູ, �ɸ�, ö��', 2021, NULL, 'ISBN', '9780123456789', 'KDC', '199.1', 'KDC 199.1', 'ENG', 'KOR', 'ANL', 'FST', 'RFR', DATE '2023-05-15', NULL, '�ູ�� ���� �پ��� ö���� ����.', 2, 1002);

-- OWNED_BOOK (���嵵��)
INSERT INTO OWNED_BOOK (ownedBookId, registrationDate, modifiedDate, isDeleted, bookInfoId) VALUES (3001, DATE '2023-05-01', NULL, 'N', 1001);
INSERT INTO OWNED_BOOK (ownedBookId, registrationDate, modifiedDate, isDeleted, bookInfoId) VALUES (3002, DATE '2023-05-01', NULL, 'N', 1002);
INSERT INTO OWNED_BOOK (ownedBookId, registrationDate, modifiedDate, isDeleted, bookInfoId) VALUES (3003, DATE '2023-06-10', NULL, 'N', 1003);

-- LOAN_INFO (��������)
INSERT INTO LOAN_INFO (loanRecordId, loanDate, returnDate, ownedBookId, statusId, userId) VALUES (4001, DATE '2023-10-01', DATE '2023-10-15', 3001, 1, 1);
INSERT INTO LOAN_INFO (loanRecordId, loanDate, returnDate, ownedBookId, statusId, userId) VALUES (4002, DATE '2023-09-20', DATE '2023-10-05', 3002, 3, 2);
INSERT INTO LOAN_INFO (loanRecordId, loanDate, returnDate, ownedBookId, statusId, userId) VALUES (4003, DATE '2023-10-10', DATE '2023-10-24', 3003, 2, 3);

-- AMENITY (���ǽü�)
INSERT INTO AMENITY (amenityId, amenityName, amenityLocation) VALUES (1, '��ī��', '1�� �κ�');
INSERT INTO AMENITY (amenityId, amenityName, amenityLocation) VALUES (2, '�������ͳ�', '����');

-- OPERATING_HOUR (�̿�ð�)
-- Oracle�� TIMESTAMP�� ����ϸ�, �ð��� ���� �ۼ��մϴ�.
INSERT INTO OPERATING_HOUR (hourId, holidayInfo, openTime, closeTime, contactNumber, isClosed, amenityId) 
VALUES (901, '���� �Ͽ���', TIMESTAMP '2025-10-30 09:00:00', TIMESTAMP '2025-10-30 18:00:00', '02-5555-1111', 'N', 1);

-- WIFI (�������ͳ�)
-- wifiUsageGuide�� CLOB Ÿ���Դϴ�.
INSERT INTO WIFI (wifiId, wifiServiceArea, wifiUsageGuide, wifiPhoneNumber, wifiRegDate, amenityId) 
VALUES (1001, '������, �κ�', '��й�ȣ ���� ��� �����մϴ�.', '02-5555-9999', DATE '2023-01-01', 2);

-- MEAL_TYPE (�Ļ�����)
INSERT INTO MEAL_TYPE (mealTypeId, mealTypeName) VALUES (1, '����');
INSERT INTO MEAL_TYPE (mealTypeId, mealTypeName) VALUES (2, '����');

-- MEAL_PLAN (�Ĵ�)
-- menuContent�� CLOB Ÿ���Դϴ�.
INSERT INTO MEAL_PLAN (mealPlanId, menuDate, menuContent, sRegDate, hourId) 
VALUES (1101, DATE '2023-10-31', '��������, �̿���, �ҹ�, ��ġ', DATE '2023-10-25', 901);

-- MEAL_ASSIGNMENT (�޴�)
INSERT INTO MEAL_ASSIGNMENT (menuId, mealPlanId, mealTypeId) VALUES (1201, 1101, 1);

-- POST_TYPE (�Խù� ����)
INSERT INTO POST_TYPE (postTypeCode, postTypeName) VALUES (10, '��������');
INSERT INTO POST_TYPE (postTypeCode, postTypeName) VALUES (20, '�ڷ��');

-- ATTACHMENT (÷������)
INSERT INTO ATTACHMENT (postAttachmentId, postAttachmentPath, postAttachmentName, postAttachmentType) 
VALUES (501, '/files/notice/501.pdf', '10�� ��ð� ���� �ȳ�', 'PDF');

-- POST (�Խù�)
-- postContent�� CLOB Ÿ���Դϴ�.
INSERT INTO POST (postId, postThumbnailUrl, postTitle, postContent, postCreateDate, postViewCount, postApplicationPeriod, postSchedule, postLocation, postTypeCode, postAttachmentId, employeeId) 
VALUES (601, NULL, '������ 10�� �ӽ� �ް� �ȳ�', '�� ����: 10�� 31�� �ü� �������� �ӽ� �ް��մϴ�.', DATE '2023-09-25', 150, NULL, NULL, NULL, 10, 501, 1);

-- EVENT_TYPE (�������)
INSERT INTO EVENT_TYPE (eventTypeId, eventOnOff) VALUES (1, '��������');
INSERT INTO EVENT_TYPE (eventTypeId, eventOnOff) VALUES (2, '�¶���');

-- DETAILED_CLASSIFICATION (�󼼺з�)
INSERT INTO DETAILED_CLASSIFICATION (detailedClassificationId, eventClassification) VALUES (1, '�������α׷�');
INSERT INTO DETAILED_CLASSIFICATION (detailedClassificationId, eventClassification) VALUES (2, '��ȭ���');

-- EVENT (���)
-- lectureContent�� CLOB Ÿ���Դϴ�.
INSERT INTO EVENT (eventId, eventName, eventStart, eventEnd, eventLocation, maxCapacity, applicationStart, applicationEnd, lectureContent, runningTime, admissionFee, eventCondition, mainImage, applicationType, eventTypeId, detailedClassificationId, employeeId) 
VALUES (701, '�ڵ� ���� ����', DATE '2023-11-01', DATE '2023-11-30', '��2���ǽ�', 30, DATE '2023-10-15', DATE '2023-10-25', '���̽� ���� ���� ����', 120, 0, '�����Ϸ�', '/images/event/701.jpg', '�¶�������', 1, 1, 2);

-- EVENT_APPLICATION_RECORD (����û���)
INSERT INTO EVENT_APPLICATION_RECORD (eventApplicationId, applicationDate, approvalStatus, participantCount, applicationMethod, isCancelled, isAttended, eventId, userId) 
VALUES (801, DATE '2023-10-20', '����', 1, '�¶���', 'N', 'Y', 701, 1);

-- TOUR_TYPE (��������)
INSERT INTO TOUR_TYPE (tourTypeId, tourName, tourOrder, routeName, routeDesc, minParticipant, maxParticipant) 
VALUES (1, '�Ϲ� ������ ����', 1, '�κ�-������-����', '������ �ֿ� �ü��� �ѷ����� �ڽ�', 5, 20);
INSERT INTO TOUR_TYPE (tourTypeId, tourName, tourOrder, routeName, routeDesc, minParticipant, maxParticipant) 
VALUES (2, '��� ������ ü��', 1, '��� �ڷ��', '���̵��� ���� ���� �� ü�� ���α׷�', 10, 30);

-- TOUR_APPLICATION (���н�û)
INSERT INTO TOUR_APPLICATION (tourId, participantCount, reservationDate, tourStatus, tourTypeId, userId) 
VALUES (5001, 15, DATE '2023-11-10', '����Ϸ�', 1, 1);
INSERT INTO TOUR_APPLICATION (tourId, participantCount, reservationDate, tourStatus, tourTypeId, userId) 
VALUES (5002, 25, DATE '2023-11-15', '����Ϸ�', 2, 2);

-- TOUR_STATISTIC (�̿��ڰ������)
INSERT INTO TOUR_STATISTIC (tourStatId, tourId, userId) VALUES (50001, 5001, 1);
INSERT INTO TOUR_STATISTIC (tourStatId, tourId, userId) VALUES (50002, 5002, 2);

-- KEYWORDS (������)
INSERT INTO KEYWORDS (keywordId, inputKeyword, integratedKeyword, relatedTerm, relatedEng, relatedCode, searchButton) 
VALUES (1, '�����ͺ��̽�', '��������', 'DBMS', 'Database Management System', 'INFO101', 'Y');
INSERT INTO KEYWORDS (keywordId, inputKeyword, integratedKeyword, relatedTerm, relatedEng, relatedCode, searchButton) 
VALUES (2, 'ö��', '�ι���', '���', 'Philosophy', 'HUMA202', 'Y');
INSERT INTO KEYWORDS (keywordId, inputKeyword, integratedKeyword, relatedTerm, relatedEng, relatedCode, searchButton) 
VALUES (3, '���α׷���', '��ǻ�� ���', '�ڵ�', 'Programming', 'INFO102', 'N');

-- MATERIAL_KEYWORDS (�ڷ�_������)
INSERT INTO MATERIAL_KEYWORDS (dataKeywordId, materialId, keywordId) VALUES (101, 2001, 1);
INSERT INTO MATERIAL_KEYWORDS (dataKeywordId, materialId, keywordId) VALUES (102, 2001, 3);
INSERT INTO MATERIAL_KEYWORDS (dataKeywordId, materialId, keywordId) VALUES (103, 2002, 2);

-- SEARCH_SESSION (�˻�����)
INSERT INTO SEARCH_SESSION (searchId, searchType, searchDate, userId) 
VALUES (6001, '���հ˻�', SYSDATE - 1, 1); -- ���� ��¥
INSERT INTO SEARCH_SESSION (searchId, searchType, searchDate, userId) 
VALUES (6002, '�󼼰˻�', SYSDATE, 2); -- ���� ��¥

-- SEARCH_CONDITION (�˻�����)
INSERT INTO SEARCH_CONDITION (conditionId, searchField, operator, searchWord, createAt, searchId) 
VALUES (7001, 'title', 'LIKE', '�����ͺ��̽�', SYSDATE - 1, 6001);
INSERT INTO SEARCH_CONDITION (conditionId, searchField, operator, searchWord, createAt, searchId) 
VALUES (7002, 'author', '=', 'Jane Doe', SYSDATE, 6002);

-- QNA
INSERT INTO QA (qaId, questionContent, answerContent, isAnswered, questionDate, userId) 
VALUES (1, '������ �������� ��й�ȣ�� �����ΰ���?', '�������̴� ��й�ȣ ���� ��� �����մϴ�.', 'Y', DATE '2023-10-20', 1);
INSERT INTO QA (qaId, questionContent, answerContent, isAnswered, questionDate, userId) 
VALUES (2, '������ å�� �����ϰ� �;��.', '�������������� ���� ��û�� �����մϴ�.', 'Y', DATE '2023-10-25', 2);
INSERT INTO QA (qaId, questionContent, answerContent, isAnswered, questionDate, userId) 
VALUES (3, '���� ��û�� ��� �ϳ���?', NULL, 'N', DATE '2023-10-28', 3); -- �̴亯 ����

-- RECOMMEND BOOK
INSERT INTO RECOMMENDED_BOOK (recommendedBookId, recommendationReason, recommendationDate, isAnonymous, ownedBookId, userId) 
VALUES (1, '�ֽ� ��ȸ Ʈ���带 �����ϴ� �� �ʼ����Դϴ�.', DATE '2024-02-01', 'N', 3003, 4);

-- INTERLIBRARY_LOAN (��ȣ����)
INSERT INTO INTERLIBRARY_LOAN (interlibraryLoanId, operatingOrganizationName, operatingDepartment) 
VALUES (1, '���� ������ ����ȸ', '��ȣ���� ���');

-- INTERLIBRARY_LOAN_REQUEST (��ȣ������û)
INSERT INTO INTERLIBRARY_LOAN_REQUEST (requestId, requestDate, requestStatus, userId, interlibraryLoanId, bookInfoId) 
VALUES (101, DATE '2024-03-01', '�����Ϸ�', 1, 1, 1003);

-- INTERLIBRARY_LOAN_STATUS (��ȣ������û�����̷�)
INSERT INTO INTERLIBRARY_LOAN_STATUS (loanStatusId, changeDate, previousStatus, newStatus, requestId) 
VALUES (10001, DATE '2024-03-01', '��û', '�����Ϸ�', 101);
INSERT INTO INTERLIBRARY_LOAN_STATUS (loanStatusId, changeDate, previousStatus, newStatus, requestId) 
VALUES (10002, DATE '2024-03-02', '�����Ϸ�', 'ó����', 101);

-- COLLECTION_TYPE (�÷�������)
INSERT INTO COLLECTION_TYPE (collectionTypeId, collectionTypeName) VALUES (1, '�̴��� �Ű�');
INSERT INTO COLLECTION_TYPE (collectionTypeId, collectionTypeName) VALUES (2, '�缭 ��õ');

-- COLLECTION (�÷���)
INSERT INTO COLLECTION (collectionId, collectionTypeId) VALUES (201, 1); -- �̴��� �Ű� �÷���
INSERT INTO COLLECTION (collectionId, collectionTypeId) VALUES (202, 2); -- �缭 ��õ �÷���

-- COLLECTION_BOOK (�÷���_����)
-- 3001: �����ͺ��̽� ����, 3002: �ູ�� ����, 3003: �ѱ� ��ȸ�� ����
INSERT INTO COLLECTION_BOOK (collectionBookId, collectionId, ownedBookId) VALUES (10001, 201, 3001); -- �Ű��� ����
INSERT INTO COLLECTION_BOOK (collectionBookId, collectionId, ownedBookId) VALUES (10002, 202, 3002); -- �缭 ��õ�� ����
INSERT INTO COLLECTION_BOOK (collectionBookId, collectionId, ownedBookId) VALUES (10003, 202, 3003); -- �缭 ��õ�� ����