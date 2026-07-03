

 i number;
begin

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='DEPT_CODE';
     if i=0 then
       execute immediate 'alter table PERF_T_ADJUSTGOAL add dept_code VARCHAR2(40)';
     end if;

execute immediate '
create or replace view v_perf_t_adjustgoal as
select *
from perf_t_adjustgoal t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

delete from bus_t_diccolumn t where t.tablecode='PERF_T_ADJUSTGOAL' and t.columncode='DEPT_CODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DEPT_CODE', '1', '2016', '87', 'DC6D0EBF408F4559E0533315A8C0017C', 'DEPT_CODE', 'PERF_T_ADJUSTGOAL', '≤ø√≈±‡¬Î', 'S', '40', null, 1, 1, null, sysdate);

update p#busfw_t_uicolumn t set t.colwidth='100' where t.key in('/pmkpi/adjust/report/proedit/index') and t.columncode='OBLIGATE1';

update bgt_perf_goal_info t set t.dept_code=(select substr(dept_code,1,3) from bgt_perf_goal_info a where t.guid=a.guid),t.update_time=to_char(sysdate,'yyyymmddhh24miss');
update bgt_perf_indicator t set t.dept_code=(select substr(dept_code,1,3) from bgt_perf_indicator a where t.guid=a.guid),t.update_time=to_char(sysdate,'yyyymmddhh24miss');

update perf_t_adjustindex t set t.dept_code=(select substr(dept_code,1,3) from perf_t_adjustindex a where t.guid=a.guid),t.update_time=to_char(sysdate,'yyyymmddhh24miss');