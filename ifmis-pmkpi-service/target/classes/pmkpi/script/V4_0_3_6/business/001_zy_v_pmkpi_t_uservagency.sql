  i number;
begin
--用户对单位视图（分区划不分年度）
execute immediate '
create or replace view v_pmkpi_t_uservagency as
select * from PMKPI_T_USERVAGENCY t
where PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
