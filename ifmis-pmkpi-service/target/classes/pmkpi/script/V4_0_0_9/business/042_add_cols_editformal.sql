i integer;
begin
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='GUID';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add GUID VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='GUID';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'GUID', '1', '2021', '87', '122sBB8D6936sfCE0580A050352adw1', 'GUID', 'PERF_T_EDITFORMAL', 'GUID', 'S', '40', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='TABLECODE';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add TABLECODE VARCHAR2(30)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='TABLECODE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'TABLECODE', '1', '2021', '87', '122sBBsfl936sfCE0580A050352adw1', 'TABLECODE', 'PERF_T_EDITFORMAL', '表编码', 'S', '30', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='NAME';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add NAME VARCHAR2(200)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='NAME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'NAME', '1', '2021', '87', '122sBBsgl936sfCE0090A050352adw1', 'NAME', 'PERF_T_EDITFORMAL', '名称', 'S', '200', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='QUERYSQL';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add QUERYSQL VARCHAR2(4000)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='QUERYSQL';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'QUERYSQL', '1', '2021', '87', '122sBBsgl936sfCE0090A050359kdw1', 'QUERYSQL', 'PERF_T_EDITFORMAL', '查询语句', 'S', '4000', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='SUMCOL';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add SUMCOL VARCHAR2(1000)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='SUMCOL';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'SUMCOL', '1', '2021', '87', '122sBBsg906sfCE009fgj50359kdw1', 'SUMCOL', 'PERF_T_EDITFORMAL', '', 'S', '1000', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='UPDATETIME';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add UPDATETIME VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='UPDATETIME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'UPDATETIME', '1', '2021', '87', '122sBBsg906sfCEsfgjA050359kdw1', 'UPDATETIME', 'PERF_T_EDITFORMAL', '更新时间', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='CREATETIME';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add CREATETIME VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='CREATETIME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'CREATETIME', '1', '2021', '87', '122sBBsg906sfCEsfgok050359kdw1', 'CREATETIME', 'PERF_T_EDITFORMAL', '创建时间', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='YEAR';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add YEAR VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='YEAR';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'YEAR', '1', '2021', '87', '122sBBpl906sfCEsfgjA050359kdw1', 'YEAR', 'PERF_T_EDITFORMAL', '年度', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='PROVINCE';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add PROVINCE VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='PROVINCE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'PROVINCE', '1', '2021', '87', '122sBBsg90ssdfhsfgjA050359kdw1', 'PROVINCE', 'PERF_T_EDITFORMAL', '区划', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='COLUMNCODE';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add COLUMNCODE VARCHAR2(50)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='COLUMNCODE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'COLUMNCODE', '1', '2021', '87', '123sBBsg90ssdfhsfgjA050359kdw1', 'COLUMNCODE', 'PERF_T_EDITFORMAL', '字段编码', 'S', '50', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='ORDERNUM';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add ORDERNUM NUMBER(3)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='ORDERNUM';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'ORDERNUM', '1', '2021', '87', '125sBBsg90ssdfhsfgjA050359kdw1', 'ORDERNUM', 'PERF_T_EDITFORMAL', '排序', 'S', '22', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='AGENCYGUID';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add AGENCYGUID VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='AGENCYGUID';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'AGENCYGUID', '1', '2021', '87', '126sBBsg90ssdfhsfgjA050359kdw1', 'AGENCYGUID', 'PERF_T_EDITFORMAL', '单位guid', 'S', '40', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EDITFORMAL' and t.column_name='VALUE';
     if i=0 then
       execute immediate 'alter table PERF_T_EDITFORMAL add VALUE NUMBER(18)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EDITFORMAL' and t.columncode='VALUE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'VALUE', '1', '2021', '87', '127sBBsg90ssdfhsfgjA050359kdw1', 'VALUE', 'PERF_T_EDITFORMAL', '值', 'S', '22', null, 1, 0, null, sysdate);
     end if;
execute immediate '
create or replace view v_perf_t_editformal as
select * 
from PERF_T_EDITFORMAL where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
