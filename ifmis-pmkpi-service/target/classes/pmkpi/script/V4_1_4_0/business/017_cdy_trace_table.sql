
 i number;
begin
--½×¶ÎÖ´ÐÐÊý
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='STAGEBGTAMT';
if i=0 then
  execute immediate 'alter table PERF_T_PROMONITOR add STAGEBGTAMT NUMBER(20,2)';
end if;

execute immediate '
create or replace view v_perf_t_promonitor as
select *
   from perf_t_promonitor t
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
