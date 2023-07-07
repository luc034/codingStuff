-- cursor vs record race using VARRARY 
DECLARE
    TYPE r_time_trial IS RECORD
    (
        t1             TIMESTAMP,
        t2             TIMESTAMP,
        time_cursor    VARCHAR2 (100),
        time_record    VARCHAR2 (100)
    );

    TYPE v_time_trial IS TABLE OF r_time_trial;

    v_recorder      v_time_trial;

    TYPE vb_trial_array IS VARRAY (366) OF r_time_trial;

    v_trial_array   vb_trial_array := vb_trial_array ();
BEGIN
    FOR i IN 1 .. 10
    LOOP
        v_trial_array.EXTEND;
        v_trial_array (i).t1 := SYSTIMESTAMP;

        DECLARE
            CURSOR BULK_COLLECTOR IS
                SELECT 'column' AS column_1, 'column' AS column_2, 'column' AS column_3, 'column' AS column_4 FROM DUAL;
        BEGIN
            FOR indx IN BULK_COLLECTOR
            LOOP
                DBMS_OUTPUT.put_line (indx.column_1);
                DBMS_OUTPUT.put_line (indx.column_2);
                DBMS_OUTPUT.put_line (indx.column_3);
                DBMS_OUTPUT.put_line (indx.column_4);
            END LOOP;
        END;

        v_trial_array (i).t2 := SYSTIMESTAMP;
        v_trial_array (i).time_cursor := v_trial_array (i).t2 - v_trial_array (i).t1;
        v_trial_array (i).t1 := SYSTIMESTAMP;

        DECLARE
            TYPE r_current_user IS RECORD
            (
                column_1    VARCHAR2 (500),
                column_2    VARCHAR2 (500),
                column_3    VARCHAR2 (500),
                column_4    VARCHAR2 (500)
            );

            TYPE v_current_user IS TABLE OF r_current_user;

            BULK_COLLECTOR   v_current_user;
        BEGIN
            SELECT 'column'     AS column_1,
                   'column'     AS column_2,
                   'column'     AS column_3,
                   'column'     AS column_4
              BULK COLLECT INTO BULK_COLLECTOR
              FROM DUAL;

            FOR indx IN 1 .. BULK_COLLECTOR.COUNT
            LOOP
                DBMS_OUTPUT.put_line (BULK_COLLECTOR (indx).column_1);
                DBMS_OUTPUT.put_line (BULK_COLLECTOR (indx).column_2);
                DBMS_OUTPUT.put_line (BULK_COLLECTOR (indx).column_3);
                DBMS_OUTPUT.put_line (BULK_COLLECTOR (indx).column_4);
            END LOOP;
        END;

        v_trial_array (i).t2 := SYSTIMESTAMP;
        v_trial_array (i).time_record := v_trial_array (i).t2 - v_trial_array (i).t1;
    END LOOP;

    FOR i IN 1 .. v_trial_array.COUNT
    LOOP
        DBMS_OUTPUT.put_line ('trial ' || i || ':');
        DBMS_OUTPUT.put_line ('Record elapsed time: ' || v_trial_array (i).time_record);
        DBMS_OUTPUT.put_line ('Cursor elapsed time: ' || v_trial_array (i).time_cursor);
        DBMS_OUTPUT.put_line (CHR (13));
    END LOOP;
END;

CREATE or replace TYPE ERROR_LOG AS OBJECT
(
    error_code NUMBER,
    error_message VARCHAR2 (4000),
    backtrace CLOB,
    callstack CLOB,
    
    MEMBER PROCEDURE set_error,
    MEMBER FUNCTION get_error_status(p_error_status VARCHAR2) RETURN VARCHAR2
    
) NOT FINAL;

CREATE or replace TYPE BODY ERROR_LOG
AS
    MEMBER PROCEDURE set_error
    IS
    BEGIN
        self.error_code := SQLCODE;
        self.error_message := SQLERRM;
        self.backtrace := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
        self.callstack := DBMS_UTILITY.FORMAT_CALL_STACK;
    END set_error;
    
    MEMBER FUNCTION get_error_status(p_error_status VARCHAR2) 
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN
                   ' failed, error code: '
                || SQLCODE
                || chr(13)
                || ' Error Message: '
                || SQLERRM
                || chr(13)
                || ' Line failed on: '
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
                || chr(13)
                || ' Callstack: '
                || DBMS_UTILITY.FORMAT_CALL_STACK
                || CHR (13)
                || p_error_status;
    END get_error_status;
    
END;

-- method to test it 
DECLARE 

e_log ERROR_LOG := ERROR_LOG('','','','');
v_error_message VARCHAR2(4000);

BEGIN
e_log.set_error;

dbms_output.put_line('error code: ' || e_log.error_code);
dbms_output.put_line('error message: ' || e_log.error_message);
dbms_output.put_line('error backtrace: ' || e_log.backtrace);
dbms_output.put_line('error callstack: ' ||  e_log.callstack);
v_error_message := e_log.get_error_status(v_error_message);
dbms_output.put_line('Program' || v_error_message);


END;



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

--PROCEDURE my_proc(
--    p_param1  NUMBER DEFAULT 1
--  , p_param2  NUMBER DEFAULT 2
--  , p_param3  NUMBER DEFAULT 3
--  , p_param4  NUMBER DEFAULT 4
--  , p_param5  NUMBER DEFAULT 5 
--);
-- can use => to skip parameters like below for the procedure above
--my_proc(p_param1 => value1, p_param5 => value2);

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

-- regular expression for word space (word and num) punct space num
--str1 := REGEXP_REPLACE (
--                    str,
--                    '([[:alpha:]_]+)+[[:space:]]+([[:alnum:]_]+)+([[:punct:]_]+)+[[:space:]]+([[:digit:]_]+)',
--                    '');

END;

-- listagg example
BEGIN
select DISTINCT (SELECT LISTAGG (COLUMN, '; ') WITHIN GROUP (ORDER BY COLUMN)    "COLUMN" 
                 FROM THE_TABLE 
                 WHERE COLUMN = COLUMN)     AS COLUMN_NAME,
COLUMN
from THE_TABLE;
END;

