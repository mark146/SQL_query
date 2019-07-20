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

insert into ex_dept values('1000','인사팀');
insert into ex_dept values('1001','총무팀');
update ex_dept set deptname = '총무팀' where deptno='1001';
commit;

select * from ex_dept;
select * from tab;
select * from ex_emp;

<-- 테이블명 변경 -->
alter table ex_emp rename to new_emp;

<-- 칼럼추가 -->
alter table ex_emp add(age number(2) default 1);

<-- 칼럼 변경 -->
alter table ex_emp modify (ename varchar2(40) not null);

<-- 칼럼 삭제 -->
alter table ex_emp drop column age;

<-- 칼럼명 변경 -->
alter table ex_emp rename column ename to new_ename;

<-- 테이블 삭제 -->
drop table ex_emp;
drop table ex_emp cascade constraint;

<-- 뷰 생성 -->
create view t_emp as select * from ex_emp;
select * from t_emp;

<-- 뷰 삭제 -->
drop view t_sam;
select * from tab;

<-- DML -->
insert into ex_emp values(1000, '임베스트');

<-- SELECT문을 사용하여 데이터를 조회해서 해당 테이블에 바로 삽입할 수 있다. 단, 입력되는 테이블은 사전에 생성되어 있어야 함-->
INSERT INTO DEPT_TEST SELECT * FROM DEPT;
 
<-- INSERT 느릴 경우 사용 -->
ALTER TABLE EX_DEPT NOLOGGING;

<-- UPDATE -->
UPDATE EX_EMP SET ENAME = '?' WHERE EMPNO = ?;

<-- DELETE -->
DELETE FROM EX_EMP WHERE EMPNO = ?;

<-- 테이블 용량 초기화(오라클만 해당) -->
TRUNCATE TABLE EX_EMP;

DESC EX_EMP;

INSERT INTO EX_EMP VALUES(1000, 'TEST1', 20000, 1000, SYSDATE);
INSERT INTO EX_EMP VALUES(1001, 'TEST2', 20000, 1000, SYSDATE);
INSERT INTO EX_EMP VALUES(1002, 'TEST3', 20000, 1001, SYSDATE);

<-- HINT 사용 -->
SELECT /*+ INDEX_DESC(A) */ * FROM EMP A;

<-- DISTINCT와 ALIAS -->
SELECT DEPTNO FROM EX_EMP ORDER BY DEPTNO;
SELECT DISTINCT DEPTNO FROM EX_EMP ORDER BY DEPTNO;
SELECT ENAME AS "이름" FROM EX_EMP A WHERE A.EMPNO=1000;

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

<-- NULL값 조회 -->
SELECT * FROM EMP WHERE MGR IS NULL;
SELECT * FROM EMP WHERE MGR IS NOT NULL;

<-- GROUP 연산 -->
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) > 10000;

<-- COUNT -->
SELECT COUNT(*) FROM EMP;
SELECT COUNT(MGR) FROM EMP;

<-- GROUP BY 사용 예 -->
SELECT DEPTNO, MGR, AVG(SAL) FROM EMP
GROUP BY DEPTNO, MGR;

<-- 직업별 급여 합계중에 급여 합계가 1000이상인 직원 -->
SELECT JOB, SUM(SAL) FROM EMP
GROUP BY JOB 
HAVING SUM(SAL) > 1000;

SELECT DEPTNO, SUM(SAL) FROM EMP WHERE EMPNO BETWEEN 1000 AND 1003
GROUP BY DEPTNO;

<-- 190611 -->
SELECT ENAME FROM EMP WHERE EMPNO=1000 GROUP BY ENAME HAVING COUNT(*) >=1 ORDER BY ENAME;

DESC DUAL;

SELECT ASCII('a'), SUBSTR('ABC',1,2), LENGTH('A BC'), LTRIM(' ABC'), LENGTH(LTRIM(' ABC')) FROM DUAL;

<-- TO_CHAR: 형변환 함수 중에서 가장 많이 사용, 숫자나 날짜를 원하는 포맷의 문자열로 변환 -->
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE), TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL;

<-- ABS: 절대값을 돌려줌, SIGN: 양수,음수,0을 구별한다. MOD: 숫자1을 숫자 2로 나눠 나머지 계산, CEIL/CEILING: 숫자보다 크거나 같은 최소의 정수를 돌려줌 -->
<-- FLOOR: 숫자보다 작거나 같은 최대의 정수를 돌려준다. ROUND: 소수점 m자리에서 반올림한다. TRUNC: 소수점 m 자리에서 절삭 -->
SELECT ABS(-1), SIGN(10), MOD(4, 2), CEIL(10.9), FLOOR(10.1), ROUND(10.222, 1) FROM DUAL;

