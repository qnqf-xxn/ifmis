begin

--重点监控范围布置（项目）页面

delete from bus_t_pageconsole t where t.url ='/pmkpi/program/trace/manage/prolistimp';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolistimp', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{left:lefttree,main:[tabpage,datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url ='/pmkpi/program/trace/manage/prolistimp';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis,v_perf_t_proindextrace],delcols:[mainguid,mainguid,mainguid]}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


--重点监控范围布置（部门整体）页面

delete from bus_t_pageconsole t where t.url ='/pmkpi/program/trace/manage/deptlistimp';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/deptlistimp', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[tabpage,datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url ='/pmkpi/program/trace/manage/deptlistimp';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlistimp', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlistimp', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlistimp', 'bustoolbutton', '{key:''/pmkpi/program/trace/manage/prolistimp''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlistimp', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis,v_perf_t_proindextrace],delcols:[mainguid,mainguid,mainguid]}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlistimp', 'bustabpage', '{key:''/pmkpi/program/trace/manage/prolistimp''}', 'tabpage', 'pmkpi', null);

--一般监控
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/manage/prolist') and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis,v_perf_t_proindextrace],delcols:[mainguid,mainguid,mainguid]}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/manage/deptlist') and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis,v_perf_t_proindextrace],delcols:[mainguid,mainguid,mainguid]}', 'datatable', 'pmkpi', null);

