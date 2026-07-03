begin
delete from bus_t_pageconsolecomconfig t where t.url = ('/pmkpi/deptperformance/report/funcd/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd/edit', 'pmkpi_deptchoose', '{}', 'deptchoose', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd/edit', 'busuidatatable', '{name:''职能职责列表'',checkbox:true,title:''职能职责列表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd/edit', 'header', '{}', 'header', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id = 'pmkpi_deptchoose';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptchoose', '部门职能职责', null, '部门职能职责', '/pmkpi/deptperformance/deptfunction.js', 'Ext.lt.pmkpi.deptfunction', 'pmkpi', 'pmkpi.deptperformance.func.DeptFuncService');

delete from bus_t_pageconsole t where t.url = '/pmkpi/deptperformance/report/funcd/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/funcd/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.func.DeptFuncPage', 'index', '{main:[datatable],footer:[toolbutton]}', null, null, 0);


delete from P#BUSFW_T_UITABLE t where t.key = '/pmkpi/deptperformance/report/funcd/edit';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('90F1EE804D064710A2E6001FCD8F5263', '/pmkpi/deptperformance/report/funcd/edit', 'V_PM_FUNCRESP_INFO', 20, 0, 0, null, null, 'pmkpi', null, '87', '2016');

delete from P#BUSFW_T_UICOLUMN t where t.key = '/pmkpi/deptperformance/report/funcd/edit';
insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('7380C66BB36146BAA5A192306526D529', '/pmkpi/deptperformance/report/funcd/edit', 'BGT_DEPT_CODE', '预算部门代码', 2, 1, 1, 0, null, 0, 6, null, null, null, null, 300, 0, 's', null, null, '87', '2016');

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('8380C66BB36146BAA5A192306526D529', '/pmkpi/deptperformance/report/funcd/edit', 'FUN_RES_CODE', '职能职责代码', 3, 1, 1, 0, null, 0, 6, null, null, null, null, 300, 0, 's', null, null, '87', '2016');

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('4380C66BB36146BAA5A192306526D521', '/pmkpi/deptperformance/report/funcd/edit', 'FUN_RES_NAME', '职能职责名称', 4, 1, 1, 0, null, 0, 6, null, null, null, null, 300, 0, 's', null, null, '87', '2016');

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5380C66BB36146BAA5A192306526D522', '/pmkpi/deptperformance/report/funcd/edit', 'FUN_RES_DES', '职能职责描述', 5, 1, 1, 0, null, 0, 6, null, null, null, null, 300, 0, 's', null, null, '87', '2016');

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E41CC19ADBEC4C19B379ECE9C3926ADF', '/pmkpi/deptperformance/report/funcd/edit', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '87', '2016');

delete from P#BUSFW_T_UIFUNCTION t where t.key = '/pmkpi/deptperformance/report/funcd/edit';
insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('080CF070E8F2434B8457283097EFC422', '/pmkpi/deptperformance/report/funcd/edit', '确认', 1, 1, null, 'deptchoose.confirm', null, '确认', 'pmkpi', null, null, '{}', '87', '2016');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('080CF070E8F2414B8457283097EFC412', '/pmkpi/deptperformance/report/funcd/edit', '取消', 1, 2, null, 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, '{}', '87', '2016');

delete from P#BUSFW_T_UIFUNCTION t where t.key = '/pmkpi/deptperformance/report/funcd';
insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('080CF070E8F2434B84571283097EFC42', '/pmkpi/deptperformance/report/funcd', '选择职能', 1, 1, null, 'deptfunc.choose', null, '选择职能', 'pmkpi', 'choose', null, '{}', '87', '2016');

delete from bus_t_pageconsole t where t.url = '/pmkpi/deptperformance/report/funcd';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/funcd', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.func.DeptFuncPage', 'index', '{header:[toolbutton],main:[datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url = '/pmkpi/deptperformance/report/funcd';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd', 'pmkpi_deptfunc', '{}', 'deptfunc', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,name:''部门职能活动'',edit:true,checkbox:true,title:''部门职能活动'',initlevel:6,isuphide:false,nextSibling:false,findex:''EA1B684EACB848D8BE35C84E3B551E81'',uikey:''/pmkpi/deptperformance/report/funcd/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/funcd', 'header', '{}', 'header', 'pmkpi', null);
