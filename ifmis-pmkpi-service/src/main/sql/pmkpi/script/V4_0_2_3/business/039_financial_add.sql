begin
--组件注册
delete from bus_t_pageconsole where url in('/pmkpi/rectification/financialAdd','/pmkpi/rectification/financial/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/financialAdd', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'rectifyAdd', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/financial/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackEdit', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url in('/pmkpi/rectification/financialAdd','/pmkpi/rectification/financial/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financialAdd', 'pmkpi_addprogram', '{}', 'addprogram', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financialAdd', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financialAdd', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financialAdd', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financial/edit', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financial/edit', 'pmkpi_addprogram', '{}', 'addprogram', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financial/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/financial/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--按钮
delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/financialAdd','/pmkpi/rectification/financial/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E75969C2A8EE0533315A8C01269', '/pmkpi/rectification/financialAdd', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E75969D2A8EE0533315A8C01269', '/pmkpi/rectification/financialAdd', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E7596A52A8EE0533315A8C01269', '/pmkpi/rectification/financial/edit', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E7596A62A8EE0533315A8C01269', '/pmkpi/rectification/financial/edit', '关闭', 1, 3, null, 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E7596A72A8EE0533315A8C01269', '/pmkpi/rectification/financial/edit', '保存并送审', 1, 2, null, 'addprogram.saveaudit', null, '保存并送审', 'pmkpi', 'audit', null, '{}');


--页签
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/financialAdd','/pmkpi/rectification/financial/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596992A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financialAdd', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E75969A2A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financialAdd', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/evaluation/financial/confirm/editor.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E75969B2A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financialAdd', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596A02A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financial/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/evaluation/financial/confirm/editor.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596A12A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financial/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, '保存,保存并送审', '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596A22A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financial/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'addprogram.clickTabpage', null, '整改反馈附件', null, null, '{filebustype:''feedback'',url:''/pmkpi/rectification/feedbackfile.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596A32A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financial/edit', '反馈信息详情', 'feedbackInfo', 1, 4, 'nomal', 'addprogram.clickTabpage', null, '反馈信息详情', null, '保存并送审', '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596A42A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financial/edit', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);



