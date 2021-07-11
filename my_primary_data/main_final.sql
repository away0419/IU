DROP TABLE EMP CASCADE CONSTRAINTS ;
DROP TABLE BOOKING CASCADE CONSTRAINTS ;
DROP TABLE BOTARGET CASCADE  CONSTRAINTS ;
DROP TABLE BOFOL CASCADE CONSTRAINTS ;
DROP TABLE CALENDAR CASCADE CONSTRAINTS ;
DROP TABLE SCTHEME CASCADE CONSTRAINTS ;
DROP TABLE SCFOLDER CASCADE CONSTRAINTS ;
DROP TABLE OFBOARDCOM CASCADE CONSTRAINTS ;
DROP TABLE OFBOARD CASCADE CONSTRAINTS ;
DROP TABLE OFOARDFOL CASCADE CONSTRAINTS ;
DROP TABLE OFBOARDFILE CASCADE CONSTRAINTS ;
DROP TABLE OFBOARDLIKE CASCADE CONSTRAINTS ;
DROP TABLE ATTENDDAY CASCADE CONSTRAINTS ;
DROP TABLE ATTEND CASCADE CONSTRAINTS ;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS ;
DROP TABLE POSITION CASCADE CONSTRAINTS ;
DROP TABLE RELINE CASCADE CONSTRAINTS ;
DROP TABLE ELFILE CASCADE CONSTRAINTS ;
DROP TABLE DOCFOL CASCADE CONSTRAINTS ;
DROP TABLE DOCSTY CASCADE CONSTRAINTS ;
DROP TABLE ELIMP CASCADE CONSTRAINTS ;
DROP TABLE APPLINE CASCADE CONSTRAINTS ;
DROP TABLE APPSTAMP CASCADE CONSTRAINTS ;
DROP TABLE ADDFOL CASCADE CONSTRAINTS ;
DROP TABLE ADDBOOK CASCADE CONSTRAINTS ;
DROP TABLE MAIL CASCADE CONSTRAINTS ;
DROP TABLE MAILFILE CASCADE CONSTRAINTS ;

/* 사용자 */
CREATE TABLE EMP (
	EMP_NO NUMBER NOT NULL, /* 사원 번호 */
	EMP_NAME VARCHAR2(255), /* 사원 이름 */
	EMP_PWD VARCHAR2(255), /* 비밀번호 */
	EMP_TEL VARCHAR2(255), /* 전화번호 */
	EMP_EMAIL VARCHAR2(255), /* 이메일 */
	EMP_ZIPCODE VARcHAR2(255), /* 우편번호 */
	EMP_ADDRESS VARCHAR2(255), /* 주소 */
	EMP_ADDRESSDETAIL VARCHAR2(255), /* 상세주소 */
	EMP_REGDATE DATE, /* 입사일 */
	EMP_RESDATE DATE, /* 퇴사일 */
	EMP_PHOTO VARCHAR2(255), /* 사원사진 */
	EMP_SALARY NUMBER, /* 봉급 */
	EMP_ACCOUNT VARCHAR2(255), /* 계좌 */
	EMP_ADMIN_LEV NUMBER, /* 관리자 레벨번호 */
	EMP_BIRTH DATE, /* 생일 */
	MAIL_NO NUMBER, /* 메일 번호 */
	DEPARTMENT_NO NUMBER, /* 부서번호 */
	POSITION_NO NUMBER /* 직급 번호 */
);

CREATE UNIQUE INDEX PK_EMP
	ON EMP (
		EMP_NO ASC
	);

ALTER TABLE EMP
	ADD
		CONSTRAINT PK_EMP
		PRIMARY KEY (
			EMP_NO
		);

/* 전자결재정보 */
CREATE TABLE ELIMP (
	ELECTRONIC_NO NUMBER NOT NULL, /* 문서번호 */
	ELECTRONIC_DATE DATE DEFAULT SYSDATE, /* 기안일자 */
	ELECTRONIC_TITLE VARCHAR2(255) NOT NULL, /* 기안제목 */
	ELECTRONIC_CONTENT CLOB NOT NULL, /* 기안내용 */
	ELECTRONIC_FILE_FLAG VARCHAR2(255), /* 첨부파일여부 */
	ELECTRONIC_COMPLET_FLAG VARCHAR2(255) DEFAULT '0', /* 완료여부 */
	ELECTRONIC_EMERGENCY_FLAG VARCHAR2(255) DEFAULT '0', /* 긴급 여부 */
	EMP_NO NUMBER, /* 기안자 */
	STYLE_NO NUMBER /* 양식번호 */
);

