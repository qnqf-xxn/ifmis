begin

delete from bus_t_pagecomponent t where t.id in('pmkpi_financialedit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_financialedit', '财政确认编辑', null, '财政确认编辑', '/pmkpi/evaluation/financial/proconfirm/confirmnew.js', 'Ext.lt.pmkpi.confirmnew', 'pmkpi', 'pmkpi.evaluation.financial.confirmnew.ConfirmNewService');


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/confirm/editor');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/confirm/editor', 'pmkpi_financialedit', '{}', 'financialedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/confirm/editor', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);


delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/confirm/editor');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/confirm/editor', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.confirmnew.ConfirmNewPage', 'editInfo', '{main:[infoeditform,editform]}', null, null, 0);


delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/finconfirm/proedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/finconfirm/proedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/finconfirm/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/finconfirm/proedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3A0D06B92EBCAA7E053B11FA8C03BDD', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '评分表', 'score', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53D3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/evaluation/financial/confirm/editor.page'',busguid:''BD2A3B90E5403AC1E053B11FA8C06F54'',action:''financialedit.save''}', null, '0', 'infoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53E3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '附件管理', 'file', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''finevapro'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53E3AC1E053B11FAPPP6F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '项目关联', 'relation', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '项目关联', null, null, '{url:''/pmkpi/evaluation/finconfirm/prorelation.page'',busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'relationiframe', null, null, null, null, null, null);
