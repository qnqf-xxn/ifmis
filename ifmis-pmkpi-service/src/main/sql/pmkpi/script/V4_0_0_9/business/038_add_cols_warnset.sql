i integer;
begin
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='GUID';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add GUID VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='GUID';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'GUID', '1', '2021', '87', '122sBB8D6936sfCE0580A050352adw1', 'GUID', 'PERF_T_WARNSET', 'GUID', 'S', '40', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='CODE';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add CODE VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='CODE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'CODE', '1', '2021', '87', '122sBBsfl936sfCE0580A050352adw1', 'CODE', 'PERF_T_WARNSET', '编码', 'S', '40', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='NAME';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add NAME VARCHAR2(100)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='NAME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'NAME', '1', '2021', '87', '122sBBsgl936sfCE0090A050352adw1', 'NAME', 'PERF_T_WARNSET', '名称', 'S', '100', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='TYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add TYPE VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='TYPE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'TYPE', '1', '2021', '87', '122sBBsgl936sfCE0090A050359kdw1', 'TYPE', 'PERF_T_WARNSET', '类别', 'S', '40', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='WARNSQL';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add WARNSQL VARCHAR2(2000)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='WARNSQL';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'WARNSQL', '1', '2021', '87', '122sBBsg906sfCE009fgj50359kdw1', 'WARNSQL', 'PERF_T_WARNSET', 'sql语句', 'S', '2000', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='UPDATETIME';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add UPDATETIME VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='UPDATETIME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'UPDATETIME', '1', '2021', '87', '122sBBsg906sfCEsfgjA050359kdw1', 'UPDATETIME', 'PERF_T_WARNSET', '更新时间', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='CREATETIME';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add CREATETIME VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='CREATETIME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'CREATETIME', '1', '2021', '87', '122sBBsg906sfCEsfgok050359kdw1', 'CREATETIME', 'PERF_T_WARNSET', '创建时间', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='YEAR';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add YEAR VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='YEAR';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'YEAR', '1', '2021', '87', '122sBBpl906sfCEsfgjA050359kdw1', 'YEAR', 'PERF_T_WARNSET', '年度', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_WARNSET' and t.column_name='PROVINCE';
     if i=0 then
       execute immediate 'alter table PERF_T_WARNSET add PROVINCE VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_WARNSET' and t.columncode='PROVINCE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'PROVINCE', '1', '2021', '87', '122sBBsg90ssdfhsfgjA050359kdw1', 'PROVINCE', 'PERF_T_WARNSET', '区划', 'S', '17', null, 1, 0, null, sysdate);
     end if;
execute immediate 'create or replace view v_perf_t_warnset as
select * 
from perf_t_warnset t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
