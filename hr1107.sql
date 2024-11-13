CREATE TABLE EMP02(
    EMPNO NUMBER(4) NOT NULL,
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE NOT NULL,
    SALARY NUMBER(7,2) NOT NULL,
    COMM NUMBER(7,2) DEFAULT 0.0,
    DEPTNO NUMBER(2) NOT NULL
);

alter table emp02 add constraint emp02_empno_pk primary key(empno);

insert into emp02 values(7369,'SMITH','CLEAK',7836, TO_DATE('80/12/17','YY/MM/DD'), 800, 0.0, 20);
insert into emp02 values(7499,'ALLEN','SALESMAN',7369, TO_DATE('87/12/20','YY/MM/DD'), 1600, 300, 30);
insert into emp02 values(7839,'KING','PRESIDENT',NULL, TO_DATE('81/02/08','YY/MM/DD'), 5000, 0.0, 10);

select * from emp02;

CREATE TABLE MEMBERS(
    ID VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(20) NOT NULL,
    REGNO VARCHAR2(13) NOT NULL,
    HP VARCHAR2(13) NOT NULL,
    ADDRESS VARCHAR2(100) NOT NULL   
);

alter table members add constraint members_id_pk primary key(id);

CREATE TABLE BOOKS(
    CODE NUMBER(4) NOT NULL,
    TITLE VARCHAR2(50) NOT NULL,
    COUNT NUMBER(6) NOT NULL,
    PRICE NUMBER(10) NOT NULL,
    PUBLISH VARCHAR2(50) NOT NULL
);

alter table books add constraint books_code_pk primary key(code);





CREATE TABLE V_GOGEK(
    G_CODE NUMBER(5) NOT NULL,
    G_NAME VARCHAR2(20) NOT NULL,
    G_AGE NUMBER(3),
    G_ADDR VARCHAR2(50),
    G_TEL VARCHAR2(20)
);

alter table v_gogek add constraint v_gogek_g_code_pk primary key(g_code);

CREATE TABLE VIDEO(
    V_CODE NUMBER(5),
    V_TITLE VARCHAR2(50) NOT NULL,
    V_GENRE VARCHAR2(30),
    V_PAY NUMBER(7) NOT NULL,
    V_LAND_STATE NUMBER(1),
    V_MAKE_COMPANY VARCHAR2(50),
    V_MAKE_DATE DATE,
    V_VIEW_AGE NUMBER(1)
);

alter table video add constraint video_v_code_pk primary key(v_code);

CREATE TABLE LEND_RETURN(
    LR_CODE NUMBER(5) NOT NULL,
    G_CODE NUMBER(5) NOT NULL,
    V_CODE NUMBER(5) NOT NULL,
    L_DATE DATE,
    R_PLAN_DATE DATE,
    L_TOTAL_PAY NUMBER(7)
);

alter table lend_return add constraint lend_return_lr_code_pk primary key(lr_code);
alter table lend_return add constraint lend_return_g_code_fk foreign key(g_code) references v_gogek(g_code);
alter table lend_return add constraint lend_return_v_code_fk foreign key(v_code) references video(v_code);

