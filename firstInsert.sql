INSERT INTO TB_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NICKNAME, MEMBER_EMAIL, MEMBER_NAME,
    MEMBER_PHONE, MEMBER_AGE, MEMBER_PURPOSE, MEMBER_CONCERN, MEMBER_TRAINER, MEMBER_ABSENCE, MEMBER_JOIN_DATE) VALUES(
    (SELECT nvl(max(member_no),0)+1 from tb_member), 'admin1', '1234', 'nickname1', 'admin1@gmail.com', '서유빈', '010-0000-0000', 18, 
    1, 1, DEFAULT, DEFAULT, DEFAULT);
    
INSERT INTO TB_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NICKNAME, MEMBER_EMAIL, MEMBER_NAME,
    MEMBER_PHONE, MEMBER_AGE, MEMBER_PURPOSE, MEMBER_CONCERN, MEMBER_TRAINER, MEMBER_ABSENCE, MEMBER_JOIN_DATE) VALUES(
    (SELECT nvl(max(member_no),0)+1 from tb_member), 'admin2', '1234', 'nickname2', 'admin2@gmail.com', '민승택', '010-0000-0000', 3, 
    1, 1, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO TB_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NICKNAME, MEMBER_EMAIL, MEMBER_NAME,
    MEMBER_PHONE, MEMBER_AGE, MEMBER_PURPOSE, MEMBER_CONCERN, MEMBER_TRAINER, MEMBER_ABSENCE, MEMBER_JOIN_DATE) VALUES(
    (SELECT nvl(max(member_no),0)+1 from tb_member), 'admin3', '1234', 'nickname3', 'admin3@gmail.com', '박재민', '010-0000-0000', 26, 
    1, 1, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO TB_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NICKNAME, MEMBER_EMAIL, MEMBER_NAME,
    MEMBER_PHONE, MEMBER_AGE, MEMBER_PURPOSE, MEMBER_CONCERN, MEMBER_TRAINER, MEMBER_ABSENCE, MEMBER_JOIN_DATE) VALUES(
    (SELECT nvl(max(member_no),0)+1 from tb_member), 'admin4', '1234', 'nickname4', 'admin4@gmail.com', '이진정', '010-0000-0000', 30, 
    1, 1, DEFAULT, DEFAULT, DEFAULT);
    
