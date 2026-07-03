
i number(9);
begin 
  select count(1) into i from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('OPINION_REMARK');
  if i = 0 then
     execute immediate 'alter table BGT_PERF_INDICATOR  ADD opinion_remark varchar2(4000)';
  end if;
  select count(1) into i from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('OPINION_REMARK');
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR  ADD opinion_remark varchar2(4000)';
  end if;

execute immediate '
create or replace view v_bgt_perf_indicator as
select *
  FROM BGT_PERF_INDICATOR T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

execute immediate '
create or replace view v_pm_perf_indicator as
select *
FROM PM_PERF_INDICATOR T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';


delete from bus_t_diccolumn t where t.tablecode='PM_PERF_INDICATOR' and t.columncode='OPINION_REMARK';
insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'OPINION_REMARK', '1', '2020', '87', 'C9A7EEAF7DAB320EE0533315A8C03A7D', 'OPINION_REMARK', 'PM_PERF_INDICATOR', '审核意见', 'S', '4000', null, 1, 0, null, sysdate);

delete from bus_t_diccolumn t where t.tablecode='BGT_PERF_INDICATOR' and t.columncode='OPINION_REMARK';
insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'OPINION_REMARK', '1', '2020', '87', 'C9A7EEAF7E30320EE0533315A8C03A7D', 'OPINION_REMARK', 'BGT_PERF_INDICATOR', '审核意见', 'S', '4000', null, 1, 0, null, sysdate);

