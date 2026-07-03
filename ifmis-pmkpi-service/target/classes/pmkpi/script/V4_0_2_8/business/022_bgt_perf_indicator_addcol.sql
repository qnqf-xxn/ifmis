 i number;
begin

--bgt_perf_indicator
select count(1) into i from user_tab_cols where table_name = 'BGT_PERF_INDICATOR' and  column_name = 'VALUE_CHANGE';
if i=0 then
  execute immediate 'alter table BGT_PERF_INDICATOR add VALUE_CHANGE varchar2(40)';
end if;

--字段注册
delete bus_t_diccolumn where tablecode = 'BGT_PERF_INDICATOR' and columncode in('VALUE_CHANGE');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFVALUECHANGE', null, '1', 'VALUE_CHANGE', '1', '2016', '87', 'DA61946DCA04101EE0533315A8C0D73D', 'VALUE_CHANGE', 'BGT_PERF_INDICATOR', '指标值变动情况', 'S', '40', null, 1, 0, null, sysdate);

--重构视图
execute immediate '
create or replace view v_bgt_perf_indicator as
select * from bgt_perf_indicator
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
