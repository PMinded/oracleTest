--Transaction
drop table dep02;

--테이블 복사(구조만 복사
create table dep02
as
select * from departments where 1=0;

--내용복사
insert into dep02 select * from departments;

select * from dep02;

savepoint c1;

delete from dep02 where department_id=90;

select * from dep02;

rollback to c1;




--employees 복사해서 emp_copy
create table emp_copy
as
select * from employees;

select * from emp_copy;

--view 제거하기
drop view view_emp01;

--view 생성하기
create view view_emp01
as
select employee_id, first_name, salary, department_id from emp_copy where department_id=10;

--select
select * from view_emp01;
select * from emp_copy where employee_id=200;
--view 수정하기
update view_emp01 set salary=4500 where employee_id=200;

--data dictionary(user_tables, user_constraints, user_cons_columns, user_views, user_indexes)
select * from user_tables;
select * from user_constraints;
select * from user_cons_columns where table_name='EMPLOYEES';
select * from user_views;
select * from user_indexes;

--가상뷰에 입력하기 (가상테이블에 컬럼 4개 입력, 원본 10개인데 그중 NOT NULL인데 가상테이블에 포함되어있지 않으면)

insert into view_emp01 values(1000,'SJH',2000,50);
select * from view_emp01;

select * from user_constraints where table_name='EMP_COPY';

--view 생성하기(테이블생성 복사하기 똑같음)
create view view_emp02
as
select employee_id, first_name, last_name, email, hire_date, job_id from emp_copy where department_id=10;

select * from view_emp02;
insert into view_emp02 values(1000,'JIHO','SHIN','jhbrian10@naver.com', to_date('02/01/20','DD/MM/YY'),'IT_DEV');

commit;
select * from emp_copy where employee_id=1000;

--view3 생성하기
create view view_emp03
as
select employee_id, first_name, last_name, email, hire_date, job_id from emp_copy;

select * from view_emp03;

insert into view_emp03 values(2000,'JIHO','SHIN','jhbrian10@naver.com', to_date('02/01/20','DD/MM/YY'),'IT_DEV');

select * from emp_copy where employee_id=2000;

--가상뷰에서 삭제를 진행하기
delete from view_emp03 where employee_id=2000;

--복합뷰 생성하기 (employees, departments) 두개의 테이블에서 조인해서 새로운 가상테이블 만들기
create or replace view view_emp_dep
as
select employee_id, first_name, salary, E.department_id, department_name, location_id
from employees E inner join departments D on E.department_id=D.department_id
order by E.department_id desc with read only;

select * from view_emp_dep;
select distinct department_id, department_name from view_emp_dep;
--부서명 it 연봉 평균, 최고값, 최저값을 구하시오
select department_name, max(salary),min(salary) from view_emp_dep where department_name='IT'group by department_name;

--view force
create or replace force view view_force
as
select employee_id, first_name, last_name, department_id from emp20;

desc view_force;

select * from emp20;

select * from user_views;

--rownum
select * from employees;
select rownum,department_id, employee_id, first_name from employees where department_id=100 order by first_name desc;
select rownum,department_id, employee_id, first_name from employees where department_id=100;

--rownum 정렬하면 순서가 흐트러진것을 다시 순서대로 보여주고 싶을때
select rownum, employee_id, first_name, hire_date from employees order by hire_date desc;

create view view_hiredate
as
select employee_id, first_name, hire_date from employees order by hire_date desc;

select rownum, employee_id, first_name, hire_date from view_hiredate;

select rownum, employee_id, first_name, hire_date from view_hiredate where rownum=4;

select rownum, employee_id, first_name, hire_date from
(select employee_id, first_name, hire_date from employees order by hire_date desc)
where rownum<=4;