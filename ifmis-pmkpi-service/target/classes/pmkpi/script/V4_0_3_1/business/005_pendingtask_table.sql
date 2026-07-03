
i number;
begin
  select count(1) into i from user_tab_columns where table_name = 'PERF_PENDINGTASK' and column_name = 'BEANID';
  if i = 0 then
     execute immediate 'alter table PERF_PENDINGTASK add BEANID varchar2(200)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PENDINGTASK' and column_name = 'MOTHOD';
  if i = 0 then
     execute immediate 'alter table PERF_PENDINGTASK add MOTHOD varchar2(100)';
  end if;

execute immediate '
create or replace view v_perf_pendingtask as
select *
from PERF_PENDINGTASK t';
