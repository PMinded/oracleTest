-- PL/SQL 
-- 내용을 employee 에 해당된 모든직원 이름, 직업, 사원번호를 출력해주는 프로그램을 작성하시오.
DECLARE
    -- 배열타입정의(테이블타입정의)
    TYPE FIRST_NAME_ARRAY_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER; 
    TYPE JOB_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE INDEX BY BINARY_INTEGER; 
    TYPE EMPLOYEE_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY BINARY_INTEGER; 
    -- 배열타입변수선언
    FIRST_NAME_ARRAY FIRST_NAME_ARRAY_TYPE; 
    JOB_ID_ARRAY JOB_ID_ARRAY_TYPE; 
    EMPLOYEE_ID_ARRAY EMPLOYEE_ID_ARRAY_TYPE;
    ROW_ARRAY EMPLOYEES%ROWTYPE;
    I BINARY_INTEGER := 0; 
    J BINARY_INTEGER; 
BEGIN
    -- 향샹된 포문을 통해서 RESULT SET값을 한개씩 가져와서 각 컬럼배열에 저장한다. 
    FOR ROW_ARRAY IN (SELECT * FROM EMPLOYEES) LOOP
        I := I + 1; 
        FIRST_NAME_ARRAY(I) := ROW_ARRAY.FIRST_NAME; 
        JOB_ID_ARRAY(I) := ROW_ARRAY.JOB_ID; 
        EMPLOYEE_ID_ARRAY(I) := ROW_ARRAY.EMPLOYEE_ID; 
    END LOOP; 
    -- 향상된 포문을 이용해서 컬럼 배열값에 저장된 값을 가져와서 출력하시오. 
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(FIRST_NAME_ARRAY(J) ||  '  /  ' || JOB_ID_ARRAY(J)|| '  /  ' ||EMPLOYEE_ID_ARRAY(J)); 
    END LOOP; 

END; 
/


DECLARE
    TYPE FIRST_NAME_ARRAY_TYPE IS TABLE OF EMPLOYEES.FIRST_NAME%TYPE INDEX BY BINARY_INTEGER;
    TYPE JOB_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.JOB_ID%TYPE INDEX BY BINARY_INTEGER;
    TYPE EMPLOYEE_ID_ARRAY_TYPE IS TABLE OF EMPLOYEES.EMPLOYEE_ID%TYPE INDEX BY BINARY_INTEGER;
    
    FIRST_NAME_ARRAY FIRST_NAME_ARRAY_TYPE; 
    JOB_ID_ARRAY JOB_ID_ARRAY_TYPE; 
    EMPLOYEE_ID_ARRAY EMPLOYEE_ID_ARRAY_TYPE;
    ROW_ARRAY EMPLOYEES%ROWTYPE;
    I BINARY_INTEGER := 0; 
    J BINARY_INTEGER; 
BEGIN
    FOR ROW_ARRAY IN (SELECT * FROM EMPLOYEES) LOOP
        I := I + 1; 
        FIRST_NAME_ARRAY(I) := ROW_ARRAY.FIRST_NAME; 
        JOB_ID_ARRAY(I) := ROW_ARRAY.JOB_ID; 
        EMPLOYEE_ID_ARRAY(I) := ROW_ARRAY.EMPLOYEE_ID; 
    END LOOP;
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(FIRST_NAME_ARRAY(J)||' // '|| JOB_ID_ARRAY(J)||' // '||EMPLOYEE_ID_ARRAY(J));
    END LOOP;
    
END;
/


--PL/SQL
--내용을 employee'Susan' 이름을 갖는 사원의 사원번호와 사원명과 부서번호를 출력하시오

DECLARE
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VLAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID INTO VEMPLOYEE_ID, VFIRST_NAME, VLAST_NAME, VDEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME='Susan';
    
    DBMS_OUTPUT.PUT_LINE(VEMPLOYEE_ID||' , '|| VFIRST_NAME||' , ' || VLAST_NAME||' , '|| VDEPARTMENT_ID);
END;
/

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME='Susan';



--PL/SQL
--내용을 employee 최고경영자 사원번호, 이름, 담당업무, 부서번호를 출력하시오(로우 타입변수 활용)
DECLARE
    --로우 타입 변수선언
    EMP_RECORD EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO EMP_RECORD FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||EMP_RECORD.FIRST_NAME || ' ' || EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('부서번호 : '||EMP_RECORD.DEPARTMENT_ID);
END;
/


select employee_id, first_name, salary, salary*12+(nvl(commission_pct,0)*salary) as "연봉" from employees where manager_id is null;

DECLARE
    --로우 타입 변수선언, 연봉타입선언
    EMP_RECORD EMPLOYEES%ROWTYPE;
    TOTAL_SALARY NUMBER(10,2);
BEGIN
    SELECT * INTO EMP_RECORD FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
    
    IF(EMP_RECORD.COMMISSION_PCT IS NULL)THEN EMP_RECORD.COMMISSION_PCT :=0;
    END IF;
    
    TOTAL_SALARY := EMP_RECORD.SALARY*12+(EMP_RECORD.SALARY*EMP_RECORD.COMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||EMP_RECORD.FIRST_NAME || ' ' || EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('전체연봉 : '||LTRIM(TO_CHAR(TOTAL_SALARY,'$999,999,999.99')));
END;
/