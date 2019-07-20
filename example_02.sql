<-- 테스트 샘플 생성 -->
create table t 
as select d.no, e.* from scott.emp e
,(select rownum no from dual connect by level <= 1000) d;

create index t_x01 on t(deptno, no);
create index t_x02 on t(deptno, job, no);

<-- t 테이블에 통계정보를 수집하는 쿼리 -->
exec dbms_stats.gather_table_stats(user, 't');


select * from t
where deptno = 10
and no =1;

<-- 힌트 사용법 -->
select /*+ index(t t_x02) */ * from t
where deptno = 10
and no = 1;

<-- Oracle 세그먼트에 할당된 익스텐트 목록 조회-->
SELECT SEGMENT_TYPE, TABLESPACE_NAME, EXTENT_ID, FILE_ID, BLOCK_ID, BLOCKS
FROM DBA_EXTENTS
WHERE OWNER = USER
AND SEGMENT_NAME = 'MY_SEGMENT'
ORDER BY EXTENT_ID;

<-- Oracle block size 확인 -->
SHOW PARAMETER BLOCK_SIZE;
select value from v$parameter where name='db_block_size';

<-- 버퍼캐시 사이즈 확인 -->
show sga;

show parameter db_file_multiblock_read_count;
