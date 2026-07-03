  i number;
begin
--待办表添加字段-页签code(根据页签code判断跳转定位页签)
select count(*) into i from user_tab_columns t where t.table_name ='PERF_PENDINGTASK' and t.column_name='TABCODE';
if i=0 then
    execute immediate 'alter table PERF_PENDINGTASK add(TABCODE VARCHAR2(200))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_PENDINGTASK' and t.column_name='LEFTTABNUM';
if i=0 then
    execute immediate 'alter table PERF_PENDINGTASK add(LEFTTABNUM VARCHAR2(40))';
end if;
--待办备份表
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PENDINGTASK_20220414';
  if i=0 then
     execute immediate '
      create table PERF_PENDINGTASK_20220414 as select * from PERF_PENDINGTASK';
end if;

--重建视图
execute immediate '
create or replace view V_PERF_PENDINGTASK as
select * 
from PERF_PENDINGTASK t';
