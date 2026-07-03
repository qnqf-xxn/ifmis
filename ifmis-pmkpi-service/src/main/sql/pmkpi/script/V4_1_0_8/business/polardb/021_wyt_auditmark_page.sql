begin
  --预算审核调用绩效页面，注册页面
delete from bus_t_pageconsole where url = '/pmkpi/program/auditmark';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/auditmark', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/auditmark';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/auditmark', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/auditmark', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/auditmark', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/auditmark', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


--按钮注册
delete from p#busfw_t_uifunction where key ='/pmkpi/program/auditmark';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/program/auditmark', '标记已审核', 1, 1, 'Nofinishicon', 'tabfreamedit.checkauditmark', null, '标记已审核', 'pmkpi', null, null, null,  null, null, '2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/program/auditmark', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.auditclose', null, '关闭', 'pmkpi', null, null, null,  null, null, '2016','87');

--页签注册
delete from p#busfw_t_uitabpage where key ='/pmkpi/program/auditmark';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/program/auditmark', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '项目基本信息', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A'',viewtype:''query''}', null, '0', 'editform', null, null, null, null, null,  null, null, null, '2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/program/auditmark', '年度绩效目标', 'yeargoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/program/report/protabgoal.page?showtab=1&isprogramiframe=1&isedittotal=1'',action:''tlprotabgoal.save'',busguid:''E9A5FB00AA4066C5E0533315A8C0D097''}', null, '0', 'goaliframe', null, null, null, null, null,  null, null, null, '2016','87');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/program/auditmark', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/program/report/treeindex.page?showtab=1&tempcode=202207141628&isprogramiframe=1&isedittotal=1'',action:''prjtreeindex.save'',busguid:''E9A5FB00AA4166C5E0533315A8C0D097''}', null, '0', 'indextableiframe', null, null, null, null, null,  null, null, null, '2016','87');


