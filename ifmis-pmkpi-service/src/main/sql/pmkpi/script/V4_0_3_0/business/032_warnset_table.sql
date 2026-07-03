
i number;
begin
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_WARNSET' and column_name = 'STATUS';
  if i = 0 then
     execute immediate 'alter table PERF_T_WARNSET add status varchar2(1) default 1';
  end if;

execute immediate 'update perf_t_warnset t set t.status=''1''';

execute immediate '
create or replace view v_perf_t_warnset as
select t.*
from perf_t_warnset t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.status=''1''';
