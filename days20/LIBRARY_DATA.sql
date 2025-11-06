-- CODE_GROUP (공통코드_그룹)
INSERT INTO CODE_GROUP (groupId, groupCode, groupName) VALUES (100, 'LANG', '언어코드');
INSERT INTO CODE_GROUP (groupId, groupCode, groupName) VALUES (200, 'FREQ', '간행빈도코드');
INSERT INTO CODE_GROUP (groupId, groupCode, groupName) VALUES (300, 'EDTYPE', '판종유형코드');
INSERT INTO CODE_GROUP (groupId, groupCode, groupName) VALUES (400, 'USAGE', '자료이용코드');

-- CODE_VALUE (공통코드_코드)
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (101, 'KOR', '한국어', NULL, 100);
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (102, 'ENG', '영어', NULL, 100);
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (201, 'ANL', '연간', NULL, 200);
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (202, 'QRT', '분기별', NULL, 200);
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (301, 'FST', '초판', NULL, 300);
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (401, 'RFR', '열람전용', NULL, 400);
INSERT INTO CODE_VALUE (valueId, valueCode, valueName, parentValueId, groupId) VALUES (402, 'LNG', '대출가능', NULL, 400);

-- CATEGORY (카테고리)
INSERT INTO CATEGORY (categoryCode, categoryName) VALUES (100, '철학');
INSERT INTO CATEGORY (categoryCode, categoryName) VALUES (200, '사회과학');
INSERT INTO CATEGORY (categoryCode, categoryName) VALUES (300, '기술과학');

-- BOOK_STATUS (책상태)
INSERT INTO BOOK_STATUS (statusId, statusName) VALUES (1, '대출중');
INSERT INTO BOOK_STATUS (statusId, statusName) VALUES (2, '연체중');
INSERT INTO BOOK_STATUS (statusId, statusName) VALUES (3, '반납완료');

-- USER_INFO (이용자)
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (1, '김철수', 'pass123', 'cs.kim@mail.com', DATE '2023-01-10', '010-1234-5678', '서울시 강남구', DATE '1990-05-15');
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (2, '이영희', 'pass456', 'yh.lee@mail.com', DATE '2023-03-20', '010-9876-5432', '경기도 수원시', DATE '1995-11-22');
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (3, '박민지', 'pass789', 'mj.park@mail.com', DATE '2023-05-01', '010-3333-4444', '인천시 연수구', DATE '1998-08-10');
INSERT INTO USER_INFO (userId, name, password, email, joinDate, contactNumber, address, birthDate) VALUES (4, '정우성', 'pass000', 'ws.jung@mail.com', DATE '2024-01-15', '010-5555-6666', '부산시 해운대구', DATE '1985-12-25');

-- EMPLOYEE (직원)
INSERT INTO EMPLOYEE (employeeId, employeeName, employeeTel, employeeEmail, employeePosition, employeeDivision) VALUES (1, '박지민', '02-1111-2222', 'jm.park@lib.org', '사서', '열람봉사과');
INSERT INTO EMPLOYEE (employeeId, employeeName, employeeTel, employeeEmail, employeePosition, employeeDivision) VALUES (2, '최현우', '02-3333-4444', 'hw.choi@lib.org', '팀장', '정보봉사과');

-- AUTHOR (저자)
INSERT INTO AUTHOR (authorId, authorName, insi, nationalityCode, birthYear, deathYear, gender) VALUES (1, '홍길동', 'KOR12345', 'KOR', 1980, NULL, 'M');
INSERT INTO AUTHOR (authorId, authorName, insi, nationalityCode, birthYear, deathYear, gender) VALUES (2, 'Jane Doe', 'USA67890', 'USA', 1975, NULL, 'F');
INSERT INTO AUTHOR (authorId, authorName, insi, nationalityCode, birthYear, deathYear, gender) VALUES (3, '김지영', 'KOR33333', 'KOR', 1992, NULL, 'F');

-- PUBLISHER (발행자정보)
INSERT INTO PUBLISHER (publisherId, name, countryCode, cityCode) VALUES (1, '지식나눔', 'KOR', 'SEL');
INSERT INTO PUBLISHER (publisherId, name, countryCode, cityCode) VALUES (2, 'World Books', 'USA', 'NYC');

-- PARTICIPATING_LIBRARY (참여도서관)
INSERT INTO PARTICIPATING_LIBRARY (libraryId, libraryName, region, contactNumber, email, managerName) VALUES (10, '중앙도서관', '서울', '02-5555-1111', 'main@lib.org', '김담당');