CREATE UNIQUE INDEX PK_ELIMP
	ON ELIMP (
		ELECTRONIC_NO ASC
	);

ALTER TABLE ELIMP
	ADD
		CONSTRAINT PK_ELIMP
		PRIMARY KEY (
			ELECTRONIC_NO
		);

/* 메일 */
CREATE TABLE MAIL (
	MAIL_NO NUMBER NOT NULL, /* 메일 번호 */
	MAIL_TITLE VARCHAR2(255) NOT NULL, /* 제목 */
	MAIL_CONTENT CLOB NOT NULL, /* 내용 */
	MAIL_SEND VARCHAR2(255) NOT NULL, /* 보낸사람 */
	MAIL_TAKE VARCHAR2(255) NOT NULL, /* 받는사람 */
	MAIL_SENDDATE DATE DEFAULT SYSDATE, /* 보낸 날짜 */
	MAIL_READDATE DATE, /* 읽은 날짜 */
	MAIL_RESERVE DATE, /* 예약 날짜 */
	MAIL_DEL_CHECK VARCHAR2(255) DEFAULT 0 /* 삭제 여부 */
);

CREATE UNIQUE INDEX PK_MAIL
	ON MAIL (
		MAIL_NO ASC
	);

ALTER TABLE MAIL
	ADD
		CONSTRAINT PK_MAIL
		PRIMARY KEY (
			MAIL_NO
		);

/* 근태 */
CREATE TABLE ATTEND (
	ATTENDANCE_NO NUMBER NOT NULL, /* 근태 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	ATTENDANCE_ANNUAL_COUNT NUMBER DEFAULT 21, /* 연차 갯수 */
	ATTENDANCE_ANNUAL_USE NUMBER DEFAULT 0, /* 연차 사용일 */
	ATTENDANCE_LATE_COUNT NUMBER DEFAULT 0 /* 지각 일수 */
);

CREATE UNIQUE INDEX PK_ATTEND
	ON ATTEND (
		ATTENDANCE_NO ASC
	);

ALTER TABLE ATTEND
	ADD
		CONSTRAINT PK_ATTEND
		PRIMARY KEY (
			ATTENDANCE_NO
		);

/* 게시판 */
CREATE TABLE OFBOARD (
	BOARD_NO NUMBER NOT NULL, /* 게시판 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	BOARD_TITLE VARCHAR2(255) NOT NULL, /* 제목 */
	BOARD_CONTENT CLOB, /* 내용 */
	BOARD_WRITER VARCHAR2(255) NOT NULL, /* 글쓴이 */
	BOARD_HITS NUMBER, /* 조회수 */
	BOARD_DATE DATE DEFAULT SYSDATE, /* 작성일 */
	BOARD_DEL_FLAG VARCHAR2(255) DEFAULT 0, /* 삭제 여부 */
	BOARD_THEME NUMBER, /* 글 분류 */
	BOARD_FOLDER_NO NUMBER /* 게시판 폴더 번호 */
);

CREATE UNIQUE INDEX PK_OFBOARD
	ON OFBOARD (
		BOARD_NO ASC
	);

ALTER TABLE OFBOARD
	ADD
		CONSTRAINT PK_OFBOARD
		PRIMARY KEY (
			BOARD_NO
		);

/* 예약 */
CREATE TABLE BOOKING (
	BOOKING_NO NUMBER NOT NULL, /* 예약 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	BOOKING_CURRENT DATE DEFAULT SYSDATE, /* 신청 시간 */
	BOOKING_START VARCHAR2(255), /* 예약 시간 */
	BOOKING_END VARCHAR2(255), /* 예약 종료 시간 */
	BOOKING_APP_FLAG VARCHAR2(255) DEFAULT '0', /* 승인 여부 */
	BOOKING_DEL_FLAG VARCHAR2(255) DEFAULT '0', /* 취소 여부 */
	BOOKING_TARGET_NO NUMBER, /* 예약 대상 번호 */
	BOOKING_CONTENT CLOB /* 예약 내용 */
);

