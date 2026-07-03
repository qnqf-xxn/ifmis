--绩效目标修订填报
begin
--页面配置
delete from bus_t_pageconsole where url='/pmkpi/prorevision/report';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url='/pmkpi/prorevision/report';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'pmkpi_revisionreport', '{}', 'revisionreport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busuidatatable', '{key:''/pmkpi/prorevision/report/list'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busqueryform', '{key:''/pmkpi/prorevision/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busqueryform', '{key:''/pmkpi/prorevision/report/dept'',name:''部门整体查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'deptqueryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

--表字段注册添加项目库参数
delete FROM BUS_T_DICCOLUMN T WHERE T.TABLECODE='PERF_T_PROVISIONDECLARE' AND T.COLUMNCODE in('MANAGE_DEPT_CODE','MANAGE_MOF_DEP_CODE','MOF_DEP_CODE','DEPT_CODE','AGENCY_CODE');
insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCY_CODE', '1', '2016', '87', 'CFB0962F961C4925E0533315A8C009D1', 'AGENCY_CODE', 'PERF_T_PROVISIONDECLARE', '单位', 'S', '40', null, null, 1, null, sysdate);

insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'DEPT_CODE', '1', '2016', '87', 'CFB0962F96184925E0533315A8C009D2', 'DEPT_CODE', 'PERF_T_PROVISIONDECLARE', '单位主管部门', 'S', '40', null, null, 1, null, sysdate);

insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'MANAGE_DEPT_CODE', '1', '2016', '87', 'CFB0962F96624925E0533315A8C009D3', 'MANAGE_DEPT_CODE', 'PERF_T_PROVISIONDECLARE', '资金主管部门', 'S', '40', null, null, 1, null, sysdate);

insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'MANAGE_MOF_DEP_CODE', '1', '2016', '87', 'CFB0962F96634925E0533315A8C009D4', 'MANAGE_MOF_DEP_CODE', 'PERF_T_PROVISIONDECLARE', '资金主管处室', 'S', '40', null, null, 1, null, sysdate);

insert into BUS_T_DICCOLUMN (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'MOF_DEP_CODE', '1', '2016', '87', 'CFB0962F96674925E0533315A8C009D5', 'MOF_DEP_CODE', 'PERF_T_PROVISIONDECLARE', '单位归口处室', 'S', '40', null, null, 1, null, sysdate);


--列表注册
delete from p#busfw_t_uitable where key ='/pmkpi/prorevision/report/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B98F5984660DB918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'V_PERF_T_PROVISIONDECLARE', 100, 0, 0, null, null, 'pmkpi', null);

--列表字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/prorevision/report/list';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F5984660FB918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'PRO_CODE', '项目编码', 4, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846612B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'PRO_NAME', '项目名称', 5, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F5984660EB918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'AGENCYGUID', '预算单位', 6, 1, 0, 0, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846615B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'YEAR', '预算年份', 7, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846610B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'CREATETIME', '填报时间', 9, 1, 0, 0, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846611B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'FININTORGGUID', '业务科室', 13, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846616B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'GUID', '主键', 15, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846614B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'WFSTATUS', '审核状态', 15, 0, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846613B918E053B11FA8C0831D', '/pmkpi/prorevision/report/list', 'WFID', '工作流id', 20, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('pC8673863AE9D5B8E053B11FA8C03A82', '/pmkpi/prorevision/report/list', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009BF2EC2E053B11FA8C00E35', '/pmkpi/prorevision/report/list', 'REVISIONNUM', '修订次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F5984660FB918E053B11FA8C08311', '/pmkpi/prorevision/report/list', 'AGENCY_CODE', '单位编码', 4, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846612B918E053B11FA8C08312', '/pmkpi/prorevision/report/list', 'AGENCY_NAME', '单位名称', 5, 1, 0, 0, null, null, 1, null, null, null, null, 150, 0, 's', '{type:''dept''}', null);

--修订填报 --选项目
--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/prorevision/report/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/prorevision/report/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'pmkpi_revisionreportcheck', '{}', 'revisionreportcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/check''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false,wheresql:'' exists (select 1 from v_pm_perf_goal_info gf where gf.mainguid = t.guid and gf.YEARFLAG = 1)''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--绩效目标修订审核
--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/prorevision/audit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.audit.ProrevisionAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/prorevision/audit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'pmkpi_prorevisionaudit', '{}', 'prorevisionaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'busqueryform', '{key:''/pmkpi/prorevision/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'busuidatatable', '{key:''/pmkpi/prorevision/report/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);



