--整改通知审核
begin
delete from bus_t_pageconsole where url ='/pmkpi/rectification/audit/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'auditIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/audit/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'pmkpi_rectificationaudit', '{}', 'rectificationaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busuidatatable', '{name:''整改通知审核'',checkbox:true,title:''整改通知审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/rectification/add''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_rectificationaudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationaudit', '整改通知审核', null, '整改通知审核', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationaudit.js', 'Ext.lt.pmkpi.rectification.audit.index', 'pmkpi', 'pmkpi.rectification.RectificationAuditService');


--列表字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/audit/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8A16B0A09DF13715DF86E37F824A7E79', '/pmkpi/rectification/audit/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E10423C94B42A2792AE6B4C3AF344000', '/pmkpi/rectification/audit/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5B36CEE8EA59C627DA73142459EDD6D0', '/pmkpi/rectification/audit/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('02C9CEB209A56DBB6F23020F00BAB8D0', '/pmkpi/rectification/audit/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CB7DA35CB33E61E1E282E185101ABA17', '/pmkpi/rectification/audit/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('062A801A0F5FBBA38C758F1C35463FF1', '/pmkpi/rectification/audit/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('221F702981887DEF3994631B81AD8542', '/pmkpi/rectification/audit/index', 'RECTYPE', '整改类型', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);


--列表
delete from p#busfw_t_uitable where key ='/pmkpi/rectification/audit/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('30CA317C24BAF4E04E412C2CEC47E6E2', '/pmkpi/rectification/audit/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);


--查询区
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/audit/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('3503799C28CF696469356D969CD15557', '/pmkpi/rectification/audit/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);


--页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/rectification/audit/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BAF217043BF56952789CB44851073CE6', 'pmkpi', '/pmkpi/rectification/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'rectificationaudit.clickTabpage', null, '曾经办', null, '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1A0D3885BCE074CFD57E0DD729A1B3FC', 'pmkpi', '/pmkpi/rectification/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'rectificationaudit.clickTabpage', null, '已审核', null, '下发', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E0E2E3D020AD1A6262A16EAF27480697', 'pmkpi', '/pmkpi/rectification/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'rectificationaudit.clickTabpage', null, '待审核', null, '退回', '{}', null, '0', null, null, null, null, null, null, null);


--按钮

delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/audit/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('59CE85375EBA016896C69A79221E4170', '/pmkpi/rectification/audit/index', '查询', 0, 1, 'addaction', 'rectificationaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('95E751B0D548BFAF4D020E0708275B4A', '/pmkpi/rectification/audit/index', '下发', 1, 2, 'addaction', 'rectificationaudit.send', null, '下发', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('40349437008AE6B5375F270FA5C63919', '/pmkpi/rectification/audit/index', '退回', 1, 3, 'addaction', 'rectificationaudit.back', null, '退回', 'pmkpi', '退回', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DE24FB043565247602D4F8496CC3A094', '/pmkpi/rectification/audit/index', '审核情况', 1, 4, 'addaction', 'rectificationaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('788D8ED39F924243A88B2F6C81E8BA22', '/pmkpi/rectification/audit/index', '导出列表', 1, 5, 'searchicon', 'rectificationaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE51', '/pmkpi/rectification/audit/index', '查看项目', 1, 6, 'addaction', 'rectificationaudit.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0ACDB', '/pmkpi/rectification/audit/index', '查看明细', 1, 7, 'searchicon', 'rectificationaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');



