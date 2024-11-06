--테이블설계하기(사원번호,사원명,급여):DDL
--class EMP01{
--  public int no;
--  public String name;
--  public double salary;
--}
create table EMP01(
    no NUMBER(4),
    name VARCHAR2(20) not null,
    salary NUMBER(10,2) default 1000.0,
    CONSTRAINT EMP01_no_PK primary key(no),
    CONSTRAINT EMP01_name_UK UNIQUE(name)
);


--테이블 정보구하기
select * from tab;
--테이블 삭제하기(ddl)
drop table emp01;
--휴지통보기
select * from recyclebin;
--휴지통복원
flashback table emp01 to before drop;
--테이블 복사(제약조건은 복사가 안됨)
desc employees;
select count(*) from employees;
create table emple02 as select * from employees;
desc emple02;
select count(*) from emple02;
--제약조건 걸기(primary key, unique)
alter table emple02 add constraint emple02_id_pk primary key(employee_id);
alter table emple02 add constraint emple02_email_uk unique(email);
--제약조건 삭제하기
alter table emple02 drop constraint emple02_email_uk;
--제약조건 확인하기
select * from user_constraints;
select table_name, constraint_name, constraint_type from user_constraints where table_name=upper('emple02');
--컬럼추가 emp01
alter table emp01 add job varchar2(10) not null;
desc emp01;
--컬럼 제거
alter table emp01 drop column job;
desc emp01;
--컬럼 변경(주의: 기존 값이 존재할 땐 생략할것 -> 타입변경 불가, 사이즈 큰것으로 변경 가능)
alter table emp01 modify job number(10) default 0;
desc emp01;
--컬럼 이름 변경
alter table emp01 rename column job to job2;
alter table emp01 rename column job2 to job;

--테이블명을 변경
rename emp01 to emp02;
rename emp02 to emp01;
select * from tab;

--
create table CUSTOMER(
    code char(7) NOT NULL,
    name VARCHAR2(10)NOT NULL,
    gender CHAR(1) NOT NULL,
    birth CHAR(8) NOT NULL,
    phone VARCHAR2(16),
    email VARCHAR2(30),
    point NUMBER(10) default 0
);

alter table CUSTOMER ADD CONSTRAINT CUSTOMER_code_pk PRIMARY KEY(code);
alter table CUSTOMER ADD CONSTRAINT CUSTOMER_email_uk UNIQUE(email);
alter table CUSTOMER ADD CONSTRAINT CUSTOMER_gender_ck check(gender in ('M','W'));

--제약조건 검색
select * from user_constraints where table_name='CUSTOMER';
desc emp01;
--제약조건 NOT NULL
alter table emp01 modify salary number(0,1)