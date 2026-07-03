i number;
begin

   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROMONITOR' and t.column_name='PRO_TOTAL_AMT';
     if i=0 then
       execute immediate 'alter table PERF_T_PROMONITOR add PRO_TOTAL_AMT NUMBER(18,2)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.columncode='PRO_TOTAL_AMT';
       insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_TOTAL_AMT', '1', null, null, '11F9A49851069332843F8FA7F568BC9F', 'PRO_TOTAL_AMT', 'PERF_T_PROMONITOR', '项目总金额', 'N', null, null, 1, 1, null, sysdate);
     end if;
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROMONITOR' and t.column_name='BGTAMT';
     if i=0 then
       execute immediate 'alter table PERF_T_PROMONITOR add BGTAMT NUMBER(18,2)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.columncode='BGTAMT';
       insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'BGTAMT', '1', '2016', '87', '73303AB496D4E6F8DD96FEB828325965', 'BGTAMT', 'PERF_T_PROMONITOR', '当年预算总金额', 'N', '20', 2, null, 1, null, sysdate);
     end if;

execute immediate 'create or replace view v_perf_t_promonitor as
select t.*
   from perf_t_promonitor t
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
