begin


delete from p#busfw_T_uitable where key = '/pmkpi/evaluatetemp/index';

insert into p#busfw_T_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('080A32D55A7B4B2321C5C7DA5E8E4188', '/pmkpi/evaluatetemp/index', 'PERF_T_RANDOMQUALITY_TYPE', 0, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluatetemp/index';

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('19C1BA269EB16AC477E61C9E32CE5796', '/pmkpi/evaluatetemp/index', 'BUSTYPE', '绩效类型', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DD78E3E25EC662477D4FFA2ECD3EEA2B', '/pmkpi/evaluatetemp/index', 'CODE', '模板编码', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('EE6DAD5C11E33113CD408403436AF00E', '/pmkpi/evaluatetemp/index', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('14A75D3EC8AA7536EBA43F74155B3D0F', '/pmkpi/evaluatetemp/index', 'NAME', '模板名称', 3, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

delete from p#busfw_t_uiqueryform where key = '/pmkpi/evaluatetemp/index';

insert into p#busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('A88ACDC8E4FC8FB3B9E590A7D930213A', '/pmkpi/evaluatetemp/index', 'NAME', '模板名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_RANDOMQUALITY_TYPE', '{}', null, '87', '2016');

delete from p#BUSFW_T_UIFUNCTION where key = '/pmkpi/evaluatetemp/index';

insert into p#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('1B3C43A5253C59C4B397118316A35F66', '/pmkpi/evaluatetemp/index', '新增', 1, 1, 'searchicon', 'evaluatetemp.toAdd', null, '新增', 'pmkpi', 'infosave', null, '{}', '87', '2016');

insert into p#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('1F513C506BB0328075B1910657546121', '/pmkpi/evaluatetemp/index', '修改', 1, 2, 'searchicon', 'evaluatetemp.toEdit', null, '修改', 'pmkpi', 'edit', null, '{}', '87', '2016');

insert into p#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('AA7E682E3870D161FB1F59230CE7C324', '/pmkpi/evaluatetemp/index', '删除', 1, 3, 'searchicon', 'evaluatetemp.del', null, '删除', 'pmkpi', 'del', null, '{}', '87', '2016');

insert into p#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('CC7FAE34A4540EB309F88CEE61186DDF', '/pmkpi/evaluatetemp/index', '查询', 1, 3, 'searchicon', 'evaluatetemp.query', null, '查询', 'pmkpi', 'query', null, '{}', '87', '2016');


delete from Bus_t_Pagecomponent where id = 'pmkpi_evaluatetemp';

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluatetemp', '评价类型', null, '评价类型', '/pmkpi/evaluateTemp/evaluatetemp.js', 'Ext.lt.pmkpi.evaluatetemp', 'pmkpi', 'pmkpi.evaluatetemp.EvaluateTempService');

delete from Bus_t_Pageconsole where url = '/pmkpi/evaluatetemp/index';

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/index', 'pmkpi_evaluatetemp', '{}', 'evaluatetemp', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/index', 'busuidatatable', '{name:''评价类型'',checkbox:true,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/index', 'busqueryform', '{}', 'queryform', 'pmkpi', null);
