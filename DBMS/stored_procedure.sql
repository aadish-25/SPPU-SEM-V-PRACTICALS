-- Write a Stored Procedure namely proc_Grade for the categorization
-- of student. If marks scored by students in examination is <=1500
-- and marks>=990 then student will be placed in distinction
-- category if marks scored are between 989 and 900 category is
-- first class, if marks 899 and 825 category is Higher Second
-- Class.
-- Write a PL/SQL block for using procedure created with above
-- requirement.
-- Stud_Marks(name, total_marks),
-- Result(Roll,Name, Class)

-- CREATE TABLES
CREATE TABLE stud_marks (
  roll NUMBER PRIMARY KEY,
  name VARCHAR2(30),
  total_marks NUMBER(5)
);

CREATE TABLE result (
  roll NUMBER PRIMARY KEY,
  name VARCHAR2(30),
  class VARCHAR2(25)
);

-- INSERT DATA
INSERT INTO stud_marks VALUES (1, 'Riya', 1450);
INSERT INTO stud_marks VALUES (2, 'Aman', 920);
INSERT INTO stud_marks VALUES (3, 'Tanya', 880);
INSERT INTO stud_marks VALUES (4, 'Suresh', 810);
INSERT INTO stud_marks VALUES (5, 'Neha', 990);

-- PL/SQL
CREATE OR REPLACE PROCEDURE proc_grade (p_roll IN NUMBER) IS
  p_name     stud_marks.name%TYPE;
  marks      stud_marks.total_marks%TYPE;
  count_rec  NUMBER;
  nodata     EXCEPTION;
BEGIN

  SELECT COUNT(*) INTO count_rec
  FROM stud_marks
  WHERE roll = p_roll;

  IF count_rec = 0 THEN
    RAISE nodata;
  END IF;

  SELECT name, total_marks INTO p_name, marks FROM stud_marks WHERE roll = p_roll;

  IF (marks >= 990 AND marks <= 1500) THEN
    DBMS_OUTPUT.PUT_LINE(p_name || ' has been placed in the distinction category.');
    INSERT INTO result VALUES (p_roll, p_name, 'Distinction');
  ELSIF (marks BETWEEN 900 AND 989) THEN
    DBMS_OUTPUT.PUT_LINE(p_name || ' has been placed in the first class category.');
    INSERT INTO result VALUES (p_roll, p_name, 'First Class');
  ELSIF (marks BETWEEN 825 AND 899) THEN
    DBMS_OUTPUT.PUT_LINE(p_name || ' has been placed in the higher second class category.');
    INSERT INTO result VALUES (p_roll, p_name, 'Higher Second Class');
  ELSE
    DBMS_OUTPUT.PUT_LINE(p_name || ' has failed.');
    INSERT INTO result VALUES (p_roll, p_name, 'Fail');
  END IF;

EXCEPTION
  WHEN nodata THEN
    DBMS_OUTPUT.PUT_LINE('No record found for roll number: ' || p_roll);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END proc_grade;
/

SET SERVEROUTPUT ON;
DECLARE
  p_roll NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Enter roll number: ');
  p_roll := &p_roll;

  proc_grade(p_roll);
END;
/

-- SELECT TABLES
SELECT * FROM result;