CREATE UNIQUE INDEX PK_BOOKING
	ON BOOKING (
		BOOKING_NO ASC
	);

ALTER TABLE BOOKING
	ADD
		CONSTRAINT PK_BOOKING
		PRIMARY KEY (
			BOOKING_NO
		);

/* 결제라인 */
CREATE TABLE APPLINE (
	APPROVAL_LINE_NO NUMBER NOT NULL, /* 결제라인번호 */
	ELECTRONIC_NO NUMBER, /* 문서번호 */
	EMP_NO NUMBER, /* 결제자 */
	APPROVAL_LINE_COMPLETE_FLAG VARCHAR2(255) DEFAULT '0', /* 대기예정승인여부 */
	APPROVAL_LINE_ORDER NUMBER DEFAULT 0 /* 결재순서 */
);

CREATE UNIQUE INDEX PK_APPLINE
	ON APPLINE (
		APPROVAL_LINE_NO ASC
	);

ALTER TABLE APPLINE
	ADD
		CONSTRAINT PK_APPLINE
		PRIMARY KEY (
			APPROVAL_LINE_NO
		);

/* 파일 */
CREATE TABLE ELFILE (
	FILE_NO NUMBER NOT NULL, /* 파일번호 */
	FILE_NAME VARCHAR2(255) NOT NULL, /* 파일이름 */
	FILE_ORIGINALNAME VARCHAR2(255) NOT NULL, /* 원래파일이름 */
	FILE_SIZE NUMBER NOT NULL, /* 파일용량 */
	ELECTRONIC_NO NUMBER /* 문서번호 */
);

CREATE UNIQUE INDEX PK_ELFILE
	ON ELFILE (
		FILE_NO ASC
	);

ALTER TABLE ELFILE
	ADD
		CONSTRAINT PK_ELFILE
		PRIMARY KEY (
			FILE_NO
		);

/* 문서양식 */
CREATE TABLE DOCSTY (
	STYLE_NO NUMBER NOT NULL, /* 양식번호 */
	STYLE_NAME VARCHAR2(255) NOT NULL, /* 양식이름 */
	FOLDER_NO NUMBER /* 문서 폴더 번호 */
);

CREATE UNIQUE INDEX PK_DOCSTY
	ON DOCSTY (
		STYLE_NO ASC
	);

ALTER TABLE DOCSTY
	ADD
		CONSTRAINT PK_DOCSTY
		PRIMARY KEY (
			STYLE_NO
		);

/* 결제도장등록 */
CREATE TABLE APPSTAMP (
	STAMP_NO NUMBER NOT NULL, /* 도장번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	STAMP_NAME VARCHAR2(255) NOT NULL /* 파일이름 */
);

CREATE UNIQUE INDEX PK_APPSTAMP
	ON APPSTAMP (
		STAMP_NO ASC
	);

ALTER TABLE APPSTAMP
	ADD
		CONSTRAINT PK_APPSTAMP
		PRIMARY KEY (
			STAMP_NO
		);

/* 부서 */
CREATE TABLE DEPARTMENT (
	DEPARTMENT_NO NUMBER NOT NULL, /* 부서번호 */
	DEPARTMENT_NAME VARCHAR2(255) NOT NULL /* 부서이름 */
);

CREATE UNIQUE INDEX PK_DEPARTMENT
	ON DEPARTMENT (
		DEPARTMENT_NO ASC
	);

ALTER TABLE DEPARTMENT
	ADD
		CONSTRAINT PK_DEPARTMENT
		PRIMARY KEY (
			DEPARTMENT_NO
		);

/* 직급 */
CREATE TABLE POSITION (
	POSITION_NO NUMBER NOT NULL, /* 직급 번호 */
	POSITION_NAME VARCHAR2(255) NOT NULL /* 직급 이름 */
);

CREATE UNIQUE INDEX PK_POSITION
	ON POSITION (
		POSITION_NO ASC
	);

ALTER TABLE POSITION
	ADD
		CONSTRAINT PK_POSITION
		PRIMARY KEY (
			POSITION_NO
		);

