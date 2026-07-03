begin
--选择调整页面、js配置
delete from bus_t_pageconsole where url in('/pmkpi/indexlib/procheck','/pmkpi/indexlib/deptcheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/indexlib/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexlib.report.IndexCheckPage', 'index', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/indexlib/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexlib.report.IndexCheckPage', 'index', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url in('/pmkpi/indexlib/procheck','/pmkpi/indexlib/deptcheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/procheck', 'pmkpi_procheck', '{}', 'procheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/procheck', 'busuidatatable', '{name:''指标表'',checkbox:true,title:''指标表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/procheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/deptcheck', 'pmkpi_deptcheck', '{}', 'deptcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/deptcheck', 'busuidatatable', '{name:''指标表'',checkbox:true,title:''指标表'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/deptcheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/indexlib/deptcheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pagecomponent where id in('pmkpi_procheck','pmkpi_deptcheck');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_procheck', '项目选择调整指标页面', null, '项目选择调整指标页面', '/pmkpi/setting/indexlib/indexchecklist.js', 'Ext.lt.pmkpi.indexchecklist', 'pmkpi', 'pmkpi.setting.indexlib.report.IndexCheckService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptcheck', '部门选择调整指标页面', null, '编码选择调整指标页面', '/pmkpi/setting/indexlib/indexchecklist.js', 'Ext.lt.pmkpi.indexchecklist', 'pmkpi', 'pmkpi.setting.indexlib.report.IndexCheckService');



--UI配置
delete from p#busfw_t_uicolumn where key ='/pmkpi/indexlib/procheck';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'AGENCY_CODE', '预算部门', 2, 1, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'PRO_NAME', '项目名称', 12, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'INDEXCATEGORIES', '行业大类', 3, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'INDUSTRYCATEGORY', '行业类别', 4, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'FUNDUSE', '资金用途', 5, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'FINDEX', '一级指标', 6, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'SINDEX', '二级指标', 7, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'PERF_IND_NAME', '内容', 8, 1, 0, null, null, null, 1, '[''三级指标'']', null, null, null, 220, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'COMPUTESIGN', '性质', 9, 1, 0, null, null, null, 1, '[''三级指标'']', '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'KPI_VAL', '参考值', 10, 1, 0, null, null, null, 1, '[''三级指标'']', null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'METERUNIT', '单位', 11, 1, 0, null, null, null, 1, '[''三级指标'']', null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'PROJTYPE', '项目类型', 13, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'UPSTATUS', '变更类型', 1, 1, 1, null, null, 1, null, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'VALUE_DESC', '指标值说明', 14, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', null, null);



delete from p#busfw_t_uicolumn where key ='/pmkpi/indexlib/deptcheck';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'AGENCY_CODE', '预算部门', 2, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'FINDEX', '一级指标', 3, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'SINDEX', '二级指标', 4, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'PERF_IND_NAME', '内容', 5, 1, 0, null, null, null, 1, '[''三级指标'']', null, null, null, 220, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'COMPUTESIGN', '性质', 6, 1, 0, null, null, null, 1, '[''三级指标'']', '#name', null, null, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'KPI_VAL', '参考值', 7, 1, 0, null, null, null, 1, '[''三级指标'']', null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'METERUNIT', '单位', 8, 1, 0, null, null, null, 1, '[''三级指标'']', null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'UPSTATUS', '变更类型', 1, 1, 1, null, null, 1, null, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'VALUE_DESC', '指标值说明', 9, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', null, null);




delete from p#busfw_t_uitable where key ='/pmkpi/indexlib/procheck';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uitable where key ='/pmkpi/indexlib/deptcheck';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}');



delete from p#busfw_t_uifunction where key ='/pmkpi/indexlib/procheck';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/procheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/procheck', '确定', 1, 1, 'Keepicon', 'procheck.save', null, '确定', 'pmkpi', null, null, null);

delete from p#busfw_t_uifunction where key ='/pmkpi/indexlib/deptcheck';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', '确定', 1, 1, 'Keepicon', 'deptcheck.save', null, '确定', 'pmkpi', null, null, null);



delete from p#busfw_t_uiqueryform where key ='/pmkpi/indexlib/procheck';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/procheck', 'PERF_IND_NAME', '三级指标名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);

delete from p#busfw_t_uiqueryform where key ='/pmkpi/indexlib/deptcheck';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/deptcheck', 'PERF_IND_NAME', '三级指标名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);

