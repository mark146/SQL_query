select * from tab;

select * from emp;

create table ex_dept(
 deptno varchar2(4),
 deptname varchar2(20),
 constraint deptpk primary key(deptno) 
);

create table ex_emp(
 empno number(10),
 ename varchar2(20),
 sal number(10,2) default 0,
 deptno varchar2(4) not null,
 createdate date default sysdate,
 constraint emppk primary key(empno),
 constraint deptfk foreign key(deptno) references ex_dept(deptno)
);

drop table ex_emp;

insert into ex_dept values('1000','�λ���');
insert into ex_dept values('1001','�ѹ���');
update ex_dept set deptname = '�ѹ���' where deptno='1001';
commit;

select * from ex_dept;
select * from tab;
select * from ex_emp;

<-- ���̺�� ���� -->
alter table ex_emp rename to new_emp;

<-- Į���߰� -->
alter table ex_emp add(age number(2) default 1);

<-- Į�� ���� -->
alter table ex_emp modify (ename varchar2(40) not null);

<-- Į�� ���� -->
alter table ex_emp drop column age;

<-- Į���� ���� -->
alter table ex_emp rename column ename to new_ename;

<-- ���̺� ���� -->
drop table ex_emp;
drop table ex_emp cascade constraint;

<-- �� ���� -->
create view t_emp as select * from ex_emp;
select * from t_emp;

<-- �� ���� -->
drop view t_sam;
select * from tab;

<-- DML -->
insert into ex_emp values(1000, '�Ӻ���Ʈ');

<-- SELECT���� ����Ͽ� �����͸� ��ȸ�ؼ� �ش� ���̺� �ٷ� ������ �� �ִ�. ��, �ԷµǴ� ���̺��� ������ �����Ǿ� �־�� ��-->
INSERT INTO DEPT_TEST SELECT * FROM DEPT;
 
<-- INSERT ���� ��� ��� -->
ALTER TABLE EX_DEPT NOLOGGING;

<-- UPDATE -->
UPDATE EX_EMP SET ENAME = '?' WHERE EMPNO = ?;

<-- DELETE -->
DELETE FROM EX_EMP WHERE EMPNO = ?;

<-- ���̺� �뷮 �ʱ�ȭ(����Ŭ�� �ش�) -->
TRUNCATE TABLE EX_EMP;

DESC EX_EMP;

INSERT INTO EX_EMP VALUES(1000, 'TEST1', 20000, 1000, SYSDATE);
INSERT INTO EX_EMP VALUES(1001, 'TEST2', 20000, 1000, SYSDATE);
INSERT INTO EX_EMP VALUES(1002, 'TEST3', 20000, 1001, SYSDATE);

<-- HINT ��� -->
SELECT /*+ INDEX_DESC(A) */ * FROM EMP A;

<-- DISTINCT�� ALIAS -->
SELECT DEPTNO FROM EX_EMP ORDER BY DEPTNO;
SELECT DISTINCT DEPTNO FROM EX_EMP ORDER BY DEPTNO;
SELECT ENAME AS "�̸�" FROM EX_EMP A WHERE A.EMPNO=1000;

SELECT * FROM EMP WHERE EMPNO = 1001 AND SAL >= 1000;

<-- LIKE -->
SELECT * FROM EX_EMP WHERE ENAME LIKE 'TEST%';
SELECT * FROM EX_EMP WHERE ENAME LIKE '%1';
SELECT * FROM EX_EMP WHERE ENAME LIKE 'TEST_';

<-- BETWEEN -->
SELECT * FROM EMP WHERE SAL BETWEEN 1000 AND 2000;
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1000 AND 2000;

<-- IN -->
SELECT * FROM EMP WHERE JOB IN ('CLERK', 'MANAGER');
SELECT * FROM EMP WHERE (JOB,ENAME) 
IN (('CLERK','test11'),('MANAGER','test4'));

<-- NULL�� ��ȸ -->
SELECT * FROM EMP WHERE MGR IS NULL;
SELECT * FROM EMP WHERE MGR IS NOT NULL;

<-- GROUP ���� -->
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) > 10000;