<-- DECODE: IF문 구현 특정 조건이 참이면 A, 거짓이면 B -->
SELECT DECODE(EMPNO, 1000, 'TRUE','FALSE') FROM EMP;

<-- CASE: IF~THEN ~ELSE-END, 조건을 WHEN구에 사용하고 THEN은 해당 조건이 참이면 실행, 거짓이면 ELSE 구가 실행 -->
SELECT CASE
        WHEN EMPNO = 1000 THEN 'A'
        WHEN EMPNO = 1001 THEN 'B'
        ELSE 'C'
       END
FROM EMP;

<-- ROWNUM: SELECT문의 결과에 대해 논리적인 일렬번호를 부여, 조회되는 행 수를 제한할 때 많이 사용, 여러개의 행을 가지고 올땐 인라인뷰 사용 -->
SELECT * FROM EMP WHERE ROWNUM <= 1;

<-- 인라인 뷰를 사용하고 ROWNUM에 별칭을 사용해야 한다. -->
SELECT * FROM 
( SELECT ROWNUM LIST, ENAME FROM EMP )
WHERE LIST <= 5;

<-- ROWNUM과 BETWEEN구를 사용해서 웹 페이지 조회 구현 -->
SELECT * FROM
( SELECT ROWNUM LIST, ENAME FROM EMP )
WHERE LIST BETWEEN 5 AND 10;

<-- ROWID -->
DESC EMP;
SELECT ROWID, ENAME FROM EMP;

<-- WITH: 서브쿼리를 사용해서 임시 테이블이나 뷰처럼 사용할 수 있는 구문이다. 서브쿼리 블록에 별칭을 지정할 수 있다. 옵티마이저는 SQL을 인라인 뷰나 임시 테이블로 판단한다. -->
WITH VIEWDATA AS
(SELECT * FROM EMP
UNION ALL
SELECT * FROM EMP)
SELECT * FROM VIEWDATA WHERE EMPNO=1000;

<-- DCL -->
GRANT SELECT,INSERT,UPDATE,DELETE ON TABLE ON USER;

<-- WITH GRANT OPTION: 특정 사용자에게 권한을 부여할 수 있는 권한을 부여 -->
GRANT SELECT, INSERT, UPDATE, DELETE ON EMP TO USER WITH GRANT OPTION;

<-- REVOKE -->
REVOKE privileges ON tabe FROM user;

<-- TCL -->
commit;

set autocommit on;

<-- rollback: 데이터에 대한 변경 사항을 취소하고 트랜잭션을 종료한다. 단, 이전에 commit한 곳까지만 복구한다. -->
<-- rollback: 실행시 lock이 해제되고 다른 사용자도 db행을 조작할 수 있다. -->
rollback;

<-- savepoint: 트랜잭션을 작게 분할하여 관리하는 것으로 savepoint를 사용하면 지정된 위치까지만 트랜잭션을 rollback할 수 있다.-->
<-- rollback -->
savepoint t1;


<-- EQUI 조인 -->
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME LIKE 'test%' ORDER BY ENAME;


<-- INNER JOIN -->
SELECT * FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.ENAME LIKE 'test%' ORDER BY ENAME;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;


<-- INTERSECT: 두 개 테이블에서 공통된 값을 조회 -->
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

<-- OUTER JOIN: 두 개의 테이블 간에 교집합을 조회하고 한쪽 테이블에만 있는 데이터도 포함시켜서 조회한다. -->
<-- Outer join을 할 때 (+) 기호를 사용해서 할 수 있다. -->
SELECT * FROM DEPT, EMP
WHERE EMP.DEPTNO (+)= DEPT.DEPTNO;

<-- LEFT OUTER JOIN과 RIGHT OUTER JOIN: 두 개의 테이블에서 같은 것을 조회하고 왼쪽 테이블에만 있는 것을 포함해서 조회된다. -->
SELECT * FROM DEPT LEFT OUTER JOIN EMP ON EMP.DEPTNO = DEPT.DEPTNO;
SELECT * FROM DEPT RIGHT OUTER JOIN EMP ON EMP.DEPTNO = DEPT.DEPTNO;

<-- CROSS JOIN: 조인 조건 구 없이 2개의 테이블을 하나로 조인한다 -->
SELECT * FROM EMP CROSS JOIN DEPT;

<-- UNION: 두 개의 테이블을 하나로 합치면서 중복된 데이터를 제거, SORT 과정을 발생 -->
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM EMP;

<-- UNION ALL: 두 개의 테이블을 하나로 합치는 것, 중복을 제거하거나 정렬을 유발하지 않음 -->
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM EMP;

