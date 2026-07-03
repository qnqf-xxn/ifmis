begin

delete from Bus_t_Pageconsole where url = '/pmkpi/evaluatetemp/add';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/add', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'add', '{main:[tabpage,toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/add';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


delete from Bus_t_Pageconsole where url = '/pmkpi/evaluatetemp/add/randomquality';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/add/randomquality', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'evaltempinfo', '{main:[toolbutton,datatable]}', null, null, 0);

delete from Bus_t_Pagecomponent where id = 'pmkpi_evaltempinfo';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaltempinfo', '评价模板', null, '评价模板', '/pmkpi/evaluateTemp/evaluatetempInfo.js', 'Ext.lt.pmkpi.evaluatetempinfo', 'pmkpi', 'pmkpi.evaluatetemp.EvaluateTempInfoService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/add/randomquality';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/randomquality', 'pmkpi_evaltempinfo', '{}', 'evaltempinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/randomquality', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''评价模板'',edit:true,title:''评价模板'', groupcols:[''guid'',''superid'',''qualityname'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,pagetype:''selfindex''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/randomquality', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from Bus_t_Pageconsole where url = '/pmkpi/evaluatetemp/add/edition';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/add/edition', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'evaltypeinfo', '{main:[editform]}', null, null, 0);

delete from Bus_t_Pagecomponent where id = 'pmkpi_evaltypeinfo';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaltypeinfo', '评价类型基本信息', null, '评价类型基本信息', '/pmkpi/evaluateTemp/evaluatetempAdd.js', 'Ext.lt.pmkpi.evaluatetempAdd', 'pmkpi', 'pmkpi.evaluatetemp.EvaluateTempAddService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/add/edition';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/edition', 'pmkpi_evaltypeinfo', '{}', 'evaltypeinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/edition', 'buseditform', '{}', 'editform', 'pmkpi', null);


delete from P#BUSFW_T_UIFUNCTION where key = '/pmkpi/evaluatetemp/add';
insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('E770D1465603E175A6C66A3A8110AAA', '/pmkpi/evaluatetemp/add', '取消', 1, 2, 'nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, '{}', '87', '2016');

insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('E770D1465603E175A6C66A3A811008FB', '/pmkpi/evaluatetemp/add', '保存', 1, 1, 'keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, '{}', '87', '2016');

delete from P#BUSFW_T_UITABPAGE WHERE KEY = '/pmkpi/evaluatetemp/add';
insert into P#BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('ED8D9E5F60B637EABE253AC706DFD9AA', 'pmkpi', '/pmkpi/evaluatetemp/add', '评价模板', 'evaltemp', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评价模板', null, null, '{url:''/pmkpi/evaluatetemp/add/randomquality.page'',action:''evaltempinfo.tempsave''}', null, '0', 'evaltempiframe', null, null, null, null, null, null, '87', '2016');

insert into P#BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('CE01B278A8456C8C71FC3494E9348113', 'pmkpi', '/pmkpi/evaluatetemp/add', '评价类型基本信息', 'evaltype', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '评价类型', null, null, '{url:''/pmkpi/evaluatetemp/add/edition.page'',action:''evaltypeinfo.infosave''}', null, '0', 'evaltypeiframe', null, null, null, null, null, null, '87', '2016');

--/pmkpi/evaluatetemp/add/randomquality
delete from P#BUSFW_T_uitable where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into P#BUSFW_T_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('17765CC7300D3A9C2724F37A336399AD', '/pmkpi/evaluatetemp/add/randomquality', 'PERF_T_RANDOMQUALITY', 0, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

delete from P#BUSFW_t_uicolumn where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BA9F35443F12CDF10D0D29109D98517C', '/pmkpi/evaluatetemp/add/randomquality', 'FININTORGGUID', '业务处室', 9, 1, 1, 0, '0', 0, null, null, '#name', null, 0, null, 1, 'tree', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('3D62FE915CE82E900616F9A30E49794C', '/pmkpi/evaluatetemp/add/randomquality', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E0B1DFE4A26621F07F7BC1B4A3DF6334', '/pmkpi/evaluatetemp/add/randomquality', 'ISCOM', '是否为综合处室', 10, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('AE06D0EB63683616E52A0881F58D4962', '/pmkpi/evaluatetemp/add/randomquality', 'ISLEAF', '是否叶子节点', 8, 1, 1, 0, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('3D0C1622251A4C24AFC67391DB42492D', '/pmkpi/evaluatetemp/add/randomquality', 'LEVELNO', '级次', 7, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('8B2826B135C3AA385519EA8D5D711BA5', '/pmkpi/evaluatetemp/add/randomquality', 'OBLIGATE1', '操作', 0, 1, 0, 0, '0', 0, 1, null, null, null, 0, 100, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('8859892D460A6DC0E8210A63DAE8D3A2', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYNAME', '评价内容', 2, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('3D5AA3E0AD6CCB57FBA0B5849927DD6B', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYNAMEEXP', '评价内容解释', 3, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('F9402D79EEEC1D4D93594CDBA5439F76', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYSTAND', '评分标准', 4, 1, 1, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('6F4A98B4F35B65C7A14C1A6DAAE86667', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYWEIGHT', '分值', 5, 1, 1, null, null, null, null, null, null, null, null, 50, 0, 's', '{}', null, '87', '2016');

insert into P#BUSFW_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('20522F29B079D66687F5310F631D2C1D', '/pmkpi/evaluatetemp/add/randomquality', 'SUPERID', 'SUPERID', 6, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

delete from P#BUSFW_T_UIFUNCTION where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into P#BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('ADF9D35513BE1B9CBE302516AF0DE230', '/pmkpi/evaluatetemp/add/randomquality', '新增', 1, 1, 'keepicon', 'evaltempinfo.toAdd', null, '新增', 'pmkpi', null, null, '{}', '87', '2016');

--/pmkpi/evaluatetemp/add/edition
delete from P#BUSFW_t_Uieditform where key = '/pmkpi/evaluatetemp/add/edition';
insert into P#BUSFW_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('551243DD4FA3D7DB8D10681E0BC89ACA', '/pmkpi/evaluatetemp/add/edition', 'PERF_T_RANDOMQUALITY_TYPE', 's', '模板名称', 'NAME', 1, null, 1, null, 2, 0, '0', 'pmkpi', 1, 0, '{}', null, null, null, '87', '2016');

insert into P#BUSFW_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('CABFA34A2D069C2AA7D7EE9C77BDD78E', '/pmkpi/evaluatetemp/add/edition', 'PERF_T_RANDOMQUALITY_TYPE', 's', '模板编码', 'CODE', 1, null, 0, null, 1, 0, '0', 'pmkpi', 1, 0, '{}', null, null, null, '87', '2016');

insert into P#BUSFW_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('544D91A3403AFD71E9BA81F16C137BCF', '/pmkpi/evaluatetemp/add/edition', 'PERF_T_RANDOMQUALITY_TYPE', 'tree', '单位', 'AGENCYGUID', 0, null, 0, null, 3, 0, '0', 'pmkpi', 1, 0, '{format:''#name''}', 1, null, null, '87', '2016');

insert into P#BUSFW_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('10F7719E3FBAABD11673F2F0BF8EBDAD', '/pmkpi/evaluatetemp/add/edition', 'PERF_T_RANDOMQUALITY_TYPE', 'tree', '菜单', 'MENUID', 1, null, 0, null, 4, 0, '0', 'pmkpi', 1, 0, '{isMulti:true,format:''#name''}', 1, null, null, '87', '2016');

insert into P#BUSFW_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('6867A382C8A108B888440065365FCC93', '/pmkpi/evaluatetemp/add/edition', 'PERF_T_RANDOMQUALITY_TYPE', 's', '主键', 'GUID', 0, null, 0, null, 0, 0, '0', 'pmkpi', 0, 0, '{}', null, null, null, '87', '2016');

insert into P#BUSFW_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('5A82D3CDA2C14D7C35B1C301533F468C', '/pmkpi/evaluatetemp/add/edition', 'PERF_T_RANDOMQUALITY_TYPE', 'tree', '绩效类型', 'BUSTYPE', 1, null, 0, null, 3, 0, '0', 'pmkpi', 1, 0, '{format:''#name''}', 1, null, null, '87', '2016');