-- matrix
DECLARE
  TYPE RecType IS RECORD
  (
    value1   NUMBER,
    value2   NUMBER,
    value3   NUMBER
  );
  TYPE TblType IS TABLE OF RecType;
  TYPE TblOfTblType IS TABLE OF TblType;
  matrix   TblOfTblType := TblOfTblType();
BEGIN
  matrix.EXTEND(3);
  FOR i IN 1 .. matrix.COUNT LOOP
    matrix(i) := TblType();
    matrix(i).EXTEND(4);
    FOR j IN 1 .. matrix(i).COUNT LOOP
      matrix(i)(j).value1 := i;
      matrix(i)(j).value2 := j;
      matrix(i)(j).value3 := DBMS_RANDOM.VALUE;
    END LOOP;
  END LOOP;

  FOR i IN 1 .. matrix.COUNT LOOP
    FOR j IN 1 .. matrix(i).COUNT LOOP
      DBMS_OUTPUT.PUT( '[' || matrix(i)(j).value1
                    || ',' || matrix(i)(j).value2
                    || ',' || matrix(i)(j).value3 || ']' || CHR(11) );
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
  END LOOP;
END;


--num := MOD(113,100);
--dbms_output.put_line(num);
--n := 1000000;
--v_digit := trunc(1/log(n, 10)) + 1;
--dbms_output.put_line( v_digit);
--
--dbms_output.put_line( lpad('1234',20,'0')); -- RPAD pads to the right

-- SUBSTR (get_db_name, -4, 4) last 4
-- SUBSTR (get_db_name, 0, 3) first 3
-- VSIZE() -- select statements only    -- LENGTH() for function
--
--- LENGTH returns Characters
--
--- LENGTHB returns Bytes
--
--- LENGTHC returns unicode characters
--
--- LENGTH2 returns Code units
--
--- LENGTH4 returns Code points

set echo on
set serveroutput on

<<begin_end_block>> 
declare 
  msg varchar2(1000);
begin
  dbms_output.enable;
  msg := chr(9) || 'start';
  <<loopblk>> 
  for itr8 in 1 .. 5
  loop
    msg := msg || chr(10) || chr (9) ||  'loop';
    dbms_output.put_line ('Iterator is ' || itr8);
    <<ifblck>> if itr8 > 2
    then
      msg := msg || chr(10) || chr(9) || 'greater than 2';
      goto gototarg;
    end if;
    exit loopblk when mod (itr8, 4) = 0;
    continue loopblk;
    <<gototarg>>
    dbms_output.put_line ('after goto target');
  end loop loopblk;
  dbms_output.put_line ('Ending, here are the messages' || chr(10) || msg);
end begin_end_block;

SELECT the_column,
         COUNT (*)                                               total,
         AVG (elapsed_time)                                      avgelap,
         AVG (elapsed_time) * COUNT (*)                          weight,
         SUM (DECODE (the_column,  'D', 1,  'C', 1,  0))     dynamic_views,
         SUM (DECODE (the_column,  'D', 0,  'C', 0,  1))     cached_views
    FROM the_table
GROUP BY the_column;

-- how to work time

SELECT TO_CHAR (
             TRUNC (ADD_MONTHS (SYSDATE, -12))
           + FLOOR (DBMS_RANDOM.VALUE (0, 365)) * INTERVAL '1' DAY
           + FLOOR (DBMS_RANDOM.VALUE (0, 1) * 19 * 60 * 60) * INTERVAL '1' SECOND,
           'MM/DD/YYYY HH:MI:SSPM')    AS Random_time
  FROM DUAL;
--CHR(TRUNC(dbms_random.value(65,122)))  -- A..z
--|| CHR(TRUNC(dbms_random.value(49,57)))  -- 1..9

-- cool procedures that are useful for stuff

    FUNCTION what_is (p_var VARCHAR2)
        RETURN VARCHAR2
    IS
        str   VARCHAR2 (100);
    BEGIN
        str :=
            CASE
                WHEN REGEXP_LIKE (p_var, '^([[:punct:]_]+)+([[:digit:]_]+)+([[:punct:]_]+)+[0-9]{2}')
                THEN
                    'currency'
                WHEN    REGEXP_LIKE (p_var, '^[0-9]{2}/[0-9]{2}/[0-9]{4}$')
                     OR REGEXP_LIKE (p_var, '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$')
                THEN
                    'date'
                WHEN    REGEXP_LIKE (UPPER (p_var), '^[0-9]{2}:[0-9]{2}PM$')
                     OR REGEXP_LIKE (p_var, '^[0-9]{2}:[0-9]{2}AM$')
                THEN
                    'time'
                WHEN REGEXP_LIKE (p_var, '^[^a-zA-Z]*$')
                THEN
                    'number'
                WHEN REGEXP_LIKE (p_var, '^[^g-zG-Z]*$')
                THEN
                    'hex'
                ELSE
                    'string'
            END;
        RETURN str;
    END;

FUNCTION parse_Date (in_string VARCHAR2, in_format VARCHAR2 DEFAULT 'YYYY-MM-DD', in_nls_params VARCHAR2 DEFAULT NULL)
    RETURN DATE
    DETERMINISTIC
AS
BEGIN
    RETURN TO_DATE (in_string, in_format, in_nls_params);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN NULL;
END;

FUNCTION find_Date (in_string       VARCHAR2,
                    in_format       VARCHAR2 DEFAULT 'MONTH DD YYYY',
                    in_nls_params   VARCHAR2 DEFAULT NULL)
    RETURN DATE
    DETERMINISTIC
AS
BEGIN
    RETURN parse_Date (
        REGEXP_SUBSTR (
            in_string,
               '(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|'
            || 'OCTOBER|NOVEMBER|DECEMBER)'
            || '[[:space:]]+([012]?[0-9]|3[01])'
            || '[[:punct:][:space:]]+\d{4}',
            1,
            1,
            'i'),
        in_format,
        in_nls_params);
END;

FUNCTION get_format (in_string VARCHAR2)
    RETURN VARCHAR2
