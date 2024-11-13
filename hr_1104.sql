-- hr resource 있는 테이블 정보(프로젝트 클래스 종류)
select * from tab;
--employees 테이블 구조(클래스 구조)
desc employees;
--employees 속에 들어있는 레코드(객체들) 보임
select * from employees;
--departments 테이블 객체(레코드=인스턴스)를 확인
select * from departments;
--departments 구조 확인
desc departments;
--department_id, department_name 확인
select department_id, department_name from departments;
--필드명에 별칭 사용하기
select department_id as "부서번호", department_name as "부서명" from departments;
select department_id as DEPT_NO, department_name as DEPT_NAME from departments;
select department_id as "DEPT_NO", department_name as "DEPT_NAME" from departments;
-- + ||
select '5'+5 from dual;
select '5'||5 from dual;
--문자열 기능을 이용해서 필드명을 보여주기
select first_name, job_id from employees;
select first_name ||'의 직급은 '|| job_id||'입니다' from employees;
select first_name ||'의 직급은 '|| job_id||'입니다' as data from employees;

--중복되지 않게 보여주기 (distinct)
select distinct job_id from employees;
--연봉을 3000 이상 받는 사람 정보
select * from employees where salary>=3000;
--2008년 이후에 입사한 직원 조사
select * from employees where hire_date>='2008/01/01';
select * from employees where TO_CHAR(hire_date,'YYYY/MM/DD')>='2008/01/01';
select * from employees where hire_date>=TO_DATE('2008/01/01','YYYY/MM/DD HH24:MI:SS');
--AND, BETWEEN a and B
select * from employees where salary>=2000 and salary<=3000;
select * from employees where salary between 2000 and 3000;
--or, in( , )직원번호가 67이거나 101이거나 184인 사원
select * from employees where employee_id=67 or employee_id=101 or employee_id=184;
select * from employees where employee_id in(67,101,184);
--NULL 연산, 비교, 할당 안된다
select 100-null from dual;
desc employees;
select * from employees where commission_pct is not null;
select * from employees where commission_pct is null;
<<<<<<< HEAD
SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES ORDER BY COMMISSION_PCT DESC;
-- ORDER BY ASC, DESC  사번을 기준으로 오름차순으로 정렬
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES ORDER BY EMPLOYEE_ID DESC; 
-- GROUP BY 
SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING DEPARTMENT_ID = 30;

SELECT  * FROM EMPLOYEES;
SELECT  * FROM EMPLOYEES WHERE DEPARTMENT_ID >= 70;
SELECT DEPARTMENT_ID, SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID >= 70;
SELECT DEPARTMENT_ID, SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID >= 70 GROUP BY DEPARTMENT_ID ;
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY),SUM(SALARY) ROUND(AVG(SALARY),1), COUNT(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID >= 70 GROUP BY DEPARTMENT_ID ;

--현재시간표션
select sysdate from dual;
select to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') from dual;
select floor(sysdate - to_date('2024/11/05','YYYY/MM/DD')) from dual;
--숫자를 우리가 원하는 형식으로 출력하기 1234567.23->$1,234,567.23
select to_char(1234567.23,'L999,999,999.99') as money from dual;
select first_name, trim(to_char(salary,'L999,999,999,999.99')) as money from employees;

--문자+문자=숫자
select to_number('10,000','999,999')+to_number('20,000','999,999') from dual;

--NVL
select first_name,salary,nvl(commission_pct,0),job_id from employees order by job_id;
=======
select employee_id, first_name, commission_pct from employees order by commission_pct desc;
--order by desc 사번을 기준으로 오름차순으로 정렬
select employee_id, first_name from employees order by employee_id asc;
select department_id, max(salary), min(salary), sum(salary), round(avg(salary),1), count(salary)
from employees where department_id>=70 group by department_id having sum(salary)>=30000;
--문자열 일부만 추출 substr(대상, 시작위치, 추출개수)
select substr('database',1,3) from dual;
--20번 부서에서 사원들의 입사 년도 가져오기
select employee_id, first_name, substr(hire_date,1,2)||'년도' as "입사년도" from employees where department_id=20;
SELECT TRIM(LEADING FROM ' ABCD ') LT, LENGTH(TRIM(LEADING FROM 'ABCD ')) LT_LEN,
TRIM(TRAILING FROM ' ABCD ') RT, LENGTH(TRIM(TRAILING FROM 'ABCD ')) RT_LEN, TRIM(BOTH FROM 'ABCD ') BOTH1, LENGTH(TRIM(BOTH FROM 'ABCD')) BOTH1,
TRIM('ABCD') BOTHT2, LENGTH(TRIM('ABCD')) BOTHLEN2 FROM DUAL;
--부서 30번 소속된 직원들 근무 달 수를 구하기
select first_name, hire_date as 입사일, sysdate as 현재날짜, round(months_between(sysdate,hire_date)) as 근무달수 from employees where department_id=30;
--next_day() 함수의 기능
select sysdate, to_char(sysdate,'yyyy/mm/dd hh24:mi:ss'), next_day(sysdate,'수요일') from dual;
>>>>>>> 77f90c28589ac6a3373eda00a38e6f1b6425aadf
