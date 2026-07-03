begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/dept/proindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/dept/proindex', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.index.DeptIndexPage', 'proindex', '{main:[queryform,datatable],footer:[toolbutton]}', null, null, null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/dept/proindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/dept/proindex', 'pmkpi_deptcheckproindex', '{}', 'deptcheckproindex', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/dept/proindex', 'busuidatatable', '{headsort:false,addrow:false,edit:false,checkbox:true,title:''项目年度绩效指标'', groupcols:[''pro_code'',''superguid'',''pro_code'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/dept/proindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/dept/proindex', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_deptcheckproindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptcheckproindex', '选择项目指标', null, '选择项目指标', '/buscommon/fileimport/js/import.js,/pmkpi/deptperformance/proindex.js', 'Ext.lt.pmkpi.proindex', 'pmkpi', 'pmkpi.deptperformance.index.ProIndexService');
