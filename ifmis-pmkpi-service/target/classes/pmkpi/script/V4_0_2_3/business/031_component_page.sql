begin



delete from P#BUSFW_T_UICOLUMN t where  t.key='/pmkpi/perfset/component';

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D2D3D3E11B6D274CE0533315A4C0ACDD', '/pmkpi/perfset/component', 'KEY', 'key', 2, 1, 0, null, null, null, null, null, null, null, null, null, null, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32B6D274CE0533315A8C0ACDD', '/pmkpi/perfset/component', 'NAME', '组件权限名称', 1, 1, 1, null, null, null, null, null, null, null, null, null, null, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32B78274CE0533315A8C0ACDD', '/pmkpi/perfset/component', 'GUID', '数据权限guid', 1, 0, 0, null, null, null, null, null, null, null, null, null, null, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D6D3D5E32B78178CE0555315A1C0ACDD', '/pmkpi/perfset/component', 'ISVISIABLE', '是否显示', 4, 1, 1, null, null, null, null, null, null, null, null, null, null, 'check', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5D3D1E32B78274CE0555315A1C0ACDD', '/pmkpi/perfset/component', 'ISEDIT', '是否编辑', 3, 1, 1, null, null, null, null, null, null, null, null, null, null, 'check', null, null);




delete from P#BUSFW_T_UIFUNCTION t where t.key='/pmkpi/perfset/component'; 

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36690274CE0533315A8C0ACDD', '/pmkpi/perfset/component', '保存', 1, 3, null, 'Ext.lt.drtemplate.save', null, '保存', 'pmkpi', null, null, null);



delete from P#BUSFW_T_UITABLE  t where t.key='/pmkpi/perfset/component';

insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30FAE274CE0533315A8C0ACDD', '/pmkpi/perfset/component', 'V_PERF_COMPONET_POWER', 0, 0, null, null, null, 'pmkpi', null);


delete from bus_t_pageconsolecomconfig t where t.url='/pmkpi/perfset/component';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfset/component', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfset/component', 'pmkpi_component', '{}', 'component', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfset/component', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfset/component', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfset/component', 'busuidatatable', '{name:''操作按钮'',checkbox:false,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id='pmkpi_component';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_component', '组件数据权限分配', null, '组件数据权限分配', '/pmkpi/setting/component/dataallotservice.js', 'Ext.lt.drtemplate.AllotIndex', 'pmkpi', 'pmkpi.componentAllot.PerfDataAllotService');


delete from bus_t_pageconsole t where t.url='/pmkpi/perfset/component';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfset/component', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.componentAllot.PerfComponentRulePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', null, null, 0);

