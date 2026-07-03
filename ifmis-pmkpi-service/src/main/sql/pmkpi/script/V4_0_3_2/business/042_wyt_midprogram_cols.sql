begin

  --年终追加选择项目列表添加创建时间字段
delete from p#busfw_t_uicolumn  where key ='/pmkpi/program/report/list' and columncode ='CREATE_TIME';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/list', 'CREATE_TIME', '项目入库时间', 22, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 200, 1, 'd', '{}', null);

--年中追加申报、审核、查询列表添加字段
delete from p#busfw_t_uicolumn where key in('/pmkpi/midprogram/report/list','/pmkpi/midprogram/report/audit','/pmkpi/midprogram/query/list') and columncode ='CREATE_TIME';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'CREATE_TIME', '项目入库时间', 22, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'CREATE_TIME', '项目入库时间', 22, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'CREATE_TIME', '项目入库时间', 21, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);


delete from bus_t_diccolumn where columncode ='CREATE_TIME' and tablecode ='PERF_T_DEPTPERFMIDDECLARE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATE_TIME', '1', '2016', '87', '41179b32532743a67ba7893e4ddfNb43', 'CREATE_TIME', 'PERF_T_DEPTPERFMIDDECLARE', '项目入库时间', 'S', '17', null, 1, 1, null, sysdate);


