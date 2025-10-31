/* 도서정보 */
CREATE TABLE BOOK_INFO (
	bookInfoId NUMBER NOT NULL, /* 도서정보ID */
	title VARCHAR2(500), /* 도서명 */
	publisherName VARCHAR2(200), /* 출판사명 */
	publishingCountry VARCHAR2(50), /* 출판국가 */
	publishingYear NUMBER, /* 출판연도 */
	isbn VARCHAR2(20), /* ISBN */
	materialType VARCHAR2(50), /* 자료유형 */
	coverImagePath VARCHAR2(500), /* 표지이미지경로 */
	libraryId NUMBER, /* 도서관ID */
	categoryCode NUMBER /* 카테고리코드 */
);

CREATE UNIQUE INDEX PK_BOOK_INFO
	ON BOOK_INFO (
		bookInfoId ASC
	);

ALTER TABLE BOOK_INFO
	ADD
		CONSTRAINT PK_BOOK_INFO
		PRIMARY KEY (
			bookInfoId
		);

/* Q&A */
CREATE TABLE QA (
	qaId NUMBER NOT NULL, /* Q&A_ID */
	questionContent CLOB, /* 질문내용 */
	answerContent CLOB, /* 답변내용 */
	isAnswered CHAR(1), /* 답변여부 */
	questionDate DATE, /* 질문일자 */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_QA
	ON QA (
		qaId ASC
	);

ALTER TABLE QA
	ADD
		CONSTRAINT PK_QA
		PRIMARY KEY (
			qaId
		);

/* 이용자 */
CREATE TABLE USER_INFO (
	userId NUMBER NOT NULL, /* 이용자ID */
	name VARCHAR2(100), /* 이름 */
	password VARCHAR2(100), /* 비밀번호 */
	email VARCHAR2(100), /* 이메일 */
	joinDate DATE, /* 가입일자 */
	contactNumber VARCHAR2(50), /* 연락처 */
	address VARCHAR2(500), /* 주소 */
	birthDate DATE /* 생년월일 */
);

CREATE UNIQUE INDEX PK_USER_INFO
	ON USER_INFO (
		userId ASC
	);

ALTER TABLE USER_INFO
	ADD
		CONSTRAINT PK_USER_INFO
		PRIMARY KEY (
			userId
		);

/* 상호대차신청상태이력 */
CREATE TABLE INTERLIBRARY_LOAN_STATUS (
	loanStatusId NUMBER NOT NULL, /* 상태이력ID */
	changeDate DATE, /* 변경일자 */
	previousStatus VARCHAR2(50), /* 이전상태 */
	newStatus VARCHAR2(50), /* 변경상태 */
	requestId NUMBER /* 신청ID */
);

CREATE UNIQUE INDEX PK_INTERLIBRARY_LOAN_STATUS
	ON INTERLIBRARY_LOAN_STATUS (
		loanStatusId ASC
	);

ALTER TABLE INTERLIBRARY_LOAN_STATUS
	ADD
		CONSTRAINT PK_INTERLIBRARY_LOAN_STATUS
		PRIMARY KEY (
			loanStatusId
		);

/* 상호대차 */
CREATE TABLE INTERLIBRARY_LOAN (
	interlibraryLoanId NUMBER NOT NULL, /* 상호대차ID */
	operatingOrganizationName VARCHAR2(200), /* 운영기관명 */
	operatingDepartment VARCHAR2(200) /* 운영부서 */
);

CREATE UNIQUE INDEX PK_INTERLIBRARY_LOAN
	ON INTERLIBRARY_LOAN (
		interlibraryLoanId ASC
	);

ALTER TABLE INTERLIBRARY_LOAN
	ADD
		CONSTRAINT PK_INTERLIBRARY_LOAN
		PRIMARY KEY (
			interlibraryLoanId
		);

/* 참여도서관 */
CREATE TABLE PARTICIPATING_LIBRARY (
	libraryId NUMBER NOT NULL, /* 도서관ID */
	libraryName VARCHAR2(200), /* 도서관명 */
	region VARCHAR2(100), /* 지역 */
	contactNumber VARCHAR2(50), /* 연락처 */
	email VARCHAR2(100), /* 이메일 */
	managerName VARCHAR2(100) /* 담당자명 */
);

CREATE UNIQUE INDEX PK_PARTICIPATING_LIBRARY
	ON PARTICIPATING_LIBRARY (
		libraryId ASC
	);

ALTER TABLE PARTICIPATING_LIBRARY
	ADD
		CONSTRAINT PK_PARTICIPATING_LIBRARY
		PRIMARY KEY (
			libraryId
		);

/* 상호대차신청 */
CREATE TABLE INTERLIBRARY_LOAN_REQUEST (
	requestId NUMBER NOT NULL, /* 신청ID */
	requestDate DATE, /* 신청일자 */
	requestStatus VARCHAR2(50), /* 신청상태 */
	userId NUMBER, /* 이용자ID */
	interlibraryLoanId NUMBER, /* 상호대차ID */
	bookInfoId NUMBER /* 도서정보ID */
);

CREATE UNIQUE INDEX PK_INTERLIBRARY_LOAN_REQUEST
	ON INTERLIBRARY_LOAN_REQUEST (
		requestId ASC
	);

ALTER TABLE INTERLIBRARY_LOAN_REQUEST
	ADD
		CONSTRAINT PK_INTERLIBRARY_LOAN_REQUEST
		PRIMARY KEY (
			requestId
		);

/* 컬렉션종류 */
CREATE TABLE COLLECTION_TYPE (
	collectionTypeId NUMBER NOT NULL, /* 컬렉션유형식별번호 */
	collectionTypeName VARCHAR2(100) /* 컬렉션유형 */
);

CREATE UNIQUE INDEX PK_COLLECTION_TYPE
	ON COLLECTION_TYPE (
		collectionTypeId ASC
	);

ALTER TABLE COLLECTION_TYPE
	ADD
		CONSTRAINT PK_COLLECTION_TYPE
		PRIMARY KEY (
			collectionTypeId
		);

/* 소장도서 */
CREATE TABLE OWNED_BOOK (
	ownedBookId NUMBER NOT NULL, /* 소장도서ID */
	registrationDate DATE, /* 등록일 */
	modifiedDate DATE, /* 수정일 */
	isDeleted CHAR(1), /* 삭제여부 */
	bookInfoId NUMBER /* 도서정보ID */
);

CREATE UNIQUE INDEX PK_OWNED_BOOK
	ON OWNED_BOOK (
		ownedBookId ASC
	);

ALTER TABLE OWNED_BOOK
	ADD
		CONSTRAINT PK_OWNED_BOOK
		PRIMARY KEY (
			ownedBookId
		);

/* 책상태(대출중,연체중,반납완료...) */
CREATE TABLE BOOK_STATUS (
	statusId NUMBER NOT NULL, /* 상태식별번호 */
	statusName VARCHAR2(50) /* 상태 */
);

CREATE UNIQUE INDEX PK_BOOK_STATUS
	ON BOOK_STATUS (
		statusId ASC
	);

ALTER TABLE BOOK_STATUS
	ADD
		CONSTRAINT PK_BOOK_STATUS
		PRIMARY KEY (
			statusId
		);

/* 추천도서 */
CREATE TABLE RECOMMENDED_BOOK (
	recommendedBookId NUMBER NOT NULL, /* 추천도서식별번호 */
	recommendationReason VARCHAR2(500), /* 추천이유 */
	recommendationDate DATE, /* 추천등록일 */
	isAnonymous CHAR(1), /* 익명허용여부 */
	ownedBookId NUMBER, /* 소장도서ID */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_RECOMMENDED_BOOK
	ON RECOMMENDED_BOOK (
		recommendedBookId ASC
	);

ALTER TABLE RECOMMENDED_BOOK
	ADD
		CONSTRAINT PK_RECOMMENDED_BOOK
		PRIMARY KEY (
			recommendedBookId
		);

/* 대출정보 */
CREATE TABLE LOAN_INFO (
	loanRecordId NUMBER NOT NULL, /* 대출기록ID */
	loanDate DATE, /* 대출일 */
	returnDate DATE, /* 반납예정일 */
	ownedBookId NUMBER, /* 소장도서ID */
	statusId NUMBER, /* 상태식별번호 */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_LOAN_INFO
	ON LOAN_INFO (
		loanRecordId ASC
	);

ALTER TABLE LOAN_INFO
	ADD
		CONSTRAINT PK_LOAN_INFO
		PRIMARY KEY (
			loanRecordId
		);

/* 컬렉션 */
CREATE TABLE COLLECTION (
	collectionId NUMBER NOT NULL, /* 컬렉션식별번호 */
	collectionTypeId NUMBER /* 컬렉션유형식별번호 */
);

CREATE UNIQUE INDEX PK_COLLECTION
	ON COLLECTION (
		collectionId ASC
	);

ALTER TABLE COLLECTION
	ADD
		CONSTRAINT PK_COLLECTION
		PRIMARY KEY (
			collectionId
		);

/* 카테고리 */
CREATE TABLE CATEGORY (
	categoryCode NUMBER NOT NULL, /* 카테고리코드 */
	categoryName VARCHAR2(100) /* 카테고리명 */
);

CREATE UNIQUE INDEX PK_CATEGORY
	ON CATEGORY (
		categoryCode ASC
	);

ALTER TABLE CATEGORY
	ADD
		CONSTRAINT PK_CATEGORY
		PRIMARY KEY (
			categoryCode
		);

/* 상세분류 */
CREATE TABLE DETAILED_CLASSIFICATION (
	detailedClassificationId NUMBER NOT NULL, /* 상세분류ID */
	eventClassification VARCHAR2(100) /* 행사구분(교육프로그램,문화행사,전시-체험) */
);

CREATE UNIQUE INDEX PK_DETAILED_CLASSIFICATION
	ON DETAILED_CLASSIFICATION (
		detailedClassificationId ASC
	);

ALTER TABLE DETAILED_CLASSIFICATION
	ADD
		CONSTRAINT PK_DETAILED_CLASSIFICATION
		PRIMARY KEY (
			detailedClassificationId
		);

/* 직원 */
CREATE TABLE EMPLOYEE (
	employeeId NUMBER NOT NULL, /* 직원ID */
	employeeName VARCHAR2(100), /* 이름 */
	employeeTel VARCHAR2(20), /* 연락처 */
	employeeEmail VARCHAR2(100), /* 이메일 */
	employeePosition VARCHAR2(50), /* 직급 */
	employeeDivision VARCHAR2(50) /* 부서 */
);

CREATE UNIQUE INDEX PK_EMPLOYEE
	ON EMPLOYEE (
		employeeId ASC
	);

ALTER TABLE EMPLOYEE
	ADD
		CONSTRAINT PK_EMPLOYEE
		PRIMARY KEY (
			employeeId
		);

/* 행사신청기록 */
CREATE TABLE EVENT_APPLICATION_RECORD (
	eventApplicationId NUMBER  NOT NULL, /* 행사신청ID */
	applicationDate DATE, /* 행사신청날짜 */
	approvalStatus VARCHAR2(50), /* 행사승인상태 */
	participantCount NUMBER, /* 행사참여인원수 */
	applicationMethod VARCHAR2(50), /* 행사신청방법(온/오프) */
	isCancelled CHAR(1), /* 행사신청취소여부 */
	isAttended CHAR(1), /* 행사참석여부 */
	eventId NUMBER, /* 행사ID */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_EVENT_APPLICATION_RECORD
	ON EVENT_APPLICATION_RECORD (
		eventApplicationId ASC
	);

ALTER TABLE EVENT_APPLICATION_RECORD
	ADD
		CONSTRAINT PK_EVENT_APPLICATION_RECORD
		PRIMARY KEY (
			eventApplicationId
		);

/* 상영시간 */
CREATE TABLE EVENT_SHOWTIME (
	showId NUMBER NOT NULL, /* 상영ID */
	eventId NUMBER, /* 행사ID */
	theater VARCHAR2(100), /* 상영관 */
	seat VARCHAR2(50) /* 좌석수 */
);

CREATE UNIQUE INDEX PK_EVENT_SHOWTIME
	ON EVENT_SHOWTIME (
		showId ASC
	);

ALTER TABLE EVENT_SHOWTIME
	ADD
		CONSTRAINT PK_EVENT_SHOWTIME
		PRIMARY KEY (
			showId
		);

/* 행사유형 */
CREATE TABLE EVENT_TYPE (
	eventTypeId NUMBER NOT NULL, /* 행사유형ID */
	eventOnOff VARCHAR2(20) /* 행사유형(온라인/오프라인) */
);

CREATE UNIQUE INDEX PK_EVENT_TYPE
	ON EVENT_TYPE (
		eventTypeId ASC
	);

ALTER TABLE EVENT_TYPE
	ADD
		CONSTRAINT PK_EVENT_TYPE
		PRIMARY KEY (
			eventTypeId
		);

/* 행사 */
CREATE TABLE EVENT (
	eventId NUMBER NOT NULL, /* 행사ID */
	eventName VARCHAR2(200), /* 행사명 */
	eventStart DATE, /* 행사시작일 */
	eventEnd DATE, /* 행사종료일 */
	eventLocation VARCHAR2(255), /* 행사위치 */
	maxCapacity NUMBER, /* 최대정원 */
	applicationStart DATE, /* 신청시작일 */
	applicationEnd DATE, /* 신청종료일 */
	lectureContent CLOB, /* 강의내용 */
	runningTime NUMBER, /* 러닝타임 */
	admissionFee NUMBER, /* 관람료 */
	eventCondition VARCHAR2(200), /* 행사상태 */
	mainImage VARCHAR2(255), /* 대표이미지 */
	applicationType VARCHAR2(50), /* 접수방식 */
	eventTypeId NUMBER, /* 행사유형ID */
	detailedClassificationId NUMBER, /* 상세분류ID */
	employeeId NUMBER /* 직원ID */
);

CREATE UNIQUE INDEX PK_EVENT
	ON EVENT (
		eventId ASC
	);

ALTER TABLE EVENT
	ADD
		CONSTRAINT PK_EVENT
		PRIMARY KEY (
			eventId
		);

/* 행사태그 */
CREATE TABLE EVENT_TAG (
	eventTagId NUMBER NOT NULL, /* 태그_행사ID */
	tagId NUMBER NOT NULL, /* 태그ID */
	eventId NUMBER NOT NULL /* 행사ID */
);

CREATE UNIQUE INDEX PK_EVENT_TAG
	ON EVENT_TAG (
		eventTagId ASC
	);

ALTER TABLE EVENT_TAG
	ADD
		CONSTRAINT PK_EVENT_TAG
		PRIMARY KEY (
			eventTagId
		);

/* 태그 */
CREATE TABLE TAG (
	tagId NUMBER NOT NULL, /* 태그ID */
	tagName VARCHAR2(50) /* 태그명(역사,독서,문화..etc) */
);

CREATE UNIQUE INDEX PK_TAG
	ON TAG (
		tagId ASC
	);

ALTER TABLE TAG
	ADD
		CONSTRAINT PK_TAG
		PRIMARY KEY (
			tagId
		);

/* 컬렉션_도서 */
CREATE TABLE COLLECTION_BOOK (
	collectionBookId NUMBER NOT NULL, /* 컬렉션_도서ID */
	collectionId NUMBER, /* 컬렉션식별번호 */
	ownedBookId NUMBER /* 소장도서ID */
);

CREATE UNIQUE INDEX PK_COLLECTION_BOOK
	ON COLLECTION_BOOK (
		collectionBookId ASC
	);

ALTER TABLE COLLECTION_BOOK
	ADD
		CONSTRAINT PK_COLLECTION_BOOK
		PRIMARY KEY (
			collectionBookId
		);

/* 이용자행사통계 */
CREATE TABLE USER_EVENT_STATISTICS (
	eventStatisticsId NUMBER NOT NULL, /* 행사통계ID */
	userId NUMBER, /* 이용자ID */
	eventId NUMBER /* 행사ID */
);

CREATE UNIQUE INDEX PK_USER_EVENT_STATISTICS
	ON USER_EVENT_STATISTICS (
		eventStatisticsId ASC
	);

ALTER TABLE USER_EVENT_STATISTICS
	ADD
		CONSTRAINT PK_USER_EVENT_STATISTICS
		PRIMARY KEY (
			eventStatisticsId
		);

/* 이용자견학통계 */
CREATE TABLE TOUR_STATISTIC (
	tourStatId NUMBER NOT NULL, /* 견학통계ID */
	tourId NUMBER, /* 견학ID */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_TOUR_STATISTIC
	ON TOUR_STATISTIC (
		tourStatId ASC
	);

ALTER TABLE TOUR_STATISTIC
	ADD
		CONSTRAINT PK_TOUR_STATISTIC
		PRIMARY KEY (
			tourStatId
		);

/* 견학신청 */
CREATE TABLE TOUR_APPLICATION (
	tourId NUMBER NOT NULL, /* 견학ID */
	participantCount NUMBER(3), /* 인원 */
	reservationDate DATE, /* 예약날짜 */
	tourStatus VARCHAR2(20), /* 예약취소여부 */
	tourTypeId NUMBER, /* 유형ID */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_TOUR_APPLICATION
	ON TOUR_APPLICATION (
		tourId ASC
	);

ALTER TABLE TOUR_APPLICATION
	ADD
		CONSTRAINT PK_TOUR_APPLICATION
		PRIMARY KEY (
			tourId
		);

/* 견학유형 */
CREATE TABLE TOUR_TYPE (
	tourTypeId NUMBER NOT NULL, /* 유형ID */
	tourName VARCHAR2(200), /* 견학명 */
	tourOrder NUMBER(3), /* 견학순서 */
	routeName VARCHAR2(100), /* 장소명 */
	routeDesc CLOB, /* 장소설명 */
	minParticipant NUMBER(3), /* 최소인원 */
	maxParticipant NUMBER(3) /* 최대인원 */
);

CREATE UNIQUE INDEX PK_TOUR_TYPE
	ON TOUR_TYPE (
		tourTypeId ASC
	);

ALTER TABLE TOUR_TYPE
	ADD
		CONSTRAINT PK_TOUR_TYPE
		PRIMARY KEY (
			tourTypeId
		);

/* 무선인터넷 */
CREATE TABLE WIFI (
	wifiId NUMBER NOT NULL, /* 와이파이ID */
	wifiServiceArea VARCHAR2(255), /* 서비스 구역 */
	wifiUsageGuide CLOB, /* 이용방법 */
	wifiPhoneNumber VARCHAR2(20), /* 문의전화 */
	wifiRegDate DATE, /* 등록일자 */
	amenityId NUMBER /* 편의시설 ID */
);

CREATE UNIQUE INDEX PK_WIFI
	ON WIFI (
		wifiId ASC
	);

ALTER TABLE WIFI
	ADD
		CONSTRAINT PK_WIFI
		PRIMARY KEY (
			wifiId
		);

/* 편의시설 */
CREATE TABLE AMENITY (
	amenityId NUMBER NOT NULL, /* 편의시설 ID */
	amenityName VARCHAR2(100), /* 편의시설명(북카페,편의점...) */
	amenityLocation VARCHAR2(255) /* 위치 */
);

CREATE UNIQUE INDEX PK_AMENITY
	ON AMENITY (
		amenityId ASC
	);

ALTER TABLE AMENITY
	ADD
		CONSTRAINT PK_AMENITY
		PRIMARY KEY (
			amenityId
		);

/* 이용시간 */
CREATE TABLE OPERATING_HOUR (
	hourId NUMBER NOT NULL, /* 이용시간ID */
	holidayInfo VARCHAR2(255), /* 휴일 */
	openTime TIMESTAMP, /* 시작시간 */
	closeTime TIMESTAMP, /* 종료시간 */
	contactNumber VARCHAR2(20), /* 문의전화 */
	isClosed CHAR(1), /* 휴점여부 */
	amenityId NUMBER /* 편의시설 ID */
);

CREATE UNIQUE INDEX PK_OPERATING_HOUR
	ON OPERATING_HOUR (
		hourId ASC
	);

ALTER TABLE OPERATING_HOUR
	ADD
		CONSTRAINT PK_OPERATING_HOUR
		PRIMARY KEY (
			hourId
		);

/* 식단 */
CREATE TABLE MEAL_PLAN (
	mealPlanId NUMBER NOT NULL, /* 식단ID */
	menuDate DATE, /* 제공일자 */
	menuContent CLOB, /* 메뉴 */
	sRegDate DATE, /* 등록일자 */
	hourId NUMBER /* 이용시간ID */
);

CREATE UNIQUE INDEX PK_MEAL_PLAN
	ON MEAL_PLAN (
		mealPlanId ASC
	);

ALTER TABLE MEAL_PLAN
	ADD
		CONSTRAINT PK_MEAL_PLAN
		PRIMARY KEY (
			mealPlanId
		);

/* 메뉴 */
CREATE TABLE MEAL_ASSIGNMENT (
	menuId NUMBER NOT NULL, /* 메뉴ID */
	mealPlanId NUMBER, /* 식단ID */
	mealTypeId NUMBER /* 식사ID */
);

CREATE UNIQUE INDEX PK_MEAL_ASSIGNMENT
	ON MEAL_ASSIGNMENT (
		menuId ASC
	);

ALTER TABLE MEAL_ASSIGNMENT
	ADD
		CONSTRAINT PK_MEAL_ASSIGNMENT
		PRIMARY KEY (
			menuId
		);

/* 식사종류 */
CREATE TABLE MEAL_TYPE (
	mealTypeId NUMBER NOT NULL, /* 식사ID */
	mealTypeName VARCHAR2(50) /* 식사종류(점심,저녁) */
);

CREATE UNIQUE INDEX PK_MEAL_TYPE
	ON MEAL_TYPE (
		mealTypeId ASC
	);

ALTER TABLE MEAL_TYPE
	ADD
		CONSTRAINT PK_MEAL_TYPE
		PRIMARY KEY (
			mealTypeId
		);

/* 게시물 */
CREATE TABLE POST (
	postId NUMBER NOT NULL, /* 게시물번호 */
	postThumbnailUrl VARCHAR(255), /* 썸네일(게시물코드에 따라서 null가능) */
	postTitle VARCHAR(200), /* 게시물제목 */
	postContent CLOB, /* 게시물내용 */
	postCreateDate DATE, /* 등록일 */
	postViewCount NUMBER, /* 조회수 */
	postApplicationPeriod VARCHAR(100), /* 접수기간(게시물코드에 따라서 null가능) */
	postSchedule VARCHAR(100), /* 일정(게시물코드에 따라서 null가능) */
	postLocation VARCHAR(100), /* 장소(게시물코드에 따라서 null가능) */
	postTypeCode NUMBER, /* 게시물종류코드 */
	postAttachmentId NUMBER, /* 첨부파일번호 */
	employeeId NUMBER /* 직원ID */
);

CREATE UNIQUE INDEX PK_POST
	ON POST (
		postId ASC
	);

ALTER TABLE POST
	ADD
		CONSTRAINT PK_POST
		PRIMARY KEY (
			postId
		);

/* 게시물 종류 */
CREATE TABLE POST_TYPE (
	postTypeCode NUMBER NOT NULL, /* 게시물종류코드 */
	postTypeName VARCHAR(100) /* 게시물종류이름 */
);

CREATE UNIQUE INDEX PK_POST_TYPE
	ON POST_TYPE (
		postTypeCode ASC
	);

ALTER TABLE POST_TYPE
	ADD
		CONSTRAINT PK_POST_TYPE
		PRIMARY KEY (
			postTypeCode
		);

/* 첨부파일 */
CREATE TABLE ATTACHMENT (
	postAttachmentId NUMBER NOT NULL, /* 첨부파일번호 */
	postAttachmentPath VARCHAR(255), /* 첨부파일경로 */
	postAttachmentName VARCHAR(200), /* 첨부파일명 */
	postAttachmentType VARCHAR(50) /* 첨부파일유형 */
);

CREATE UNIQUE INDEX PK_ATTACHMENT
	ON ATTACHMENT (
		postAttachmentId ASC
	);

ALTER TABLE ATTACHMENT
	ADD
		CONSTRAINT PK_ATTACHMENT
		PRIMARY KEY (
			postAttachmentId
		);

/* 주제어 */
CREATE TABLE KEYWORDS (
	keywordId NUMBER NOT NULL, /* 주제어_ID */
	inputKeyword VARCHAR2(200), /* 입력주제어 */
	integratedKeyword VARCHAR2(200), /* 통합주제어 */
	relatedTerm VARCHAR2(200), /* 관계용어 */
	relatedEng VARCHAR2(200), /* 관계영문어 */
	relatedCode VARCHAR2(50), /* 관계코드 */
	searchButton CHAR(1) /* 검색버튼여부 */
);

CREATE UNIQUE INDEX PK_KEYWORDS
	ON KEYWORDS (
		keywordId ASC
	);

ALTER TABLE KEYWORDS
	ADD
		CONSTRAINT PK_KEYWORDS
		PRIMARY KEY (
			keywordId
		);

/* 검색조건 */
CREATE TABLE SEARCH_CONDITION (
	conditionId NUMBER NOT NULL, /* 조건_ID */
	searchField VARCHAR2(100), /* 검색필드명 */
	operator VARCHAR2(20), /* 연산자 */
	searchWord VARCHAR2(500), /* 검색어 */
	createAt DATE, /* 생성일시 */
	searchId NUMBER /* 검색세션_ID */
);

CREATE UNIQUE INDEX PK_SEARCH_CONDITION
	ON SEARCH_CONDITION (
		conditionId ASC
	);

ALTER TABLE SEARCH_CONDITION
	ADD
		CONSTRAINT PK_SEARCH_CONDITION
		PRIMARY KEY (
			conditionId
		);

/* 검색세션 */
CREATE TABLE SEARCH_SESSION (
	searchId NUMBER NOT NULL, /* 검색세션_ID */
	searchType VARCHAR2(50), /* 검색유형 */
	searchDate DATE, /* 검색일시 */
	userId NUMBER /* 이용자ID */
);

CREATE UNIQUE INDEX PK_SEARCH_SESSION
	ON SEARCH_SESSION (
		searchId ASC
	);

ALTER TABLE SEARCH_SESSION
	ADD
		CONSTRAINT PK_SEARCH_SESSION
		PRIMARY KEY (
			searchId
		);

/* 도서_저자 */
CREATE TABLE BOOK_AUTHOR (
	bookAuthorId NUMBER NOT NULL, /* 도서_저자ID */
	roleCode VARCHAR2(20), /* 역할코드(저자,편집자,역자) */
	authorId NUMBER, /* 저자_ID */
	bookInfoId NUMBER /* 도서정보ID */
);

CREATE UNIQUE INDEX PK_BOOK_AUTHOR
	ON BOOK_AUTHOR (
		bookAuthorId ASC
	);

ALTER TABLE BOOK_AUTHOR
	ADD
		CONSTRAINT PK_BOOK_AUTHOR
		PRIMARY KEY (
			bookAuthorId
		);

/* 자료_주제어 */
CREATE TABLE MATERIAL_KEYWORDS (
	dataKeywordId NUMBER NOT NULL, /* 자료_주제어_ID */
	materialId NUMBER, /* 자료_ID */
	keywordId NUMBER /* 주제어_ID */
);

CREATE UNIQUE INDEX PK_MATERIAL_KEYWORDS
	ON MATERIAL_KEYWORDS (
		dataKeywordId ASC
	);

ALTER TABLE MATERIAL_KEYWORDS
	ADD
		CONSTRAINT PK_MATERIAL_KEYWORDS
		PRIMARY KEY (
			dataKeywordId
		);

/* 소장자료 */
CREATE TABLE MATERIAL (
	materialId NUMBER NOT NULL, /* 자료_ID */
	title VARCHAR2(500), /* 제목 */
	subTitle VARCHAR2(500), /* 부제목 */
	keyword VARCHAR2(500), /* 키워드 */
	publishYear NUMBER, /* 발행년도 */
	url VARCHAR2(1000), /* URL */
	stdCodeType VARCHAR2(50), /* 표준부호코드 */
	stdCodeValue VARCHAR2(100), /* 표준부호값 */
	classSchemeCode VARCHAR2(50), /* 분류체계코드 */
	classSymbolValue VARCHAR2(100), /* 분류기호값 */
	callNo VARCHAR2(100), /* 청구기호 */
	mainLangCode VARCHAR2(20), /* 본문언어코드 */
	summaryLangCode VARCHAR2(20), /* 요약언어코드 */
	frequencyCode VARCHAR2(20), /* 간행빈도코드 */
	editionCode VARCHAR2(20), /* 판종유형코드 */
	usageCode VARCHAR2(20), /* 자료이용코드 */
	regDate DATE, /* 등록일시 */
	updateDate DATE, /* 수정일시 */
	summary CLOB, /* 요약 */
	publisherId NUMBER, /* 발행자_ID */
	bookInfoId NUMBER /* 도서정보ID */
);

CREATE UNIQUE INDEX PK_MATERIAL
	ON MATERIAL (
		materialId ASC
	);

ALTER TABLE MATERIAL
	ADD
		CONSTRAINT PK_MATERIAL
		PRIMARY KEY (
			materialId
		);

/* 발행자정보 */
CREATE TABLE PUBLISHER (
	publisherId NUMBER NOT NULL, /* 발행자_ID */
	name VARCHAR2(200), /* 이름 */
	countryCode VARCHAR2(20), /* 국가코드 */
	cityCode VARCHAR2(20) /* 도시코드 */
);

CREATE UNIQUE INDEX PK_PUBLISHER
	ON PUBLISHER (
		publisherId ASC
	);

ALTER TABLE PUBLISHER
	ADD
		CONSTRAINT PK_PUBLISHER
		PRIMARY KEY (
			publisherId
		);

/* 소장정보 */
CREATE TABLE HOLDING_INFO (
	materialId NUMBER NOT NULL, /* 자료_ID */
	location VARCHAR2(100), /* 자료이용장소 */
	callNo VARCHAR2(100), /* 청구기호 */
	status VARCHAR2(50), /* 자료상태 */
	regNo VARCHAR2(100), /* 등록번호 */
	isElectronic CHAR(1), /* 전자자료여부 */
	edition VARCHAR2(50), /* 판차수 */
	partNo VARCHAR2(50) /* 편권차 */
);

CREATE UNIQUE INDEX PK_HOLDING_INFO
	ON HOLDING_INFO (
		materialId ASC
	);

ALTER TABLE HOLDING_INFO
	ADD
		CONSTRAINT PK_HOLDING_INFO
		PRIMARY KEY (
			materialId
		);

/* 공통코드_그룹 */
CREATE TABLE CODE_GROUP (
	groupId NUMBER NOT NULL, /* 그룹_ID */
	groupName VARCHAR2(100) /* 그룹명 */
);

CREATE UNIQUE INDEX PK_CODE_GROUP
	ON CODE_GROUP (
		groupId ASC
	);

ALTER TABLE CODE_GROUP
	ADD
		CONSTRAINT PK_CODE_GROUP
		PRIMARY KEY (
			groupId
		);

/* 공통코드_코드 */
CREATE TABLE CODE_VALUE (
	codeId NUMBER NOT NULL, /* 코드_ID */
	code VARCHAR2(50), /* 코드 */
	codeName VARCHAR2(200), /* 코드명 */
	parentCodeId NUMBER, /* 상위코드_ID */
	groupId NUMBER /* 그룹_ID */
);

CREATE UNIQUE INDEX PK_CODE_VALUE
	ON CODE_VALUE (
		codeId ASC
	);

ALTER TABLE CODE_VALUE
	ADD
		CONSTRAINT PK_CODE_VALUE
		PRIMARY KEY (
			codeId
		);

/* 저자 */
CREATE TABLE AUTHOR (
	authorId NUMBER NOT NULL, /* 저자_ID */
	authorName VARCHAR2(100), /* 이름 */
	insi VARCHAR2(50), /* INSI */
	nationalityCode VARCHAR2(20), /* 국적코드 */
	birthYear NUMBER, /* 출생년도 */
	deathYear NUMBER, /* 사망년도 */
	gender VARCHAR2(10) /* 성별코드 */
);

CREATE UNIQUE INDEX PK_AUTHOR
	ON AUTHOR (
		authorId ASC
	);

ALTER TABLE AUTHOR
	ADD
		CONSTRAINT PK_AUTHOR
		PRIMARY KEY (
			authorId
		);

ALTER TABLE BOOK_INFO
    ADD CONSTRAINT FK_BOOK_LIB
    FOREIGN KEY (libraryId)
    REFERENCES PARTICIPATING_LIBRARY (libraryId);

ALTER TABLE BOOK_INFO
    ADD CONSTRAINT FK_BOOK_CAT
    FOREIGN KEY (categoryCode)
    REFERENCES CATEGORY (categoryCode);

ALTER TABLE QA
    ADD CONSTRAINT FK_QA_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE INTERLIBRARY_LOAN_STATUS
    ADD CONSTRAINT FK_LOANSTAT_REQ
    FOREIGN KEY (requestId)
    REFERENCES INTERLIBRARY_LOAN_REQUEST (requestId);

ALTER TABLE INTERLIBRARY_LOAN_REQUEST
    ADD CONSTRAINT FK_REQ_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE INTERLIBRARY_LOAN_REQUEST
    ADD CONSTRAINT FK_REQ_LOAN
    FOREIGN KEY (interlibraryLoanId)
    REFERENCES INTERLIBRARY_LOAN (interlibraryLoanId);

ALTER TABLE INTERLIBRARY_LOAN_REQUEST
    ADD CONSTRAINT FK_REQ_BOOK
    FOREIGN KEY (bookInfoId)
    REFERENCES BOOK_INFO (bookInfoId);

ALTER TABLE OWNED_BOOK
    ADD CONSTRAINT FK_OWN_BOOK
    FOREIGN KEY (bookInfoId)
    REFERENCES BOOK_INFO (bookInfoId);

ALTER TABLE RECOMMENDED_BOOK
    ADD CONSTRAINT FK_REC_OWN
    FOREIGN KEY (ownedBookId)
    REFERENCES OWNED_BOOK (ownedBookId);

ALTER TABLE RECOMMENDED_BOOK
    ADD CONSTRAINT FK_REC_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE LOAN_INFO
    ADD CONSTRAINT FK_LOAN_OWN
    FOREIGN KEY (ownedBookId)
    REFERENCES OWNED_BOOK (ownedBookId);

ALTER TABLE LOAN_INFO
    ADD CONSTRAINT FK_LOAN_STATUS
    FOREIGN KEY (statusId)
    REFERENCES BOOK_STATUS (statusId);

ALTER TABLE LOAN_INFO
    ADD CONSTRAINT FK_LOAN_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE COLLECTION
    ADD CONSTRAINT FK_COLL_TYPE
    FOREIGN KEY (collectionTypeId)
    REFERENCES COLLECTION_TYPE (collectionTypeId);

ALTER TABLE EVENT_APPLICATION_RECORD
    ADD CONSTRAINT FK_EVTAPP_EVT
    FOREIGN KEY (eventId)
    REFERENCES EVENT (eventId);

ALTER TABLE EVENT_APPLICATION_RECORD
    ADD CONSTRAINT FK_EVTAPP_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE EVENT_SHOWTIME
    ADD CONSTRAINT FK_EVTST_EVT
    FOREIGN KEY (eventId)
    REFERENCES EVENT (eventId);

ALTER TABLE EVENT
    ADD CONSTRAINT FK_EVT_DETAIL
    FOREIGN KEY (detailedClassificationId)
    REFERENCES DETAILED_CLASSIFICATION (detailedClassificationId);

ALTER TABLE EVENT
    ADD CONSTRAINT FK_EVT_EMP
    FOREIGN KEY (employeeId)
    REFERENCES EMPLOYEE (employeeId);

ALTER TABLE EVENT
    ADD CONSTRAINT FK_EVT_TYPE
    FOREIGN KEY (eventTypeId)
    REFERENCES EVENT_TYPE (eventTypeId);

ALTER TABLE EVENT_TAG
    ADD CONSTRAINT FK_EVT_TAG
    FOREIGN KEY (tagId)
    REFERENCES TAG (tagId);

ALTER TABLE EVENT_TAG
    ADD CONSTRAINT FK_EVT_TAG_EVT
    FOREIGN KEY (eventId)
    REFERENCES EVENT (eventId);

ALTER TABLE COLLECTION_BOOK
    ADD CONSTRAINT FK_COLLBOOK_COLL
    FOREIGN KEY (collectionId)
    REFERENCES COLLECTION (collectionId);

ALTER TABLE COLLECTION_BOOK
    ADD CONSTRAINT FK_COLLBOOK_OWN
    FOREIGN KEY (ownedBookId)
    REFERENCES OWNED_BOOK (ownedBookId);

ALTER TABLE USER_EVENT_STATISTICS
    ADD CONSTRAINT FK_UES_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE USER_EVENT_STATISTICS
    ADD CONSTRAINT FK_UES_EVT
    FOREIGN KEY (eventId)
    REFERENCES EVENT (eventId);

ALTER TABLE TOUR_STATISTIC
    ADD CONSTRAINT FK_TOURSTAT_APP
    FOREIGN KEY (tourId)
    REFERENCES TOUR_APPLICATION (tourId);

ALTER TABLE TOUR_STATISTIC
    ADD CONSTRAINT FK_TOURSTAT_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE TOUR_APPLICATION
    ADD CONSTRAINT FK_TOURAPP_TYPE
    FOREIGN KEY (tourTypeId)
    REFERENCES TOUR_TYPE (tourTypeId);

ALTER TABLE TOUR_APPLICATION
    ADD CONSTRAINT FK_TOURAPP_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE WIFI
    ADD CONSTRAINT FK_WIFI_AMEN
    FOREIGN KEY (amenityId)
    REFERENCES AMENITY (amenityId);

ALTER TABLE OPERATING_HOUR
    ADD CONSTRAINT FK_OPH_AMEN
    FOREIGN KEY (amenityId)
    REFERENCES AMENITY (amenityId);

ALTER TABLE MEAL_PLAN
    ADD CONSTRAINT FK_MEAL_OPH
    FOREIGN KEY (hourId)
    REFERENCES OPERATING_HOUR (hourId);

ALTER TABLE MEAL_ASSIGNMENT
    ADD CONSTRAINT FK_MEAL_PLAN_ASSIGN
    FOREIGN KEY (mealPlanId)
    REFERENCES MEAL_PLAN (mealPlanId);

ALTER TABLE MEAL_ASSIGNMENT
    ADD CONSTRAINT FK_MEAL_TYPE_ASSIGN
    FOREIGN KEY (mealTypeId)
    REFERENCES MEAL_TYPE (mealTypeId);

ALTER TABLE POST
    ADD CONSTRAINT FK_POST_TYPE
    FOREIGN KEY (postTypeCode)
    REFERENCES POST_TYPE (postTypeCode);

ALTER TABLE POST
    ADD CONSTRAINT FK_POST_ATTACH
    FOREIGN KEY (postAttachmentId)
    REFERENCES ATTACHMENT (postAttachmentId);

ALTER TABLE POST
    ADD CONSTRAINT FK_POST_EMP
    FOREIGN KEY (employeeId)
    REFERENCES EMPLOYEE (employeeId);

ALTER TABLE SEARCH_CONDITION
    ADD CONSTRAINT FK_SEARCHCOND_SESSION
    FOREIGN KEY (searchId)
    REFERENCES SEARCH_SESSION (searchId);

ALTER TABLE SEARCH_SESSION
    ADD CONSTRAINT FK_SEARCHSESSION_USER
    FOREIGN KEY (userId)
    REFERENCES USER_INFO (userId);

ALTER TABLE BOOK_AUTHOR
    ADD CONSTRAINT FK_BOOKAUTH_AUTHOR
    FOREIGN KEY (authorId)
    REFERENCES AUTHOR (authorId);

ALTER TABLE BOOK_AUTHOR
    ADD CONSTRAINT FK_BOOKAUTH_BOOK
    FOREIGN KEY (bookInfoId)
    REFERENCES BOOK_INFO (bookInfoId);

ALTER TABLE MATERIAL_KEYWORDS
    ADD CONSTRAINT FK_MATKEY_MATERIAL
    FOREIGN KEY (materialId)
    REFERENCES MATERIAL (materialId);

ALTER TABLE MATERIAL_KEYWORDS
    ADD CONSTRAINT FK_MATKEY_KEYWORD
    FOREIGN KEY (keywordId)
    REFERENCES KEYWORDS (keywordId);

ALTER TABLE MATERIAL
    ADD CONSTRAINT FK_MAT_PUBLISHER
    FOREIGN KEY (publisherId)
    REFERENCES PUBLISHER (publisherId);

ALTER TABLE MATERIAL
    ADD CONSTRAINT FK_MAT_BOOK
    FOREIGN KEY (bookInfoId)
    REFERENCES BOOK_INFO (bookInfoId);

ALTER TABLE HOLDING_INFO
    ADD CONSTRAINT FK_HOLD_MATERIAL
    FOREIGN KEY (materialId)
    REFERENCES MATERIAL (materialId);

ALTER TABLE CODE_VALUE
    ADD CONSTRAINT FK_CODEVAL_GROUP
    FOREIGN KEY (groupId)
    REFERENCES CODE_GROUP (groupId);