AS
-- so far does:
-- 'MM/DD/YYYY' ; 'DD/MM/YYYY' ; 'YYYY/MM/DD' ; 'YYYY/DD/MM' ; 
-- (defaults to 'MM/DD/YYYY' or 'YYYY/MM/DD' if day and month < 13)
-- 'MM-DD-YYYY' ; 'DD-MM-YYYY' ; 'YYYY-MM-DD' ; 'YYYY-DD-MM' ; 
-- (defaults to 'MM-DD-YYYY' or 'YYYY-MM-DD' if day and month < 13)
-- 'DD-MON-YY' ; 'FMMonth Ddth, YYYY' ; 'FMMonth Dd, YYYY'
BEGIN
    IF (REGEXP_LIKE (in_string, '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'))
    THEN
        IF SUBSTR (REGEXP_SUBSTR (in_string,
                                  '[^/]+',                                                            -- '[^[:punct:]]+'
                                  1,
                                  1),
                   -2) < 13
        THEN
            RETURN 'MM/DD/YYYY';
        ELSIF REGEXP_SUBSTR (in_string,
                             '[^/]+',                                                                 -- '[^[:punct:]]+'
                             1,
                             2) < 13
        THEN
            RETURN 'DD/MM/YYYY';
        END IF;
    ELSIF (REGEXP_LIKE (in_string, '^[0-9]{4}/[0-9]{2}/[0-9]{2}$'))
    THEN
        IF REGEXP_SUBSTR (in_string,
                          '[^/]+',                                                                    -- '[^[:punct:]]+'
                          1,
                          2) < 13
        THEN
            RETURN 'YYYY/MM/DD';
        ELSIF SUBSTR (REGEXP_SUBSTR (in_string,
                                     '[^/]+',                                                         -- '[^[:punct:]]+'
                                     1,
                                     3),
                      2) < 13
        THEN
            RETURN 'YYYY/DD/MM';
        END IF;
    ELSIF (REGEXP_LIKE (in_string, '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'))
    THEN
        IF SUBSTR (REGEXP_SUBSTR (in_string,
                                  '[^-]+',                                                            -- '[^[:punct:]]+'
                                  1,
                                  1),
                   -2) < 13
        THEN
            RETURN 'MM-DD-YYYY';
        ELSIF REGEXP_SUBSTR (in_string,
                             '[^-]+',                                                                 -- '[^[:punct:]]+'
                             1,
                             2) < 13
        THEN
            RETURN 'DD-MM-YYYY';
        END IF;
    ELSIF (REGEXP_LIKE (in_string, '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'))
    THEN
        IF REGEXP_SUBSTR (in_string,
                          '[^/]+',                                                                    -- '[^[:punct:]]+'
                          1,
                          2) < 13
        THEN
            RETURN 'YYYY-MM-DD';
        ELSIF SUBSTR (REGEXP_SUBSTR (in_string,
                                     '[^/]+',                                                         -- '[^[:punct:]]+'
                                     1,
                                     3),
                      2) < 13
        THEN
            RETURN 'YYYY-DD-MM';
        END IF;
    ELSIF (REGEXP_LIKE (in_string, '^[0-9]{2}-[A-Za-z]{3}-[0-9]{2}$'))
    THEN
        RETURN 'DD-MON-YY';
    ELSIF (REGEXP_LIKE (in_string, '^[A-Za-z]{3,9} [0-9A-Za-z]{1,4}, [0-9]{4}$'))
    THEN
        IF (REGEXP_LIKE (in_string, '^[A-Za-z]{3,9} [0-9A-Za-z]{3,4}, [0-9]{4}$'))
        THEN
            RETURN 'FMMonth Ddth, YYYY';
        ELSIF (REGEXP_LIKE (in_string, '^[A-Za-z]{3,9} [0-9]{1,2}, [0-9]{4}$'))
        THEN
            RETURN 'FMMonth Dd, YYYY';
        END IF;
    END IF;
END;
    -- '[[:digit:]]+/+([[:digit:]_]+)'  '[[:digit:]]+/+[[:digit:]]+/+([[:digit:]_]+)'
    -- '^[0-9]{2}/[0-9]{2}/[0-9]{4}$'   '^0-9]{4}/[0-9]{1}$'

