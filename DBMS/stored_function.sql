-- Create a stored function titled 'Age_calc'.
-- Accept the date of birth of a person as a parameter.
-- Calculate the age of the person in years, months and days e.g. 3
-- years, 2months, 10 days.
-- Return the age in years directly (with the help of Return
-- statement).
-- The months and days are to be returned indirectly in the form of
-- OUT parameters.

-- CREATE TABLE
CREATE TABLE person (
  person_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  dob DATE
);

-- INSERT DATA
INSERT INTO person VALUES (1, 'Aman', TO_DATE('2002-08-15', 'YYYY-MM-DD'));
INSERT INTO person VALUES (2, 'Riya', TO_DATE('1999-12-10', 'YYYY-MM-DD'));
INSERT INTO person VALUES (3, 'Karan', TO_DATE('1985-03-05', 'YYYY-MM-DD'));
INSERT INTO person VALUES (4, 'Nisha', TO_DATE('2010-01-28', 'YYYY-MM-DD'));

-- PL/SQL
CREATE OR REPLACE FUNCTION age_calc (p_dob IN  DATE, p_months OUT NUMBER, p_days OUT NUMBER) RETURN NUMBER IS
  v_years   NUMBER;

BEGIN
  v_years  := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
  p_months := FLOOR(MOD(MONTHS_BETWEEN(SYSDATE, p_dob), 12));
  p_days   := TRUNC(SYSDATE - ADD_MONTHS(p_dob, v_years * 12 + p_months));
  RETURN v_years;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    p_months := NULL;
    p_days := NULL;
    RETURN NULL;
END age_calc;
/

SET SERVEROUTPUT ON;

DECLARE
  v_dob     DATE;
  v_years   NUMBER;
  v_months  NUMBER;
  v_days    NUMBER;
BEGIN
  v_dob := TO_DATE('&v_dob', 'DD-MON-YYYY');
  v_years := age_calc(v_dob, v_months, v_days);
  DBMS_OUTPUT.PUT_LINE('Age: ' || v_years || ' years, ' || v_months || ' months, ' || v_days || ' days.');
END;
/
