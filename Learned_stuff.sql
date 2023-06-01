
DECLARE 
str1 varchar2(1000) := 'the big string';
str2 varchar2(1000) ;
str3 varchar2(1000);
str4 varchar2(1000);

v_list varchar2(1000) := 'first, second, third';
v_first varchar2(1000);
v_second varchar2(1000);
v_third varchar2(1000);
v_total number;
v_delimiter varchar2(1000) := ',';

v_delimiter_first    VARCHAR2 (50) := '[^' || v_delimiter || ']+';
v_delimiter_middle   VARCHAR2 (50) := ',[^' || v_delimiter || ']+';
v_delimiter_last     VARCHAR2 (50) := '[^' || v_delimiter || ']+$';

TYPE record_stuff IS RECORD
        (
            v_firstvar     VARCHAR2 (360),              -- oracle manufacturer
            v_secondvar           VARCHAR2 (240),             -- henrico manufacturer
            v_thirdvar    VARCHAR2 (240),                   -- henrico status
            v_num          number                       -- tag number
        );

        TYPE v_record_stuff IS TABLE OF record_stuff;
        BULK_COLLECTOR     v_record_stuff;

        TYPE values_t IS TABLE OF VARCHAR2 (200);
        l_values     values_t;
        
v_table VARCHAR2 (240);
v_columns  VARCHAR2 (240);

BEGIN
str2 := SUBSTR(str1,0,3);
str3 := SUBSTR(str1,-6,6);
dbms_output.put_line(str2);
dbms_output.put_line(str3);

str4 := REPLACE(str1,'big','not so big');
dbms_output.put_line( str4);



v_total := LENGTH (v_list) - LENGTH (REPLACE (v_list, v_delimiter, '')) + 1;

        IF v_total = 2
        THEN
            v_first := REGEXP_SUBSTR (v_list, v_delimiter_first);
            v_second := REGEXP_SUBSTR (v_list, v_delimiter_last);
        ELSE
            v_first := REGEXP_SUBSTR (v_list, v_delimiter_first);
            v_second := REPLACE (REGEXP_SUBSTR (v_list, v_delimiter_middle), v_delimiter, '');
            v_third := REGEXP_SUBSTR (v_list, v_delimiter_last);
        END IF;
dbms_output.put_line( v_total);
dbms_output.put_line( v_first);
dbms_output.put_line( v_second);
dbms_output.put_line( v_third);


---- record builder uncomment and add table and column names
--    EXECUTE IMMEDIATE   'SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = '
--                     || ''''
--                     || UPPER (v_table)
--                     || ''''
--        BULK COLLECT INTO l_values;
--
--
--        SELECT column_1                                   AS v_firstvar,
--        column_2                                   AS v_secondvar,
--        column_3                                   AS v_thirdvar,
--        column_4                                   AS v_num
--         BULK COLLECT INTO BULK_COLLECTOR
--  FROM TABLE_NAME
---- WHERE  CONDITION
--;
--        FOR indx IN 1 .. BULK_COLLECTOR.COUNT
--        LOOP
--            INSERT INTO TABLE_NAME (column_1,
--                                                    column_2,
--        column_3,
--        column_4)
--                 VALUES (ACTIVE_BULK_COLLECTOR (indx).v_firstvar,
--                         ACTIVE_BULK_COLLECTOR (indx).v_secondvar,
--                         ACTIVE_BULK_COLLECTOR (indx).v_thirdvar,
--                         ACTIVE_BULK_COLLECTOR (indx).v_num);
--        END LOOP;
--
--    -- places collected column names into v_columns variable and adds ref_name if applicable
--    FOR indx IN 1 .. l_values.COUNT
--    LOOP
--        v_columns := v_columns || ', ' || v_ref_name || l_values (indx);
--    END LOOP;
--
--    -- trim ',' from beggining
--    v_columns := SUBSTR (v_columns, 3);



END;



-- SUBSTR (get_db_name, -4, 4) last 4
-- SUBSTR (get_db_name, 0, 3) first 3