<-- COUNT -->
SELECT COUNT(*) FROM EMP;
SELECT COUNT(MGR) FROM EMP;

<-- GROUP BY ��� �� -->
SELECT DEPTNO, MGR, AVG(SAL) FROM EMP
GROUP BY DEPTNO, MGR;

<-- ������ �޿� �հ��߿� �޿� �հ谡 1000�̻��� ���� -->
SELECT JOB, SUM(SAL) FROM EMP
GROUP BY JOB 
HAVING SUM(SAL) > 1000;

SELECT DEPTNO, SUM(SAL) FROM EMP WHERE EMPNO BETWEEN 1000 AND 1003
GROUP BY DEPTNO;

<-- 190611 -->
SELECT ENAME FROM EMP WHERE EMPNO=1000 GROUP BY ENAME HAVING COUNT(*) >=1 ORDER BY ENAME;

DESC DUAL;

SELECT ASCII('a'), SUBSTR('ABC',1,2), LENGTH('A BC'), LTRIM(' ABC'), LENGTH(LTRIM(' ABC')) FROM DUAL;

<-- TO_CHAR: ����ȯ �Լ� �߿��� ���� ���� ���, ���ڳ� ��¥�� ���ϴ� ������ ���ڿ��� ��ȯ -->
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE), TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL;

<-- ABS: ���밪�� ������, SIGN: ���,����,0�� �����Ѵ�. MOD: ����1�� ���� 2�� ���� ������ ���, CEIL/CEILING: ���ں��� ũ�ų� ���� �ּ��� ������ ������ -->
<-- FLOOR: ���ں��� �۰ų� ���� �ִ��� ������ �����ش�. ROUND: �Ҽ��� m�ڸ����� �ݿø��Ѵ�. TRUNC: �Ҽ��� m �ڸ����� ���� -->
SELECT ABS(-1), SIGN(10), MOD(4, 2), CEIL(10.9), FLOOR(10.1), ROUND(10.222, 1) FROM DUAL;

<-- DECODE: IF�� ���� Ư�� ������ ���̸� A, �����̸� B -->
SELECT DECODE(EMPNO, 1000, 'TRUE','FALSE') FROM EMP;

<-- CASE: IF~THEN ~ELSE-END, ������ WHEN���� ����ϰ� THEN�� �ش� ������ ���̸� ����, �����̸� ELSE ���� ���� -->
SELECT CASE
        WHEN EMPNO = 1000 THEN 'A'
        WHEN EMPNO = 1001 THEN 'B'
        ELSE 'C'
       END
FROM EMP;

<-- ROWNUM: SELECT���� ����� ���� ������ �ϷĹ�ȣ�� �ο�, ��ȸ�Ǵ� �� ���� ������ �� ���� ���, �������� ���� ������ �ö� �ζ��κ� ��� -->
SELECT * FROM EMP WHERE ROWNUM <= 1;

<-- �ζ��� �並 ����ϰ� ROWNUM�� ��Ī�� ����ؾ� �Ѵ�. -->
SELECT * FROM 
( SELECT ROWNUM LIST, ENAME FROM EMP )
WHERE LIST <= 5;

<-- ROWNUM�� BETWEEN���� ����ؼ� �� ������ ��ȸ ���� -->
SELECT * FROM
( SELECT ROWNUM LIST, ENAME FROM EMP )
WHERE LIST BETWEEN 5 AND 10;

<-- ROWID -->
DESC EMP;
SELECT ROWID, ENAME FROM EMP;

<-- WITH: ���������� ����ؼ� �ӽ� ���̺��̳� ��ó�� ����� �� �ִ� �����̴�. �������� ��Ͽ� ��Ī�� ������ �� �ִ�. ��Ƽ�������� SQL�� �ζ��� �䳪 �ӽ� ���̺�� �Ǵ��Ѵ�. -->
WITH VIEWDATA AS
(SELECT * FROM EMP
UNION ALL
SELECT * FROM EMP)
SELECT * FROM VIEWDATA WHERE EMPNO=1000;

<-- DCL -->
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE ON USER;

