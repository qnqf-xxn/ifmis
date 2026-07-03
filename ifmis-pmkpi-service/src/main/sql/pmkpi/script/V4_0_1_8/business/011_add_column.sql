i number(9);
begin
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='EXPLAIN';
     if i=0 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX add EXPLAIN VARCHAR2(200)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_CASEMODELINDEX' and t.columncode='EXPLAIN';
       insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'EXPLAIN', '1', '2016', '87', '9985545C9F15D27ACC45443A2AA10FA1', 'EXPLAIN', 'PERF_T_CASEMODELINDEX', '指标解释', 'S', '200', null, 1, 1, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='KPI_REMARK';
     if i=0 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX add KPI_REMARK VARCHAR2(2000)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_CASEMODELINDEX' and t.columncode='KPI_REMARK';
       insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'KPI_REMARK', '1', '2016', '87', 'C3AD7B7D6671A7CDB3E32BD6F38117D7', 'KPI_REMARK', 'PERF_T_CASEMODELINDEX', '备注', 'S', '2000', null, 1, 1, null, sysdate);
     end if;
     
execute immediate '
create or replace view v_perf_t_casemodelindex as
select * FROM PERF_T_CASEMODELINDEX T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