-- BOOK_INFO (도서정보)
INSERT INTO BOOK_INFO (bookInfoId, title, publisherName, publishingCountry, publishingYear, isbn, materialType, coverImagePath, libraryId, categoryCode) 
VALUES (1001, '데이터베이스 개론', '지식나눔', 'KOR', 2022, '9788912345678', '단행본', '/images/book/1001.jpg', 10, 300);
INSERT INTO BOOK_INFO (bookInfoId, title, publisherName, publishingCountry, publishingYear, isbn, materialType, coverImagePath, libraryId, categoryCode) 
VALUES (1002, '행복의 조건', 'World Books', 'USA', 2021, '9780123456789', '단행본', '/images/book/1002.jpg', 10, 100);
INSERT INTO BOOK_INFO (bookInfoId, title, publisherName, publishingCountry, publishingYear, isbn, materialType, coverImagePath, libraryId, categoryCode) 
VALUES (1003, '한국 사회의 이해', '미래출판', 'KOR', 2023, '9788954321098', '단행본', '/images/book/1003.jpg', 10, 200);

-- BOOK_AUTHOR (도서_저자)
INSERT INTO BOOK_AUTHOR (bookAuthorId, roleCode, authorId, bookInfoId) VALUES (1, '저자', 1, 1001);
INSERT INTO BOOK_AUTHOR (bookAuthorId, roleCode, authorId, bookInfoId) VALUES (2, '저자', 2, 1002);
INSERT INTO BOOK_AUTHOR (bookAuthorId, roleCode, authorId, bookInfoId) VALUES (3, '저자', 3, 1003);

-- MATERIAL (소장자료)
INSERT INTO MATERIAL (materialId, title, subTitle, keyword, publishYear, url, stdCodeType, stdCodeValue, classSchemeCode, classSymbolValue, callNo, mainLangCode, summaryLangCode, frequencyCode, editionCode, usageCode, regDate, updateDate, summary, publisherId, bookInfoId)
VALUES (2001, '데이터베이스 개론', 'DBMS 기초', 'DB, SQL, 데이터', 2022, NULL, 'ISBN', '9788912345678', 'KDC', '004.6', 'KDC 004.6', 'KOR', 'KOR', 'ANL', 'FST', 'LNG', DATE '2023-05-10', NULL, '데이터베이스의 기본 원리를 설명한다.', 1, 1001);
INSERT INTO MATERIAL (materialId, title, subTitle, keyword, publishYear, url, stdCodeType, stdCodeValue, classSchemeCode, classSymbolValue, callNo, mainLangCode, summaryLangCode, frequencyCode, editionCode, usageCode, regDate, updateDate, summary, publisherId, bookInfoId)
VALUES (2002, '행복의 조건', '진정한 행복 찾기', '행복, 심리, 철학', 2021, NULL, 'ISBN', '9780123456789', 'KDC', '199.1', 'KDC 199.1', 'ENG', 'KOR', 'ANL', 'FST', 'RFR', DATE '2023-05-15', NULL, '행복에 대한 다양한 철학적 고찰.', 2, 1002);

-- OWNED_BOOK (소장도서)
INSERT INTO OWNED_BOOK (ownedBookId, registrationDate, modifiedDate, isDeleted, bookInfoId) VALUES (3001, DATE '2023-05-01', NULL, 'N', 1001);
INSERT INTO OWNED_BOOK (ownedBookId, registrationDate, modifiedDate, isDeleted, bookInfoId) VALUES (3002, DATE '2023-05-01', NULL, 'N', 1002);
INSERT INTO OWNED_BOOK (ownedBookId, registrationDate, modifiedDate, isDeleted, bookInfoId) VALUES (3003, DATE '2023-06-10', NULL, 'N', 1003);

-- LOAN_INFO (대출정보)
INSERT INTO LOAN_INFO (loanRecordId, loanDate, returnDate, ownedBookId, statusId, userId) VALUES (4001, DATE '2023-10-01', DATE '2023-10-15', 3001, 1, 1);
INSERT INTO LOAN_INFO (loanRecordId, loanDate, returnDate, ownedBookId, statusId, userId) VALUES (4002, DATE '2023-09-20', DATE '2023-10-05', 3002, 3, 2);
INSERT INTO LOAN_INFO (loanRecordId, loanDate, returnDate, ownedBookId, statusId, userId) VALUES (4003, DATE '2023-10-10', DATE '2023-10-24', 3003, 2, 3);