<-- WITH GRANT OPTION: Ư�� ����ڿ��� ������ �ο��� �� �ִ� ������ �ο� -->
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO USER WITH GRANT OPTION;

<-- REVOKE -->
REVOKE privileges ON tabe FROM user;

<-- TCL -->
commit;

set autocommit on;

<-- rollback: �����Ϳ� ���� ���� ������ ����ϰ� Ʈ������� �����Ѵ�. ��, ������ commit�� �������� �����Ѵ�. -->
<-- rollback: ����� lock�� �����ǰ� �ٸ� ����ڵ� db���� ������ �� �ִ�. -->
rollback;

<-- savepoint: Ʈ������� �۰� �����Ͽ� �����ϴ� ������ savepoint�� ����ϸ� ������ ��ġ������ Ʈ������� rollback�� �� �ִ�.-->
<-- rollback -->
savepoint t1;


<-- EQUI ���� -->
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME LIKE 'test%' ORDER BY ENAME;


<-- INNER JOIN -->
SELECT * FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME LIKE 'test%' ORDER BY ENAME;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;


<-- INTERSECT: �� �� ���̺��� ����� ���� ��ȸ -->
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

<-- OUTER JOIN: �� ���� ���̺� ���� �������� ��ȸ�ϰ� ���� ���̺��� �ִ� �����͵� ���Խ��Ѽ� ��ȸ�Ѵ�. -->
<-- Outer join�� �� �� (+) ��ȣ�� ����ؼ� �� �� �ִ�. -->
SELECT * FROM DEPT, EMP
WHERE EMP.DEPTNO (+)= DEPT.DEPTNO;

<-- LEFT OUTER JOIN�� RIGHT OUTER JOIN: �� ���� ���̺��� ���� ���� ��ȸ�ϰ� ���� ���̺��� �ִ� ���� �����ؼ� ��ȸ�ȴ�. -->
SELECT * FROM DEPT LEFT OUTER JOIN EMP ON EMP.DEPTNO = DEPT.DEPTNO;
SELECT * FROM DEPT RIGHT OUTER JOIN EMP ON EMP.DEPTNO = DEPT.DEPTNO;

<-- CROSS JOIN: ���� ���� �� ���� 2���� ���̺��� �ϳ��� �����Ѵ� -->
SELECT * FROM EMP CROSS JOIN DEPT;

<-- UNION: �� ���� ���̺��� �ϳ��� ��ġ�鼭 �ߺ��� �����͸� ����, SORT ������ �߻� -->
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM EMP;

<-- UNION ALL: �� ���� ���̺��� �ϳ��� ��ġ�� ��, �ߺ��� �����ϰų� ������ �������� ���� -->
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM EMP;

<-- MINUS: �� ���� ���̺��� �������� ��ȸ�Ѵ�. ��, ���� �� SELECT������ �ְ� �ڿ� ���� SELECT ������ ���� ������ ��ȸ�ϴ� ���̴�. -->
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

<-- ������ ��ȸ(connect by): Ʈ�������� ������ ���Ǹ� �����ϴ� ������ start with���� ���������� �ǹ� connect by prior�� ���� �����̴�. root ���κ��� ���� ����� ���Ǹ� �����Ѵ�. -->
DESC EMP;

SELECT MAX(LEVEL)
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

SELECT LEVEL, EMPNO, MGR, ENAME
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

<-- 4*LEVEL-1�� �ִ�. LEVEL���� ROOT�̸� 1�̵ȴ�. ���� 4*(1-1)=0�� �ȴ�. -->
<-- ��, root�� ���� LPAD('',0)�̹Ƿ� �ƹ��� �ǹ̰� ����. -->
SELECT LEVEL, LPAD(' ', 4 * (LEVEL -1)) || EMPNO, MGR,CONNECT_BY_ISLEAF
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

<-- subquery: select�� ���� �ٽ� select���� ����ϴ� sql�̴�. ���´� from���� select���� ����ϴ� �ζ��� ��� select���� subquery�� ����ϴ� ��Į�� �������� ���� �ִ�. -->
SELECT * FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DEPTNO=10);