/* 메일 첨부파일 */
CREATE TABLE MAILFILE (
	FILENO NUMBER NOT NULL, /* 파일번호 */
	MAIL_NO NUMBER, /* 메일 번호 */
	FILENAME VARCHAR2(255) NOT NULL, /* 파일이름 */
	FILEORIGINNAME VARCHAR2(255) NOT NULL, /* 원래파일이름 */
	FILESIZE NUMBER NOT NULL /* 파일용량 */
);

CREATE UNIQUE INDEX PK_MAILFILE
	ON MAILFILE (
		FILENO ASC
	);

ALTER TABLE MAILFILE
	ADD
		CONSTRAINT PK_MAILFILE
		PRIMARY KEY (
			FILENO
		);

/* 날짜별 근태 정보 */
CREATE TABLE ATTENDDAY (
	ATTENDANCE_DAY_NO NUMBER NOT NULL, /* 날짜 근태 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	ATTENDANCE_DAY_ON_HOUR DATE, /* 출근 시간 */
	ATTENDANCE_DAY_OFF_HOUR DATE, /* 퇴근 시간 */
	ATTENDANCE_DAY_WORK_HOUR DATE, /* 근무 시간 */
	ATTENDANCE_DAY_HOLIDAY_FLAG VARCHAR2(255) DEFAULT 0 /* 휴일 여부 */
);

CREATE UNIQUE INDEX PK_ATTENDDAY
	ON ATTENDDAY (
		ATTENDANCE_DAY_NO ASC
	);

ALTER TABLE ATTENDDAY
	ADD
		CONSTRAINT PK_ATTENDDAY
		PRIMARY KEY (
			ATTENDANCE_DAY_NO
		);

/* 게시판 첨부파일 */
CREATE TABLE OFBOARDFILE (
	BOARD_FILE_NO NUMBER NOT NULL, /* 파일번호 */
	BOARD_NO NUMBER, /* 게시판 번호 */
	BOARD_FILE_NAME VARCHAR2(255) NOT NULL, /* 파일이름 */
	BOARD_FILE_ORIGINALNAME VARCHAR2(255) NOT NULL, /* 원래파일이름 */
	BOARD_FILE_SIZE NUMBER NOT NULL /* 파일용량 */
);

CREATE UNIQUE INDEX PK_OFBOARDFILE
	ON OFBOARDFILE (
		BOARD_FILE_NO ASC
	);

ALTER TABLE OFBOARDFILE
	ADD
		CONSTRAINT PK_OFBOARDFILE
		PRIMARY KEY (
			BOARD_FILE_NO
		);

/* 게시판 댓글 */
CREATE TABLE OFBOARDCOM (
	BOARD_COMMENT_NO NUMBER NOT NULL, /* 댓글 번호 */
	BOARD_NO NUMBER, /* 게시판 번호 */
	BOARD_COMMENT_CONTENT VARCHAR2(255) NOT NULL, /* 내용 */
	BOARD_COMMENT_WRITER VARCHAR2(255) NOT NULL, /* 글쓴이 */
	BOARD_COMMENT_DATE DATE DEFAULT SYSDATE, /* 작성일 */
	BOARD_COMMENT_DEL_FLAG VARCHAR2(255) DEFAULT '0', /* 삭제 여부 */
	BOARD_COMMENT_GROUP_NO NUMBER /* 그룹 번호 */
);

CREATE UNIQUE INDEX PK_OFBOARDCOM
	ON OFBOARDCOM (
		BOARD_COMMENT_NO ASC
	);

ALTER TABLE OFBOARDCOM
	ADD
		CONSTRAINT PK_OFBOARDCOM
		PRIMARY KEY (
			BOARD_COMMENT_NO
		);

/* 좋아요 */
CREATE TABLE OFBOARDLIKE (
	BOARD_NO NUMBER, /* 게시판 번호 */
	EMP_NO NUMBER /* 사원 번호 */
);

/* 주소록 정보 */
CREATE TABLE ADDBOOK (
	ADDRESSBOOK_NO NUMBER NOT NULL, /* 주소록 정보 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	ADDRESSBOOK_NAME VARCHAR2(255) NOT NULL, /* 이름 */
	ADDRESSBOOK_TEL VARCHAR2(255) NOT NULL, /* 전화번호 */
	ADDRESSBOOK_MAILE VARCHAR2(255), /* 이메일 */
	ADDRESSBOOK_POSITION VARCHAR2(255), /* 직급 */
	ADDRESS_FOLDER_NO NUMBER /* 주소록 폴더 번호 */
);