-- AMENITY (편의시설)
INSERT INTO AMENITY (amenityId, amenityName, amenityLocation) 
VALUES (1, '북카페', '1층');
INSERT INTO AMENITY (amenityId, amenityName, amenityLocation) 
VALUES (2, '편의점', '1층');
INSERT INTO AMENITY (amenityId, amenityName, amenityLocation) 
VALUES (3, '북한자료센터', '본관 2층');
INSERT INTO AMENITY (amenityId, amenityName, amenityLocation) 
VALUES (4, '디지털도서관', '디지털관');

-- OPERATING_HOUR (이용시간)
-- Oracle의 TIMESTAMP를 사용하며, 시간에 맞춰 작성합니다.
INSERT INTO OPERATING_HOUR (hourId, holidayInfo, openTime, closeTime, contactNumber, isClosed, amenityId) 
VALUES (901, '매주 일요일', TIMESTAMP '2025-10-30 09:00:00', TIMESTAMP '2025-10-30 18:00:00', '02-5555-1111', 'N', 1);
INSERT INTO OPERATING_HOUR (hourId, holidayInfo, openTime, closeTime, amenityId) 
VALUES (902, '국가공휴일, 대체휴무일', TIMESTAMP '1970-01-01 08:00:00'
       , TIMESTAMP '1970-01-01 18:00:00', 1);

INSERT INTO OPERATING_HOUR (hourId, holidayInfo, openTime, closeTime, amenityId) 
VALUES (903, '일요일을 제외한 관공서 공휴일', TIMESTAMP '1970-01-01 08:00:00'
       , TIMESTAMP '1970-01-01 19:00:00', 2);

INSERT INTO OPERATING_HOUR (hourId, holidayInfo, openTime, closeTime, amenityId) 
VALUES (904, '매월 둘째·넷째 월요일', TIMESTAMP '1970-01-01 09:00:00'
       , TIMESTAMP '1970-01-01 18:00:00', 3);

-- WIFI (무선인터넷)
-- wifiUsageGuide는 CLOB 타입입니다.
INSERT INTO WIFI (wifiId, wifiServiceArea, wifiUsageGuide, wifiPhoneNumber, wifiRegDate, amenityId) 
VALUES (1001, '열람실, 로비', '비밀번호 없이 사용 가능합니다.', '02-5555-9999', DATE '2023-01-01', 2);

-- MEAL_TYPE (식사종류)
INSERT INTO MEAL_TYPE (mealTypeId, mealTypeName) VALUES (1, '점심');
INSERT INTO MEAL_TYPE (mealTypeId, mealTypeName) VALUES (2, '저녁');

-- MEAL_PLAN (식단)
-- menuContent는 CLOB 타입입니다.
INSERT INTO MEAL_PLAN (mealPlanId, menuDate, menuContent, sRegDate, hourId) 
VALUES (1101, DATE '2023-10-31', '제육볶음, 미역국, 쌀밥, 김치', DATE '2023-10-25', 901);

-- MEAL_ASSIGNMENT (메뉴)
INSERT INTO MEAL_ASSIGNMENT (menuId, mealPlanId, mealTypeId) VALUES (1201, 1101, 1);

-- POST_TYPE (게시물 종류)
INSERT INTO POST_TYPE (postTypeCode, postTypeName) VALUES (10, '공지사항');
INSERT INTO POST_TYPE (postTypeCode, postTypeName) VALUES (20, '자료실');

-- ATTACHMENT (첨부파일)
INSERT INTO ATTACHMENT (postAttachmentId, postAttachmentPath, postAttachmentName, postAttachmentType) 
VALUES (501, '/files/notice/501.pdf', '10월 운영시간 변경 안내', 'PDF');

-- POST (게시물)
-- postContent는 CLOB 타입입니다.
INSERT INTO POST (postId, postThumbnailUrl, postTitle, postContent, postCreateDate, postViewCount, postApplicationPeriod, postSchedule, postLocation, postTypeCode, postAttachmentId, employeeId) 
VALUES (601, NULL, '도서관 10월 임시 휴관 안내', '상세 내용: 10월 31일 시설 점검으로 임시 휴관합니다.', DATE '2023-09-25', 150, NULL, NULL, NULL, 10, 501, 1);

-- EVENT_TYPE (행사유형)
INSERT INTO EVENT_TYPE (eventTypeId, eventOnOff) VALUES (1, '오프라인');
INSERT INTO EVENT_TYPE (eventTypeId, eventOnOff) VALUES (2, '온라인');

