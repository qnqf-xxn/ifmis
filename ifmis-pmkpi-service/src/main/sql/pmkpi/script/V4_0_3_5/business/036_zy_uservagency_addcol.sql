  i number;
begin

select count(*) into i from user_tab_columns t where t.table_name ='PMKPI_T_USERVAGENCY' and t.column_name='PROVINCE';
if i=0 then
    execute immediate 'alter table PMKPI_T_USERVAGENCY add(PROVINCE VARCHAR2(32))';
end if;
--处理历史数据
execute immediate 'update PMKPI_T_USERVAGENCY t set t.PROVINCE = (select province from fasp_t_causer where guid = t.userguid)  where t.province is null';
--重建视图
execute immediate '
create or replace view v_pmkpi_t_uservagency as
select * from PMKPI_T_USERVAGENCY t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
