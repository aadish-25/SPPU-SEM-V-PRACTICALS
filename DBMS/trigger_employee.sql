-- Trigger :Write a after trigger for Insert, update and delete
-- event considering following requirement:
-- Emp(Emp_no, Emp_name, Emp_salary)
-- a) Trigger should be initiated when salary tried to be inserted
-- is less than Rs.50,000/-
-- b) Trigger should be initiated when salary tried to be updated
-- for value less than Rs. 50,000/-
-- Also the new values expected to be inserted will be stored in new
-- table Tracking(Emp_no,Emp_salary).

-- CREATE TABLES
CREATE TABLE emp (
    emp_no NUMBER(10) PRIMARY KEY,
    emp_name VARCHAR2(50),
    emp_salary NUMBER(10,2)
);

CREATE TABLE tracking (
    emp_no NUMBER(10),
    emp_salary NUMBER(10,2)
);

-- INSERT DATA
INSERT INTO emp VALUES (101, 'Aman', 60000);
INSERT INTO emp VALUES (102, 'Riya', 55000);
INSERT INTO emp VALUES (103, 'Karan', 75000);
INSERT INTO emp VALUES (104, 'Neha', 50000);
INSERT INTO emp VALUES (105, 'Vivek', 80000);

-- PL/SQL
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER TT4 AFTER INSERT OR UPDATE OR DELETE ON emp FOR EACH ROW
    BEGIN
        IF INSERTING AND (:NEW.emp_salary < 50000) THEN
            INSERT INTO tracking (emp_no, emp_salary) VALUES (:new.emp_no, :new.emp_salary);
            DBMS_OUTPUT.PUT_LINE('Inserting record with salary < 50000');
        END IF;
        IF UPDATING AND (:NEW.emp_salary < 50000) THEN
            INSERT INTO tracking (emp_no, emp_salary) VALUES (:new.emp_no, :new.emp_salary);
            DBMS_OUTPUT.PUT_LINE('Updating record with salary < 50000');
        END IF;
        IF DELETING THEN
            INSERT INTO tracking (emp_no, emp_salary) VALUES (:old.emp_no, :old.emp_salary);
            DBMS_OUTPUT.PUT_LINE('Deleting a record');
        END IF;
    END;
/

-- TO TEST TRIGGERS
INSERT INTO emp VALUES (106, 'Tina', 45000);
UPDATE emp SET emp_salary = 40000 WHERE emp_no = 102;
UPDATE emp SET emp_salary = 65000 WHERE emp_no = 101;
DELETE from emp WHERE emp_no = 103;

-- SELECT STATEMENTS
SELECT * FROM emp;
SELECT * FROM tracking;
