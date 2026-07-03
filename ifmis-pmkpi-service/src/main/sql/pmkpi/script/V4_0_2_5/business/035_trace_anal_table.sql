
 i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROTRACEANALYSIS' and t.column_name='REASONTYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_PROTRACEANALYSIS add reasontype varchar2(40)';
     end if;

execute immediate '
create or replace view v_perf_t_protraceanalysis as
select *
from perf_t_protraceanalysis t where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


delete from bus_t_diccolumn t where t.tablecode='PERF_T_PROTRACEANALYSIS' and t.columncode='REASONTYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIREASONTYPE', null, '1', 'REASONTYPE', '1', '2020', '87', 'DC98B644AAF5387EE0533315A8C05B69', 'REASONTYPE', 'PERF_T_PROTRACEANALYSIS', '原因类型', 'S', '40', null, 1, 1, null, sysdate);
