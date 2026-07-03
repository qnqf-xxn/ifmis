begin

--1.标识业务
--dic
delete from bus_t_diccolumn where tablecode in('BAS_PERF_INDICATOR','PM_PERF_INDICATOR','PM_PERF_INDICATOR_TEMP','PERF_T_ADJUSTINDEX','PERF_T_CASEMODELINDEX','PERF_IMPTMP_CASEMODELINDEX') and columncode ='IS_REMARKED';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_REMARKED', '1', '2016', '87', sys_guid(), 'IS_REMARKED', 'BAS_PERF_INDICATOR', '是否梳理指标', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_REMARKED', '1', '2016', '87', sys_guid(), 'IS_REMARKED', 'PM_PERF_INDICATOR', '是否梳理指标', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_REMARKED', '1', '2016', '87', sys_guid(), 'IS_REMARKED', 'PM_PERF_INDICATOR_TEMP', '是否梳理指标', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_REMARKED', '1', '2016', '87', sys_guid(), 'IS_REMARKED', 'PERF_T_ADJUSTINDEX', '是否梳理指标', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_REMARKED', '1', '2016', '87', sys_guid(), 'IS_REMARKED', 'PERF_T_CASEMODELINDEX', '是否梳理指标', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'IS_REMARKED', '1', '2016', '87', sys_guid(), 'IS_REMARKED', 'PERF_IMPTMP_CASEMODELINDEX', '是否梳理指标', 'N', '1', null, 1, 1, null, sysdate);

--ui
delete from p#busfw_t_uieditform where key in('/pmkpi/indexlib/edit','/pmkpi/indexlib/commedit') and columncode ='IS_REMARKED';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '梳理指标', 'IS_REMARKED', 0, null, 0, null, 47, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null,  '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'tree', '梳理指标', 'IS_REMARKED', 0, null, 0, null, 47, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null,  '87', '2016', null, null, null);


delete from p#busfw_t_uicolumn where key in ('/pmkpi/case/proindex','/pmkpi/program/report/treeindex','/pmkpi/adjust/report/proedit/index') and columncode ='IS_REMARKED';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/case/proindex', 'IS_REMARKED', '梳理指标', 30, 0, 1, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'IS_REMARKED', '梳理指标', 50, 0, 0, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', 'IS_REMARKED', '梳理指标', 50, 0, 0, 0, null, 1, 1, null, '#name', null, null, null, 1, 'tree', null, null,  '87', '2016', null, null);


--2.统计查询
--统计页面
delete from bus_t_pageconsole where url ='/pmkpi/casemarkedindi/index';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/casemarkedindi/index', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.casemarkedindi.CasemarkedIndiPage', 'list', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/casemarkedindi/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'pmkpi_casemarkedindi', '{}', 'casequery', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'header', '{}', 'header', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'busuidatatable', '{name:''梳理指标库统计查询'',checkbox:true,title:''梳理指标库统计查询'',edit:false,addrow:false}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null, null);

delete from bus_t_pagecomponent where id ='pmkpi_casemarkedindi';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_casemarkedindi', '梳理指标库统计查询', null, '梳理指标库统计查询', '/pmkpi/setting/casepage/casemarkedindiquery.js', 'Ext.lt.pmkpi.casemarkedindi.casemarkedindiquery', 'pmkpi', 'pmkpi.casemarkedindi.CasemarkedIndiService');

--左侧树
delete from perf_t_treetab where key ='/pmkpi/casemarkedindi/index';

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'PM001', '项目支出', 1, null, 1, '2016', '87', 'E2A5CA708C55131DE0533315A8C01809', 'pm001casequeryhide', '{"leftsource":"PERFGXCLASSIFICATION"}');

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'DEPT', '部门整体', 0, null, 2, '2016', '87', 'E2A5CA708C56131DE0533315A8C01809', 'deptcaserqueryhide', '{"leftsource":"PMKPIDEPT"}');

--查询区
delete from p#busfw_t_uiqueryform t where key ='/pmkpi/casemarkedindi/index';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'CASE_NAME', '案例名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_V_INDIMARKED', '{}', null, null, null, null,  '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'INDI_NAME', '指标名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_V_INDIMARKED', '{}', null, null, null, null,  '87', '2016');

--按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/casemarkedindi/index';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', '导出列表', 1, 1, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}',  '87', '2016', null, null);