-- 2 uses, p_num > 0 is a replacer p_num = 0 is a seperator 
    -- p_num = 0 : Seperator
    -- p_num = 1 : username replacer
    -- p_num = 2 : admin replacer
    -- p_num = 3 : due date replacer
    -- p_num = 4 : billing cycle replacer
    PROCEDURE dynamic_replacer (p_list     IN     VARCHAR2,
                                p_body     IN OUT CLOB,
                                p_prefix   IN     VARCHAR2 DEFAULT '',
                                p_num      IN     NUMBER DEFAULT 0)
    IS
        -- expression for 'Username: variable'
        v_expression         VARCHAR2 (2000)                                   -- 'Username:[[:space:]]+([[:alnum:]_]+)'
            := CASE
                   WHEN p_num = 0
                   THEN
                       '[^[:punct:]]+'                                                             -- Punction Dilimeter
                   WHEN p_num = 1
                   THEN
                       p_prefix || '[[:space:]]+([[:alnum:]_]+)'  -- pattern: username or username2 Prefix should be Username:
                   WHEN p_num = 2
                   THEN
                       p_prefix || '[[:space:]]+([[:alpha:]_]+)+[[:space:]]+([[:alpha:]_]+)'  -- pattern: FirstName LastName Prefix should be Attention:
                   WHEN p_num = 3
                   THEN
                       '([[:alpha:]_]+)+[[:space:]]+([[:alnum:]_]+)+([[:punct:]_]+)+[[:space:]]+([[:digit:]_]+)'  -- pattern: June 25th, 2023 no prefix
                   WHEN p_num = 4
                   THEN
                       '[[:digit:]]+/+([[:digit:]_]+)'                      -- pattern: 2023/1 no prefix
                   WHEN p_num = 5
                   THEN
                       '([[:punct:]_]+)'                  --'[^[:punct:]]+'                         -- Replaces Punction
               END;
        -- how many usernames are in the email currently
        v_count              NUMBER := REGEXP_COUNT (p_body, v_expression);   --'Username:[[:space:]]+([[:alnum:]_]+)');
        -- how many usernames are going into the email
        v_total              NUMBER := LENGTH (p_list) - LENGTH (REGEXP_REPLACE (p_list, '([[:punct:]_]+)', '')) + 1;
        -- for multiple instances of the expression
        v_multi_expression   VARCHAR2 (2000) := v_expression;
        -- for holding each 'Username: variable' instance
        v_replacement        VARCHAR2 (1000) := p_list;
        v_punct_substr       VARCHAR2 (100) := '[^[:punct:]]+';
    BEGIN
        IF p_num > 0
        THEN
            IF p_num = 1 OR p_num = 2
            THEN
                FOR indx IN 1 .. v_total
                LOOP
                    IF indx = 1
                    THEN
                        v_replacement :=
                               p_prefix
                            || ' '
                            || REGEXP_SUBSTR (p_list,
                                              v_punct_substr,
                                              1,
                                              indx);
                    ELSE
                        v_replacement :=
                               v_replacement
                            || '<br>'
                            || p_prefix
                            || ' '
                            || REGEXP_SUBSTR (p_list,
                                              v_punct_substr,
                                              1,
                                              indx);
                    END IF;
                END LOOP;

                IF p_num = 1
                THEN
                    FOR i IN 2 .. v_count
                    LOOP
                        v_multi_expression := v_expression || '<br>' || v_multi_expression;
                    END LOOP;
                END IF;
            END IF;

            p_body := REGEXP_REPLACE (p_body, v_multi_expression, v_replacement);
        -- when p_num = 0 then procedure has a different use can be used to cycle through a list when p_list is the list, p_body is the return, p_prefix is the number
        ELSE
            p_body :=
                REGEXP_SUBSTR (p_list,
                               v_multi_expression,
                               1,
                               TO_NUMBER (p_prefix));
        END IF;
    END dynamic_replacer;


    -- p_num = 0 : Seperator
    -- p_num = 1 : username replacer
    -- p_num = 2 : admin replacer
    -- p_num = 3 : due date replacer
    -- p_num = 4 : billing cycle replacer
    PROCEDURE dynamic_replacer (p_list     IN     VARCHAR2,
                                p_body     IN OUT VARCHAR2,
                                p_prefix   IN     VARCHAR2 DEFAULT '',
                                p_num      IN     NUMBER DEFAULT 0)
    IS
        -- expression for 'Username: variable'
        v_expression         VARCHAR2 (2000)                                   -- 'Username:[[:space:]]+([[:alnum:]_]+)'
            := CASE
                   WHEN p_num = 0
                   THEN
                       '[^[:punct:]]+'                                                             -- Punction Dilimeter
                   WHEN p_num = 1
                   THEN
                       p_prefix || '[[:space:]]+([[:alnum:]_]+)'  -- pattern: username or username2 Prefix should be Username:
                   WHEN p_num = 2
                   THEN
                       p_prefix || '[[:space:]]+([[:alpha:]_]+)+[[:space:]]+([[:alpha:]_]+)'  -- pattern: FirstName LastName Prefix should be Attention:
                   WHEN p_num = 3
                   THEN
                       '([[:alpha:]_]+)+[[:space:]]+([[:alnum:]_]+)+([[:punct:]_]+)+[[:space:]]+([[:digit:]_]+)'  -- pattern: June 25th, 2023 no prefix
                   WHEN p_num = 4
                   THEN
                       '[[:digit:]]+/+([[:digit:]_]+)'                     -- pattern: 2023/1 no prefix
                   WHEN p_num = 5
                   THEN
                       '([[:punct:]_]+)'                  --'[^[:punct:]]+'                         -- Replaces Punction
               END;
        -- how many usernames are in the email currently
        v_count              NUMBER := REGEXP_COUNT (p_body, v_expression);   --'Username:[[:space:]]+([[:alnum:]_]+)');
        -- how many usernames are going into the email
        v_total              NUMBER := LENGTH (p_list) - LENGTH (REGEXP_REPLACE (p_list, '([[:punct:]_]+)', '')) + 1;
        -- for multiple instances of the expression
        v_multi_expression   VARCHAR2 (2000) := v_expression;
        -- for holding each 'Username: variable' instance
        v_replacement        VARCHAR2 (1000) := p_list;
        v_punct_substr       VARCHAR2 (100) := '[^[:punct:]]+';
    BEGIN
        IF p_num > 0
        THEN
            IF p_num = 1 OR p_num = 2
            THEN
                FOR indx IN 1 .. v_total
                LOOP
                    IF indx = 1
                    THEN
                        v_replacement :=
                               p_prefix
                            || ' '
                            || REGEXP_SUBSTR (p_list,
                                              v_punct_substr,
                                              1,
                                              indx);
                    ELSE
                        v_replacement :=
                               v_replacement
                            || '<br>'
                            || p_prefix
                            || ' '
                            || REGEXP_SUBSTR (p_list,
                                              v_punct_substr,
                                              1,
                                              indx);
                    END IF;
                END LOOP;

                IF p_num = 1
                THEN
                    FOR i IN 2 .. v_count
                    LOOP
                        v_multi_expression := v_expression || '<br>' || v_multi_expression;
                    END LOOP;
                END IF;
            END IF;

            p_body := REGEXP_REPLACE (p_body, v_multi_expression, v_replacement);
        -- when p_num = 0 then procedure has a different use can be used to cycle through a list when p_list is the list, p_body is the return, p_prefix is the number
        ELSE
            p_body :=
                REGEXP_SUBSTR (p_list,
                               v_multi_expression,
                               1,
                               TO_NUMBER (p_prefix));
        END IF;
    END dynamic_replacer;

    PROCEDURE user_seperator (p_list        IN     VARCHAR2,
                              p_delimiter   IN     VARCHAR2,
                              p_total          OUT INTEGER,
                              p_first          OUT VARCHAR2,
                              p_second         OUT VARCHAR2,
                              p_third          OUT VARCHAR2)
    IS
        -- sets up the regular expression for each
        v_delimiter_first    VARCHAR2 (50) := '[^' || p_delimiter || ']+';
        v_delimiter_middle   VARCHAR2 (50) := p_delimiter || v_delimiter_first;         -- ',[^' || p_delimiter || ']+';
        v_delimiter_last     VARCHAR2 (50) := v_delimiter_first || '$';                 -- '[^' || p_delimiter || ']+$';
    BEGIN
        -- finds if 1, 2, or 3 are coming in
        p_total := LENGTH (p_list) - LENGTH (REPLACE (p_list, p_delimiter, '')) + 1;

        -- the middle needs to replace the delimiter
        IF p_total = 2
        THEN
            p_first := REGEXP_SUBSTR (p_list, v_delimiter_first);
            p_second := REGEXP_SUBSTR (p_list, v_delimiter_last);
        ELSE
            p_first := REGEXP_SUBSTR (p_list, v_delimiter_first);
            p_second := REPLACE (REGEXP_SUBSTR (p_list, v_delimiter_middle), p_delimiter, '');
            p_third := REGEXP_SUBSTR (p_list, v_delimiter_last);
        END IF;
    END user_seperator;

