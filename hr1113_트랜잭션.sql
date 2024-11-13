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