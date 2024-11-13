--employees 복사
create table emp03
as 
select * from employees;

--모든 사원의 부서번호를 30번으로 수정하자
select * from emp03;
update emp03 set department_id=30;
rollback;

--모든 사원의 급여를 10% 인상한다.
update emp03 set salary=salary*1.1;

--입사일을 오늘로 수정한다
update emp03 set hire_date=sysdate;

--부서번호가 10번인 사원의 부서번호를 30번으로 수정
update emp03 set department_id=30 where department_id=10;

--급여가 3000 이상인 사원만 급여를 10% 인상
update emp03 set salary=salary*1.1 where salary>=3000;

--2007년에 입사한 사원의 입사일이 오늘로 수정한다
update emp03 set hire_date=sysdate where substr(hire_date,1,2)='07';

--이름이 Susan의 부서번호는 20번으로, 직급은 FI_MGR
update emp03 set department_id=20, job_id='FI_MGR' where upper(FIRST_NAME)=upper('Susan');
select * from emp03 where first_name='Susan';

--LAST_NAME이 Russell인 사원의 급여(salary)를 17000으로, 커미션 비율(commission_pct)이 0.45로 인상됨
update emp03 set salary=17000, commission_pct=0.45 where upper(last_name)=upper('russell');

--30번 부서를 삭제
delete from emp03 where department_id=30;

create table MYCUSTOMER(
    CODE VARCHAR2(7),
    NAME VARCHAR2(10) NOT NULL,
    GENDER CHAR(1) NOT NULL,
    BIRTHDAY VARCHAR2(8) NOT NULL,
    PHONE VARCHAR2(16)
);

alter table mycustomer add constraint mycustomer_code_pk primary key(code);
alter table mycustomer add constraint mycustomer_gender_ck check(gender IN('M','W'));
alter table mycustomer add constraint mycustomer_phone_uk unique(phone);
desc mycustomer;

INSERT INTO MYCUSTOMER VALUES ('2017108','박승대','M','19711430','010-2580-9919');
INSERT INTO MYCUSTOMER VALUES ('2019302','전미래','W','19740812','010-8864-0232');
select * from mycustomer;
select * from customer;

--제약조건 검색기능(반드시 알아둘 것)
select * from user_constraints;
select * from user_tables;
select * from user_cons_columns where table_name='CUSTOMER';

--이메일 제약조건 해제
alter table customer drop constraint customer_email_uk;

--gender 제약조건 해제
alter table customer drop constraint customer_gender_ck;

--MERGE MYCUSTOMER->CUSTOMER 병합을 진행하는데 없으면 INSERT, 있으면 UPDATE
MERGE INTO CUSTOMER C
    USING MYCUSTOMER M
    ON (C.CODE = M.CODE)
    WHEN MATCHED THEN
        UPDATE SET C.NAME = M.NAME, C.GENDER = M.GENDER, C.BIRTH = M.BIRTHDAY, C.PHONE = M.PHONE
    WHEN NOT MATCHED THEN
        INSERT (C.CODE, C.NAME, C.GENDER, C.BIRTH, C.PHONE) values(M.CODE, M.NAME, M.GENDER, M.BIRTHDAY, M.PHONE);
        
select * from customer;
select * from mycustomer;
update mycustomer set name='박승우' where code = '2017108';

-- 두 테이블 관계설정하기
CREATE TABLE DEPT01(
    NO VARCHAR2(8),
    NAME VARCHAR2(10) NOT NULL,
    REGION VARCHAR2(10)
);
ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_NO_PK PRIMARY KEY(NO);
CREATE TABLE MEMBER(
    NO NUMBER(8),
    NAME VARCHAR2(10) NOT NULL,
    JOB_ID VARCHAR2(10),
    DEPT_NO VARCHAR2(8)
    );
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT01(NO);

CREATE TABLE DEPT02(
    DEPT_NO NUMBER,
    DEPT_NAME VARCHAR2(10),
    LOCATION VARCHAR2(10)
);

ALTER TABLE DEPT02 ADD CONSTRAINT DEPT02_NO_PK PRIMARY KEY(DEPT_NO);

INSERT INTO DEPT02 VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT02 VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT02 VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT02 VALUES(40,'OPERATIONS','BOSTON');

CREATE TABLE MEMBER01(
    MEMBER_NO NUMBER,
    MEMBER_NAME VARCHAR(10),
    JOB_ID VARCHAR(10),
    DEPT_NO NUMBER
);

ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_NO_PK PRIMARY KEY(MEMBER_NO);
ALTER TABLE MEMBER01 ADD CONSTRAINT MEMBER01_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT02(DEPT_NO);

INSERT INTO MEMBER01 VALUES(7499,'ALLEN','SALESMAN',30);
INSERT INTO MEMBER01 VALUES(7566,'JONES','MANAGER',50);--무결성 제약조건 위배
INSERT INTO MEMBER01 VALUES(7566,'JONES','MANAGER',40);
SELECT * FROM MEMBER01;

DELETE FROM MEMBER01 WHERE DEPT_NO=40;
DELETE FROM DEPT02 WHERE DEPT_NO=40; --무결성 제약조건 위배

ALTER TABLE MEMBER DROP CONSTRAINT MEMBER01_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT02(NO) ON DELETE CASCADE;
