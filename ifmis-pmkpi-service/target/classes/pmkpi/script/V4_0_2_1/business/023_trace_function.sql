begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/query') and code in('export');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/audit') and code in('export');

--绩效监控查询页面添加  查看整改详情  按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/program/trace/query' and guid = 'DF610A5FB15D6763E0533315A8C0A8FA';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DF610A5FB15D6763E0533315A8C0A8FA', '/pmkpi/program/trace/query', '查看整改详情', 1, 5, 'searchicon', 'protracequery.rectify', null, '查看整改详情', 'pmkpi', 'rectify', null, '{}');


--整改表添加字段
delete from bus_t_diccolumn where tablecode = 'PERF_T_RECTIFY' and columncode in('ISRECTIFY','RECTIFYEND');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISRECTIFY', '1', null, null, 'D223D53E31CA37A7B9616BA093990A40', 'ISRECTIFY', 'PERF_T_RECTIFY', '是否发起整改', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'RECTIFYEND', '1', null, null, 'D223D53E31CA37A7B9616BA093990A0E', 'RECTIFYEND', 'PERF_T_RECTIFY', '是否完成整改', 'S', '40', null, null, 1, null, sysdate);

--监控查询页面组件注册
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/trace/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'pmkpi_protracequery', '{}', 'protracequery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busuidatatable', '{name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busfw.dataexport', '{}', 'dataexport', null, null);

--监控列表表字段注册  
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/query';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFF607C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'WARN', '预警', 17, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFF707C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'PRO_CODE', '项目编码', 2, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{type:"protrace"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFF807C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{type:"protrace"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFF907C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 180, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFFA07C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFFB07C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFFC07C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'TASKSTAGE', '监控阶段', 9, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFFD07C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'WARNDAYS', '预警截止天数', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFFF07C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'DEPTTASK', '自行监控', 15, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DEFFE07C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'GOALWARN', '目标完成预警', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DF00007C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'PROVINCETASK', '重点监控', 16, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DF00107C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'BGTWARN', '预算执行预警', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DF00207C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'FININTORGGUID', '业务处室', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DF00307C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'ISRECTIFY', '是否发起整改', 18, 1, 0, 0, null, 0, 6, null, '#name', null, null, 50, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7B5BB6DF00407C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'RECTIFYEND', '是否完成整改', 19, 1, 0, 0, null, 0, 6, null, '#name', null, null, 50, 1, 'tree', null, null);

--列表注册
delete from p#busfw_t_uitable where key ='/pmkpi/program/trace/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B7B5BB6DEFF507C7E0530100007FDFB3', '/pmkpi/program/trace/query', 'PERF_V_PROMONITOR', 100, 0, 0, null, null, 'pmkpi', null);

--监控 表字段注册
delete from bus_t_diccolumn where  tablecode ='PERF_V_PROMONITOR' and COLUMNCODE in('ISRECTIFY','RECTIFYEND');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '0', 'ISRECTIFY', '1', '2020', '87', 'B71F832B8B2903B0E0530100007FA900', 'ISRECTIFY', 'PERF_V_PROMONITOR', '是否发起整改', 'S', '10', null, 1, 1, null,sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '0', 'RECTIFYEND', '1', '2020', '87', 'B71F832B8B2903B0E0530100007FA911', 'RECTIFYEND', 'PERF_V_PROMONITOR', '是否完成整改', 'S', '10', null, 1, 1, null, sysdate);

