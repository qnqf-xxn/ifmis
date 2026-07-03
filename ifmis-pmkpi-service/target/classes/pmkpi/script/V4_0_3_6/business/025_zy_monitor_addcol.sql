  i number;
begin

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='PRO_LEV';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add(PRO_LEV VARCHAR2(40))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='PROJECTKIND';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add(PROJECTKIND VARCHAR2(32))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='PRO_LEVONE_CODE';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add(PRO_LEVONE_CODE VARCHAR2(21))';
end if;
--÷ÿΩ® ”Õº
execute immediate '
create or replace view v_perf_t_promonitor as
select t.*
   from perf_t_promonitor t
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  ';