<-- MINUS: 두 개의 테이블에서 차집합을 조회한다. 즉, 먼저 쓴 SELECT문에는 있고 뒤에 쓰는 SELECT 문에는 없는 집합을 조회하는 것이다. -->
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

<-- 계층형 조회(connect by): 트리형태의 구조로 질의를 수행하는 것으로 start with구는 시작조건을 의미 connect by prior는 조인 조건이다. root 노드로부터 하위 노드의 질의를 실행한다. -->
DESC EMP;

SELECT MAX(LEVEL)
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

SELECT LEVEL, EMPNO, MGR, ENAME
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

<-- 4*LEVEL-1이 있다. LEVEL값은 ROOT이면 1이된다. 따라서 4*(1-1)=0이 된다. -->
<-- 즉, root일 때는 LPAD('',0)이므로 아무런 의미가 없다. -->
SELECT LEVEL, LPAD(' ', 4 * (LEVEL -1)) || EMPNO, MGR,CONNECT_BY_ISLEAF
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO = MGR;

<-- subquery: select문 내에 다시 select문을 사용하는 sql이다. 형태는 from구에 select문을 사용하는 인라인 뷰와 select문에 subquery를 사용하는 스칼라 서브쿼리 등이 있다. -->
SELECT * FROM EMP WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DEPTNO=10);

<-- FROM구에 SELECT문을 사용하여 가상의 테이블을 만드는 효과를 얻을 수 있다. FROM구에 SELECT문을 사용한 것이 인라인 뷰이다. -->
SELECT * FROM
(SELECT ROWNUM NUM,ENAME FROM EMP) a
WHERE NUM < 5;

<-- 여러 개의 행 중에서 하나만 참이 되어도 참이 되는 연산 -->
SELECT ENAME, DNAME, SAL
FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EMP.EMPNO
IN (SELECT EMPNO FROM EMP WHERE SAL > 2000);

<-- ALL: 메인쿼리와 서브쿼리의 결과가 모두 동일하면 참 -->
SELECT * FROM EMP
WHERE DEPTNO <= ALL (20, 30);

<-- EXISTS: 서브쿼리로 어떤 데이터 존재 여부를 확인하는 것, 결과는 참과 거짓이 반환됨 -->
SELECT ENAME, DNAME, SAL FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EXISTS (SELECT 1 FROM EMP WHERE SAL > 2000);

<-- 스칼라 서브쿼리: 반드시 한 행과 한 칼럼만 반환하는 서브쿼리이다. -->
SELECT ENAME AS "이름", SAL AS "급여",(SELECT AVG(SAL) FROM EMP) AS "평균급여" FROM EMP WHERE EMPNO=1000;

<-- 연관 서브쿼리: 서브쿼리내에서 Main Query 내의 칼럼을 사용하는 것을 의미한다. -->
SELECT * FROM EMP A WHERE A.DEPTNO = 
(SELECT DEPTNO FROM DEPT B WHERE B.DEPTNO=A.DEPTNO);

<-- ROLLUP: GROUP BY의 칼럼에 대해서 Subtotal를 만들어 준다. group by구에 칼럼이 두 개 이상 오면 순서에 따라서 결과가 달라진다. -->
SELECT DECODE(DEPTNO, NULL, '전체합계',DEPTNO) AS DEPTNO, SUM(SAL) FROM EMP GROUP BY ROLLUP(DEPTNO);

select deptno, sum(sal) from emp group by deptno
union all

select "전체합계", sum(sal) from emp;


SELECT DECODE(DEPTNO, NULL, '전체합계',DEPTNO) AS DEPTNO, JOB, SUM(SAL) AS SAL FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

<-- GROUPING함수: ROLLUP, CUBE, GROUPING SETS에서 생성되는 합계 값을 구분하기 위해서 만들어진 함수 -->
<-- 소계,합계 등이 계산되면 GROUPING 함수는 1 반환 그렇지 않으면 0을 반환 -->
SELECT DEPTNO, GROUPING(DEPTNO), JOB,GROUPING(JOB), SUM(SAL) FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO,
DECODE(GROUPING(DEPTNO),1,'전체합계') TOT, JOB,
DECODE(GROUPING(JOB),1,'부서합계') T_DEPT, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

<-- GROUPING SETS: GROUP BY에 나오는 칼럼의 순서와 관계없이 다양한 소계를 만들 수 있다. GROUP BY에 나오는 칼럼의 순서와 관계없이 개별적으로 모두 처리 -->
SELECT DEPTNO, JOB,SUM(SAL) FROM EMP
GROUP BY GROUPING SETS(DEPTNO, JOB);

