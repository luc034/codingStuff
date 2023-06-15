
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
                 FROM TABLE 
                 WHERE COLUMN = COLUMN)     AS COLUMN_NAME,
COLUMN
from TABLE
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
/

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
/

  SELECT column,
         COUNT (*)                                               total,
         AVG (elapsed_time)                                      avgelap,
         AVG (elapsed_time) * COUNT (*)                          weight,
         SUM (DECODE (column,  'D', 1,  'C', 1,  0))     dynamic_views,
         SUM (DECODE (column,  'D', 0,  'C', 0,  1))     cached_views
    FROM table
GROUP BY column;

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