<-- FROM���� SELECT���� ����Ͽ� ������ ���̺��� ����� ȿ���� ���� �� �ִ�. FROM���� SELECT���� ����� ���� �ζ��� ���̴�. -->
SELECT * FROM
(SELECT ROWNUM NUM,ENAME FROM EMP) a
WHERE NUM < 5;

<-- ���� ���� �� �߿��� �ϳ��� ���� �Ǿ ���� �Ǵ� ���� -->
SELECT ENAME, DNAME, SAL
FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EMP.EMPNO
IN (SELECT EMPNO FROM EMP WHERE SAL > 2000);

<-- ALL: ���������� ���������� ����� ��� �����ϸ� �� -->
SELECT * FROM EMP
WHERE DEPTNO <= ALL (20, 30);

<-- EXISTS: ���������� � ������ ���� ���θ� Ȯ���ϴ� ��, ����� ���� ������ ��ȯ�� -->
SELECT ENAME, DNAME, SAL FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EXISTS (SELECT 1 FROM EMP WHERE SAL > 2000);

<-- ��Į�� ��������: �ݵ�� �� ��� �� Į���� ��ȯ�ϴ� ���������̴�. -->
SELECT ENAME AS "�̸�", SAL AS "�޿�",(SELECT AVG(SAL) FROM EMP) AS "��ձ޿�" FROM EMP WHERE EMPNO=1000;

<-- ���� ��������: �������������� Main Query ���� Į���� ����ϴ� ���� �ǹ��Ѵ�. -->
SELECT * FROM EMP A WHERE A.DEPTNO = 
(SELECT DEPTNO FROM DEPT B WHERE B.DEPTNO=A.DEPTNO);

<-- ROLLUP: GROUP BY�� Į���� ���ؼ� Subtotal�� ����� �ش�. group by���� Į���� �� �� �̻� ���� ������ ���� ����� �޶�����. -->
SELECT DECODE(DEPTNO, NULL, '��ü�հ�',DEPTNO) AS DEPTNO, SUM(SAL) FROM EMP GROUP BY ROLLUP(DEPTNO);

select deptno, sum(sal) from emp group by deptno
union all

select "��ü�հ�", sum(sal) from emp;


SELECT DECODE(DEPTNO, NULL, '��ü�հ�',DEPTNO) AS DEPTNO, JOB, SUM(SAL) AS SAL FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

<-- GROUPING�Լ�: ROLLUP, CUBE, GROUPING SETS���� �����Ǵ� �հ� ���� �����ϱ� ���ؼ� ������� �Լ� -->
<-- �Ұ�,�հ� ���� ���Ǹ� GROUPING �Լ��� 1 ��ȯ �׷��� ������ 0�� ��ȯ -->
SELECT DEPTNO, GROUPING(DEPTNO), JOB,GROUPING(JOB), SUM(SAL) FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO,
DECODE(GROUPING(DEPTNO),1,'��ü�հ�') TOT, JOB,
DECODE(GROUPING(JOB),1,'�μ��հ�') T_DEPT, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

<-- GROUPING SETS: GROUP BY�� ������ Į���� ������ ������� �پ��� �Ұ踦 ���� �� �ִ�. GROUP BY�� ������ Į���� ������ ������� ���������� ��� ó�� -->
SELECT DEPTNO, JOB,SUM(SAL) FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB);

<-- CUBE: CUBE�Լ��� ������ Į���� ���ؼ� ���� ������ ��� ���踦 ��� -->
SELECT DEPTNO, JOB, SUM(SAL) FROM EMP
GROUP BY CUBE(DEPTNO, JOB);

<-- ������ �Լ� -->
SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) TOTSAL FROM EMP;

SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TOTSAL FROM EMP;

SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)TOTSAL FROM EMP;

<-- RANK Function -->
SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) ALL_RANK, RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK FROM EMP;

SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) ALL_RANK, DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK FROM EMP;

SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) ALL_RANK, ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUM FROM EMP;

<-- �����Լ� -->
SELECT ENAME, SAL, SUM(SAL) OVER (PARTITION BY MGR) NUM_MGR FROM EMP;

