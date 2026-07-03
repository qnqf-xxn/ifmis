begin

DELETE from p#busfw_t_uifunction where key = '/pmkpi/evaluation/financial/query' AND CODE = 'queryresult';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/financial/query', '查看评价成果', 1, 6, 'searchicon', 'finevalquery.queryresult', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');

--项目查看成果
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/query/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{url:''/pmkpi/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2'',url:''/pmkpi/evaluation/financial/result/edit.page'',viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceisframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '评分表', 'info', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, '保存', '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/score.page'',viewtype:''query''}', null, '0', 'proscoreiframe', null, null, null, null, null, null);



delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/query/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/query/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/query/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/deptfill/score'',name:''评分表'',checkbox:true,title:''评分表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
