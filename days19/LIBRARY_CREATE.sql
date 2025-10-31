/* �������� */
CREATE TABLE BOOK_INFO (
	bookInfoId NUMBER NOT NULL, /* ��������ID */
	title VARCHAR2(500), /* ������ */
	publisherName VARCHAR2(200), /* ���ǻ�� */
	publishingCountry VARCHAR2(50), /* ���Ǳ��� */
	publishingYear NUMBER, /* ���ǿ��� */
	isbn VARCHAR2(20), /* ISBN */
	materialType VARCHAR2(50), /* �ڷ����� */
	coverImagePath VARCHAR2(500), /* ǥ���̹������ */
	libraryId NUMBER, /* ������ID */
	categoryCode NUMBER /* ī�װ��ڵ� */
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
	questionContent CLOB, /* �������� */
	answerContent CLOB, /* �亯���� */
	isAnswered CHAR(1), /* �亯���� */
	questionDate DATE, /* �������� */
	userId NUMBER /* �̿���ID */
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

/* �̿��� */
CREATE TABLE USER_INFO (
	userId NUMBER NOT NULL, /* �̿���ID */
	name VARCHAR2(100), /* �̸� */
	password VARCHAR2(100), /* ��й�ȣ */
	email VARCHAR2(100), /* �̸��� */
	joinDate DATE, /* �������� */
	contactNumber VARCHAR2(50), /* ����ó */
	address VARCHAR2(500), /* �ּ� */
	birthDate DATE /* ������� */
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

/* ��ȣ������û�����̷� */
CREATE TABLE INTERLIBRARY_LOAN_STATUS (
	loanStatusId NUMBER NOT NULL, /* �����̷�ID */
	changeDate DATE, /* �������� */
	previousStatus VARCHAR2(50), /* �������� */
	newStatus VARCHAR2(50), /* ������� */
	requestId NUMBER /* ��ûID */
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

/* ��ȣ���� */
CREATE TABLE INTERLIBRARY_LOAN (
	interlibraryLoanId NUMBER NOT NULL, /* ��ȣ����ID */
	operatingOrganizationName VARCHAR2(200), /* ������ */
	operatingDepartment VARCHAR2(200) /* ��μ� */
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

/* ���������� */
CREATE TABLE PARTICIPATING_LIBRARY (
	libraryId NUMBER NOT NULL, /* ������ID */
	libraryName VARCHAR2(200), /* �������� */
	region VARCHAR2(100), /* ���� */
	contactNumber VARCHAR2(50), /* ����ó */
	email VARCHAR2(100), /* �̸��� */
	managerName VARCHAR2(100) /* ����ڸ� */
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

/* ��ȣ������û */
CREATE TABLE INTERLIBRARY_LOAN_REQUEST (
	requestId NUMBER NOT NULL, /* ��ûID */
	requestDate DATE, /* ��û���� */
	requestStatus VARCHAR2(50), /* ��û���� */
	userId NUMBER, /* �̿���ID */
	interlibraryLoanId NUMBER, /* ��ȣ����ID */
	bookInfoId NUMBER /* ��������ID */
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

/* �÷������� */
CREATE TABLE COLLECTION_TYPE (
	collectionTypeId NUMBER NOT NULL, /* �÷��������ĺ���ȣ */
	collectionTypeName VARCHAR2(100) /* �÷������� */
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

/* ���嵵�� */
CREATE TABLE OWNED_BOOK (
	ownedBookId NUMBER NOT NULL, /* ���嵵��ID */
	registrationDate DATE, /* ����� */
	modifiedDate DATE, /* ������ */
	isDeleted CHAR(1), /* �������� */
	bookInfoId NUMBER /* ��������ID */
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

/* å����(������,��ü��,�ݳ��Ϸ�...) */
CREATE TABLE BOOK_STATUS (
	statusId NUMBER NOT NULL, /* ���½ĺ���ȣ */
	statusName VARCHAR2(50) /* ���� */
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

/* ��õ���� */
CREATE TABLE RECOMMENDED_BOOK (
	recommendedBookId NUMBER NOT NULL, /* ��õ�����ĺ���ȣ */
	recommendationReason VARCHAR2(500), /* ��õ���� */
	recommendationDate DATE, /* ��õ����� */
	isAnonymous CHAR(1), /* �͸���뿩�� */
	ownedBookId NUMBER, /* ���嵵��ID */
	userId NUMBER /* �̿���ID */
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

/* �������� */
CREATE TABLE LOAN_INFO (
	loanRecordId NUMBER NOT NULL, /* ������ID */
	loanDate DATE, /* ������ */
	returnDate DATE, /* �ݳ������� */
	ownedBookId NUMBER, /* ���嵵��ID */
	statusId NUMBER, /* ���½ĺ���ȣ */
	userId NUMBER /* �̿���ID */
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

/* �÷��� */
CREATE TABLE COLLECTION (
	collectionId NUMBER NOT NULL, /* �÷��ǽĺ���ȣ */
	collectionTypeId NUMBER /* �÷��������ĺ���ȣ */
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

/* ī�װ� */
CREATE TABLE CATEGORY (
	categoryCode NUMBER NOT NULL, /* ī�װ��ڵ� */
	categoryName VARCHAR2(100) /* ī�װ��� */
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

/* �󼼺з� */
CREATE TABLE DETAILED_CLASSIFICATION (
	detailedClassificationId NUMBER NOT NULL, /* �󼼺з�ID */
	eventClassification VARCHAR2(100) /* ��籸��(�������α׷�,��ȭ���,����-ü��) */
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

/* ���� */
CREATE TABLE EMPLOYEE (
	employeeId NUMBER NOT NULL, /* ����ID */
	employeeName VARCHAR2(100), /* �̸� */
	employeeTel VARCHAR2(20), /* ����ó */
	employeeEmail VARCHAR2(100), /* �̸��� */
	employeePosition VARCHAR2(50), /* ���� */
	employeeDivision VARCHAR2(50) /* �μ� */
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

/* ����û��� */
CREATE TABLE EVENT_APPLICATION_RECORD (
	eventApplicationId NUMBER  NOT NULL, /* ����ûID */
	applicationDate DATE, /* ����û��¥ */
	approvalStatus VARCHAR2(50), /* �����λ��� */
	participantCount NUMBER, /* ��������ο��� */
	applicationMethod VARCHAR2(50), /* ����û���(��/����) */
	isCancelled CHAR(1), /* ����û��ҿ��� */
	isAttended CHAR(1), /* ����������� */
	eventId NUMBER, /* ���ID */
	userId NUMBER /* �̿���ID */
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

/* �󿵽ð� */
CREATE TABLE EVENT_SHOWTIME (
	showId NUMBER NOT NULL, /* ��ID */
	eventId NUMBER, /* ���ID */
	theater VARCHAR2(100), /* �󿵰� */
	seat VARCHAR2(50) /* �¼��� */
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

/* ������� */
CREATE TABLE EVENT_TYPE (
	eventTypeId NUMBER NOT NULL, /* �������ID */
	eventOnOff VARCHAR2(20) /* �������(�¶���/��������) */
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

/* ��� */
CREATE TABLE EVENT (
	eventId NUMBER NOT NULL, /* ���ID */
	eventName VARCHAR2(200), /* ���� */
	eventStart DATE, /* �������� */
	eventEnd DATE, /* ��������� */
	eventLocation VARCHAR2(255), /* �����ġ */
	maxCapacity NUMBER, /* �ִ����� */
	applicationStart DATE, /* ��û������ */
	applicationEnd DATE, /* ��û������ */
	lectureContent CLOB, /* ���ǳ��� */
	runningTime NUMBER, /* ����Ÿ�� */
	admissionFee NUMBER, /* ������ */
	eventCondition VARCHAR2(200), /* ������ */
	mainImage VARCHAR2(255), /* ��ǥ�̹��� */
	applicationType VARCHAR2(50), /* ������� */
	eventTypeId NUMBER, /* �������ID */
	detailedClassificationId NUMBER, /* �󼼺з�ID */
	employeeId NUMBER /* ����ID */
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

/* ����±� */
CREATE TABLE EVENT_TAG (
	eventTagId NUMBER NOT NULL, /* �±�_���ID */
	tagId NUMBER NOT NULL, /* �±�ID */
	eventId NUMBER NOT NULL /* ���ID */
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

/* �±� */
CREATE TABLE TAG (
	tagId NUMBER NOT NULL, /* �±�ID */
	tagName VARCHAR2(50) /* �±׸�(����,����,��ȭ..etc) */
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

/* �÷���_���� */
CREATE TABLE COLLECTION_BOOK (
	collectionBookId NUMBER NOT NULL, /* �÷���_����ID */
	collectionId NUMBER, /* �÷��ǽĺ���ȣ */
	ownedBookId NUMBER /* ���嵵��ID */
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

/* �̿��������� */
CREATE TABLE USER_EVENT_STATISTICS (
	eventStatisticsId NUMBER NOT NULL, /* ������ID */
	userId NUMBER, /* �̿���ID */
	eventId NUMBER /* ���ID */
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

/* �̿��ڰ������ */
CREATE TABLE TOUR_STATISTIC (
	tourStatId NUMBER NOT NULL, /* �������ID */
	tourId NUMBER, /* ����ID */
	userId NUMBER /* �̿���ID */
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

/* ���н�û */
CREATE TABLE TOUR_APPLICATION (
	tourId NUMBER NOT NULL, /* ����ID */
	participantCount NUMBER(3), /* �ο� */
	reservationDate DATE, /* ���೯¥ */
	tourStatus VARCHAR2(20), /* ������ҿ��� */
	tourTypeId NUMBER, /* ����ID */
	userId NUMBER /* �̿���ID */
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

/* �������� */
CREATE TABLE TOUR_TYPE (
	tourTypeId NUMBER NOT NULL, /* ����ID */
	tourName VARCHAR2(200), /* ���и� */
	tourOrder NUMBER(3), /* ���м��� */
	routeName VARCHAR2(100), /* ��Ҹ� */
	routeDesc CLOB, /* ��Ҽ��� */
	minParticipant NUMBER(3), /* �ּ��ο� */
	maxParticipant NUMBER(3) /* �ִ��ο� */
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

/* �������ͳ� */
CREATE TABLE WIFI (
	wifiId NUMBER NOT NULL, /* ��������ID */
	wifiServiceArea VARCHAR2(255), /* ���� ���� */
	wifiUsageGuide CLOB, /* �̿��� */
	wifiPhoneNumber VARCHAR2(20), /* ������ȭ */
	wifiRegDate DATE, /* ������� */
	amenityId NUMBER /* ���ǽü� ID */
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

/* ���ǽü� */
CREATE TABLE AMENITY (
	amenityId NUMBER NOT NULL, /* ���ǽü� ID */
	amenityName VARCHAR2(100), /* ���ǽü���(��ī��,������...) */
	amenityLocation VARCHAR2(255) /* ��ġ */
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

/* �̿�ð� */
CREATE TABLE OPERATING_HOUR (
	hourId NUMBER NOT NULL, /* �̿�ð�ID */
	holidayInfo VARCHAR2(255), /* ���� */
	openTime TIMESTAMP, /* ���۽ð� */
	closeTime TIMESTAMP, /* ����ð� */
	contactNumber VARCHAR2(20), /* ������ȭ */
	isClosed CHAR(1), /* �������� */
	amenityId NUMBER /* ���ǽü� ID */
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

/* �Ĵ� */
CREATE TABLE MEAL_PLAN (
	mealPlanId NUMBER NOT NULL, /* �Ĵ�ID */
	menuDate DATE, /* �������� */
	menuContent CLOB, /* �޴� */
	sRegDate DATE, /* ������� */
	hourId NUMBER /* �̿�ð�ID */
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

/* �޴� */
CREATE TABLE MEAL_ASSIGNMENT (
	menuId NUMBER NOT NULL, /* �޴�ID */
	mealPlanId NUMBER, /* �Ĵ�ID */
	mealTypeId NUMBER /* �Ļ�ID */
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

/* �Ļ����� */
CREATE TABLE MEAL_TYPE (
	mealTypeId NUMBER NOT NULL, /* �Ļ�ID */
	mealTypeName VARCHAR2(50) /* �Ļ�����(����,����) */
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

/* �Խù� */
CREATE TABLE POST (
	postId NUMBER NOT NULL, /* �Խù���ȣ */
	postThumbnailUrl VARCHAR(255), /* �����(�Խù��ڵ忡 ���� null����) */
	postTitle VARCHAR(200), /* �Խù����� */
	postContent CLOB, /* �Խù����� */
	postCreateDate DATE, /* ����� */
	postViewCount NUMBER, /* ��ȸ�� */
	postApplicationPeriod VARCHAR(100), /* �����Ⱓ(�Խù��ڵ忡 ���� null����) */
	postSchedule VARCHAR(100), /* ����(�Խù��ڵ忡 ���� null����) */
	postLocation VARCHAR(100), /* ���(�Խù��ڵ忡 ���� null����) */
	postTypeCode NUMBER, /* �Խù������ڵ� */
	postAttachmentId NUMBER, /* ÷�����Ϲ�ȣ */
	employeeId NUMBER /* ����ID */
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

/* �Խù� ���� */
CREATE TABLE POST_TYPE (
	postTypeCode NUMBER NOT NULL, /* �Խù������ڵ� */
	postTypeName VARCHAR(100) /* �Խù������̸� */
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

/* ÷������ */
CREATE TABLE ATTACHMENT (
	postAttachmentId NUMBER NOT NULL, /* ÷�����Ϲ�ȣ */
	postAttachmentPath VARCHAR(255), /* ÷�����ϰ�� */
	postAttachmentName VARCHAR(200), /* ÷�����ϸ� */
	postAttachmentType VARCHAR(50) /* ÷���������� */
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

/* ������ */
CREATE TABLE KEYWORDS (
	keywordId NUMBER NOT NULL, /* ������_ID */
	inputKeyword VARCHAR2(200), /* �Է������� */
	integratedKeyword VARCHAR2(200), /* ���������� */
	relatedTerm VARCHAR2(200), /* ������ */
	relatedEng VARCHAR2(200), /* ���迵���� */
	relatedCode VARCHAR2(50), /* �����ڵ� */
	searchButton CHAR(1) /* �˻���ư���� */
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

/* �˻����� */
CREATE TABLE SEARCH_CONDITION (
	conditionId NUMBER NOT NULL, /* ����_ID */
	searchField VARCHAR2(100), /* �˻��ʵ�� */
	operator VARCHAR2(20), /* ������ */
	searchWord VARCHAR2(500), /* �˻��� */
	createAt DATE, /* �����Ͻ� */
	searchId NUMBER /* �˻�����_ID */
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

/* �˻����� */
CREATE TABLE SEARCH_SESSION (
	searchId NUMBER NOT NULL, /* �˻�����_ID */
	searchType VARCHAR2(50), /* �˻����� */
	searchDate DATE, /* �˻��Ͻ� */
	userId NUMBER /* �̿���ID */
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

/* ����_���� */
CREATE TABLE BOOK_AUTHOR (
	bookAuthorId NUMBER NOT NULL, /* ����_����ID */
	roleCode VARCHAR2(20), /* �����ڵ�(����,������,����) */
	authorId NUMBER, /* ����_ID */
	bookInfoId NUMBER /* ��������ID */
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

/* �ڷ�_������ */
CREATE TABLE MATERIAL_KEYWORDS (
	dataKeywordId NUMBER NOT NULL, /* �ڷ�_������_ID */
	materialId NUMBER, /* �ڷ�_ID */
	keywordId NUMBER /* ������_ID */
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

/* �����ڷ� */
CREATE TABLE MATERIAL (
	materialId NUMBER NOT NULL, /* �ڷ�_ID */
	title VARCHAR2(500), /* ���� */
	subTitle VARCHAR2(500), /* ������ */
	keyword VARCHAR2(500), /* Ű���� */
	publishYear NUMBER, /* ����⵵ */
	url VARCHAR2(1000), /* URL */
	stdCodeType VARCHAR2(50), /* ǥ�غ�ȣ�ڵ� */
	stdCodeValue VARCHAR2(100), /* ǥ�غ�ȣ�� */
	classSchemeCode VARCHAR2(50), /* �з�ü���ڵ� */
	classSymbolValue VARCHAR2(100), /* �з���ȣ�� */
	callNo VARCHAR2(100), /* û����ȣ */
	mainLangCode VARCHAR2(20), /* ��������ڵ� */
	summaryLangCode VARCHAR2(20), /* ������ڵ� */
	frequencyCode VARCHAR2(20), /* ������ڵ� */
	editionCode VARCHAR2(20), /* ���������ڵ� */
	usageCode VARCHAR2(20), /* �ڷ��̿��ڵ� */
	regDate DATE, /* ����Ͻ� */
	updateDate DATE, /* �����Ͻ� */
	summary CLOB, /* ��� */
	publisherId NUMBER, /* ������_ID */
	bookInfoId NUMBER /* ��������ID */
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

/* ���������� */
CREATE TABLE PUBLISHER (
	publisherId NUMBER NOT NULL, /* ������_ID */
	name VARCHAR2(200), /* �̸� */
	countryCode VARCHAR2(20), /* �����ڵ� */
	cityCode VARCHAR2(20) /* �����ڵ� */
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

/* �������� */
CREATE TABLE HOLDING_INFO (
	materialId NUMBER NOT NULL, /* �ڷ�_ID */
	location VARCHAR2(100), /* �ڷ��̿���� */
	callNo VARCHAR2(100), /* û����ȣ */
	status VARCHAR2(50), /* �ڷ���� */
	regNo VARCHAR2(100), /* ��Ϲ�ȣ */
	isElectronic CHAR(1), /* �����ڷῩ�� */
	edition VARCHAR2(50), /* ������ */
	partNo VARCHAR2(50) /* ����� */
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

/* �����ڵ�_�׷� */
CREATE TABLE CODE_GROUP (
	groupId NUMBER NOT NULL, /* �׷�_ID */
	groupName VARCHAR2(100) /* �׷�� */
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

/* �����ڵ�_�ڵ� */
CREATE TABLE CODE_VALUE (
	codeId NUMBER NOT NULL, /* �ڵ�_ID */
	code VARCHAR2(50), /* �ڵ� */
	codeName VARCHAR2(200), /* �ڵ�� */
	parentCodeId NUMBER, /* �����ڵ�_ID */
	groupId NUMBER /* �׷�_ID */
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

/* ���� */
CREATE TABLE AUTHOR (
	authorId NUMBER NOT NULL, /* ����_ID */
	authorName VARCHAR2(100), /* �̸� */
	insi VARCHAR2(50), /* INSI */
	nationalityCode VARCHAR2(20), /* �����ڵ� */
	birthYear NUMBER, /* ����⵵ */
	deathYear NUMBER, /* ����⵵ */
	gender VARCHAR2(10) /* �����ڵ� */
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
