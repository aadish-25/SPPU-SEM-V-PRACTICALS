-- Write a PL/SQL Block to increase the salary of employees by 10%
-- of existing salary, who are having salary less than average
-- salary of organization, whenever such salary updates takes place,
-- a record for same is maintained in the increment_salary table.
-- emp(emp_no, salary)
-- increment_salary(emp_no, salary)

-- Create tables
CREATE TABLE employee(emp_no NUMBER PRIMARY KEY, salary DECIMAL(10, 2));
CREATE TABLE increment_salary(emp_no NUMBER, salary DECIMAL(10, 2));

-- Insert values
INSERT INTO employee VALUES (101, 25000);
INSERT INTO employee VALUES (102, 32000);
INSERT INTO employee VALUES (103, 40000);
INSERT INTO employee VALUES (104, 28000);
INSERT INTO employee VALUES (105, 36000);
INSERT INTO employee VALUES (106, 22000);
INSERT INTO employee VALUES (107, 41000);
INSERT INTO employee VALUES (108, 27000);

--PL/SQL
SET SERVEROUTPUT ON;
DECLARE
    avg_salary DECIMAL(10, 2);
    updated_salary DECIMAL(10, 2);
    emp_no1 employee.emp_no%TYPE;
    salary1 employee.salary%TYPE;
    CURSOR CC is SELECT emp_no, salary from employee;
BEGIN
    OPEN CC;
    SELECT AVG(salary) INTO avg_salary from employee;
    DBMS_OUTPUT.PUT_LINE('Average salary is : ' || avg_salary);
    LOOP
        FETCH CC INTO emp_no1, salary1;
        EXIT WHEN CC%NOTFOUND;

        IF salary1 < avg_salary then
        updated_salary := salary1 + (0.1 * salary1);
        DBMS_OUTPUT.PUT_LINE('Incrementing salary of employee id : ' || emp_no1 || ' to ' || updated_salary);
        UPDATE employee SET salary = updated_salary where emp_no = emp_no1;
        INSERT INTO increment_salary VALUES (emp_no1, updated_salary-salary1);
        END IF;
    END LOOP;
    CLOSE CC;
END;
/

-- SELECT STATEMENTS
SELECT * FROM employee;
SELECT * FROM increment_salary;
