  i integer;
begin
--∆¿…Ûƒ£∞Â≈‰÷√
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_REVIEWTEMP' and t.column_name='CODE';
    if i=0 then
    execute immediate 'alter table PERF_T_REVIEWTEMP add(CODE varchar2(32))';
end if;

execute immediate '
create or replace view v_perf_t_reviewtemp as
select * FROM perf_T_reviewtemp T WHERE  PROVINCE=global_multyear_cz.Secu_f_Global_Parm(''DIVID'') AND YEAR=global_multyear_cz.Secu_f_Global_Parm(''YEAR'')
';