--列表
delete from p#busfw_t_uitable where key ='/pmkpi/casemarkedindi/index';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'PERF_V_INDIMARKED', 20, 1, 0, null, null, 'pmkpi', '{}',  '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/casemarkedindi/index';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'CASEPARENT_NAME', '大专项', 1, 1, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'CASETYPE_NAME', '子专项', 2, 1, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'CASE_GUID', '案例GUID', 3, 0, 0, 0, null, 0, 0, null, null, null, null, 150, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'INDI_CODE', '指标编码', 3, 0, 0, 0, null, 0, 0, null, null, null, null, 150, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'CASE_NAME', '案例名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'INDI_NAME', '指标名称', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'INDI_COUNT1', '2024', 5, 1, 0, 0, null, 0, 0, '[''近三年引用次数'']', null, null, null, 50, 0, 'i', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'INDI_COUNT2', '2025', 6, 1, 0, 0, null, 0, 0, '[''近三年引用次数'']', null, null, null, 50, 0, 'i', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/index', 'INDI_COUNT3', '2026', 7, 1, 0, 0, null, 0, 0, '[''近三年引用次数'']', null, null, null, 50, 0, 'i', null, null,  '87', '2016', null, null);


--3.引用情况页面
delete from bus_t_pageconsole where url ='/pmkpi/casemarkedindi/prolist';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/casemarkedindi/prolist', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.casepage.casemarkedindi.CasemarkedIndiPage', 'prolist', '{main:[toolbutton,queryform,datatable]}', null, null, 1);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/casemarkedindi/prolist';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/prolist', 'pmkpi_casemarkedindiprolist', '{}', 'casequery', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/prolist', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/prolist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/prolist', 'busuidatatable', '{name:''梳理指标库引用情况'',checkbox:true,title:''梳理指标库引用情况'',edit:false,addrow:false}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/casemarkedindi/prolist', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null, null);

delete from bus_t_pagecomponent where id ='pmkpi_casemarkedindiprolist';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_casemarkedindiprolist', '梳理指标库引用情况', null, '梳理指标库引用情况', '/pmkpi/setting/casepage/casemarkedindiprolist.js', 'Ext.lt.pmkpi.casemarkedindi.casemarkedindiprolist', 'pmkpi', 'pmkpi.casemarkedindi.CasemarkedIndiService');

--查询区
delete from p#busfw_t_uiqueryform t where key ='/pmkpi/casemarkedindi/prolist';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PRO_CODE', '项目编码', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null, null, null,  '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null, null, null,  '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'AGENCYGUID', '项目单位', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null, null, null,  '87', '2016');

--按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/casemarkedindi/prolist';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', '导出列表', 1, 1, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}',  '87', '2016', null, null);

--列表
delete from p#busfw_t_uitable where key ='/pmkpi/casemarkedindi/prolist';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'V_PERF_PROJECT_INFO', 20, 1, 0, null, null, 'pmkpi', '{}',  '87', '2016');

delete from p#busfw_t_uicolumn t where key ='/pmkpi/casemarkedindi/prolist';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PRO_ID', '项目ID', 0, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'INDI_CODE', '指标编码', 1, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'INDI_NAME', '指标名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PRO_CODE', '项目编码', 3, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PRO_NAME', '项目名称', 4, 0, 0, 0, null, 0, 1, null, null, null, null, 300, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PRO_CODENAME', '项目名称', 5, 1, 0, 0, null, 0, 1, null, null, null, null, 300, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'AGENCY_CODE', '项目单位', 6, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'AGENCY_NAME', '项目单位', 7, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PROAGENCY_NAME', '项目单位', 8, 1, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'MOF_DEP_CODE', '业务处室', 9, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'MOF_DEP_NAME', '业务处室', 10, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/casemarkedindi/prolist', 'PROFININTORG_NAME', '业务处室', 11, 1, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null,  '87', '2016', null, null);

--页面配置节点
delete from perf_t_pagemenu t where t.uikey='/pmkpi/casemarkedindi/prolist';

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('1E44E0025CE80858493C9FAF5F7C4E65', '98101', '指标引用情况', '/pmkpi/casemarkedindi/prolist', '780AD7F3R9928F2C879799997ED5B79E', 2, 1, 1, 1, '20260121100752', '20260121100752', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

