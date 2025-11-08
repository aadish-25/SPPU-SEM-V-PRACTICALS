-- Trigger: Create a row level trigger for the CUSTOMERS table that
-- would fire INSERT or UPDATE or DELETE operations performed on the
-- CUSTOMERS table. This trigger will display the salary difference
-- between the old values and new values.

-- CREATE TABLES
CREATE TABLE customers (
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(50),
    salary NUMBER(10,2)
);

-- INSERT DATA
INSERT INTO customers VALUES (1, 'Aman', 50000);
INSERT INTO customers VALUES (2, 'Riya', 60000);
INSERT INTO customers VALUES (3, 'Karan', 55000);
INSERT INTO customers VALUES (4, 'Neha', 45000);
INSERT INTO customers VALUES (5, 'Vivek', 70000);

-- PL/SQL
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER TT3 AFTER INSERT or UPDATE or DELETE ON customers FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            DBMS_OUTPUT.PUT_LINE(' >>>>>>>>> CUSTOMER INSERTED, SALARY : ' || :new.salary);
        END IF;
        IF UPDATING THEN
            IF (:new.salary > :old.salary) THEN
                DBMS_OUTPUT.PUT_LINE('>>>>>>>> SALARY INCREASED. DIFFERENCE : ' || (:new.salary - :old.salary));
            END IF;
            IF (:new.salary < :old.salary) THEN
                DBMS_OUTPUT.PUT_LINE('>>>>>>>> SALARY DECREASED. DIFFERENCE : ' || (:old.salary - :new.salary));
            END IF;
        END IF;
        IF DELETING THEN
            DBMS_OUTPUT.PUT_LINE(' >>>>>>>>>> CUSTOMER REMOVED, SALARY : ' || :old.salary);
        END IF;
    END;
/

-- TO TEST TRIGGERS
UPDATE customers SET salary = 65000 WHERE id = 2;
DELETE FROM customers WHERE id = 4;
INSERT INTO customers VALUES (6, 'Meena', 48000);

-- SELECT STATEMENTS
SELECT * FROM customers;