INSERT INTO TB_MEMBER (MEMBER_NO, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NICKNAME, MEMBER_EMAIL, MEMBER_NAME,
    MEMBER_PHONE, MEMBER_AGE, MEMBER_PURPOSE, MEMBER_CONCERN, MEMBER_TRAINER, MEMBER_ABSENCE, MEMBER_JOIN_DATE) VALUES(
    (SELECT nvl(max(member_no),0)+1 from tb_member), 'admin5', '1234', 'nickname5', 'admin5@gmail.com', '사람이름', '010-0000-0000', 30, 
    1, 1, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO TB_EXERCISE (EXERCISE_NO, EXERCISE_NAME, EXERCISE_PART, EXERCISE_AEROBIC) 
    VALUES ((SELECT nvl(max(EXERCISE_NO),0)+1 from TB_EXERCISE), '스쿼트', 'L', 'F');
    
INSERT INTO TB_EXERCISE (EXERCISE_NO, EXERCISE_NAME, EXERCISE_PART, EXERCISE_AEROBIC) 
    VALUES ((SELECT nvl(max(EXERCISE_NO),0)+1 from TB_EXERCISE), '데드리프트', 'F', 'F');
    
INSERT INTO TB_EXERCISE (EXERCISE_NO, EXERCISE_NAME, EXERCISE_PART, EXERCISE_AEROBIC) 
    VALUES ((SELECT nvl(max(EXERCISE_NO),0)+1 from TB_EXERCISE), '벤치프레스', 'C', 'F');

INSERT INTO TB_ROUTINE (ROUTINE_NO, MEMBER_NO, ROUTINE_NAME, ROUTINE_DISABLE) 
    VALUES ((SELECT nvl(max(ROUTINE_NO),0)+1 from TB_ROUTINE), 1, '서유빈루틴', DEFAULT);

INSERT INTO TB_ROUTINE (ROUTINE_NO, MEMBER_NO, ROUTINE_NAME, ROUTINE_DISABLE) 
    VALUES ((SELECT nvl(max(ROUTINE_NO),0)+1 from TB_ROUTINE), 2, '민승택루틴', DEFAULT);

INSERT INTO TB_ROUTINE (ROUTINE_NO, MEMBER_NO, ROUTINE_NAME, ROUTINE_DISABLE) 
    VALUES ((SELECT nvl(max(ROUTINE_NO),0)+1 from TB_ROUTINE), 3, '박재민루틴', DEFAULT);

INSERT INTO TB_ROUTINE_EXERCISE (ROUTINE_EXERCISE_NO, EXERCISE_NO, ROUTINE_NO, ROUTINE_EXERCISE_DAY,
    ROUTINE_WEEK, ROUTINE_DAY, ROUTINE_EXERCISE_SET, ROUTINE_EXERCISE_REPEAT, ROUTINE_EXERCISE_WEIGHT, 
    ROUTINE_EXERCISE_TIME, ROUTINE_EXERCISE_DISTANCE, ROUTINE_EXERCISE_PERFORM_DAY, ROUTINE_EXERCISE_D_DAY, ROUTINE_EXERCISE_SEQUENCE)
    VALUES ((SELECT nvl(max(ROUTINE_EXERCISE_NO),0)+1 from TB_ROUTINE_EXERCISE), 1, 1, 1, 1, 1, 1, 10, 50, 
    null, null, systimestamp, systimestamp, 1);
    
INSERT INTO TB_ROUTINE_EXERCISE (ROUTINE_EXERCISE_NO, EXERCISE_NO, ROUTINE_NO, ROUTINE_EXERCISE_DAY,
    ROUTINE_WEEK, ROUTINE_DAY, ROUTINE_EXERCISE_SET, ROUTINE_EXERCISE_REPEAT, ROUTINE_EXERCISE_WEIGHT, 
    ROUTINE_EXERCISE_TIME, ROUTINE_EXERCISE_DISTANCE, ROUTINE_EXERCISE_PERFORM_DAY, ROUTINE_EXERCISE_D_DAY, ROUTINE_EXERCISE_SEQUENCE)
    VALUES ((SELECT nvl(max(ROUTINE_EXERCISE_NO),0)+1 from TB_ROUTINE_EXERCISE), 1, 1, 1, 1, 1, 2, 10, 50, 
    null, null, systimestamp, systimestamp, 1);
    
INSERT INTO TB_ROUTINE_EXERCISE (ROUTINE_EXERCISE_NO, EXERCISE_NO, ROUTINE_NO, ROUTINE_EXERCISE_DAY,
    ROUTINE_WEEK, ROUTINE_DAY, ROUTINE_EXERCISE_SET, ROUTINE_EXERCISE_REPEAT, ROUTINE_EXERCISE_WEIGHT, 
    ROUTINE_EXERCISE_TIME, ROUTINE_EXERCISE_DISTANCE, ROUTINE_EXERCISE_PERFORM_DAY, ROUTINE_EXERCISE_D_DAY, ROUTINE_EXERCISE_SEQUENCE)
    VALUES ((SELECT nvl(max(ROUTINE_EXERCISE_NO),0)+1 from TB_ROUTINE_EXERCISE), 1, 1, 1, 1, 1, 3, 10, 50, 
    null, null, systimestamp, systimestamp, 1);

INSERT INTO TB_EXERCISE_RECORD (RECORD_NO, RECORD_START, RECORD_STOP, MEMBER_NO, ROUTINE_EXERCISE_NO) 
    VALUES ((SELECT nvl(max(RECORD_NO),0)+1 from TB_EXERCISE_RECORD), DEFAULT, DEFAULT, 1, 1);

INSERT INTO TB_EXERCISE_RECORD (RECORD_NO, RECORD_START, RECORD_STOP, MEMBER_NO, ROUTINE_EXERCISE_NO) 
    VALUES ((SELECT nvl(max(RECORD_NO),0)+1 from TB_EXERCISE_RECORD), DEFAULT, DEFAULT, 1, 2);

INSERT INTO TB_EXERCISE_RECORD (RECORD_NO, RECORD_START, RECORD_STOP, MEMBER_NO, ROUTINE_EXERCISE_NO) 
    VALUES ((SELECT nvl(max(RECORD_NO),0)+1 from TB_EXERCISE_RECORD), DEFAULT, DEFAULT, 1, 3);

INSERT INTO TB_TRAINER (TRAINER_NO, MEMBER_NO, TRAINER_FILE, TRAINER_CONFIRM, GYM_NAME, GYM_LOCATION, TRAINER_ETR) 
    VALUES ((SELECT nvl(max(TRAINER_NO),0)+1 from TB_TRAINER), 1, null, DEFAULT, '민승택 헬스장', '강동구', NULL);

INSERT INTO TB_TRAINER (TRAINER_NO, MEMBER_NO, TRAINER_FILE, TRAINER_CONFIRM, GYM_NAME, GYM_LOCATION, TRAINER_ETR) 
    VALUES ((SELECT nvl(max(TRAINER_NO),0)+1 from TB_TRAINER), 3, null, DEFAULT, '박재민 헬스장', '동탄', NULL);

INSERT INTO TB_BLACKLIST (BLACK_LIST_NO, TRAINER_NO, MEMBER_NO) 
    VALUES ((SELECT nvl(max(BLACK_LIST_NO),0)+1 from TB_BLACKLIST), 1, 5);
    
INSERT INTO TB_PT (PT_NO, TRAINER_NO, PT_NAME, PT_CATEGORY, PT_PRICE, PT_INTRODUCE, PT_INFORMATION, PT_TARGET_STUDENT, PT_NOTICE) 
    VALUES ((SELECT nvl(max(PT_NO),0)+1 from TB_PT), 1, '민승택의 PT', 1, 100000, '헬린이 탈출', '헬린이 탈출 가능', '헬린이', '다칠 수 있음');

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220415100000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220415110000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220415120000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220415130000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220415140000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220415150000', 'YYYYMMDDHH24MISS'), DEFAULT);
    
INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220417100000', 'YYYYMMDDHH24MISS'), 'T');

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220417110000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220417120000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220417130000', 'YYYYMMDDHH24MISS'), DEFAULT);

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220417140000', 'YYYYMMDDHH24MISS'), 'T');

INSERT INTO TB_PT_CALENDAR (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
    VALUES ((SELECT nvl(max(PT_CALENDAR_NO),0)+1 from TB_PT_CALENDAR), 1, 2, to_date('20220417150000', 'YYYYMMDDHH24MISS'), DEFAULT);
    
INSERT INTO TB_REVIEW (REVIEW_NO, MEMBER_NO, PT_NO, REVIEW_CONTENT) 
    VALUES ((SELECT nvl(max(REVIEW_NO),0)+1 from TB_REVIEW), 2, '감사합니당');
     
INSERT INTO TB_BOARD (BOARD_NO, MEMBER_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_COUNT, BOARD_DATE, BOARD_TYPE)
    VALUES((SELECT NVL(MAX(BOARD_NO),0)+1 FROM TB_BOARD), 1, '제목', '내용', DEFAULT, DEFAULT, DEFAULT);
    
INSERT INTO TB_BOARD (BOARD_NO, MEMBER_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_COUNT, BOARD_DATE, BOARD_TYPE)
    VALUES((SELECT NVL(MAX(BOARD_NO),0)+1 FROM TB_BOARD), 2, '제목2', '내용2', DEFAULT, DEFAULT, DEFAULT);

INSERT INTO TB_BOARD (BOARD_NO, MEMBER_NO, BOARD_TITLE, BOARD_CONTENT, BOARD_COUNT, BOARD_DATE, BOARD_TYPE)
    VALUES((SELECT NVL(MAX(BOARD_NO),0)+1 FROM TB_BOARD), 3, '제목3', '내용3', DEFAULT, DEFAULT, DEFAULT);
    
INSERT INTO TB_COMMENT (COMMENT_NO, BOARD_NO, MEMBER_NO, COMMENT_CONTENT, COMMENT_DATE, COMMENT_EDIT_DATE)
    VALUES((SELECT NVL(MAX(COMMENT_NO),0)+1 FROM TB_COMMENT), 2, 1, '댓글 내용', DEFAULT, NULL);
    
INSERT INTO TB_COMMENT (COMMENT_NO, BOARD_NO, MEMBER_NO, COMMENT_CONTENT, COMMENT_DATE, COMMENT_EDIT_DATE)
    VALUES((SELECT NVL(MAX(COMMENT_NO),0)+1 FROM TB_COMMENT), 2, 2, '댓글 내용', DEFAULT, NULL);
    
INSERT INTO TB_COMMENT (COMMENT_NO, BOARD_NO, MEMBER_NO, COMMENT_CONTENT, COMMENT_DATE, COMMENT_EDIT_DATE)
    VALUES((SELECT NVL(MAX(COMMENT_NO),0)+1 FROM TB_COMMENT), 2, 3, '댓글 내용', DEFAULT, NULL);

INSERT INTO TB_TRADE (TRADE_NO, MEMBER_NO, PT_NO, TRADE_METHOD, TRADE_TIME, TRADE_PRICE)
    VALUES ((SELECT NVL(MAX(TRADE_NO),0)+1 FROM TB_TRADE), 2, 1, 1, SYSTIMESTAMP, 100000);

INSERT INTO TB_BOARD_REPORT (BOARD_REPORT_NO, BOARD_REPORT_CONTENT, BOARD_REPORT_TIME, BOARD_NO, MEMBER_NO) 
    VALUES ((SELECT NVL(MAX(BOARD_REPORT_NO),0)+1 FROM TB_BOARD_REPORT), '짱나', SYSTIMESTAMP, 2, 4);

INSERT INTO TB_COMMENT_REPORT (COMMENT_REPORT_NO, COMMENT_REPORT_CONTENT, COMMENT_REPORT_TIME, COMMENT_NO, MEMBER_NO) 
    VALUES ((SELECT NVL(MAX(COMMENT_REPORT_NO),0)+1 FROM TB_COMMENT_REPORT), '짱남', SYSTIMESTAMP, 2, 2);











































