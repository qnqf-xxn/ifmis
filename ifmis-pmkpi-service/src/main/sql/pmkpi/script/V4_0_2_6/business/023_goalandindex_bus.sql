begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/report/goalandindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/goalandindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/goalandindex', 'busuidatatable', '{key:''/pmkpi/program/report/hbprotabgoal'',name:''绩效目标'',radio:true,title:''绩效目标'',edit:true,addrow:true}', 'goaldatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/goalandindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/goalandindex', 'pmkpi_goalandindex', '{}', 'goalandindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/goalandindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);




delete from bus_t_pageconsole where url = '/pmkpi/program/report/goalandindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'hblist', '{main:[tabpage,toolbutton,goaldatatable,datatable]}', null, null, 0);



delete from bus_t_pagecomponent where id = 'pmkpi_goalandindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_goalandindex', '项目绩效目标指标(湖北)', null, '项目绩效目标指标(湖北)', '/pmkpi/perfprogram/goal/goalandindex.js', 'Ext.lt.pmkpi.goalandindexservice', 'pmkpi', 'pmkpi.goal.GoalAndIndexService');





delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in ('GOALGUID','INDEXSTANDARDS','ISSTANDPUSH','COMPUTETYPE','REFERENCEVAL','REFERENCESTANDARDS','SNINDEXVAL','QNINDEXVAL');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPUTETYPE', '1', '2016', '87', '0DEDFE2FDF3AC79175D12A7B6B1CFD4F', 'COMPUTETYPE', 'PM_PERF_INDICATOR', '计算公式', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALGUID', '1', '2021', '87', '3F7E8B19706D2E3EF9711761D2D7CB40', 'GOALGUID', 'PM_PERF_INDICATOR', '关联目标id(湖北)', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'INDEXSTANDARDS', null, '1', 'INDEXSTANDARDS', '1', '2016', '87', 'A2F2BC69B1F00D7A96FFEBF7CA42B124', 'INDEXSTANDARDS', 'PM_PERF_INDICATOR', '参考值确定依据', 'S', '2000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFISSTANDPUSH', null, '1', 'ISSTANDPUSH', '1', '2016', '87', '98C31C890136B47A61C2542CCFF8A347', 'ISSTANDPUSH', 'PM_PERF_INDICATOR', '绩效指标来源', 'S', '4000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'QNINDEXVAL', '1', '2016', '87', 'B096F8BA8C9DA465ACD0C1CCCAACA7A9', 'QNINDEXVAL', 'PM_PERF_INDICATOR', '前年指标值', 'S', '1000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REFERENCESTANDARDS', '1', '2016', '87', '3581608267B8EB52887A319ECD4E4B61', 'REFERENCESTANDARDS', 'PM_PERF_INDICATOR', '指标值确定依据', 'S', '2000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REFERENCEVAL', '1', '2016', '87', 'E75613F96F7302876C19B80C5320FC9A', 'REFERENCEVAL', 'PM_PERF_INDICATOR', '参考值', 'S', '1000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SNINDEXVAL', '1', '2016', '87', '6FA158D20FE1FCD90A141D883F1968D8', 'SNINDEXVAL', 'PM_PERF_INDICATOR', '上年指标值', 'S', '1000', null, 1, 1, null, sysdate);
