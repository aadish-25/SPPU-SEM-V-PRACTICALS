-- Write a PL/SQL code block to calculate the area of a circle for a
-- value of radius varying from 5 to 9. Store the radius and the
-- corresponding values of calculated area in an empty table named
-- areas, consisting of two columns, radius and area.

CREATE TABLE CIRCLE(radius NUMBER, area decimal(10, 2));

SET SERVEROUTPUT ON;
DECLARE
    radius NUMBER;
    area decimal(10, 2);
BEGIN
    FOR radius in 5..9 LOOP
        area:= 3.14*radius*radius;
        DBMS_OUTPUT.PUT_LINE('Area of circle with radius '|| radius || ' is ' || area);
        INSERT INTO CIRCLE (radius, area) VALUES(radius, area);
    END LOOP;
END;
/

-- Run after executing the PL/SQL
SELECT * FROM CIRCLE;

