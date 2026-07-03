begin
  
delete from bus_t_pageconsole where url ='/pmkpi/yeardept/query/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/yeardept/query/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform,totaldatatable],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/yeardept/query/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yeardept/query/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftarget'',addrow:true,name:''年度绩效目标'',title:''年度绩效目标'',}', 'totaldatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yeardept/query/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yeardept/query/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yeardept/query/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yeardept/query/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',tablecode:''perf_t_deptperfdeclare'',title:''基础信息'',iswf:''true''}', 'editform', 'pmkpi', null);



delete from p#busfw_t_uitabpage where key ='/pmkpi/yeardept/query/edit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/yeardept/query/edit', '年度绩效目标', 'tabgoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{busguid:''EBC360C187D673DCE0533315A8C0CDA4''}', null, '0', 'totaldatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/yeardept/query/edit', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{busguid:''BAD24F5F1B89184E656236029E483E3B'',action:''deptindex.save'',url:''/pmkpi/deptperformance/report/perfindex.page''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/yeardept/query/edit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''E00000C187D673DCE0533315A8C0CDA4''}', null, '0', 'editform', null, null, null, null, null, null);

