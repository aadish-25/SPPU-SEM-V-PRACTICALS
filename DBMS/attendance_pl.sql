-- Write a PL/SQL block for following requirements and handle the
-- exceptions. Roll no. of students will be entered by the user.
-- Attendance of roll no. entered by user will be checked in the
-- Stud table. If attendance is less than 75% then display the
-- message “Term not granted” and set the status in stud table as
-- “Detained”. Otherwise display message “Term granted” and set the
-- status in stud table as “Not Detained”
--  Student (Roll, Name, Attendance ,Status)

-- Create table
CREATE TABLE student (
        rollno NUMBER PRIMARY KEY,
        name VARCHAR(30),
        attendance DECIMAL(10, 2),
        status VARCHAR(30)
);
-- Fill table
INSERT INTO student VALUES (1, 'Riya',   82.5, NULL);
INSERT INTO student VALUES (2, 'Aman',   68.0, NULL);
INSERT INTO student VALUES (3, 'Tanya',  74.9, NULL);
INSERT INTO student VALUES (4, 'Suresh', 91.2, NULL);
INSERT INTO student VALUES (5, 'Neha',   59.0, NULL);
INSERT INTO student VALUES (6, 'Arjun',  75.0, NULL);
INSERT INTO student VALUES (7, 'Mitali', 88.3, NULL);

-- PL/SQL
SET SERVEROUTPUT ON;
DECLARE
    input_rollno student.rollno%TYPE;
    student_attendance student.attendance%TYPE;
BEGIN 
    input_rollno := &input_rollno;

    SELECT attendance into student_attendance FROM student where rollno = input_rollno;

    IF student_attendance < 75 then
    UPDATE student SET status = 'Term not granted' where rollno = input_rollno;
    DBMS_OUTPUT.PUT_LINE('Term status updated for roll no ' || input_rollno || ': ' || 'Term not granted');
    ELSE
    UPDATE student SET status = 'Term granted' where rollno = input_rollno;
    DBMS_OUTPUT.PUT_LINE('Term status updated for roll no ' || input_rollno || ': ' || 'Term granted');
    END IF;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Invalid roll number entered');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR : ' || SQLERRM);
END;
/


-- PL/SQL : using cursor to automate the status message
SET SERVEROUTPUT ON;
DECLARE
    CURSOR CC is SELECT rollno, attendance from student;
    rollno1 student.rollno%TYPE;
    attendance1 student.attendance%TYPE;
BEGIN 
    OPEN CC;
    LOOP
        FETCH CC into rollno1, attendance1;
        EXIT when CC%NOTFOUND;

        IF attendance1 < 75 then
        UPDATE student SET status = 'Term not granted' where rollno = rollno1;
        DBMS_OUTPUT.PUT_LINE('Term status updated for roll no ' || rollno1 || ': ' || 'Term not granted');
        ELSE
        UPDATE student SET status = 'Term granted' where rollno = rollno1;
        DBMS_OUTPUT.PUT_LINE('Term status updated for roll no ' || rollno1 || ': ' || 'Term granted');
        END IF;
    END LOOP;
    CLOSE CC;

    EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR : ' || SQLERRM);
END;
/
