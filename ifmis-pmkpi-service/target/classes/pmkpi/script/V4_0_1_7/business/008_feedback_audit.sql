--整改反馈审核
begin
delete from bus_t_pageconsole where url = '/pmkpi/rectification/feedback/audit/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedback/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackAuditIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/rectification/feedback/audit/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'pmkpi_feedbackAudit', '{}', 'feedbackAudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busuidatatable', '{name:''整改情况审核'',checkbox:true,title:''整改情况审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/rectification/feedback/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_feedbackAudit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedbackAudit', '整改情况审核', null, '整改情况审核', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/feedbackauditIndex.js', 'Ext.lt.pmkpi.feedback.audit.index', 'pmkpi', 'pmkpi.rectification.FeedbackAuditIndexService');

--列表
delete from p#busfw_t_uitable where key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('71E40A87BD91392E172848F3944CC03B', '/pmkpi/rectification/feedback/audit/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);


--列表字段
delete from p#busfw_t_uicolumn where key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E543D68CD1AB715EBBDAA614B324104B', '/pmkpi/rectification/feedback/audit/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0645A2AD66C5EEC0BCF9FA5B2A6618E3', '/pmkpi/rectification/feedback/audit/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F9197D58C35CA88ED51ED47DC7F04D5D', '/pmkpi/rectification/feedback/audit/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8C91B3D03D0FEF8F15D24F1E743728B', '/pmkpi/rectification/feedback/audit/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3004FAFEAC8A7540C909FB34EBB11017', '/pmkpi/rectification/feedback/audit/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FD7CBB752F2D2924FD94A9F779D809A5', '/pmkpi/rectification/feedback/audit/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('111F702981887DEF3994631B81AD8542', '/pmkpi/rectification/feedback/audit/index', 'RECTYPE', '整改类型', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

--查询区
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B279545AD93DAC49EF495E7AFB0A6938', '/pmkpi/rectification/feedback/audit/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);


--页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A29C4F477B69E77F09501150DC5D3618', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '待办', 'waitaudit', 1, 1, 'choosed', 'feedbackAudit.clickTabpage', null, '待办', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('916576D530E9FC995D911162E28F4C2B', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '已办', 'alreadyaudit', 1, 2, 'nomal', 'feedbackAudit.clickTabpage', null, '已办', null, '审核,批量审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('06AB75D352DAFA8B47CBFA7F26DDD757', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'feedbackAudit.clickTabpage', null, '曾经办', null, '审核,批量审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);


--按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('64AFDD7C9DFD82DA5F418F0B68013751', '/pmkpi/rectification/feedback/audit/index', '查询', 0, 1, 'addaction', 'feedbackAudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3B63783C84CA198D92FD6EBD458496FB', '/pmkpi/rectification/feedback/audit/index', '审核', 1, 5, 'addaction', 'feedbackAudit.send', null, '审核', 'pmkpi', 'send', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0E47A168221C06E8E8C25C2A3A80EB6C', '/pmkpi/rectification/feedback/audit/index', '退回', 0, 6, 'addaction', 'feedbackAudit.back', null, '退回', 'pmkpi', 'back', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4E3DC0A835A5B0683955F67349075DC2', '/pmkpi/rectification/feedback/audit/index', '批量审核', 0, 7, 'addaction', 'feedbackAudit.sendlist', null, '批量审核', 'pmkpi', 'sendlist', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2E041D630C43BDE245F03751798259C3', '/pmkpi/rectification/feedback/audit/index', '取消审核', 1, 8, 'addaction', 'feedbackAudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AEDD3BDCB952726578D7D2838F16BA87', '/pmkpi/rectification/feedback/audit/index', '审核情况', 1, 9, 'addaction', 'feedbackAudit.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54314B2E452249C08234D60BB31729FE', '/pmkpi/rectification/feedback/audit/index', '审核信息', 1, 10, 'searchicon', 'feedbackAudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE51', '/pmkpi/rectification/feedback/audit/index', '查看项目', 1, 4, 'addaction', 'feedbackAudit.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0ACDB', '/pmkpi/rectification/feedback/audit/index', '查看明细', 1, 2, 'addaction', 'feedbackAudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');