CREATE UNIQUE INDEX ADDRESSBOOK
	ON ADDBOOK (
		ADDRESSBOOK_NO ASC
	);

ALTER TABLE ADDBOOK
	ADD
		CONSTRAINT ADDRESSBOOK
		PRIMARY KEY (
			ADDRESSBOOK_NO
		);

/* 달력 */
CREATE TABLE CALENDAR (
	SCHEDULE_NO NUMBER NOT NULL, /* 달력 번호 */
	SCHEDULE_TITLE VARCHAR2(255) NOT NULL, /* 달력 제목 */
	SCHEDULE_START VARCHAR2(255), /* 달력 시작날짜 */
	SCHEDULE_END VARCHAR2(255), /* 달력 종료날짜 */
	SCHEDULE_ALLDAY VARCHAR2(255), /* 달력 종일 여부 */
	SCHEDULE_COLOR VARCHAR2(255), /* 달력 색 */
	SCHEDULE_FOLDER_NO NUMBER DEFAULT 0, /* 예약 폴더 번호 */
	SCHEDULE_THEME_NO NUMBER, /* 스케줄 구분 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	BOOKING_TARGET_NO NUMBER DEFAULT 0, /* 예약 대상 번호 */
	SCHEDULE_CONTENT CLOB /* 달력 내용 */
);

CREATE UNIQUE INDEX PK_CALENDAR
	ON CALENDAR (
		SCHEDULE_NO ASC
	);

ALTER TABLE CALENDAR
	ADD
		CONSTRAINT PK_CALENDAR
		PRIMARY KEY (
			SCHEDULE_NO
		);

/* 주소록 폴더 */
CREATE TABLE ADDFOL (
	ADDRESS_FOLDER_NO NUMBER NOT NULL, /* 주소록 폴더 번호 */
	EMP_NO NUMBER, /* 사원 번호 */
	ADDRESS_FOLDER_NAME VARCHAR2(255) /* 폴더 이름 */
);

CREATE UNIQUE INDEX PK_ADDFOL
	ON ADDFOL (
		ADDRESS_FOLDER_NO ASC
	);

ALTER TABLE ADDFOL
	ADD
		CONSTRAINT PK_ADDFOL
		PRIMARY KEY (
			ADDRESS_FOLDER_NO
		);

/* 일정 폴더 */
CREATE TABLE SCFOLDER (
	SCHEDULE_FOLDER_NO NUMBER NOT NULL, /* 일정 폴더 번호 */
	SCHEDULE_FOLDER_NAME VARCHAR2(255), /* 일정 폴더 이름 */
	SCHEDULE_FOLDER_COLOR VARCHAR2(255), /* 색 */
	EMP_NO NUMBER /* 사원 번호 */
);

CREATE UNIQUE INDEX PK_SCFOLDER
	ON SCFOLDER (
		SCHEDULE_FOLDER_NO ASC
	);

ALTER TABLE SCFOLDER
	ADD
		CONSTRAINT PK_SCFOLDER
		PRIMARY KEY (
			SCHEDULE_FOLDER_NO
		);

/* 스케줄 구분 */
CREATE TABLE SCTHEME (
	SCHEDULE_THEME_NO NUMBER NOT NULL, /* 구분 번호 */
	SCHEDULE_THEME_NAME VARCHAR2(255) /* 구분 이름 */
);

CREATE UNIQUE INDEX PK_SCTHEME
	ON SCTHEME (
		SCHEDULE_THEME_NO ASC
	);

ALTER TABLE SCTHEME
	ADD
		CONSTRAINT PK_SCTHEME
		PRIMARY KEY (
			SCHEDULE_THEME_NO
		);

/* 예약 폴더 */
CREATE TABLE BOFOL (
	BOOKING_FOLDER_NO NUMBER NOT NULL, /* 예약 폴더 번호 */
	BOOKING_FOLDER_NAME VARCHAR2(255) /* 예약 폴더 이름 */
);

