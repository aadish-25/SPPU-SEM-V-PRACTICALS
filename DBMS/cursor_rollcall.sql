-- Write a PL/SQL block of code using Cursor that will merge the
-- data available in the newly created table N_Roll Call with the
-- data available in the table O_RollCall. If the data in the first
-- table already exist in the second table then that data should be
-- skipped.

-- Create req tables
CREATE TABLE N_RollCall(rollno NUMBER PRIMARY KEY, name varchar(20));
CREATE TABLE O_RollCall(rollno NUMBER PRIMARY KEY, name varchar(20));

-- Input data
INSERT INTO O_RollCall VALUES (1, 'Riya');
INSERT INTO O_RollCall VALUES (2, 'Aman');
INSERT INTO O_RollCall VALUES (3, 'Tanya');
INSERT INTO O_RollCall VALUES (4, 'Suresh');

INSERT INTO N_RollCall VALUES (3, 'Tanya');   
INSERT INTO N_RollCall VALUES (4, 'Suresh');   
INSERT INTO N_RollCall VALUES (5, 'Mitali');   
INSERT INTO N_RollCall VALUES (6, 'Aditya');  
INSERT INTO N_RollCall VALUES (7, 'Neha');     

-- PL/SQL to add data from new rollcall to old rollcall if missing
SET SERVEROUTPUT ON;
DECLARE
    CURSOR CC is
        SELECT rollno, name from N_RollCall;
        rollno1 N_RollCall.rollno%TYPE;
        name1 N_RollCall.name%TYPE;
BEGIN
    OPEN CC;
    LOOP
        FETCH CC into rollno1, name1;
        EXIT when CC%NOTFOUND;
        BEGIN
            INSERT INTO O_RollCall VALUES(rollno1, name1);
            DBMS_OUTPUT.PUT_LINE('Inserted Roll_no: ' || rollno1 || ', Name: ' || name1);
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE(rollno1 || ' already exists');
            END;
    END LOOP;
    CLOSE CC;
END;
/
