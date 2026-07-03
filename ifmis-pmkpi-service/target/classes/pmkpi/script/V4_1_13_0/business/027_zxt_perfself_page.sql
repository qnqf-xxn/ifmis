BEGIN

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/random' ;

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random', 'pmkpi_selfrandom', '{}', 'selfrandom', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random', 'busuidatatable', '{checkbox:true,edit:false,addrow:false,pagetype:''report'',deltables:[''v_perf_t_selfevaltask''],delcols:[''guid''],viewtabcode:''v_perf_v_selfevaltask'',infotablecode:''v_perf_project_info'',infosavetablecode:''v_perf_project_info'',busguid:''31A575D94D5C0FD937BEBD2D18C144A1_000''}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random', 'header', '{}', 'header', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random', 'buslefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);



delete from bus_t_pageconsole where url = '/pmkpi/perfself/random';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/random', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfRandomPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);



delete from bus_t_pagecomponent where id = 'pmkpi_selfrandom';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfrandom', '绩效自评抽评', null, '绩效自评抽评', '/pmkpi/perfself/perfselfrandom.js', 'Ext.lt.pmkpi.perfself.perfselfrandomservice', 'pmkpi', 'pmkpi.perfSelf.PerfSelfRandomService');




delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/random/procheck' ;

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random/procheck', 'buslefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random/procheck', 'pmkpi_randomcheck', '{}', 'randomcheck', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random/procheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random/procheck', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/random/procheck', 'busuidatatable', '{name:''自评项目'',checkbox:true,title:''自评项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null, null);



delete from bus_t_pageconsole where url = '/pmkpi/perfself/random/procheck';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/random/procheck', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfRandomPage', 'check', '{left:lefttree,main:[tabpage,queryform,datatable],footer:[toolbutton]}', null, null, 0);



delete from bus_t_pagecomponent where id = 'pmkpi_randomcheck';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcheck', '自评抽评人工调整', null, '自评抽评人工调整', '/pmkpi/perfself/perfselfrandomcheck.js', 'Ext.lt.pmkpi.perfself.perfselfrandomcheckservice', 'pmkpi', 'pmkpi.perfSelf.PerfSelfRandomCheckService');



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editnx' ;


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/editnx';


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/bdgpaynx' ;


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/bdgpaynx';


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/selfindexnx' ;


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/selfindexnx' ;


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/selfdescnx' ;


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/selfdescnx';


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editzyzf' ;


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/editzyzf';


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/fundmanag';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/apply/edit/fundmanag', 'pmkpi_fundmanag', '{}', 'fundmanag', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/perfself/apply/edit/fundmanag', 'busuidatatable', '{name:''资金管理情况'',checkbox:true,title:''资金情况'',edit:true ,addrow:false}', 'datatable', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/fundmanag';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/fundmanag', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'fundmanag', '{main:[datatable]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_fundmanag';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_fundmanag', '资金管理情况', null, '资金管理情况', '/pmkpi/perfself/selffundmanag.js', 'Ext.lt.pmkpi.selffundmanag', 'pmkpi', 'pmkpi.perfSelf.tab.SelfFundManagService');
