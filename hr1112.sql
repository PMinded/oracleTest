select * from employees;

select first_name, job_id from employees where department_id=(select department_id from departments where department_name='Accounting');

select * from employees where department_id=10;

drop table emp02;
create table emp02
as
select employee_id, first_name from employees;
select * from emp02;

--서브쿼리를 이용해서 데이터 복사
--구조만 복사 departments 테이블 생성(DEP01)
create table dep01
as
select * from departments where 1=0;

drop table dep01;

-- 내용을 서브쿼리를 이용해서 저장하시오
insert into dep01(select * from departments);

--UPDATA 서브쿼리를 활용한다
--부서 10번에 지역위치를 부서 40번 지역위치로 수정하시오
update dep01 set location_id=(2400) where department_id=10;
update dep01 set location_id=(select location_id from departments where department_id=40) where department_id=10;

select * from employees;
select * from departments;

select first_name, salary from employees where salary>(select min(salary) from employees where job_id='ST_MAN') and department_id<>20;

select * from employees where job_id=(select job_id from employees where first_name='Valli') and salary=(select salary from employees where first_name='Valli') and first_name<>'Valli';

select department_id, first_name, salary from employees where salary>(select avg(salary) from employees where job_id=(select job_id from employees where first_name='Valli'));
select avg(salary) from employees;




select concat(first_name,concat(' ',last_name)) as NAME, job_id, salary from employees where salary>(select salary from employees where last_name='Tucker');

select concat(first_name,concat(' ',last_name)) as NAME, job_id, salary, hire_date from employees where salary=(select min(salary) from employees);

select concat(E.first_name,concat(' ',E.last_name)) as NAME, E.salary, E.department_id, E.job_id from employees E join (select department_id, avg(salary) as avg_salary from employees group by department_id) D on E.department_id = D.department_id where E.salary > D.avg_salary;

select concat(E.first_name,concat(' ',E.last_name)) as NAME, E.job_id, E.salary, E.department_id, D.department_avg_salary from employees E join (select department_id, avg(salary) as department_avg_salary from employees group by department_id) D on  E.department_id = D.department_id;

select  first_name||' '||last_name Name ,job_id,salary,department_id, (select round(avg(salary),2) from employees d where e.department_id=d.department_id) "department Avg Salary" 

from employees e;