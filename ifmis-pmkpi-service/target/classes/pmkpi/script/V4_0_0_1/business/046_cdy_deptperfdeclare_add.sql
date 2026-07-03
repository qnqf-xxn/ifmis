begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/hnindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/hnindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.hnindex.DeptHNIndexPage', 'index', '{main:[datatable]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_depthnindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_depthnindex', '部门年度指标', null, '部门年度指标', '/pmkpi/deptperformance/depthnindex.js', 'Ext.lt.pmkpi.deptindex', 'pmkpi', 'pmkpi.deptperformance.hnindex.DeptHNIndexService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/hnindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/hnindex', 'pmkpi_depthnindex', '{}', 'depthnindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/hnindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:true,title:''年度绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);

delete from busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/target');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('FC5022FAF0E14E1A9B03F81D92B7973F', '/pmkpi/deptperformance/report/target', 'V_PERF_T_DEPTFUNCTION', 0, 1, 0, null, null, 'pmkpi', null);

delete from busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/target');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9A743B54574448818E91158DA5541B4E', '/pmkpi/deptperformance/report/target', 'GUID', 'guid', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8BD8BCE40B354483821885536699CAF6', '/pmkpi/deptperformance/report/target', 'NAME', '目标', 2, 1, 1, 0, null, 0, null, null, null, null, null, 300, 0, 's', null, null);

delete from busfw_t_uieditform t where key in('/pmkpi/deptperformance/report/edit');


insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E5BF000C2F284D768896F0C6DA7CBC3E', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '资金总额', 'BUDGETTOTAL', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A82A3DAFF88F4FFF83BEB8B837291139', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '一般公共预算', 'BUDGETAMT', 1, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD4D2133A30C4F21859A3884793AB39D', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '政府性基金拨款', 'GOVEFUNCAMT', 1, null, 1, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E20428A954C4459C84CF5B5023BCA14C', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '纳入专户管理的非税收入拨款', 'TAXRANAMT', 1, null, 1, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B50D43C5E0EE4A5DA67CAC0A5A13E115', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '其他资金', 'OTHERFUND', 1, null, 1, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('8AD344AC45CE43AC9B288B75B0BA2DB9', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '基本支出', 'BASICEXPEND', 1, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('89790368673E45FEAC5BE252DE9BD587', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '项目支出', 'PROJEXPAMT', 1, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('AF7B9FCB028148698EBC8E83F659ECB9', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'textarea', '部门职能职责概述', 'FUNCDESC', 1, null, 0, null, 17, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('e622e19ff98b47444d10c893b78975e8', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('79beace2f9ef6d03abacb81e0f87f5bd', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('57067c6345a3a3b972dd627a23774081', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('219ff73ff870eea8ecabed2f3952ad20', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系人', 'LINKMAN', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('110ca017fa06755393685baa83ba3655', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系电话', 'TELEPHONE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);


delete from busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/hnindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('28C2DB4BEEDB4854B1E7A21B0913EB98', '/pmkpi/deptperformance/report/hnindex', 'V_BGT_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', null);

delete from busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/hnindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AC642B4C187A4207B7C41CFC9383E095', '/pmkpi/deptperformance/report/hnindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 1, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('10DBD7909F034847A1AFC6DFC24325B8', '/pmkpi/deptperformance/report/hnindex', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4C2E70B9F45F4066B4C0E3578B61AF27', '/pmkpi/deptperformance/report/hnindex', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F2C485F9E32A4F4D867C46930CC5411D', '/pmkpi/deptperformance/report/hnindex', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9730FD1375F54D7A8371BB1555FB6755', '/pmkpi/deptperformance/report/hnindex', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('06D1CBF56AEB433E8BEEBCC0BDB90438', '/pmkpi/deptperformance/report/hnindex', 'METERUNIT', '计量单位', 11, 1, 1, 1, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAE9967E32974B71B9B7F321A03C8054', '/pmkpi/deptperformance/report/hnindex', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 280, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('84496BDE25744FA0AE5F735E28751F47', '/pmkpi/deptperformance/report/hnindex', 'OBLIGATE3', '操作', 2, 1, 0, 0, null, 0, null, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('547B6F10B07844CB96FBB0A5D706431D', '/pmkpi/deptperformance/report/hnindex', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2B80A85236504025B38FAA209BB0FD06', '/pmkpi/deptperformance/report/hnindex', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1E561BA880764982A000F0BDE919D21E', '/pmkpi/deptperformance/report/hnindex', 'WEIGHT', '权重', 16, 0, 1, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