-- takes in list and makes a smaller list
    PROCEDURE list_seperator (p_list         IN     VARCHAR2,
                              p_total        IN     NUMBER,
                              p_delimiter    IN     VARCHAR2,
                              p_small_list      OUT VARCHAR2)
    IS
        -- sets delimiter
        v_delimiter_first   VARCHAR2 (50) := '[^' || p_delimiter || ']+';
    BEGIN
        -- loops for total number of entrys wanted in new list
        FOR i IN 1 .. p_total
        LOOP
            p_small_list :=
                CASE
                    WHEN i = 1
                    THEN
                        REGEXP_SUBSTR (p_list,
                                       v_delimiter_first,
                                       1,
                                       i)
                    WHEN i > 1
                    THEN
                           REGEXP_SUBSTR (p_list,
                                          v_delimiter_first,
                                          1,
                                          i)
                        || p_delimiter
                        || p_small_list
                END;
        END LOOP;
    END;
    
    
    FUNCTION number_to_word (p_num INTEGER)
        RETURN VARCHAR2
    IS
        -- declare variable are num, num_to_word, str, len, c
        -- and in above declare variable num, len, c are integer datatype
        -- and num_to_word and str are varchar datatype
        num           INTEGER := p_num;
        num_to_word   VARCHAR2 (100);
        str           VARCHAR2 (100);
        len           INTEGER;
        c             INTEGER;
    BEGIN
        -- length of number
        len := LENGTH (num);

        -- loop to go through each number
        FOR i IN 1 .. len
        LOOP
            c := SUBSTR (num, i, 1);

            SELECT DECODE (c,
                           0, 'Zero ',
                           1, 'One ',
                           2, 'Two ',
                           3, 'Three ',
                           4, 'Four ',
                           5, 'Five ',
                           6, 'Six ',
                           7, 'Seven ',
                           8, 'Eight ',
                           9, 'Nine ')
              INTO str
              FROM DUAL;

            num_to_word := num_to_word || str;
        END LOOP;

        RETURN num_to_word;
    END;

FUNCTION number_to_word_adverb (p_num INTEGER)
        RETURN VARCHAR2
    IS
        -- declare variable are num, num_to_word, str, len, c
        -- and in above declare variable num, len, c are integer datatype
        -- and num_to_word and str are varchar datatype
        num           INTEGER := p_num;
        num_to_word   VARCHAR2 (100);
        str           VARCHAR2 (100);
        len           INTEGER;
        c             INTEGER;
    BEGIN
        -- length of number
        len := LENGTH (num);

        -- loop to go through each number
        FOR i IN 1 .. len
        LOOP
            c := SUBSTR (num, i, 1);

            SELECT DECODE (c,
                           0, 'Zeroth ',
                           1, 'First ',
                           2, 'Second ',
                           3, 'Third ',
                           4, 'Fourth ',
                           5, 'Fifth ',
                           6, 'Sixth ',
                           7, 'Seventh ',
                           8, 'Eighth ',
                           9, 'Ninth ')
              INTO str
              FROM DUAL;

            num_to_word := num_to_word || str;
        END LOOP;

        RETURN num_to_word;
    END number_to_word_adverb;

    FUNCTION adverb_to_number (p_adverb VARCHAR2)
        RETURN INTEGER
    IS
        advrb   VARCHAR2 (1000) := TRIM (LOWER (p_adverb));
        num     NUMBER;
    BEGIN
        SELECT DECODE (advrb,
                       'zeroth', 0,
                       'first', 1,
                       'second', 2,
                       'third', 3,
                       'fourth', 4,
                       'fifth', 5,
                       'sixth', 6,
                       'seventh', 7,
                       'eighth', 8,
                       'ninth', 9,
                       'tenth', 10,
                       'eleventh', 11,
                       'twelveth', 12,
                       'thirteenth', 13,
                       'fourteenth', 14,
                       'fifteenth', 15,
                       'sixteenth', 16,
                       'seventeenth', 17,
                       'eighteenth', 18,
                       'nineteenth', 19,
                       'twentyth', 20)
          INTO num
          FROM DUAL;

        RETURN num;
    END adverb_to_number;

    FUNCTION get_ordinal_number (p_num NUMBER)
        RETURN VARCHAR2
    IS
        v_ordinal   VARCHAR2 (20);
    BEGIN
        v_ordinal :=
            CASE
                WHEN MOD (p_num, 100) IN (11, 12, 13) THEN 'th'
                WHEN MOD (p_num, 10) = 1 THEN 'st'
                WHEN MOD (p_num, 10) = 2 THEN 'nd'
                WHEN MOD (p_num, 10) = 3 THEN 'rd'
                ELSE 'th'
            END;
        RETURN v_ordinal;
    END get_ordinal_number;
    
    
    FUNCTION spell_number (p_number IN NUMBER)
    RETURN VARCHAR2
AS
    TYPE myArray IS TABLE OF VARCHAR2 (255);

    l_str      myArray
                   := myArray ('',
                               ' thousand ',
                               ' million ',
                               ' billion ',
                               ' trillion ',
                               ' quadrillion ',
                               ' quintillion ',
                               ' sextillion ',
                               ' septillion ',
                               ' octillion ',
                               ' nonillion ',
                               ' decillion ',
                               ' undecillion ',
                               ' duodecillion ');

    l_num      VARCHAR2 (50) DEFAULT TRUNC (p_number);
    l_return   VARCHAR2 (4000);
BEGIN
    FOR i IN 1 .. l_str.COUNT
    LOOP
        EXIT WHEN l_num IS NULL;

        IF (SUBSTR (l_num, LENGTH (l_num) - 2, 3) <> 0)
        THEN
            l_return := TO_CHAR (TO_DATE (SUBSTR (l_num, LENGTH (l_num) - 2, 3), 'J'), 'Jsp') || l_str (i) || l_return;
        END IF;

        l_num := SUBSTR (l_num, 1, LENGTH (l_num) - 3);
    END LOOP;

    RETURN l_return;