CREATE UNIQUE INDEX PK_BOFOL
	ON BOFOL (
		BOOKING_FOLDER_NO ASC
	);

ALTER TABLE BOFOL
	ADD
		CONSTRAINT PK_BOFOL
		PRIMARY KEY (
			BOOKING_FOLDER_NO
		);

/* 게시판 폴더 */
CREATE TABLE OFOARDFOL (
	BOARD_FOLDER_NO NUMBER NOT NULL, /* 게시판 폴더 번호 */
	BOARD_FOLDER__NAME VARCHAR2(255) /* 게시판 폴더 이름 */
);

CREATE UNIQUE INDEX PK_OFOARDFOL
	ON OFOARDFOL (
		BOARD_FOLDER_NO ASC
	);

ALTER TABLE OFOARDFOL
	ADD
		CONSTRAINT PK_OFOARDFOL
		PRIMARY KEY (
			BOARD_FOLDER_NO
		);

/* 예약 대상 */
CREATE TABLE BOTARGET (
	BOOKING_TARGET_NO NUMBER NOT NULL, /* 예약 대상 번호 */
	BOOKING_TARGET_NAME VARCHAR2(255), /* 예약 대상 이름 */
	BOOKING_FOLDER_NO NUMBER /* 예약 폴더 번호 */
);

CREATE UNIQUE INDEX PK_BOTARGET
	ON BOTARGET (
		BOOKING_TARGET_NO ASC
	);

ALTER TABLE BOTARGET
	ADD
		CONSTRAINT PK_BOTARGET
		PRIMARY KEY (
			BOOKING_TARGET_NO
		);

/* 문서폴더 */
CREATE TABLE DOCFOL (
	FOLDER_NO NUMBER NOT NULL, /* 문서 폴더 번호 */
	FOLDER_NAME VARCHAR(255) DEFAULT '기본' /* 문서 폴더 이름 */
);

CREATE UNIQUE INDEX PK_DOCFOL
	ON DOCFOL (
		FOLDER_NO ASC
	);

ALTER TABLE DOCFOL
	ADD
		CONSTRAINT PK_DOCFOL
		PRIMARY KEY (
			FOLDER_NO
		);

/* 수신라인 */
CREATE TABLE RELINE (
	RECEIVE_LINE_NO NUMBER NOT NULL, /* 수신라인번호 */
	ELECTRONIC_NO NUMBER, /* 문서번호 */
	EMP_NO NUMBER, /* 수신자 */
	RECEIVE_LINE_FLAG VARCHAR2(255) DEFAULT '0' /* 수신확인여부 */
);

CREATE UNIQUE INDEX PK_RELINE
	ON RELINE (
		RECEIVE_LINE_NO ASC
	);

ALTER TABLE RELINE
	ADD
		CONSTRAINT PK_RELINE
		PRIMARY KEY (
			RECEIVE_LINE_NO
		);

ALTER TABLE EMP
	ADD
		CONSTRAINT FK_MAIL_TO_EMP
		FOREIGN KEY (
			MAIL_NO
		)
		REFERENCES MAIL (
			MAIL_NO
		);

ALTER TABLE EMP
	ADD
		CONSTRAINT FK_DEPARTMENT_TO_EMP
		FOREIGN KEY (
			DEPARTMENT_NO
		)
		REFERENCES DEPARTMENT (
			DEPARTMENT_NO
		);

ALTER TABLE EMP
	ADD
		CONSTRAINT FK_POSITION_TO_EMP
		FOREIGN KEY (
			POSITION_NO
		)
		REFERENCES POSITION (
			POSITION_NO
		);

ALTER TABLE ELIMP
	ADD
		CONSTRAINT FK_EMP_TO_ELIMP
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE ELIMP
	ADD
		CONSTRAINT FK_DOCSTY_TO_ELIMP
		FOREIGN KEY (
			STYLE_NO
		)
		REFERENCES DOCSTY (
			STYLE_NO
		);

ALTER TABLE ATTEND
	ADD
		CONSTRAINT FK_EMP_TO_ATTEND
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE OFBOARD
	ADD
		CONSTRAINT FK_EMP_TO_OFBOARD
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE OFBOARD
	ADD
		CONSTRAINT FK_OFOARDFOL_TO_OFBOARD
		FOREIGN KEY (
			BOARD_FOLDER_NO
		)
		REFERENCES OFOARDFOL (
			BOARD_FOLDER_NO
		);