-- DETAILED_CLASSIFICATION (상세분류)
INSERT INTO DETAILED_CLASSIFICATION (detailedClassificationId, eventClassification) VALUES (1, '교육프로그램');
INSERT INTO DETAILED_CLASSIFICATION (detailedClassificationId, eventClassification) VALUES (2, '문화행사');
INSERT INTO DETAILED_CLASSIFICATION (DETAILEDCLASSIFICATIONID, EVENTCLASSIFICATION) VALUES (3, '드라마');
-- EVENT (행사)
INSERT INTO EVENT (eventId, eventName, eventStart, eventEnd, eventLocation, maxCapacity, applicationStart, applicationEnd, lectureContent, runningTime, admissionFee, eventCondition, mainImage, applicationType, eventTypeId, detailedClassificationId, employeeId) 
VALUES (701, '코딩 기초 강좌', DATE '2023-11-01', DATE '2023-11-30', '제2강의실', 30, DATE '2023-10-15', DATE '2023-10-25', '파이썬 기초 문법 교육', 120, 0, '모집완료', '/images/event/701.jpg', '온라인접수', 1, 1, 2);
INSERT INTO EVENT (EVENTID, EVENTNAME, EVENTSTART, EVENTEND, EVENTLOCATION,MAXCAPACITY, APPLICATIONSTART, APPLICATIONEND, EVENTCONDITION,EVENTTYPEID, DETAILEDCLASSIFICATIONID, EMPLOYEEID) 
VALUES (9200, '트리거 테스트', SYSDATE, SYSDATE+1, '도서관 A실',2, SYSDATE-1, SYSDATE+2, '신청가능',1, 3, 2);

-- EVENT_APPLICATION_RECORD (행사신청기록)
INSERT INTO EVENT_APPLICATION_RECORD (eventApplicationId, applicationDate, approvalStatus, participantCount, applicationMethod, isCancelled, isAttended, eventId, userId) 
VALUES (801, DATE '2023-10-20', '승인', 1, '온라인', 'N', 'Y', 701, 1);

-- TOUR_TYPE (견학유형)
INSERT INTO TOUR_TYPE (tourTypeId, tourName, tourOrder, routeName, routeDesc, minParticipant, maxParticipant) 
VALUES (1, '일반 도서관 견학', 1, '로비-열람실-서고', '도서관 주요 시설을 둘러보는 코스', 5, 20);
INSERT INTO TOUR_TYPE (tourTypeId, tourName, tourOrder, routeName, routeDesc, minParticipant, maxParticipant) 
VALUES (2, '어린이 도서관 체험', 1, '어린이 자료실', '아이들을 위한 독서 및 체험 프로그램', 10, 30);

-- TOUR_APPLICATION (견학신청)
INSERT INTO TOUR_APPLICATION (tourId, participantCount, reservationDate, tourStatus, tourTypeId, userId) 
VALUES (5001, 15, DATE '2023-11-10', '예약완료', 1, 1);
INSERT INTO TOUR_APPLICATION (tourId, participantCount, reservationDate, tourStatus, tourTypeId, userId) 
VALUES (5002, 25, DATE '2023-11-15', '예약완료', 2, 2);

-- TOUR_STATISTIC (이용자견학통계)
INSERT INTO TOUR_STATISTIC (tourStatId, tourId, userId) VALUES (50001, 5001, 1);
INSERT INTO TOUR_STATISTIC (tourStatId, tourId, userId) VALUES (50002, 5002, 2);

-- KEYWORDS (주제어)
INSERT INTO KEYWORDS (keywordId, inputKeyword, integratedKeyword, relatedTerm, relatedEng, relatedCode, searchButton) 
VALUES (1, '데이터베이스', '정보과학', 'DBMS', 'Database Management System', 'INFO101', 'Y');
INSERT INTO KEYWORDS (keywordId, inputKeyword, integratedKeyword, relatedTerm, relatedEng, relatedCode, searchButton) 
VALUES (2, '철학', '인문학', '사상', 'Philosophy', 'HUMA202', 'Y');
INSERT INTO KEYWORDS (keywordId, inputKeyword, integratedKeyword, relatedTerm, relatedEng, relatedCode, searchButton) 
VALUES (3, '프로그래밍', '컴퓨터 언어', '코딩', 'Programming', 'INFO102', 'N');

-- MATERIAL_KEYWORDS (자료_주제어)
INSERT INTO MATERIAL_KEYWORDS (dataKeywordId, materialId, keywordId) VALUES (101, 2001, 1);
INSERT INTO MATERIAL_KEYWORDS (dataKeywordId, materialId, keywordId) VALUES (102, 2001, 3);
INSERT INTO MATERIAL_KEYWORDS (dataKeywordId, materialId, keywordId) VALUES (103, 2002, 2);