END spell_number;

FUNCTION percentage_inc_over_int (p_amount NUMBER, p_years NUMBER, p_percent NUMBER)
        RETURN NUMBER
    IS
    BEGIN
        IF p_years > 1
        THEN
            RETURN ROUND(percentage_inc_over_int (p_amount + (p_amount * p_percent), p_years - 1, p_percent),2);
        ELSE
            RETURN ROUND(p_amount + (p_amount * p_percent),2);
        END IF;

        NULL;
    END;
    
    FUNCTION is_weekend (p_date DATE)
        RETURN BOOLEAN
    IS
        -- sets date incase no changes are needed it will still be the same date
        is_day_off   BOOLEAN := FALSE;
--        v_day        NUMBER := TO_CHAR (p_date, 'DD');
--        v_month      NUMBER := TO_CHAR (p_date, 'MM');
    BEGIN
            IF TO_CHAR (p_date, 'D') = 7
            THEN
                is_day_off := TRUE;
            ELSIF TO_CHAR (p_date, 'D') = 1
            THEN
                is_day_off := TRUE;
            END IF;

            RETURN is_day_off;
    END is_holiday_and_weekend;
    
    FUNCTION is_weekday (p_date DATE)
        RETURN BOOLEAN
    IS
        -- sets date incase no changes are needed it will still be the same date
        is_day_off   BOOLEAN := FALSE;
--        v_day        NUMBER := TO_CHAR (p_date, 'DD');
--        v_month      NUMBER := TO_CHAR (p_date, 'MM');
    BEGIN
            IF TO_CHAR (p_date, 'D') IN (2,3,4,5,6)
            THEN
                is_day_off := TRUE;
            ELSE
                is_day_off := FALSE;
            END IF;

            RETURN is_day_off;
    END is_holiday_and_weekend;
    -- create own lists

WITH
    codes
    AS
        (SELECT '00123' code FROM DUAL
         UNION ALL
         SELECT '02314' code FROM DUAL
         UNION ALL
         SELECT '83419' code FROM DUAL
         UNION ALL
         SELECT '98231' code FROM DUAL
         UNION ALL
         SELECT '84719' code FROM DUAL)
SELECT c.*, c.CODE
  FROM codes c
 WHERE NOT EXISTS
           (SELECT 1
              FROM MMMA_MANAGEMENT_AREAS rt
             WHERE rt.MMMA_ID = c.code
             FETCH FIRST 1 ROWS ONLY)                                              -- connecting to table, dont need
;

SELECT DISTINCT c.COLUMN_VALUE
  FROM TABLE (sys.dbms_debug_vc2coll ('00123',
                                      '02314',
                                      '83419',
                                      '98231',
                                      84719)) c
 WHERE NOT EXISTS
           (SELECT 1
              FROM MMMA_MANAGEMENT_AREAS rt
             WHERE rt.MMMA_ID = c.COLUMN_VALUE
             FETCH FIRST 1 ROWS ONLY)                                              -- connecting to table, dont need
;
SELECT COLUMN_VALUE AS val FROM TABLE (sys.ku$_vcnt ('one', 'two', 'three'));

SELECT t.COLUMN_VALUE
  FROM TABLE (sys.dbms_debug_vc2coll ('foo', 'bar', 'baz')) t;

SELECT COLUMN_VALUE r, h.COLUMN_VALUE d
  FROM TABLE (ku$_vcnt ('one', 'two', 'three')) h;

CREATE TYPE STRINGS AS TABLE OF VARCHAR2 (100);

CREATE TYPE NUMBERS AS VARRAY (100) OF NUMBER (10);

SELECT * FROM TABLE (STRINGS ('a', 'b', 'c'));

SELECT * FROM TABLE (NUMBERS (1, 2, 3));

SELECT *
  FROM (SELECT 'a' FROM DUAL
        UNION ALL
        SELECT 'b' FROM DUAL
        UNION ALL
        SELECT 'c' FROM DUAL);
        
        
   -- incomplete currently replaces repeated numbers need to fix that and optimize
   FUNCTION word_adverb_to_number (p_adverb VARCHAR2)
        RETURN INTEGER
    IS

--DECLARE
--    p_adverb      VARCHAR2 (1000) := 'One Hundred and two';
    -- declare variable are num, num_to_word, str, len, c
    -- and in above declare variable num, len, c are integer datatype
    -- and num_to_word and str are varchar datatype
    num           INTEGER;                                                                                  -- := p_num;
    advrb         VARCHAR2 (1000) := LOWER (p_adverb);
    num_to_word   VARCHAR2 (100);                                                                         -- := p_adverb
    str           VARCHAR2 (100);
    len           INTEGER;
    c             VARCHAR2 (100);
    --        current_word  VARCHAR2(100);
    word_list     VARCHAR2 (1000);
