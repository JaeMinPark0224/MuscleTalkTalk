create or replace PROCEDURE PROC_UPDATE_PT
(
    IN_PT_NO IN NUMBER, /* 1 */
    IN_PT_TIME_INFO IN VARCHAR2,    /* 2 */
    IN_PT_START_DATE IN VARCHAR2,   /* 3 */
    IN_PT_END_DATE IN VARCHAR2,     /* 4 */
    OUT_PT_RESULT OUT NUMBER        /* 5 */    
)

IS
    TYPE TABLE_TYPE IS TABLE OF VARCHAR2(10)
        INDEX BY BINARY_INTEGER;
    ALL_DAY VARCHAR2(200);
    ARRAY_IDX NUMBER;
    ALL_DAY_INDEX NUMBER;
    ALL_DAY_DAY VARCHAR2(20);
    DATE_TABLE_DAY TABLE_TYPE;
    DATE_TABLE_START TABLE_TYPE;
    DATE_TABLE_END TABLE_TYPE;
    VAR_CURRENT_TIMESTAMP TIMESTAMP;
    VAR_END_TIMESTAMP TIMESTAMP;
    PT_NO_MAX NUMBER;
BEGIN
      
    ALL_DAY := IN_PT_TIME_INFO;
    ARRAY_IDX := 1;
    
    
    LOOP
        ALL_DAY_INDEX := INSTR(ALL_DAY,',');
        ALL_DAY_DAY := SUBSTR(ALL_DAY, 1, ALL_DAY_INDEX - 1);
        ALL_DAY := SUBSTR(ALL_DAY, ALL_DAY_INDEX + 1, LENGTH(ALL_DAY));
        DATE_TABLE_DAY(ARRAY_IDX) := ALL_DAY_DAY;
        
        ALL_DAY_INDEX := INSTR(ALL_DAY,',');
        ALL_DAY_DAY := SUBSTR(ALL_DAY, 1, ALL_DAY_INDEX - 1);
        ALL_DAY := SUBSTR(ALL_DAY, ALL_DAY_INDEX + 1, LENGTH(ALL_DAY));
        DATE_TABLE_START(ARRAY_IDX) := ALL_DAY_DAY;
        
        IF LENGTH(DATE_TABLE_START(ARRAY_IDX)) = 4 THEN
            DATE_TABLE_START(ARRAY_IDX) := '0' || DATE_TABLE_START(ARRAY_IDX);
        END IF;
        
        ALL_DAY_INDEX := INSTR(ALL_DAY,',');
        IF ALL_DAY_INDEX = 0 THEN
            DATE_TABLE_END(ARRAY_IDX) := ALL_DAY;
        ELSE
            ALL_DAY_DAY := SUBSTR(ALL_DAY, 1, ALL_DAY_INDEX - 1);
            ALL_DAY := SUBSTR(ALL_DAY, ALL_DAY_INDEX + 1, LENGTH(ALL_DAY));
            DATE_TABLE_END(ARRAY_IDX) := ALL_DAY_DAY;
        END IF;    
        
        IF LENGTH(DATE_TABLE_END(ARRAY_IDX)) = 4 THEN
            DATE_TABLE_END(ARRAY_IDX) := '0' || DATE_TABLE_END(ARRAY_IDX);
        END IF;

        
        ALL_DAY_INDEX := INSTR(ALL_DAY,',');

        ARRAY_IDX := ARRAY_IDX + 1;
        
        
    EXIT WHEN ALL_DAY_INDEX = 0;
    END LOOP;
    
    VAR_CURRENT_TIMESTAMP := TO_TIMESTAMP(IN_PT_START_DATE || ' 00:00:00');
    VAR_END_TIMESTAMP := TO_TIMESTAMP(IN_PT_END_DATE || ' 23:00:00');
    
    WHILE(VAR_CURRENT_TIMESTAMP < VAR_END_TIMESTAMP)
    LOOP
        FOR IDX IN 1..DATE_TABLE_DAY.COUNT LOOP
            IF TO_CHAR(VAR_CURRENT_TIMESTAMP, 'DAY') = DATE_TABLE_DAY(IDX) THEN
                IF TO_CHAR(VAR_CURRENT_TIMESTAMP, 'HH24:MI') >= DATE_TABLE_START(IDX) THEN
                    IF TO_CHAR(VAR_CURRENT_TIMESTAMP, 'HH24:MI') < DATE_TABLE_END(IDX) THEN
                        INSERT INTO TB_PT_CALENDAR 
                            (PT_CALENDAR_NO, PT_NO, MEMBER_NO, PT_CALENDAR_START_TIME, PT_CALENDAR_RESERVATION_STATE) 
                            VALUES 
                            ((SELECT nvl(max(pt_calendar_no),0)+1 from tb_pt_calendar), IN_PT_NO, NULL, 
                            VAR_CURRENT_TIMESTAMP, DEFAULT);
                        COMMIT;
                        OUT_PT_RESULT := OUT_PT_RESULT + 1;
                    END IF;
                END IF;
            END IF;        
        END LOOP;
    VAR_CURRENT_TIMESTAMP := VAR_CURRENT_TIMESTAMP + 1/24;
    END LOOP;

END PROC_UPDATE_PT; 