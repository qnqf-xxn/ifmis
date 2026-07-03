
 i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_IMPEXPSUB' and t.column_name='TABLECODE';
     if i=0 then
       execute immediate 'alter table PERF_T_IMPEXPSUB add TABLECODE varchar2(40)';
     end if;

execute immediate '
create or replace view v_perf_t_impexpsub as
select *
from perf_t_impexpsub where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

delete from bus_t_diccolumn t where t.tablecode='PERF_T_IMPEXPSUB' and t.columncode='TABLECODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'TABLECODE', '1', '2016', '87', 'DCE4AD04E7E25F55E0533315A8C05642', 'TABLECODE', 'PERF_T_IMPEXPSUB', null, 'S', '40', null, 1, 0, null, sysdate);