BEGIN
    -- length of number
    len := LENGTH (advrb) - LENGTH (REPLACE (advrb, ' ')) + 1;

    --        CASE
    --            WHEN LENGTH (advrb) - LENGTH (REPLACE (advrb, ' ')) = 0 THEN 1
    --            ELSE LENGTH (advrb) - LENGTH (REPLACE (advrb, ' '))
    --        END;                                                                       --INSTR(advrb, ' ');--LENGTH (advrb);
    IF len > 1
    THEN
        -- loop to go through each number
        FOR i IN 1 .. len
        LOOP
            c := REGEXP_SUBSTR (advrb, '[^ ]+');
            advrb := REPLACE (advrb, c);
            --            c := SUBSTR (advrb, 1, LENGTH(current_word));
            DBMS_OUTPUT.put_line ('c: ' || c);
            DBMS_OUTPUT.put_line ('advrb: ' || advrb);

            IF len > i
            THEN
                IF TRIM (LOWER (c)) = 'and'
                THEN
                    --                    DBMS_OUTPUT.put_line ('and if statement');
                    NULL;
                ELSE
                    --            IF
                    SELECT DECODE (c,
                                   'zero', 0,
                                   'one', 1,
                                   'two', 2,
                                   'three', 3,
                                   'four', 4,
                                   'five', 5,
                                   'six', 6,
                                   'seven', 7,
                                   'eight', 8,
                                   'nine', 9,
                                   'ten', 10,
                                   'eleven', 11,
                                   'twelve', 12,
                                   'thirteen', 13,
                                   'fourteen', 14,
                                   'fifteen', 15,
                                   'sixteen', 16,
                                   'seventeen', 17,
                                   'eighteen', 18,
                                   'nineteen', 19,
                                   'twenty', 20,
                                   'thirty', 30,
                                   'forty', 40,
                                   'fifty', 50,
                                   'sixty', 60,
                                   'seventy', 70,
                                   'eighty', 80,
                                   'ninety', 90,
                                   'hundred', 100,
                                   'thousand', 1000,
                                   'million', 1000000,
                                   'billion', 1000000000,
                                   'trillion', 1000000000000)
                      INTO str
                      FROM DUAL;

                    --            DBMS_OUTPUT.put_line ('num_to_word: ' || num_to_word);
                    num_to_word :=
                        CASE WHEN num_to_word IS NULL THEN str ELSE TO_NUMBER (num_to_word) * TO_NUMBER (str) END;
                    DBMS_OUTPUT.put_line ('str: ' || str);
                    DBMS_OUTPUT.put_line ('num_to_word: ' || num_to_word);
                END IF;
            ELSE
                SELECT DECODE (c,
                               'zero', 0,
                               'one', 1,
                               'two', 2,
                               'three', 3,
                               'four', 4,
                               'five', 5,
                               'six', 6,
                               'seven', 7,
                               'eight', 8,
                               'nine', 9,
                               'ten', 10,
                               'eleven', 11,
                               'twelve', 12,
                               'thirteen', 13,
                               'fourteen', 14,
                               'fifteen', 15,
                               'sixteen', 16,
                               'seventeen', 17,
                               'eighteen', 18,
                               'nineteen', 19,
                               'twenty', 20,
                               'thirty', 30,
                               'forty', 40,
                               'fifty', 50,
                               'sixty', 60,
                               'seventy', 70,
                               'eighty', 80,
                               'ninety', 90,
                               'hundred', 100,
                               'thousand', 1000,
                               'million', 1000000,
                               'billion', 1000000000,
                               'trillion', 1000000000000,
                               'zeroth', 0,
                               'first', 1,
                               'second', 2,
                               'third', 3,
                               'fourth', 4,
                               'fifth', 5,
                               'sixth', 6,
                               'seventh', 7,
                               'eighth', 8,
                               'ninth', 9,
                               'tenth', 10,
                               'eleventh', 11,
                               'twelveth', 12,
                               'thirteenth', 13,
                               'fourteenth', 14,
                               'fifteenth', 15,
                               'sixteenth', 16,
                               'seventeenth', 17,
                               'eighteenth', 18,
                               'nineteenth', 19,
                               'twentyth', 20,
                               'thirtyth', 30,
                               'fortyth', 40,
                               'fiftyth', 50,
                               'sixtyth', 60,
                               'seventyth', 70,
                               'eightyth', 80,
                               'ninetyth', 90,
                               'hundredth', 100,
                               'thousandth', 1000,
                               'millionth', 1000000,
                               'billionth', 1000000000,
                               'trillionth', 1000000000000)
                  INTO str
                  FROM DUAL;

                num_to_word := TO_NUMBER (num_to_word) + TO_NUMBER (str);
            END IF;
        END LOOP;
    ELSE
        c := TRIM (advrb);

        SELECT DECODE (c,
                       'zeroth', 0,
                       'first', 1,
                       'second', 2,
                       'third', 3,
                       'fourth', 4,
                       'fifth', 5,
                       'sixth', 6,
                       'seventh', 7,
                       'eighth', 8,
                       'ninth', 9,
                       'tenth', 10,
                       'eleventh', 11,
                       'twelveth', 12,
                       'thirteenth', 13,
                       'fourteenth', 14,
                       'fifteenth', 15,
                       'sixteenth', 16,
                       'seventeenth', 17,
                       'eighteenth', 18,
                       'nineteenth', 19,
                       'twentyth', 20,
                       'thirtyth', 30,
                       'fortyth', 40,
                       'fiftyth', 50,
                       'sixtyth', 60,
                       'seventyth', 70,
                       'eightyth', 80,
                       'ninetyth', 90,
                       'hundredth', 100,
                       'thousandth', 1000,
                       'millionth', 1000000,
                       'billionth', 1000000000,
                       'trillionth', 1000000000000)
          INTO str
          FROM DUAL;

        num_to_word := num_to_word || str;
    END IF;

    --        RETURN num_to_word;
    DBMS_OUTPUT.put_line (num_to_word);
END;

---------------- learning about function inheritence, online examples

CREATE OR REPLACE type obj_supertype

IS

  object

  (

    obj_emp_id   VARCHAR2(30),

    obj_emp_name VARCHAR2(30),

    map member FUNCTION func_super_map RETURN NUMBER,

    member FUNCTION func_super_print RETURN VARCHAR2) NOT final;

  /

CREATE OR REPLACE type body obj_supertype

IS

  map member FUNCTION func_super_map

  RETURN NUMBER

IS

BEGIN

  RETURN obj_emp_id;

END;

member FUNCTION func_super_print

  RETURN VARCHAR2

IS

BEGIN

  RETURN 'The Employee details for the ID '||obj_emp_id||' is Name: '||

  obj_emp_name;

END;

END;

---------------------------------------------------------------------------------------------------

CREATE OR REPLACE TYPE super_t AS OBJECT
  (n NUMBER) NOT final;
/
CREATE OR REPLACE TYPE sub_t UNDER super_t
  (n2 NUMBER) NOT final;
/
CREATE OR REPLACE TYPE final_t UNDER sub_t
  (n3 NUMBER);
/
CREATE OR REPLACE PACKAGE p IS
   FUNCTION func (arg super_t) RETURN NUMBER;
   FUNCTION func (arg sub_t) RETURN NUMBER;
END;
/
CREATE OR REPLACE PACKAGE BODY p IS
   FUNCTION func (arg super_t) RETURN NUMBER IS BEGIN RETURN 1; END;
   FUNCTION func (arg sub_t) RETURN NUMBER IS BEGIN RETURN 2; END;
