begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/trace/report/edit/goalandindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/goalandindex', 'pmkpi_tracegoalindex', '{}', 'tracegoalindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/goalandindex', 'busuidatatable', '{key:''/pmkpi/trace/report/edit/hbprogoal'',addrow:false,headsort:false,name:''绩效指标完成情况'',edit:false,checkbox:false,radio:true,title:''绩效指标完成情况'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/goalandindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/trace/report/edit/hbtreeindex'',nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/program/trace/report/edit/goalandindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetPage', 'hbindex', '{main:[maintable,datatable]}', null, null, null);


delete from bus_t_pagecomponent where id = 'pmkpi_tracegoalindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tracegoalindex', '绩效指标完成情况', null, '绩效指标完成情况', '/pmkpi/perfprotrace/indextarget/tracegoalindex.js', 'Ext.lt.pmkpi.protrace.goalindexservice', 'pmkpi', 'pmkpi.perfprotrace.indextarget.ProTraceGoalIndexService');



delete from bus_t_diccolumn where tablecode = 'PERF_T_PROINDEXTRACE' and columncode = 'GOALGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALGUID', '1', '2021', '87', '75354CEFE6DE6A1579D7BAFF1B6179BF', 'GOALGUID', 'PERF_T_PROINDEXTRACE', '关联目标id(湖北)', 'S', '40', null, 1, 1, null, sysdate);