<-- CUBE: CUBE함수에 제시한 칼럼에 대해서 결합 가능한 모든 집계를 계산 -->
SELECT DEPTNO, JOB, SUM(SAL) FROM EMP
GROUP BY CUBE(DEPTNO, JOB);

<-- 윈도우 함수 -->
SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) TOTSAL FROM EMP;

SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TOTSAL FROM EMP;

SELECT EMPNO, ENAME, SAL, SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)TOTSAL FROM EMP;

<-- RANK Function -->
SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) ALL_RANK, RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK FROM EMP;

SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) ALL_RANK, DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK FROM EMP;

SELECT ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) ALL_RANK, ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUM FROM EMP;

<-- 집계함수 -->
SELECT ENAME, SAL, SUM(SAL) OVER (PARTITION BY MGR) NUM_MGR FROM EMP;

SELECT DEPTNO, ENAME, SAL, FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A FROM EMP;

SELECT DEPTNO, ENAME, SAL, LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS DEPT_A FROM EMP;

SELECT DEPTNO, ENAME, SAL, LAG(SAL) OVER(ORDER BY SAL DESC) AS PRE_SAL FROM EMP;

SELECT DEPTNO, ENAME, SAL, LEAD(SAL,2) OVER(ORDER BY SAL DESC) AS PRE_SAL FROM EMP;

<-- 비율 관련 함수 -->
SELECT DEPTNO, ENAME, SAL, PERCENT_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS PERCENT_SAL FROM EMP;

SELECT DEPTNO, ENAME, SAL, NTILE(4) OVER(ORDER BY SAL DESC) AS N_TILE FROM EMP;

<-- 옵티마이저 -->
DESC PLAN_TABLE;

SELECT /*+ RULE */ * FROM EMP WHERE ROWID='AAAFL4AAEAAAAGlAAA';

<-- INDEX 생성 -->
SELECT * FROM TAB;
CREATE INDEX IDX_EMP ON EMP (ENAME ASC, SAL DESC);

<-- INDEX UNIQUE SCAN: 인덱스의 키 값이 중복되지 않는 경우, 해당 인덱스를 사용할 때 발생 -->
SELECT * FROM EMP WHERE EMPNO=1000;

<-- INDEX RANGE SCAN: SELECT문에서 특정 범위를 조회하는 WHERE문을 사용할 경우 발생. 예: Like, Between이 대표적. 물론 데이터 양이 적은 경우는 인덱스 자체를 실행하지 않고 table full scan이 될 수 있다. -->
<-- 인덱스의 Leaf Block의 특정 범위를 스캔 -->
SELECT EMPNO FROM EMP WHERE EMPNO >= 1000;

<-- INDEX FULL SCAN: 인덱스에서 검색되는 인덱스 키가 많은 경우에 Leaf Block의 처음부터 끝까지 전체를 읽어 들인다. -->
SELECT ENAME, SAL FROM EMP WHERE ENAME LIKE '%' AND SAL > 0;

<-- Nested Loop 조인 -->
SELECT /*+ ORDERED USE_NL(B) */ * FROM EMP A, DEPT B
WHERE A.DEPTNO = B.DEPTNO AND A.DEPTNO = 10;

<-- Sort Merge 조인: 두 개의 테이블을 SORT_AREA라는 메모리 공간에 모두 로딩하고 SORT를 수행 -->
<-- 정렬이 발생하기 때문에 데이터 양이 많아지면 성능이 떨어지게 된다. 정렬데이터양이 너무 많으면 정렬은 임시 영역에서 수행된다. 임시영역은 디스크에 있기에 성능이 급격히 떨어짐 -->
<-- USE_MERGE 힌트를 사용해서 SORT MERGE 조인을 하게 할 수가 있다. 단, USE_MERGE 힌트는 ORDERED 힌트와 같이 사용해야 한다. -->
SELECT /*+ ORDERED USE_MERGE(B) */ * FROM EMP A, DEPT B WHERE A.DEPTNO = B.DEPTNO AND A.DEPTNO = 10;

<-- Hash 조인: 두 개의 테이블 중에서 작은 테이블을 hash 메모리에 로딩하고 두 개의 테이블의 조인 키를 사용해서 해시 테이블을 생성한다. -->
<-- 해시함수를 사용해서 주소를 계산하고 해당 주소를 사용해서 테이블을 조인하기 때문에 cpu 연산을 많이 한다. -->
<-- 특히 hash 조인 시에는 선행 테이블의 크기가 작아서 충분히 메모리에 로딩되어야 한다. -->
SELECT /*+ ORDERED USE_HASH(B) */ * FROM EMP A, DEPT B WHERE A.DEPTNO = B.DEPTNO AND A.DEPTNO = 10;