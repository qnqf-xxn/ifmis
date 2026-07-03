begin

delete from bus_t_pageconsole where url = '/pmkpi/evaluatetemp/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_evaluatetemp';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaluatetemp', '评价类型', null, '评价类型', '/pmkpi/evaluateTemp/evaluatetemp.js', 'Ext.lt.pmkpi.evaluatetemp', 'pmkpi', 'pmkpi.evaluatetemp.EvaluateTempService');


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


delete from bus_t_pageconsole where url = '/pmkpi/evaluatetemp/add';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/add', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'add', '{main:[tabpage,toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/add';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/evaluatetemp/add/edition';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/add/edition', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'evaltypeinfo', '{main:[editform]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_evaltypeinfo';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaltypeinfo', '评价类型基本信息', null, '评价类型基本信息', '/busfw/common/bill/billmanage.js,/pmkpi/evaluateTemp/evaluatetempAdd.js', 'Ext.lt.pmkpi.evaluatetempAdd', 'pmkpi', 'pmkpi.evaluatetemp.EvaluateTempAddService');


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/add/edition';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/edition', 'pmkpi_evaltypeinfo', '{}', 'evaltypeinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/edition', 'buseditform', '{}', 'editform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluatetemp/add/randomquality';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluatetemp/add/randomquality', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluateTemp.page.EvaluateTempPage', 'evaltempinfo', '{main:[toolbutton,datatable]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_evaltempinfo';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evaltempinfo', '评价模板', null, '评价模板', '/pmkpi/evaluateTemp/evaluatetempInfo.js', 'Ext.lt.pmkpi.evaluatetempinfo', 'pmkpi', 'pmkpi.evaluatetemp.EvaluateTempInfoService');


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluatetemp/add/randomquality';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/randomquality', 'pmkpi_evaltempinfo', '{}', 'evaltempinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/randomquality', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''评价模板'',edit:true,title:''评价模板'', groupcols:[''guid'',''superid'',''qualityname'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,pagetype:''selfindex''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluatetemp/add/randomquality', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from p#busfw_t_uiqueryform where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values ('A88ACDC8E4FC8FB3B9E590A7D930213A', '/pmkpi/evaluatetemp/index', 'NAME', '模板名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMQUALITY_TYPE', '{}', null,'2016','87');


delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('19C1BA269EB16AC477E61C9E32CE5796', '/pmkpi/evaluatetemp/index', 'BUSTYPE', '绩效类型', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}','2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('DD78E3E25EC662477D4FFA2ECD3EEA2B', '/pmkpi/evaluatetemp/index', 'CODE', '模板编码', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('EE6DAD5C11E33113CD408403436AF00E', '/pmkpi/evaluatetemp/index', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('14A75D3EC8AA7536EBA43F74155B3D0F', '/pmkpi/evaluatetemp/index', 'NAME', '模板名称', 3, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', '2016','87');


delete from p#busfw_t_uitable where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR,PROVINCE)
values ('080A32D55A7B4B2321C5C7DA5E8E4188', '/pmkpi/evaluatetemp/index', 'V_PERF_T_RANDOMQUALITY_TYPE', 0, 0, 0, null, null, 'pmkpi', '{}','2016','87');



delete from p#busfw_t_uifunction where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('1B3C43A5253C59C4B397118316A35F66', '/pmkpi/evaluatetemp/index', '新增', 1, 1, 'searchicon', 'evaluatetemp.toAdd', null, '新增', 'pmkpi', 'infosave', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('1F513C506BB0328075B1910657546121', '/pmkpi/evaluatetemp/index', '修改', 1, 2, 'searchicon', 'evaluatetemp.toEdit', null, '修改', 'pmkpi', 'edit', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('AA7E682E3870D161FB1F59230CE7C324', '/pmkpi/evaluatetemp/index', '删除', 1, 3, 'searchicon', 'evaluatetemp.del', null, '删除', 'pmkpi', 'del', null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('CC7FAE34A4540EB309F88CEE61186DDF', '/pmkpi/evaluatetemp/index', '查询', 1, 3, 'searchicon', 'evaluatetemp.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');



delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluatetemp/add';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR,PROVINCE)
values ('ED8D9E5F60B637EABE253AC706DFD9AA', 'pmkpi', '/pmkpi/evaluatetemp/add', '评价模板', 'evaltemp', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评价模板', null, null, '{url:''/pmkpi/evaluatetemp/add/randomquality.page'',action:''evaltempinfo.tempsave''}', null, '0', 'evaltempiframe', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR,PROVINCE)
values ('CE01B278A8456C8C71FC3494E9348113', 'pmkpi', '/pmkpi/evaluatetemp/add', '评价类型基本信息', 'evaltype', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '评价类型', null, null, '{url:''/pmkpi/evaluatetemp/add/edition.page'',action:''evaltypeinfo.infosave''}', null, '0', 'evaltypeiframe', null, null, null, null, null, null,'2016','87');


delete from p#busfw_t_uieditform where key = '/pmkpi/evaluatetemp/add/edition';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR,PROVINCE)
values ('10F7719E3FBAABD11673F2F0BF8EBDAD', '/pmkpi/evaluatetemp/add/edition', 'V_PERF_T_RANDOMQUALITY_TYPE', 'tree', '菜单', 'MENUID', 1, null, 0, null, 4, 0, '0', null, 1, 0, '{isMulti:true,"format":"#name"}', '1', null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR,PROVINCE)
values ('6867A382C8A108B888440065365FCC93', '/pmkpi/evaluatetemp/add/edition', 'V_PERF_T_RANDOMQUALITY_TYPE', 's', '主键', 'GUID', 0, null, 0, null, 0, 0, '0', null, 0, 0, '{}', null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR,PROVINCE)
values ('5A82D3CDA2C14D7C35B1C301533F468C', '/pmkpi/evaluatetemp/add/edition', 'V_PERF_T_RANDOMQUALITY_TYPE', 'tree', '绩效类型', 'BUSTYPE', 1, null, 0, null, 3, 0, '0', null, 1, 0, '{"format":"#name"}', '1', null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR,PROVINCE)
values ('551243DD4FA3D7DB8D10681E0BC89ACA', '/pmkpi/evaluatetemp/add/edition', 'V_PERF_T_RANDOMQUALITY_TYPE', 's', '模板名称', 'NAME', 1, null, 1, null, 2, 0, '0', null, 1, 0, '{}', null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, YEAR,PROVINCE)
values ('CABFA34A2D069C2AA7D7EE9C77BDD78E', '/pmkpi/evaluatetemp/add/edition', 'V_PERF_T_RANDOMQUALITY_TYPE', 's', '模板编码', 'CODE', 0, null, 0, null, 1, 0, '0', null, 1, 0, '{}', null, null, null,'2016','87');


delete from p#busfw_t_uifunction where key = '/pmkpi/evaluatetemp/add';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('D485840A6FB33F1C2CB5EE703C333300', '/pmkpi/evaluatetemp/add', '取消', 1, 2, 'nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, '{}','2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('E770D1465603E175A6C66A3A811008FB', '/pmkpi/evaluatetemp/add', '保存', 1, 1, 'keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, '{}','2016','87');


delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluatetemp/add/randomquality';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('BA9F35443F12CDF10D0D29109D98517C', '/pmkpi/evaluatetemp/add/randomquality', 'FININTORGGUID', '业务处室', 9, 1, 1, 0, '0', 0, null, null, '#name', null, 0, null, 1, 'tree', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('3D62FE915CE82E900616F9A30E49794C', '/pmkpi/evaluatetemp/add/randomquality', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('E0B1DFE4A26621F07F7BC1B4A3DF6334', '/pmkpi/evaluatetemp/add/randomquality', 'ISCOM', '是否为综合处室', 10, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('AE06D0EB63683616E52A0881F58D4962', '/pmkpi/evaluatetemp/add/randomquality', 'ISLEAF', '是否叶子节点', 8, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('3D0C1622251A4C24AFC67391DB42492D', '/pmkpi/evaluatetemp/add/randomquality', 'LEVELNO', '级次', 7, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('8B2826B135C3AA385519EA8D5D711BA5', '/pmkpi/evaluatetemp/add/randomquality', 'OBLIGATE1', '操作', 0, 1, 0, 0, '0', 0, 1, null, null, null, 0, 100, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('8859892D460A6DC0E8210A63DAE8D3A2', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYNAME', '评价内容', 2, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('3D5AA3E0AD6CCB57FBA0B5849927DD6B', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYNAMEEXP', '评价内容解释', 3, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('F9402D79EEEC1D4D93594CDBA5439F76', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYSTAND', '评分标准', 4, 1, 1, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('6F4A98B4F35B65C7A14C1A6DAAE86667', '/pmkpi/evaluatetemp/add/randomquality', 'QUALITYWEIGHT', '分值', 5, 1, 1, null, null, null, null, null, null, null, null, 50, 0, 's', '{}', '2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, YEAR,PROVINCE)
values ('20522F29B079D66687F5310F631D2C1D', '/pmkpi/evaluatetemp/add/randomquality', 'SUPERID', 'SUPERID', 6, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', '{}', '2016','87');


delete from p#busfw_t_uifunction where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR,PROVINCE)
values ('ADF9D35513BE1B9CBE302516AF0DE230', '/pmkpi/evaluatetemp/add/randomquality', '新增', 1, 1, 'keepicon', 'evaltempinfo.toAdd', null, '新增', 'pmkpi', null, null, '{}','2016','87');

delete from p#busfw_t_uitable where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR,PROVINCE)
values ('17765CC7300D3A9C2724F37A336399AD', '/pmkpi/evaluatetemp/add/randomquality', 'V_PERF_T_RANDOMQUALITY', 0, 0, 0, null, null, 'pmkpi', '{}','2016','87');
