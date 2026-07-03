begin

--删除 自评填报多余的页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/perfself/apply/edit' and name like'资金使用情况%';
delete from p#busfw_t_uitabpage where key ='/pmkpi/perfself/apply/dept/edit' and name like'资金使用情况%';


--自评填报 新增页签（合肥市本级使用）
delete from p#busfw_t_uitabpage where key in ('/pmkpi/perfself/apply/edit', '/pmkpi/perfself/apply/dept/edit') and COMPONENTID = 'fundsiframe';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7D7345D59B9B4FC39A485871C4B05556', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '预算执行情况(合肥)', 'selfbdgpay', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/dept/edit/fund.page'',action:''selffund.save''}', null, '0', 'fundsiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1D53C1BDAE7C5511E053B11FA8C09800', 'pmkpi', '/pmkpi/perfself/apply/edit', '预算执行情况(合肥)', 'selfbdgpay', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/edit/fund.page'',action:''selffund.save''}', null, '0', 'fundsiframe', null, null, null, null, null, null);

--自评填报预算执行情况 合肥 单独加一个页签
delete from bus_t_pageconsole where url in('/pmkpi/perfself/apply/edit/fund','/pmkpi/perfself/apply/dept/edit/fund');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/fund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'payindex', '{main:[datatable]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/dept/edit/fund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'payindex', '{main:[datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url in('/pmkpi/perfself/apply/edit/fund','/pmkpi/perfself/apply/dept/edit/fund');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/fund', 'pmkpi_selffund', '{}', 'selffund', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/fund', 'busuidatatable', '{name:''资金明细'',checkbox:true,tiptiptiptiptiptitle:''资金明细'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/fund', 'pmkpi_selffund', '{}', 'selffund', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/fund', 'busuidatatable', '{name:''资金明细'',checkbox:true,tiptiptiptiptiptitle:''资金明细'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_selffund';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selffund', '自评预算执行情况取数(合肥)', null, '自评预算执行情况取数(合肥)', '/pmkpi/perfself/hfselfbdgpay.js', 'Ext.lt.pmkpi.hfselfbdgpay', 'pmkpi', 'pmkpi.perfself.tab.HFSelfBdgpayService');




delete p#busfw_t_uicolumn t where key in('/pmkpi/perfself/apply/edit/fund','/pmkpi/perfself/apply/dept/edit/fund');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1DE4504598800DAFE0530603A8C42DD1', '/pmkpi/perfself/apply/dept/edit/fund', 'NAME', '任务名称', 1, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2DE4504598810DAFE4530603A8C02DD2', '/pmkpi/perfself/apply/dept/edit/fund', 'AMT1', '年初预算数', 3, 1, 1, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3DE4504598820DAFE8530603A8C02DD3', '/pmkpi/perfself/apply/dept/edit/fund', 'AMT2', '年度预算调整', 4, 0, 1, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4DE4504598850DAFE0530603A8C62DD4', '/pmkpi/perfself/apply/dept/edit/fund', 'AMT3', '全年预算数', 5, 1, 1, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6DE4504598860DAFE0530603A8C82DD6', '/pmkpi/perfself/apply/dept/edit/fund', 'AMT4', '全年执行数', 7, 1, 1, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8DE4504598870DAFE0530603A8C02DD8', '/pmkpi/perfself/apply/dept/edit/fund', 'BGTGET', '预算执行率%', 9, 1, 0, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9DE4504598800DAFE0530603A8C42DD9', '/pmkpi/perfself/apply/dept/edit/fund', 'SCORES', '分值', 10, 1, 0, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5DE4504598850DAFE0530603A8C62DD5', '/pmkpi/perfself/apply/dept/edit/fund', 'AMT5', '其中：财政拨款', 6, 1, 1, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7DE4504598860DAFE0530603A8C82DD7', '/pmkpi/perfself/apply/dept/edit/fund', 'AMT6', '其中：财政拨款', 8, 1, 1, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0DE4504598800DAFE0530603A8C42DD0', '/pmkpi/perfself/apply/dept/edit/fund', 'SCORE', '自评得分', 11, 1, 0, 1, null, 0, null, '[''部门预算情况'']', null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('10E4504598800DAFE0530603A8C42D10', '/pmkpi/perfself/apply/dept/edit/fund', 'COMPLETION', '完成情况', 2, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);


insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('11E4504598810DAFE4530603A8C02DD2', '/pmkpi/perfself/apply/edit/fund', 'AMT1', '年初预算数', 3, 1, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('22E4504598820DAFE8530603A8C02DD3', '/pmkpi/perfself/apply/edit/fund', 'AMT2', '年度预算调整', 4, 0, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33E4504598850DAFE0530603A8C62DD4', '/pmkpi/perfself/apply/edit/fund', 'AMT3', '全年预算数', 5, 1, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('44E4504598860DAFE0530603A8C82DD6', '/pmkpi/perfself/apply/edit/fund', 'AMT4', '全年执行数', 7, 1, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('55E4504598870DAFE0530603A8C02DD8', '/pmkpi/perfself/apply/edit/fund', 'BGTGET', '预算执行率%', 9, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('66E4504598800DAFE0530603A8C42D21', '/pmkpi/perfself/apply/edit/fund', 'NAME', '资金来源', 1, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);


delete from p#busfw_t_uitable t where key in('/pmkpi/perfself/apply/edit/fund','/pmkpi/perfself/apply/dept/edit/fund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD547EED79AC0EABE053B11FA8C0BC22', '/pmkpi/perfself/apply/edit/fund', 'V_PERF_T_SELFPROFUND', 0, 1, 0, null, null, 'pmkpi', null);


insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD547EED79AC0EABE053B11FA8C0BC11', '/pmkpi/perfself/apply/dept/edit/fund', 'V_PERF_T_SELFPROFUND', 0, 1, 0, null, null, 'pmkpi', null);