SELECT DEPTNO, ENAME, SAL, FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A FROM EMP;

SELECT DEPTNO, ENAME, SAL, LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS DEPT_A FROM EMP;

SELECT DEPTNO, ENAME, SAL, LAG(SAL) OVER(ORDER BY SAL DESC) AS PRE_SAL FROM EMP;

SELECT DEPTNO, ENAME, SAL, LEAD(SAL,2) OVER(ORDER BY SAL DESC) AS PRE_SAL FROM EMP;

<-- ���� ���� �Լ� -->
SELECT DEPTNO, ENAME, SAL, PERCENT_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERCENT_SAL FROM EMP;

SELECT DEPTNO, ENAME, SAL, NTILE(4) OVER(ORDER BY SAL DESC) AS N_TILE FROM EMP;

<-- ��Ƽ������ -->
DESC PLAN_TABLE;

SELECT /*+ RULE */ * FROM EMP WHERE ROWID='AAAFL4AAEAAAAGlAAA';

<-- INDEX ���� -->
SELECT * FROM TAB;
CREATE INDEX IDX_EMP ON EMP (ENAME ASC, SAL DESC);

<-- INDEX UNIQUE SCAN: �ε����� Ű ���� �ߺ����� �ʴ� ���, �ش� �ε����� ����� �� �߻� -->
SELECT * FROM EMP WHERE EMPNO=1000;

<-- INDEX RANGE SCAN: SELECT������ Ư�� ������ ��ȸ�ϴ� WHERE���� ����� ��� �߻�. ��: Like, Between�� ��ǥ��. ���� ������ ���� ���� ���� �ε��� ��ü�� �������� �ʰ� table full scan�� �� �� �ִ�. -->
<-- �ε����� Leaf Block�� Ư�� ������ ��ĵ -->
SELECT EMPNO FROM EMP WHERE EMPNO >= 1000;

<-- INDEX FULL SCAN: �ε������� �˻��Ǵ� �ε��� Ű�� ���� ��쿡 Leaf Block�� ó������ ������ ��ü�� �о� ���δ�. -->
SELECT ENAME, SAL FROM EMP WHERE ENAME LIKE '%' AND SAL > 0;

<-- Nested Loop ���� -->
SELECT /*+ ORDERED USE_NL(B) */ * FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO AND A.DEPTNO = 10;

<-- Sort Merge ����: �� ���� ���̺��� SORT_AREA��� �޸� ������ ��� �ε��ϰ� SORT�� ���� -->
<-- ������ �߻��ϱ� ������ ������ ���� �������� ������ �������� �ȴ�. ���ĵ����;��� �ʹ� ������ ������ �ӽ� �������� ����ȴ�. �ӽÿ����� ��ũ�� �ֱ⿡ ������ �ް��� ������ -->
<-- USE_MERGE ��Ʈ�� ����ؼ� SORT MERGE ������ �ϰ� �� ���� �ִ�. ��, USE_MERGE ��Ʈ�� ORDERED ��Ʈ�� ���� ����ؾ� �Ѵ�. -->
SELECT /*+ ORDERED USE_MERGE(B) */ * FROM EMP A, DEPT B WHERE A.DEPTNO = B.DEPTNO AND A.DEPTNO = 10;

<-- Hash ����: �� ���� ���̺� �߿��� ���� ���̺��� hash �޸𸮿� �ε��ϰ� �� ���� ���̺��� ���� Ű�� ����ؼ� �ؽ� ���̺��� �����Ѵ�. -->
<-- �ؽ��Լ��� ����ؼ� �ּҸ� ����ϰ� �ش� �ּҸ� ����ؼ� ���̺��� �����ϱ� ������ cpu ������ ���� �Ѵ�. -->
<-- Ư�� hash ���� �ÿ��� ���� ���̺��� ũ�Ⱑ �۾Ƽ� ����� �޸𸮿� �ε��Ǿ�� �Ѵ�. -->
SELECT /*+ ORDERED USE_HASH(B) */ * FROM EMP A, DEPT B WHERE A.DEPTNO = B.DEPTNO AND A.DEPTNO = 10;