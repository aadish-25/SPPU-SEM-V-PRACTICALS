--  Trigger: Create a row level trigger for the CUSTOMERS table that
-- would fire INSERT or UPDATE or DELETE operations performed on the
-- CUSTOMERS table. This trigger will display the salary difference
-- between the old values and new values.

-- CREATE TABLES
CREATE TABLE library(
    id NUMBER(12),
    title VARCHAR(30),
    dateofissue DATE,
    author VARCHAR(30)
);

CREATE TABLE library_audit(
    id NUMBER(12),
    title VARCHAR(30),
    dateofaction DATE,
    author VARCHAR(30),
    status VARCHAR(30)
);

-- INSERT DATA
INSERT INTO library VALUES (1, 'Attack on Titan', TO_DATE('2025-05-13', 'YYYY-MM-DD'), 'Author1');
INSERT INTO library VALUES (2, 'DBMS', TO_DATE('2025-04-23', 'YYYY-MM-DD'), 'Author2');
INSERT INTO library VALUES (3, 'Ikigai', TO_DATE('2025-01-12', 'YYYY-MM-DD'), 'Author3');
INSERT INTO library VALUES (4, 'Java Reference', TO_DATE('2024-01-11', 'YYYY-MM-DD'), 'Author4');
INSERT INTO library VALUES (5, 'DSA', TO_DATE('2024-11-11', 'YYYY-MM-DD'), 'Author5');

-- PL/SQL
CREATE OR REPLACE TRIGGER TT AFTER INSERT OR DELETE OR UPDATE ON library FOR EACH ROW   
    BEGIN
        IF INSERTING THEN
            INSERT INTO library_audit (id, title, dateofaction, author, status) VALUES
            (:new.id, :new.title, SYSDATE, :new.author, 'INSERTED');
        END IF;
        IF DELETING THEN
            INSERT INTO library_audit (id, title, dateofaction, author, status) VALUES
            (:old.id, :old.title, SYSDATE, :old.author, 'DELETED');
        END IF;
        IF UPDATING THEN
            INSERT INTO library_audit (id, title, dateofaction, author, status) VALUES
            (:new.id, :new.title, SYSDATE, :new.author, 'UPDATED');
        END IF;
    END;
/

-- TO TEST TRIGGERS
INSERT INTO library VALUES (6, 'AI/ML', TO_DATE('2025-6-21', 'YYYY-MM-DD'), 'Author6');
UPDATE library SET id = 7 WHERE title = 'DSA';
DELETE FROM library WHERE author = 'Author1';

-- SELECT STATEMENTS
SELECT * FROM library;
SELECT * FROM library_audit;
