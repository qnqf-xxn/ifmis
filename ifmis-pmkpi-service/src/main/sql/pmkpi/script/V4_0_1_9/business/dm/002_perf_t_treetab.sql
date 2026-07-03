 i number(9);
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_TREETAB';
  if i=0 then
     execute immediate '
create table PERF_T_TREETAB
(
  guid       VARCHAR2(40) not null,
  key        VARCHAR2(100),
  code       VARCHAR2(40),
  name       VARCHAR2(100),
  isvisiable NUMBER(1),
  hidebtns   VARCHAR2(200),
  ordernum   NUMBER(9),
  year       VARCHAR2(4) not null,
  province   VARCHAR2(9) not null,
  leftwfid   VARCHAR2(32),
  leftmenuid VARCHAR2(32)
)';
execute immediate '
alter table PERF_T_TREETAB
  add constraint PK_PERF_TREEMENU primary key (GUID, PROVINCE, YEAR)';

end if;

execute immediate '
create or replace view v_perf_t_treetab as
select t.*
from perf_t_treetab t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';