END;
/

DECLARE
  v final_t := final_t(1,2,3);
BEGIN
  DBMS_OUTPUT.PUT_LINE(p.func(v));  -- prints 2
END;
/


-- Perform the following drop commands if you created these objects in Ex. 3-9
 DROP PACKAGE p;
 DROP TYPE final_t;
 DROP TYPE sub_t;
 DROP TYPE super_t FORCE;
 
CREATE OR REPLACE TYPE super_t AS OBJECT
  (n NUMBER, MEMBER FUNCTION func RETURN NUMBER) NOT final;
/
CREATE OR REPLACE TYPE BODY super_t AS
 MEMBER FUNCTION func RETURN NUMBER IS BEGIN RETURN 1; END; END;
/
CREATE TYPE sub_t UNDER super_t
  (n2 NUMBER,
   OVERRIDING MEMBER FUNCTION func RETURN NUMBER) NOT final;
/
CREATE OR REPLACE TYPE BODY sub_t AS
 OVERRIDING MEMBER FUNCTION func RETURN NUMBER IS BEGIN RETURN 2; END; END;
/
CREATE OR REPLACE TYPE final_t UNDER sub_t
  (n3 NUMBER);
/

DECLARE
  v super_t := final_t(1,2,3);
BEGIN
  DBMS_OUTPUT.PUT_LINE('answer:'|| v.func); -- prints 2
END;
/


---------------------------------------------------------------------------------------------------


--creating the base vehicle object type
CREATE OR REPLACE TYPE vehicle_t AS OBJECT
(
vehicle_id NUMBER,
manufacturer VARCHAR2(30),
purchase_date DATE,
color VARCHAR2 (10),
MEMBER FUNCTION get_vehicle RETURN VARCHAR2
)NOT FINAL;
/

CREATE TYPE BODY vehicle_t AS
MEMBER FUNCTION get_vehicle RETURN VARCHAR2
IS 
BEGIN
RETURN 'Vehicle ID:'|| TO_CHAR (vehicle_id) || 'Manufacturer:'|| manufacturer || 'Purchase Date:'||purchase_date||'Color:'||color;
END get_vehicle;
END;
/

-- CREATING SUB TYPE OF VEHICLE_T POWERED_VEHICLE  
CREATE OR REPLACE TYPE powred_vehicle UNDER vehicle_t
(
fule_type VARCHAR2(30),
license_number VARCHAR2 (10),
model VARCHAR2 (10),
OVERRIDING MEMBER FUNCTION get_vehicle RETURN VARCHAR2
)FINAL;
/

CREATE TYPE BODY powred_vehicle AS
OVERRIDING MEMBER FUNCTION get_vehicle RETURN VARCHAR2
IS 
BEGIN
RETURN (self AS vehicle_t).get_vehicle || 'Fuel Type:'|| fule_type || 'License Number:'||license_number||'Model:'||model;
END get_vehicle;
END;
/

CREATE OR REPLACE TYPE bicycle UNDER vehicle_t
(
gear_count number,
OVERRIDING MEMBER FUNCTION get_vehicle RETURN VARCHAR2,
MEMBER PROCEDURE set_gear_count (p_gear_count IN bicycle, p_vehicleid IN vehicle_t)
)FINAL;
/


CREATE TABLE vehicle_tab OF bicycle;

CREATE TYPE BODY bicycle AS
OVERRIDING MEMBER FUNCTION get_vehicle RETURN VARCHAR2
IS 
BEGIN
RETURN (self AS vehicle_t).get_vehicle || 'Gear Count:'|| TO_CHAR(gear_count);
END get_vehicle;
MEMBER PROCEDURE set_gear_count (p_gear_count IN bicycle, p_vehicleid IN vehicle_t)
IS
BEGIN
INSERT INTO vehicle_tab VALUES (p_gear_count, p_vehicleid);  -- INSERT INTO vehicle_tab VALUES (SELF);
END set_gear_count;
END;

   CREATE TYPE first_thing AS OBJECT (
   id        NUMBER,
   first_name  VARCHAR2 (100)
   )
   NOT FINAL
   ;
   
   CREATE TYPE second_thing UNDER first_thing (
   age   NUMBER,
   last_name          VARCHAR2(100)
   )
   NOT FINAL
   ;
   
DECLARE
   l_person   rbsx_users
                     := rbsx_users (11,
                                    'john',
                                    67,
                                    'doe');
BEGIN
   DBMS_OUTPUT.put_line (l_honda_user.first_name); 
   DBMS_OUTPUT.put_line (l_honda_user.last_name); 
END;
/

CREATE TYPE third_thing UNDER second_thing (
   height NUMBER,
   middle_name VARCHAR2 (200)
   );
/
--euler_constant NUMBER := 0.577215664901532860606512090082;
--golden_ratio NUMBER := 1.618033988749894;

    FUNCTION pi
        RETURN NUMBER
    IS
    BEGIN
        RETURN ACOS (-1);
    END;
    
    FUNCTION eulers_number
        RETURN NUMBER
    IS
    BEGIN
        RETURN EXP(1);
    END;
FUNCTION p_rectangle(p_length NUMBER, p_width NUMBER)
RETURN NUMBER
IS
v_length2 NUMBER := p_length * 2;
v_width2 NUMBER := p_width * 2;
BEGIN
RETURN v_length2 + v_width2;
END;

FUNCTION a_rectangle(p_length NUMBER, p_width NUMBER)
RETURN NUMBER
IS
BEGIN
RETURN p_length * p_width;
END;

FUNCTION p_square(p_side NUMBER)
RETURN NUMBER
IS
BEGIN
RETURN p_side * 4;
END;

FUNCTION a_square(p_side NUMBER)
RETURN NUMBER
IS
BEGIN
RETURN p_side * p_side;
END;

FUNCTION p_rectangle(p_length NUMBER, p_width NUMBER)
RETURN NUMBER
IS
v_length2 NUMBER := p_length * 2;
v_width2 NUMBER := p_width * 2;
BEGIN
RETURN v_length2 + v_width2;
END;

FUNCTION a_rectangle(p_length NUMBER, p_width NUMBER)
RETURN NUMBER
IS
BEGIN
RETURN p_length * p_width;
END;
