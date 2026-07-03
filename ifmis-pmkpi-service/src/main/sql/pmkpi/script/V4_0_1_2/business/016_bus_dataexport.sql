begin
--1
delete from p#busfw_t_uifunction  where key = '/pmkpi/deptperformance/audit/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0FC3275E053C224280A22FC', '/pmkpi/deptperformance/audit/index', '审核信息', 1, 7, 'searchicon', 'deptperformanceaudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0FD3275E053C224280A22FC', '/pmkpi/deptperformance/audit/index', '审核', 1, 1, null, 'deptperformanceaudit.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0FE3275E053C224280A22FC', '/pmkpi/deptperformance/audit/index', '取消审核', 1, 2, null, 'deptperformanceaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('e9bbc1539c1d2268c7b4e902850a321d', '/pmkpi/deptperformance/audit/index', '查询', 0, 3, 'searchicon', 'deptperformanceaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1003275E053C224280A22FC', '/pmkpi/deptperformance/audit/index', '审核情况', 1, 6, 'searchicon', 'deptperformanceaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F53BEA502FDB4B24B45B6407E1A8E6B8', '/pmkpi/deptperformance/audit/index', '导出列表', 1, 5, 'searchicon', 'deptperformanceaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/deptperformance/audit/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'pmkpi_deptperformanceaudit', '{}', 'deptperformanceaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'busuidatatable', '{name:''部门绩效审核'',checkbox:true,title:''部门绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/deptperformance/report/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--2
delete from p#busfw_t_uifunction  where key = '/pmkpi/deptperformance/report/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('272B06A449D54A68982B0C8ED1410D8A', '/pmkpi/deptperformance/report/index', '导出列表', 1, 8, 'searchicon', 'tabfreamlist.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0F73275E053C224280A22FC', '/pmkpi/deptperformance/report/index', '填报/修改', 1, 2, 'searchicon', 'tabfreamlist.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0F63275E053C224280A22FC', '/pmkpi/deptperformance/report/index', '删除', 1, 3, 'searchicon', 'tabfreamlist.del', null, '删除', 'pmkpi', 'del', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0F23275E053C224280A22FC', '/pmkpi/deptperformance/report/index', '送审', 1, 4, 'searchicon', 'tabfreamlist.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{remark:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0F43275E053C224280A22FC', '/pmkpi/deptperformance/report/index', '取消送审', 1, 5, 'searchicon', 'tabfreamlist.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB0F33275E053C224280A22FC', '/pmkpi/deptperformance/report/index', '审核情况', 1, 6, 'searchicon', 'tabfreamlist.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('15CE63D25473440689219988DC6F6C58', '/pmkpi/deptperformance/report/index', '查询', 0, 7, 'searchicon', 'tabfreamlist.query', null, '查询', 'pmkpi', 'query', null, '{}');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/deptperformance/report/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'pmkpi_tabfreamlist', '{}', 'tabfreamlist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/deptperformance/report/edit'',deltables:[perf_t_deptfunction,v_bgt_perf_goal_info,v_bgt_perf_indicator],repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--3
delete from p#busfw_t_uifunction  where key = '/pmkpi/adjust/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616974744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '审核', 1, 1, 'searchicon', 'adjustaudit.audit', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616994744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '取消审核', 1, 2, 'searchicon', 'adjustaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616964744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '审核情况', 1, 3, 'searchicon', 'adjustaudit.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E6169A4744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '查看明细', 1, 4, 'searchicon', 'adjustaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A7223760806648CDBD477EC2C433E14F', '/pmkpi/adjust/audit', '导出列表', 1, 5, 'searchicon', 'adjustaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/adjust/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'pmkpi_adjustaudit', '{}', 'adjustaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busqueryform', '{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busuidatatable', '{key:''/pmkpi/adjust/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/audit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--4
delete from p#busfw_t_uifunction  where key = '/pmkpi/adjust/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9ED1F70095B2EC2E053B11FA8C00E35', '/pmkpi/adjust/query', '审核情况', 1, 3, 'searchicon', 'adjustquery.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9ED1F70095C2EC2E053B11FA8C00E35', '/pmkpi/adjust/query', '查看明细', 1, 4, 'searchicon', 'adjustquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('95F12E5D3C084A03AD622DD659A62E8C', '/pmkpi/adjust/query', '导出列表', 1, 5, 'searchicon', 'adjustquery.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/adjust/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'pmkpi_adjustquery', '{}', 'adjustquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busqueryform', '{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busuidatatable', '{key:''/pmkpi/adjust/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--5
delete from p#busfw_t_uifunction  where key = '/pmkpi/adjust/report';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C6AF05E29E637CE053B11FA8C06B90', '/pmkpi/adjust/report', '选择项目', 1, 1, 'searchicon', 'adjustreport.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F5984661AB918E053B11FA8C0831D', '/pmkpi/adjust/report', '调整', 1, 2, 'searchicon', 'adjustreport.adjustment', null, '调整', 'pmkpi', 'toEdit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F59846619B918E053B11FA8C0831D', '/pmkpi/adjust/report', '送审', 1, 3, 'searchicon', 'adjustreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F5984661BB918E053B11FA8C0831D', '/pmkpi/adjust/report', '取消送审', 1, 4, 'searchicon', 'adjustreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F59846618B918E053B11FA8C0831D', '/pmkpi/adjust/report', '审核情况', 1, 5, 'searchicon', 'adjustreport.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616324744E053B11FA8C01BA3', '/pmkpi/adjust/report', '查看明细', 1, 6, 'searchicon', 'adjustreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4BC659F5BB2043608C45C6F8FADAE2BF', '/pmkpi/adjust/report', '导出列表', 1, 7, 'searchicon', 'adjustreport.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F5984661BB918E053B11FA8C08PPP', '/pmkpi/adjust/report', '删除项目', 1, 7, 'searchicon', 'adjustreport.deladjust', null, '删除项目', 'pmkpi', 'deladjust', null, '{}');

delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/adjust/report';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'pmkpi_adjustreport', '{}', 'adjustreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busuidatatable', '{key:''/pmkpi/adjust/report/program'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busqueryform', '{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busqueryform', '{key:''/pmkpi/adjust/report/dept'',name:''部门整体查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'deptqueryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busuidatatable', '{key:''/pmkpi/adjust/report/dept'',name:''部门整体绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'deptdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--6
delete from p#busfw_t_uifunction  where key = '/pmkpi/program/trace/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9449CBE0530100007F4B66', '/pmkpi/program/trace/audit', '审核', 1, 4, 'searchicon', 'protraceaudit.audit', null, '审核', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9549CBE0530100007F4B66', '/pmkpi/program/trace/audit', '取消审核', 1, 5, 'searchicon', 'protraceaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B7A11C351F9649CBE0530100007F4B66', '/pmkpi/program/trace/audit', '审核情况', 1, 6, 'searchicon', 'protraceaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4D4011F3455B444FB0C58CF7D5C5EFC8', '/pmkpi/program/trace/audit', '导出列表', 1, 9, 'searchicon', 'protraceaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C14F231C6BB34F83D254806FDDE5478A', '/pmkpi/program/trace/audit', '导出报告', 1, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告', 'pmkpi', 'expdoc', null, '{tempatecode:''tracereportindex''}');

delete from  bus_t_pageconsolecomconfig  where  url = '/pmkpi/program/trace/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'pmkpi_protraceaudit', '{}', 'protraceaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/audit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--7
delete from p#busfw_t_uifunction  where key = '/pmkpi/program/trace/auditresults';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4BFE24C81E944474BC48EF6C3087470C', '/pmkpi/program/trace/auditresults', '导出列表', 1, 7, 'searchicon', 'traceauditresults.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E66CD765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '审核', 1, 4, 'searchicon', 'traceauditresults.audit', null, '审核', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E66DD765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '取消审核', 1, 5, 'searchicon', 'traceauditresults.wfAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E66ED765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '审核情况', 1, 6, 'searchicon', 'traceauditresults.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C2A75BE2E671D765E053B11FA8C0E2C8', '/pmkpi/program/trace/auditresults', '成果查看', 1, 6, 'searchicon', 'traceauditresults.viewresults', null, '成果查看', 'pmkpi', 'viewresults', null, '{}');

delete from  bus_t_pageconsolecomconfig  where  url = '/pmkpi/program/trace/auditresults';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'pmkpi_traceauditresults', '{}', 'traceauditresults', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/auditresults', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

--8
delete from p#busfw_t_uifunction  where key = '/pmkpi/program/trace/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA6668DFDFB71167E053B11FA8C08965', '/pmkpi/program/trace/query', '审核情况', 1, 6, 'searchicon', 'protracequery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0FB417C7AD8D4E088AD39AF1F490F2A4', '/pmkpi/program/trace/query', '导出列表', 1, 9, 'searchicon', 'protracequery.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C14F231C6BB22F66D254806FDDE5478A', '/pmkpi/program/trace/query', '导出报告', 1, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告', 'pmkpi', 'expdoc', null, '{tempatecode:''tracereportindex''}');

delete from  bus_t_pageconsolecomconfig  where  url = '/pmkpi/program/trace/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'pmkpi_protracequery', '{}', 'protracequery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busuidatatable', '{key:''/pmkpi/program/trace/report'',name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busqueryform', '{key:''/pmkpi/program/trace/report'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--9
delete from p#busfw_t_uifunction where key = '/pmkpi/program/trace/report';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AF003B0E0530100007FA9FF', '/pmkpi/program/trace/report', '填报/修改', 1, 2, 'searchicon', 'protaskreport.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AEC03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '送审', 1, 4, 'searchicon', 'protaskreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{remark:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AEE03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '取消送审', 1, 5, 'searchicon', 'protaskreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AED03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '审核情况', 1, 6, 'searchicon', 'protaskreport.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B71F832B8AEF03B0E0530100007FA9FF', '/pmkpi/program/trace/report', '查询', 0, 7, 'searchicon', 'protaskreport.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8E849BE30C494CE9B90A907776A5F9AE', '/pmkpi/program/trace/report', '导出列表', 1, 5, 'searchicon', 'protaskreport.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C14F231C6BB22F83D254806FDDE5478A', '/pmkpi/program/trace/report', '导出报告', 1, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告', 'pmkpi', 'expdoc', null, '{tempatecode:''tracereportindex''}');

delete from  bus_t_pageconsolecomconfig where  url = '/pmkpi/program/trace/report';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'pmkpi_protaskreport', '{}', 'protaskreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busuidatatable', '{name:''绩效运行监控'',checkbox:true,title:''绩效运行监控'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--10
delete from p#busfw_t_uifunction  where key = '/pmkpi/rectification/audit/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('95E751B0D548BFAF4D020E0708275B4A', '/pmkpi/rectification/audit/index', '下发', 1, 2, 'addaction', 'rectificationaudit.send', null, '下发', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DE24FB043565247602D4F8496CC3A094', '/pmkpi/rectification/audit/index', '审核情况', 1, 4, 'addaction', 'rectificationaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('40349437008AE6B5375F270FA5C63919', '/pmkpi/rectification/audit/index', '退回', 1, 3, 'addaction', 'rectificationaudit.back', null, '退回', 'pmkpi', '退回', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('59CE85375EBA016896C69A79221E4170', '/pmkpi/rectification/audit/index', '查询', 0, 1, 'addaction', 'rectificationaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('788D8ED39F924243A88B2F6C81E8BA22', '/pmkpi/rectification/audit/index', '导出列表', 1, 5, 'searchicon', 'rectificationaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

delete from  bus_t_pageconsolecomconfig  where  url = '/pmkpi/rectification/audit/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'pmkpi_rectificationaudit', '{}', 'rectificationaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busuidatatable', '{name:''整改通知审核'',checkbox:true,title:''整改通知审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/rectification/add''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

--11
delete from p#busfw_t_uifunction where key = '/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2E041D630C43BDE245F03751798259C3', '/pmkpi/rectification/feedback/audit/index', '取消审核', 1, 8, 'addaction', 'feedbackAudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AEDD3BDCB952726578D7D2838F16BA87', '/pmkpi/rectification/feedback/audit/index', '审核情况', 1, 9, 'addaction', 'feedbackAudit.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3B63783C84CA198D92FD6EBD458496FB', '/pmkpi/rectification/feedback/audit/index', '审核', 1, 5, 'addaction', 'feedbackAudit.send', null, '审核', 'pmkpi', 'send', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('64AFDD7C9DFD82DA5F418F0B68013751', '/pmkpi/rectification/feedback/audit/index', '查询', 0, 1, 'addaction', 'feedbackAudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0E47A168221C06E8E8C25C2A3A80EB6C', '/pmkpi/rectification/feedback/audit/index', '退回', 0, 6, 'addaction', 'feedbackAudit.back', null, '退回', 'pmkpi', 'back', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4E3DC0A835A5B0683955F67349075DC2', '/pmkpi/rectification/feedback/audit/index', '批量审核', 0, 7, 'addaction', 'feedbackAudit.sendlist', null, '批量审核', 'pmkpi', 'sendlist', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54314B2E452249C08234D60BB31729FE', '/pmkpi/rectification/feedback/audit/index', '审核信息', 0, 10, 'searchicon', 'feedbackAudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F46EFBD2379D4F43A22FAAFD9625FD89', '/pmkpi/rectification/feedback/audit/index', '导出列表', 1, 11, 'searchicon', 'feedbackAudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

delete from bus_t_pageconsolecomconfig where  url = '/pmkpi/rectification/feedback/audit/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'pmkpi_feedbackAudit', '{}', 'feedbackAudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busuidatatable', '{name:''整改情况审核'',checkbox:true,title:''整改情况审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/rectification/feedback/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);
