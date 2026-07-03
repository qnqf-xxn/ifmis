i integer;
begin
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='GUID';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add GUID VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='GUID';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'GUID', '1', '2021', '87', '122sBB8D6936sfCE0580A050352adw1', 'GUID', 'PERF_T_AUDITDEFINEMENU', 'GUID', 'S', '40', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='CODE';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add CODE VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='CODE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'CODE', '1', '2021', '87', '122sBBsfl936sfCE0580A050352adw1', 'CODE', 'PERF_T_AUDITDEFINEMENU', '编码', 'S', '50', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='NAME';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add NAME VARCHAR2(200)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='NAME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'NAME', '1', '2021', '87', '122sBBsgl936sfCE0090A050352adw1', 'NAME', 'PERF_T_AUDITDEFINEMENU', '名称', 'S', '200', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='REMARK';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add REMARK VARCHAR2(2000)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='REMARK';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'REMARK', '1', '2021', '87', '122sBBsgl936sfCE0090A050359kdw1', 'REMARK', 'PERF_T_AUDITDEFINEMENU', '备注', 'S', '2000', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='SUPERID';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add SUPERID VARCHAR2(2000)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='SUPERID';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'SUPERID', '1', '2021', '87', '122sBBsg906sfCE009fgj50359kdw1', 'SUPERID', 'PERF_T_AUDITDEFINEMENU', '父类菜单guid', 'S', '32', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='UPDATETIME';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add UPDATETIME VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='UPDATETIME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'UPDATETIME', '1', '2021', '87', '122sBBsg906sfCEsfgjA050359kdw1', 'UPDATETIME', 'PERF_T_AUDITDEFINEMENU', '更新时间', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='CREATETIME';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add CREATETIME VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='CREATETIME';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'CREATETIME', '1', '2021', '87', '122sBBsg906sfCEsfgok050359kdw1', 'CREATETIME', 'PERF_T_AUDITDEFINEMENU', '创建时间', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='YEAR';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add YEAR VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='YEAR';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'YEAR', '1', '2021', '87', '122sBBpl906sfCEsfgjA050359kdw1', 'YEAR', 'PERF_T_AUDITDEFINEMENU', '年度', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='PROVINCE';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add PROVINCE VARCHAR2(17)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='PROVINCE';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'PROVINCE', '1', '2021', '87', '122sBBsg90ssdfhsfgjA050359kdw1', 'PROVINCE', 'PERF_T_AUDITDEFINEMENU', '区划', 'S', '17', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='LEVELNO';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add LEVELNO NUMBER(2)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='LEVELNO';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'LEVELNO', '1', '2021', '87', '123sBBsg90ssdfhsfgjA050359kdw1', 'LEVELNO', 'PERF_T_AUDITDEFINEMENU', '级别', 'S', '22', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='ISLEAF';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add ISLEAF NUMBER(1)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='ISLEAF';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'ISLEAF', '1', '2021', '87', '124sBBsg90ssdfhsfgjA050359kdw1', 'ISLEAF', 'PERF_T_AUDITDEFINEMENU', '是否叶子节点', 'S', '22', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='ORDERNUM';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add ORDERNUM NUMBER(9)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='ORDERNUM';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'ORDERNUM', '1', '2021', '87', '125sBBsg90ssdfhsfgjA050359kdw1', 'ORDERNUM', 'PERF_T_AUDITDEFINEMENU', '排序', 'S', '22', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='STATUS';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add STATUS NUMBER(1)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='STATUS';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'STATUS', '1', '2021', '87', '126sBBsg90ssdfhsfgjA050359kdw1', 'STATUS', 'PERF_T_AUDITDEFINEMENU', '状态', 'S', '22', null, 1, 0, null, sysdate);
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITDEFINEMENU' and t.column_name='CREATER';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITDEFINEMENU add CREATER VARCHAR2(40)';
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_AUDITDEFINEMENU' and t.columncode='CREATER';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'CREATER', '1', '2021', '87', '127sBBsg90ssdfhsfgjA050359kdw1', 'CREATER', 'PERF_T_AUDITDEFINEMENU', '创建者', 'S', '40', null, 1, 0, null, sysdate);
     end if;