ALTER TABLE BOOKING
	ADD
		CONSTRAINT FK_EMP_TO_BOOKING
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE BOOKING
	ADD
		CONSTRAINT FK_BOTARGET_TO_BOOKING
		FOREIGN KEY (
			BOOKING_TARGET_NO
		)
		REFERENCES BOTARGET (
			BOOKING_TARGET_NO
		);

ALTER TABLE APPLINE
	ADD
		CONSTRAINT FK_EMP_TO_APPLINE
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE APPLINE
	ADD
		CONSTRAINT FK_ELIMP_TO_APPLINE
		FOREIGN KEY (
			ELECTRONIC_NO
		)
		REFERENCES ELIMP (
			ELECTRONIC_NO
		);

ALTER TABLE ELFILE
	ADD
		CONSTRAINT FK_ELIMP_TO_ELFILE
		FOREIGN KEY (
			ELECTRONIC_NO
		)
		REFERENCES ELIMP (
			ELECTRONIC_NO
		);

ALTER TABLE DOCSTY
	ADD
		CONSTRAINT FK_DOCFOL_TO_DOCSTY
		FOREIGN KEY (
			FOLDER_NO
		)
		REFERENCES DOCFOL (
			FOLDER_NO
		);

ALTER TABLE APPSTAMP
	ADD
		CONSTRAINT FK_EMP_TO_APPSTAMP
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE MAILFILE
	ADD
		CONSTRAINT FK_MAIL_TO_MAILFILE
		FOREIGN KEY (
			MAIL_NO
		)
		REFERENCES MAIL (
			MAIL_NO
		);

ALTER TABLE ATTENDDAY
	ADD
		CONSTRAINT FK_EMP_TO_ATTENDDAY
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE OFBOARDFILE
	ADD
		CONSTRAINT FK_OFBOARD_TO_OFBOARDFILE
		FOREIGN KEY (
			BOARD_NO
		)
		REFERENCES OFBOARD (
			BOARD_NO
		);

ALTER TABLE OFBOARDCOM
	ADD
		CONSTRAINT FK_OFBOARD_TO_OFBOARDCOM
		FOREIGN KEY (
			BOARD_NO
		)
		REFERENCES OFBOARD (
			BOARD_NO
		);

ALTER TABLE OFBOARDLIKE
	ADD
		CONSTRAINT FK_OFBOARD_TO_OFBOARDLIKE
		FOREIGN KEY (
			BOARD_NO
		)
		REFERENCES OFBOARD (
			BOARD_NO
		);

ALTER TABLE OFBOARDLIKE
	ADD
		CONSTRAINT FK_EMP_TO_OFBOARDLIKE
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE ADDBOOK
	ADD
		CONSTRAINT FK_EMP_TO_ADDBOOK
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE CALENDAR
	ADD
		CONSTRAINT FK_EMP_TO_CALENDAR
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE CALENDAR
	ADD
		CONSTRAINT FK_SCTHEME_TO_CALENDAR
		FOREIGN KEY (
			SCHEDULE_THEME_NO
		)
		REFERENCES SCTHEME (
			SCHEDULE_THEME_NO
		);

ALTER TABLE ADDFOL
	ADD
		CONSTRAINT FK_EMP_TO_ADDFOL
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE SCFOLDER
	ADD
		CONSTRAINT FK_EMP_TO_SCFOLDER
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);

ALTER TABLE BOTARGET
	ADD
		CONSTRAINT FK_BOFOL_TO_BOTARGET
		FOREIGN KEY (
			BOOKING_FOLDER_NO
		)
		REFERENCES BOFOL (
			BOOKING_FOLDER_NO
		);

ALTER TABLE RELINE
	ADD
		CONSTRAINT FK_ELIMP_TO_RELINE
		FOREIGN KEY (
			ELECTRONIC_NO
		)
		REFERENCES ELIMP (
			ELECTRONIC_NO
		);

ALTER TABLE RELINE
	ADD
		CONSTRAINT FK_EMP_TO_RELINE
		FOREIGN KEY (
			EMP_NO
		)
		REFERENCES EMP (
			EMP_NO
		);