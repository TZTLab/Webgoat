-- This statement is here the schema is always created even if we use Flyway directly like in test-cases
-- For the normal WebGoat server there is a bean which already provided the schema (and creates it see DatabaseInitialization)
CREATE SCHEMA IF NOT EXISTS CONTAINER;

CREATE SEQUENCE CONTAINER.HIBERNATE_SEQUENCE;

CREATE TABLE CONTAINER.ASSIGNMENT (
  ID BIGINT NOT NULL PRIMARY KEY,
  NAME VARCHAR(255),
  PATH VARCHAR(255)
);

CREATE TABLE CONTAINER.LESSON_TRACKER(
  ID BIGINT NOT NULL PRIMARY KEY,
  LESSON_NAME VARCHAR(255),
  NUMBER_OF_ATTEMPTS INTEGER NOT NULL
);

CREATE TABLE CONTAINER.LESSON_TRACKER_ALL_ASSIGNMENTS(
  LESSON_TRACKER_ID BIGINT NOT NULL,
  ALL_ASSIGNMENTS_ID BIGINT NOT NULL,
  PRIMARY KEY(LESSON_TRACKER_ID,ALL_ASSIGNMENTS_ID),
  CONSTRAINT FKNHIDKE27BCJHI8C7WJ9QW6Y3Q FOREIGN KEY(ALL_ASSIGNMENTS_ID) REFERENCES CONTAINER.ASSIGNMENT(ID),
  CONSTRAINT FKBM51QSDJ7N17O2DNATGAMW7D FOREIGN KEY(LESSON_TRACKER_ID) REFERENCES CONTAINER.LESSON_TRACKER(ID),
  CONSTRAINT UK_SYGJY2S8O8DDGA2K5YHBMUVEA UNIQUE(ALL_ASSIGNMENTS_ID)
);

CREATE TABLE CONTAINER.LESSON_TRACKER_SOLVED_ASSIGNMENTS(
  LESSON_TRACKER_ID BIGINT NOT NULL,
  SOLVED_ASSIGNMENTS_ID BIGINT NOT NULL,
  PRIMARY KEY(LESSON_TRACKER_ID,SOLVED_ASSIGNMENTS_ID),
  CONSTRAINT FKPP850U1MG09YKKL2EQGM0TRJK FOREIGN KEY(SOLVED_ASSIGNMENTS_ID) REFERENCES CONTAINER.ASSIGNMENT(ID),
  CONSTRAINT FKNKRWGA1UHLOQ6732SQXHXXSCR FOREIGN KEY(LESSON_TRACKER_ID) REFERENCES CONTAINER.LESSON_TRACKER(ID),
  CONSTRAINT UK_9WFYDUY3TVE1XD05LWOUEG0C1 UNIQUE(SOLVED_ASSIGNMENTS_ID)
);

CREATE TABLE CONTAINER.USER_TRACKER(
  ID BIGINT NOT NULL PRIMARY KEY,
  USERNAME VARCHAR(255)
);

CREATE TABLE CONTAINER.USER_TRACKER_LESSON_TRACKERS(
  USER_TRACKER_ID BIGINT NOT NULL,
  LESSON_TRACKERS_ID BIGINT NOT NULL,
  PRIMARY KEY(USER_TRACKER_ID,LESSON_TRACKERS_ID),
  CONSTRAINT FKQJSTCA3YND3OHP35D50PNUH3H FOREIGN KEY(LESSON_TRACKERS_ID) REFERENCES CONTAINER.LESSON_TRACKER(ID),
  CONSTRAINT FKC9GX8INK7LRC79XC77O2MN9KE FOREIGN KEY(USER_TRACKER_ID) REFERENCES CONTAINER.USER_TRACKER(ID),
  CONSTRAINT UK_5D8N5I3IC26CVF7DF7N95DOJB UNIQUE(LESSON_TRACKERS_ID)
);

CREATE TABLE CONTAINER.WEB_GOAT_USER(
  USERNAME VARCHAR(255) NOT NULL PRIMARY KEY,
  PASSWORD VARCHAR(255),
  ROLE VARCHAR(255)
);

CREATE TABLE CONTAINER.EMAIL(
  ID BIGINT GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
  CONTENTS VARCHAR(1024),
  RECIPIENT VARCHAR(255),
  SENDER VARCHAR(255),
  TIME TIMESTAMP,
  TITLE VARCHAR(255)
);

ALTER TABLE CONTAINER.EMAIL ALTER COLUMN ID RESTART WITH 2;
