begin

delete from bus_t_pageconsolecomconfig t where url in('/pmkpi/program/trace/manage/prolist','/pmkpi/program/trace/manage/prolistimp','/pmkpi/program/trace/manage/deptlistimp','/pmkpi/program/trace/manage/deptlist') and id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis],delcols:[mainguid,mainguid]}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolistimp', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis],delcols:[mainguid,mainguid]}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlistimp', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis],delcols:[mainguid,mainguid]}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false,deltables:[v_perf_t_probgtfund,v_perf_t_protraceanalysis],delcols:[mainguid,mainguid]}', 'datatable', 'pmkpi', null);
