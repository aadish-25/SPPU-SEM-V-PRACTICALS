-- Write a Unnamed PL/SQL of code for the following requirements:-
-- Schema:
--  Borrower (Roll_no, Name, DateofIssue, NameofBook, Status)
--  Fine (Roll_no,Date,Amt)
-- Accept roll_no & name of book from user.
-- Check the number of days (from date of issue).
-- 1. If days are between 15 to 30 then fine amounts will be Rs 5
-- per day.
-- 2. If no. of days>30, per day fine will be Rs 50 per day & for
-- days less than 30, Rs. 5 per day.
-- 3. After submitting the book, status will change from I to R.
-- 4. If condition of fine is true, then details will be stored into
-- fine table.

-- Creating Table
CREATE TABLE
    Borrower (
        Roll_no NUMBER PRIMARY KEY,
        Name varchar(30),
        DateofIssue date,
        NameofBook varchar(30),
        Status varchar(20)
    );

CREATE TABLE Fine (Roll_no NUMBER PRIMARY KEY, DateofFine DATE, Amt NUMBER, foreign key (Roll_no) references Borrower(Roll_no));

-- Insert Values
INSERT INTO Borrower VALUES (1, 'Kalas', TO_DATE('2024-10-19', 'YYYY-MM-DD'), 'DBMS', 'I');
INSERT INTO Borrower VALUES (2, 'Himanshu', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'IOT', 'I');
INSERT INTO Borrower VALUES (3, 'Mepa', TO_DATE('2024-10-29', 'YYYY-MM-DD'), 'TOC', 'I');
INSERT INTO Borrower VALUES (4, 'Jambo', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 'CNS', 'I');
INSERT INTO Borrower VALUES (5, 'Riya', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'OS', 'I');
INSERT INTO Borrower VALUES (6, 'Aaditya', TO_DATE('2024-09-25', 'YYYY-MM-DD'), 'DBMS', 'I');
INSERT INTO Borrower VALUES (7, 'Tanya', TO_DATE('2024-10-05', 'YYYY-MM-DD'), 'DSA', 'I');
INSERT INTO Borrower VALUES (8, 'Shyam', TO_DATE('2024-09-29', 'YYYY-MM-DD'), 'AI', 'I');
INSERT INTO Borrower VALUES (9, 'Mitali', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 'Maths', 'I');
INSERT INTO Borrower VALUES (10, 'Suresh', TO_DATE('2024-10-02', 'YYYY-MM-DD'), 'Compiler', 'I');


-- PL/SQL
SET SERVEROUTPUT ON;
DECLARE
    input_roll NUMBER;
    input_book varchar(30);
    current_date DATE;
    total_days_passed NUMBER;
    issue_date DATE;
    fine_amount NUMBER;
    nodata EXCEPTION;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Enter roll number and book name : ');
    input_roll := &input_roll;
    input_book := '&input_book';
    current_date := TRUNC(SYSDATE);

    IF(input_roll < 0) then raise nodata;
    END IF;

    SELECT DateofIssue into issue_date from Borrower where Roll_no = input_roll AND NameofBook = input_book;
    total_days_passed := current_date - issue_date;

    DBMS_OUTPUT.PUT_LINE('Roll number : ' || input_roll);
    DBMS_OUTPUT.PUT_LINE('Name of Book : ' || input_book);
    DBMS_OUTPUT.PUT_LINE('Days passed : ' || total_days_passed);

    IF(total_days_passed between 15 AND 30) then
        fine_amount:= total_days_passed * 5;
        INSERT INTO Fine VALUES(input_roll, current_date, fine_amount);
        UPDATE Borrower set Status = 'R' where Roll_no = input_roll;
    END IF;

    IF(total_days_passed > 30) then
    -- fine = 5 per day till 15 days and then 50 per day
        fine_amount := (15 * 5) + (total_days_passed - 15) * 50;
        INSERT INTO Fine VALUES(input_roll, current_date, fine_amount);
        UPDATE Borrower set Status = 'R' where Roll_no = input_roll;
    END IF;

    IF(total_days_passed <= 15) then
        fine_amount := 0;
        INSERT INTO Fine VALUES(input_roll, current_date, fine_amount);
        UPDATE Borrower set Status = 'R' where Roll_no = input_roll;
    END IF;

EXCEPTION
    WHEN nodata then
        DBMS_OUTPUT.PUT_LINE('Enter a valid roll number!');
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Something went wrong. Please check input data.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error occured. Error: ' || SQLERRM);
END;
/


