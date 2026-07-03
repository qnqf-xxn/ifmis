begin


--单位端对接信息选择项目页面配置
delete from bus_t_pageconsole where url ='/pmkpi/deif/selectpro';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deif/selectpro', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'check', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/deif/selectpro';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deif/selectpro', 'perf_deifselectpro', '{}', 'deifselectpro', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deif/selectpro', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deif/selectpro', 'busuidatatable', '{key:''/pmkpi/perfself/query'',name:''选择项目'',checkbox:true,title:''选择项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/deif/selectpro', 'busqueryform', '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);


delete from bus_t_pagecomponent where id ='perf_deifselectpro';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_deifselectpro', '选择项目', null, '选择项目', '/pmkpi/deif/deifselectpro.js', 'Ext.lt.pmkpi.deifselectpro', 'pmkpi', 'pmkpi.deif.DeifselectproService');


delete from p#busfw_t_uifunction where key ='/pmkpi/deif/selectpro';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deif/selectpro', '查看自评详情', 1, 0, 'Keepicon', 'Ext.lt.pmkpi.deifselectpro.selfdetail', null, '查看自评详情', 'pmkpi', 'selfdetail', null, null,'87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deif/selectpro', '确定', 1, 1, 'Keepicon', 'Ext.lt.pmkpi.deifselectpro.exp', null, '导出', 'pmkpi', 'exp', null, null,'87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deif/selectpro', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.pmkpi.deifselectpro.close', null, '取消', 'pmkpi', 'close', null, null, '87', '2016', null, null);

