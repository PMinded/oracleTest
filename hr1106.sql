--INSERT INTO 테이블명(컬럼명,,) VALUES(컬럼값, ,,)
create table IT(
    NO1 NUMBER,
    NO2 NUMBER,
    NO3 NUMBER
);

desc it;
insert into it values(1,2,3);
insert into it values(1,2,NULL);
insert into it(NO1,NO2) values(11,22);
insert into it(NO1,NO2) values(11,'문자');--오류발생
insert into it(NO1,NO2) values(111);--오류발생
insert into it(NO1,NO2) values(111,222,333);--오류발생
select * from it;

--NO3 NOT NULL 제약조건 걸기
delete from it where no3 is null;
alter table it modify NO3 NUMBER NOT NULL;

insert into it values(1111,NULL,3333);

--DEPT 테이블 생성
create table DEPT as select DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID from DEPARTMENTS;
select * from dept;
delete from dept;
truncate table dept; --구조만 남기고 완전히 지워버리기(롤백도 안됨)
rollback;