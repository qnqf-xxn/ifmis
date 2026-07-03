begin

--01 问题下达页面
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/issue';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/issue', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'issue', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/issue';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'perf_problemtasklist', '{}', 'problemtasklist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'busuidatatable', '{checkbox:true,edit:false,addrow:false,uikey:''/pmkpi/problemtask/editissue''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issue', 'buseditform', '{}', 'editform', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='perf_problemtasklist';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_problemtasklist', '评价问题整改销号', null, '评价问题整改销号', '/pmkpi/problemtask/problemtasklist.js', 'Ext.lt.pmkpi.problemtasklist', 'pmkpi', 'pmkpi.probleamtask.ProblemTaskService');


--02 整改反馈页面
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/feedback';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/feedback', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'feedback', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/feedback';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'perf_problemtasklist', '{}', 'problemtasklist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'busqueryform', '{key:''/pmkpi/problemtask/issue'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'busuidatatable', '{checkbox:true,edit:false,addrow:false,uikey:''/pmkpi/problemtask/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/feedback', 'buseditform', '{key:''/pmkpi/problemtask/issue''}', 'editform', 'pmkpi', null);


--03 整改审核页面
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/audit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'audit', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/audit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'perf_problemtasklist', '{}', 'problemtasklist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'busqueryform', '{key:''/pmkpi/problemtask/issue'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'busuidatatable', '{key:''/pmkpi/problemtask/feedback'',checkbox:true,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/audit', 'buseditform', '{key:''/pmkpi/problemtask/issue''}', 'editform', 'pmkpi', null);


--04 延期申请审核页面
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/delayaudit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/delayaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'delayaudit', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/delayaudit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'perf_problemtasklist', '{}', 'problemtasklist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'busqueryform', '{key:''/pmkpi/problemtask/issue'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'busuidatatable', '{checkbox:true,edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/delayaudit', 'buseditform', '{key:''/pmkpi/problemtask/issue''}', 'editform', 'pmkpi', null);


--05 整改反馈信息页面
--下达编辑
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/editissue';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/editissue', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'query', '{main:[tabpage,infoeditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/editissue';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/editissue', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/editissue', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/editissue', 'bustoolbutton', '{key:''/pmkpi/problemtask/edit''}', 'toolbutton', 'pmkpi', null);

--反馈编辑
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/edit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'query', '{main:[tabpage,infoeditform,feedbackeditform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/edit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--问题页
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/issueinfo';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/issueinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'query', '{main:[infoeditform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/issueinfo';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issueinfo', 'perf_problemtaskinfo', '{}', 'problemtaskinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/issueinfo', 'buseditform', '{key:''/pmkpi/problemtask/edit'',tablecode:''V_PERF_T_PROBLEMTASK'',iswf:''true''}', 'infoeditform', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='perf_problemtaskinfo';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_problemtaskinfo', '评价问题整改信息', null, '评价问题整改信息', '/pmkpi/problemtask/problemtaskinfo.js', 'Ext.lt.pmkpi.problemtaskinfo', 'pmkpi', 'pmkpi.probleamtask.ProblemTaskService');

--反馈页
delete from bus_t_pageconsole where url ='/pmkpi/problemtask/editfeedback';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/problemtask/editfeedback', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.probleamtask.ProblemTaskPage', 'query', '{main:[feedbackeditform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/problemtask/editfeedback';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/editfeedback', 'perf_problemtaskinfo', '{}', 'problemtaskinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/problemtask/editfeedback', 'buseditform', '{key:''/pmkpi/problemtask/edit/feedback'',tablecode:''V_PERF_T_PROBLEMTASK'',iswf:''true''}', 'feedbackeditform', 'pmkpi', null);