-- SEARCH_SESSION (검색세션)
INSERT INTO SEARCH_SESSION (searchId, searchType, searchDate, userId) 
VALUES (6001, '통합검색', SYSDATE - 1, 1); -- 어제 날짜
INSERT INTO SEARCH_SESSION (searchId, searchType, searchDate, userId) 
VALUES (6002, '상세검색', SYSDATE, 2); -- 오늘 날짜

-- SEARCH_CONDITION (검색조건)
INSERT INTO SEARCH_CONDITION (conditionId, searchField, operator, searchWord, createAt, searchId) 
VALUES (7001, 'title', 'LIKE', '데이터베이스', SYSDATE - 1, 6001);
INSERT INTO SEARCH_CONDITION (conditionId, searchField, operator, searchWord, createAt, searchId) 
VALUES (7002, 'author', '=', 'Jane Doe', SYSDATE, 6002);

-- QNA
INSERT INTO QA (qaId, questionContent, answerContent, isAnswered, questionDate, userId) 
VALUES (1, '도서관 와이파이 비밀번호가 무엇인가요?', '와이파이는 비밀번호 없이 사용 가능합니다.', 'Y', DATE '2023-10-20', 1);
INSERT INTO QA (qaId, questionContent, answerContent, isAnswered, questionDate, userId) 
VALUES (2, '대출한 책을 연장하고 싶어요.', '마이페이지에서 연장 신청이 가능합니다.', 'Y', DATE '2023-10-25', 2);
INSERT INTO QA (qaId, questionContent, answerContent, isAnswered, questionDate, userId) 
VALUES (3, '견학 신청은 어떻게 하나요?', NULL, 'N', DATE '2023-10-28', 3); -- 미답변 질문

-- RECOMMEND BOOK
INSERT INTO RECOMMENDED_BOOK (recommendedBookId, recommendationReason, recommendationDate, isAnonymous, ownedBookId, userId) 
VALUES (1, '최신 사회 트렌드를 이해하는 데 필수적입니다.', DATE '2024-02-01', 'N', 3003, 4);

-- INTERLIBRARY_LOAN (상호대차)
INSERT INTO INTERLIBRARY_LOAN (interlibraryLoanId, operatingOrganizationName, operatingDepartment) 
VALUES (1, '지역 도서관 협의회', '상호대차 운영팀');

-- INTERLIBRARY_LOAN_REQUEST (상호대차신청)
INSERT INTO INTERLIBRARY_LOAN_REQUEST (requestId, requestDate, requestStatus, userId, interlibraryLoanId, bookInfoId) 
VALUES (101, DATE '2024-03-01', '접수완료', 1, 1, 1003);

-- INTERLIBRARY_LOAN_STATUS (상호대차신청상태이력)
INSERT INTO INTERLIBRARY_LOAN_STATUS (loanStatusId, changeDate, previousStatus, newStatus, requestId) 
VALUES (10001, DATE '2024-03-01', '신청', '접수완료', 101);
INSERT INTO INTERLIBRARY_LOAN_STATUS (loanStatusId, changeDate, previousStatus, newStatus, requestId) 
VALUES (10002, DATE '2024-03-02', '접수완료', '처리중', 101);

-- COLLECTION_TYPE (컬렉션종류)
INSERT INTO COLLECTION_TYPE (collectionTypeId, collectionTypeName) VALUES (1, '이달의 신간');
INSERT INTO COLLECTION_TYPE (collectionTypeId, collectionTypeName) VALUES (2, '사서 추천');

-- COLLECTION (컬렉션)
INSERT INTO COLLECTION (collectionId, collectionTypeId) VALUES (201, 1); -- 이달의 신간 컬렉션
INSERT INTO COLLECTION (collectionId, collectionTypeId) VALUES (202, 2); -- 사서 추천 컬렉션

-- COLLECTION_BOOK (컬렉션_도서)
-- 3001: 데이터베이스 개론, 3002: 행복의 조건, 3003: 한국 사회의 이해
INSERT INTO COLLECTION_BOOK (collectionBookId, collectionId, ownedBookId) VALUES (10001, 201, 3001); -- 신간에 포함
INSERT INTO COLLECTION_BOOK (collectionBookId, collectionId, ownedBookId) VALUES (10002, 202, 3002); -- 사서 추천에 포함
INSERT INTO COLLECTION_BOOK (collectionBookId, collectionId, ownedBookId) VALUES (10003, 202, 3003); -- 사서 추천에 포함