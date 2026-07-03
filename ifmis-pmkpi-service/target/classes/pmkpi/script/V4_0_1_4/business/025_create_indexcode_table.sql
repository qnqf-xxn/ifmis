
  i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_INDEX_CODE';
  if i=0 then
     execute immediate '
create table PERF_INDEX_CODE
(
  guid       VARCHAR2(40),
  findex     VARCHAR2(30) not null,
  sindex     VARCHAR2(30) not null,
  tindex     VARCHAR2(30) not null,
  province   VARCHAR2(9) not null,
  year       VARCHAR2(4) not null,
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate ' 
alter table PERF_INDEX_CODE
  add constraint PK_PERF_INDEXCODE primary key (PROVINCE, YEAR, FINDEX, SINDEX, TINDEX)
  using index';
 end if;

select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_CHECKUPDATETIME';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_CHECKUPDATETIME
(
  guid          VARCHAR2(40),
  updatetime    VARCHAR2(17),
  oldupdatetime VARCHAR2(17)
)
on commit delete rows';
 end if;

execute immediate '
create or replace view v_perf_index_code as
select *
FROM PERF_INDEX_CODE T WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
    
execute immediate '
create or replace view perf_v_checkindex as
select guid,findex,sindex,'''' as tindex,code from bas_perf_indicator
union all
select guid,findex,sindex,tindex,code from perf_t_casemodelindex';
