begin
  
delete from bus_t_pageconsole t where t.url  in('/pmkpi/auditdefine/error');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/auditdefine/error', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.auditdefine.AuditDefinePage', 'error', '{main:[datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_auditdefineerror');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_auditdefineerror', '审核定义信息展示', null, '审核定义信息展示', '/pmkpi/perfcommon/auditdefine/auditerror.js', 'Ext.lt.pmkpi.auditerror', 'pmkpi', 'pmkpi.auditdefine.AuditDefineService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/auditdefine/error');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/error', 'busuidatatable', '{name:''审核信息'',checkbox:false,title:''审核信息'',edit:false,addrow:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/auditdefine/error', 'pmkpi_auditdefineerror', '{}', 'auditdefine', 'pmkpi', null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/auditdefine/error');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/auditdefine/error', 'EOORO', 0, 0, null, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/auditdefine/error');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/auditdefine/error', 'CODE', '审核定义编码', 1, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/auditdefine/error', 'NAME', '审核定义名称', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/auditdefine/error', 'REMARK', '错误信息', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 300, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/auditdefine/error', 'EXPLAIN', '审核说明', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 250, 0, 's', null, null);
