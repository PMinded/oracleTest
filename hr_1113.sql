--시퀀스생성
create sequence emp_seq
start with 1
increment by 1
minvalue 1
maxvalue 100000
nocycle
cache 2;
--user_tables, user_constraints, user_cons_columns, user_views, user_indexes, user_sequences
select * from user_sequences;

--employees 구조만 복사 emp01
drop table emp01;
create table emp01
as
select employee_id, first_name, hire_date from employees where 1=0;

select * from emp01;
desc emp01;

insert into emp01 values (emp_seq.nextval,'SJH', sysdate);

--emp_seq_currval 입력하기
select emp_seq.currval from dual;

--sequence dep_seq 생성하기, 시작값 10, 증가치 10, 결과치 30
create sequence dept_seq
start with 10
increment by 10
maxvalue 30;

select * from user_sequences;

--dept03 테이블 구조 복사하기
drop table dept03;

create table dept03
as
select department_id, department_name, location_id from departments where 1=0;

insert into dept03 values (dept_seq.nextval, '인사과', 1);
insert into dept03 values (dept_seq.nextval, '총무과', 2);
insert into dept03 values (dept_seq.nextval, '서무과', 3);

--sequence 수정하기
alter sequence dept_seq
maxvalue 100;

insert into dept03 values (dept_seq.nextval, '교육과', 4);

--sequence 삭제
drop sequence dept_seq;