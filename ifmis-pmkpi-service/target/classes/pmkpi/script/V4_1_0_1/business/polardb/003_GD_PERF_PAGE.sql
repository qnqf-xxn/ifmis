BEGIN
--重点绩效指标页
delete from bus_t_pagecomponent t where t.id in('pmkpi_gdfinindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_gdfinindex', '债务重点评价指标', null, '债务重点评价指标', '/pmkpi/evaluation/financial/gdindex/gdfinindex.js', 'Ext.lt.pmkpi.gdfinindex', 'pmkpi', 'pmkpi.evaluation.financial.GDFinIndexService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/gd/gdindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/gd/gdindex', 'pmkpi_gdfinindex', '{}', 'gdfinindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/gd/gdindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''债券绩效指标'',edit:true,checkbox:false,title:''债券绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/gd/gdindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/gd/gdindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/gd/gdindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.gdindex.GDFinIndexPage', 'index', '{main:[toolbutton,datatable]}', null, null, 0);

--债务绩效指标库
delete from bus_t_pagecomponent t where t.id in('pmkpi_gdindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_gdindex', '债务绩效指标库', null, '债务绩效指标库', '/pmkpi/setting/indexlib/gdindex.js', 'Ext.lt.pmkpi.gdindex', 'pmkpi', 'pmkpi.setting.gd.GDIndexService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/gd/gdindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/gd/gdindex', 'pmkpi_gdindex', '{}', 'gdindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/gd/gdindex', 'busuidatatable', '{name:''债务绩效指标库'',checkbox:true,title:''债务绩效指标库'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/gd/gdindex', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/gd/gdindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/gd/gdindex', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/gd/gdindex', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/setting/gd/gdindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/gd/gdindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexlib.gdreport.GDIndexPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

--指标库编辑
delete from Bus_t_Pageconsole t where t.url in ('/pmkpi/gdindex/edit');

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/gdindex/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexlib.gdreport.GDIndexPage', 'editindex', '{main:[editform],footer:[toolbutton]}', null, null, 0);

delete FROM Bus_t_Pageconsolecomconfig t where t.url in ('/pmkpi/gdindex/edit');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/gdindex/edit', 'pmkpi_gdindexedit', '{}', 'gdindexedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/gdindex/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/gdindex/edit', 'buseditform', '{}', 'editform', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id in ('pmkpi_gdindexedit');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_gdindexedit', '指标编辑', null, '指标编辑', '/pmkpi/setting/indexlib/gdindexedit.js', 'Ext.lt.pmkpi.gdindexedit', 'pmkpi', 'pmkpi.setting.gd.GDIndexEditService');
