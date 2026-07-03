begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/protztj','/pmkpi/adjust/protztjedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/protztjedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'tztjedit', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/protztj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'tztjadjust', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/adjust/protztjedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID)
values ('/pmkpi/adjust/protztjedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID)
values ('/pmkpi/adjust/protztjedit', 'bustabpage', '{}', 'tabpage', 'pmkpi');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID)
values ('/pmkpi/adjust/protztjedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/adjust/protztjedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/protztjedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null, '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/protztjedit', '取消', 0, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null, '87', '2016', null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/protztjedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/protztjedit', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''B9B1886CA7A400A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/info.page?istztj=1''}', null, '0', 'infoiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/protztjedit', '绩效目标调整', 'progoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标调整', null, null, '{busguid:''B9B1886CA7A600A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/goal.page'',action:''adjustgoal.save''}', null, '0', 'progoaliframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/protztjedit', '绩效指标调整', 'proindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, null, '{busguid:''B9B1886CA7A700A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/index.page'',action:''adjustindex.save''}', null, '0', 'proindexiframe', null, null, null, null, null, '87', '2016', null, null, null);

delete from perf_t_auditdefinemenu t where t.guid='2612D26A978E1693E0638516A8C07705';
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('2612D26A978E1693E0638516A8C07705', '1', '绩效调整指标（预算调整调剂）', null, 'B99067F619D5E2E2E053B11FA8C09FEF', 3, 1, 1, 1, '20241107093658', '20241107093658', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016);

delete from perf_t_pagemenu t where t.uikey='/pmkpi/adjust/protztjedit';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('9C719F35641B382DC37D2D91AF9ED87E', '3', '绩效目标调整填报（项目支出-预算调整调剂）', '/pmkpi/adjust/protztjedit', 'B99067F619D4E2E2E053B11FA8C09FEF', 4, 1, 3, 1, '20241111180430', '20241111180430', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');
