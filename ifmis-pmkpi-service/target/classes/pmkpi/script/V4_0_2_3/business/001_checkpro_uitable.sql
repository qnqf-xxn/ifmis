begin
delete from p#busfw_t_uitable where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD4E9B88DEF56473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'V_PERF_V_DEPTPERFDECLARE', 200, 0, null, null, null, 'pmkpi', null);

delete from p#busfw_t_uitable where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('265BD352DC9C401E2B63D2CCC36ED7E0', '/pmkpi/rectification/check/proj', 'PERF_V_PROJECT_INFO', 200, 0, null, null, null, 'pmkpi', null);



--虚拟视图表字段注册 添加 任务阶段 字段(数据源翻译字段)
delete from bus_t_diccolumn where tablecode ='V_PERF_V_DEPTPERFDECLARE'; 
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', '2016', '87', 'D5FDEEA6BA6D0CD8E0533315A8C06C21', 'FININTORGGUID', 'V_PERF_V_DEPTPERFDECLARE', '处室', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITASKSTAGE', null, '0', 'TASKSTAGE', '1', '2016', '87', '138f1bdbb2ae4d747f831f3807859411', 'TASKSTAGE', 'V_PERF_V_DEPTPERFDECLARE', '任务', 'S', '40', null, 1, 1, null, sysdate);


delete from bus_t_diccolumn where tablecode ='PERF_V_PROJECT_INFO'; 
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'FININTORGGUID', '1', null, null, 'D5FDEEA6BA6C0CD8E0533315A8C06C21', 'FININTORGGUID', 'PERF_V_PROJECT_INFO', '财政处室', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITASKSTAGE', null, '0', 'TASKSTAGE', '1', null, null, 'D0419BBF1AEA23B8E0533315A8C06982', 'TASKSTAGE', 'PERF_V_PROJECT_INFO', '阶段', 'S', null, null, 1, 1, null, sysdate);

