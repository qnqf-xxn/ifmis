begin
  --问题整改查询 页面注册
delete from bus_t_pageconsole where url ='/pmkpi/rectification/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'pmkpi_rectifyquery', '{}', 'rectifyquery', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'busuidatatable', '{key:''/pmkpi/rectification/index'',name:''问题整改'',checkbox:true,title:''问题整改'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/query', 'header', '{}', 'header', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_rectifyquery';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectifyquery', '问题整改查询', null, '问题整改查询', '/pmkpi/rectification/rectificationQuery.js', 'Ext.lt.pmkpi.rectification.query', 'pmkpi', 'pmkpi.rectification.RectificationQueryService');

--ui配置
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/query';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('D4D3D3E35B72274CE0533315A8C0ACDD', '/pmkpi/rectification/query', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null, null);

delete from busfw_t_uifunction where key ='/pmkpi/rectification/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36601274CE0533315A8C0ACDD', '/pmkpi/rectification/query', '查看明细', 1, 6, 'addaction', 'rectifyquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36604274CE0533315A8C0ACDD', '/pmkpi/rectification/query', '查看项目', 1, 7, null, 'rectifyquery.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36605274CE0533315A8C0ACDD', '/pmkpi/rectification/query', '审核情况', 1, 8, 'addaction', 'rectifyquery.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3690A274CE0533315A8C0ACDD', '/pmkpi/rectification/query', '导出列表', 1, 11, 'addaction', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

