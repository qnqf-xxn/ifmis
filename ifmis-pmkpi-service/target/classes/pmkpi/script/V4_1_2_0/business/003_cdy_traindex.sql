begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/traindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/traindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'traIndex', '{left:lefttree,main:[toolbutton,editform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_traindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_traindex', '细化区域年度绩效', null, '细化区域年度绩效', '/pmkpi/perfprogram/prjindex/prjtragoalandindex.js', 'Ext.lt.pmkpi.tragoalandindex', 'pmkpi', 'pmkpi.prjindex.PrjTraGoalAndIndexService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/traindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/traindex', 'pmkpi_traindex', '{}', 'traindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/traindex', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/traindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/traindex', 'busuidatatable', '{key:''/pmkpi/program/report/treeindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false,remark:''当整体年度绩效修改时区域年度绩效需同步调整。''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/traindex', 'buseditform', '{key:''/pmkpi/program/report/protabgoal''}', 'editform', 'pmkpi', null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/program/report/protabgoal') and t.columncode in('SUB_MOF_DIV_CODE');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '下级财政区划代码', 'SUB_MOF_DIV_CODE', 0, null, 1, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/traindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/traindex', '获取最新整体绩效指标', 1, 1, 'searchicon', 'traindex.updaedata', null, '获取最新整体绩效指标', 'pmkpi', 'updaedata', null, '{}', '87', '2016', null, null);
