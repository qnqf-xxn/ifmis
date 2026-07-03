begin
  --问题整改，选择项目，自评类型查询区注册
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/check/selfproj';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('DE407C29239275D0E0533315A8C031DB', '/pmkpi/rectification/check/selfproj', 'SELFRESULT', '自评结论', 2, 1, 'tree', null, 0, 0, 'pmkpi', 'PERF_V_PROJECT_INFO', null, null,  null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('DE504E802AB97702E0533315A8C06154', '/pmkpi/rectification/check/selfproj', 'NAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null, null);


--表字段注册
delete from bus_t_diccolumn where tablecode ='PERF_V_PROJECT_INFO';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCYGUID', '1', null, null, 'D7B638A6A8547F18E0533315A8C0556A', 'AGENCYGUID', 'PERF_V_PROJECT_INFO', '单位信息', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'FININTORGGUID', '1', null, null, 'D5FDEEA6BA6C0CD8E0533315A8C06C21', 'FININTORGGUID', 'PERF_V_PROJECT_INFO', '财政处室', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPISELFRESULT', null, '0', 'SELFRESULT', '1', null, null, 'E03844EB11667229E0533315A8C0A2B9', 'SELFRESULT', 'PERF_V_PROJECT_INFO', '自评结论', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITASKSTAGE', null, '0', 'TASKSTAGE', '1', null, null, 'D0419BBF1AEA23B8E0533315A8C06982', 'TASKSTAGE', 'PERF_V_PROJECT_INFO', '阶段', 'S', null, null, 1, 1, null, sysdate);


--查询区自评结论 --数据源
delete from perf_t_datasource where elementcode ='selfresult';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('优', '1', '优', null, null, null, null, 1, 'selfresult', 1, '20220531', '20220531', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('良', '2', '良', null, null, null, null, 2, 'selfresult', 1, '20220531', '20220531', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('中', '3', '中', null, null, null, null, 3, 'selfresult', 1, '20220531', '20220531', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('差', '4', '差', null, null, null, null, 4, 'selfresult', 1, '20220531', '20220531', 2020, '87');



