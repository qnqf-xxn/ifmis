begin


update p#busfw_t_uiqueryform set type ='s' where type ='Ext.lt.ui.proj_queryform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config ='{key:''/pmkpi/adjust/report/program'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}' where url ='/pmkpi/adjust/report' and id ='queryform' and appid ='pmkpi';

update p#busfw_t_uiqueryform set name ='项目编码' where key ='/pmkpi/review/report/program' and columncode = 'PRO_CODE' and appid ='pmkpi';

update p#busfw_t_uiqueryform set name ='项目名称' where key in ('/pmkpi/midprogram/report/list','/pmkpi/midprogram/report/audit','/pmkpi/midprogram/query/list') and columncode = 'PRO_NAME' and appid ='pmkpi';

delete from bus_t_diccolumn where TABLECODE = 'PERF_V_PROMONITOR_APPRESULT' and COLUMNCODE = 'GUID';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2020', '87', 'B71F832B8B1903B0E0530100877FA9FF', 'GUID', 'PERF_V_PROMONITOR_APPRESULT', '主建', 'S', '40', null, 1, 1, null, sysdate);

update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',nextSibling:false,rowtolist:false,title:''绩效指标''}'
where url ='/pmkpi/program/report/goalandindex' and id ='datatable' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/adjust/report/proedit/hbtreeindex'',nextSibling:false,rowtolist:false,title:''项目绩效指标''}'
where url ='/pmkpi/adjust/report/proedit/goalandindex' and id ='datatable' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config ='{key:''/pmkpi/program/query/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}' where url ='/pmkpi/performance/query' and id ='queryform' and appid ='pmkpi';

update bus_t_pageconsole set config = '{header:[header],main:[queryform,recomtable]}' where url ='/pmkpi/program/prjindex/recomindex';

update bus_t_pageconsolecomconfig set id = 'header' where url ='/pmkpi/program/prjindex/recomindex' and componentid ='bustabpage';

update bus_t_pageconsolecomconfig set config = '{}' where url ='/pmkpi/audit/opinion' and id ='editform';

update p#busfw_t_uieditform set colspannum = 3 where key ='/pmkpi/audit/opinion' and columncode ='REMARK';

update p#busfw_t_uiqueryform set TABLECODE ='V_PERF_T_ADJUST' where key ='/pmkpi/adjust/report/dept';

update p#busfw_t_uiqueryform set columncode ='AGENCY_CODE' where key ='/pmkpi/adjust/report/dept' and columncode ='CODE';

update bus_t_pageconsole set config = '{header:[header],main:[queryform,recomtable]}' where url ='/pmkpi/deptperformance/deptperf/recomindex';

update bus_t_pageconsolecomconfig set id = 'header' where url ='/pmkpi/deptperformance/deptperf/recomindex' and componentid ='bustabpage';

update bus_t_pageconsolecomconfig set config = '{headsort:false,name:''自评补充信息'',edit:true,title:''自评补充信息'',nextSibling:false,table:"V_PERF_T_SELFPERFDESC",amtswitch:false}'
where url ='/pmkpi/perfself/apply/edit/selfdesc' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{headsort:false,name:''自评分析信息'',edit:true,title:''自评分析信息'',nextSibling:false,table:"V_PERF_T_SELFPERFDESC",amtswitch:false}'
where url ='/pmkpi/perfself/apply/editdept/selfanaly' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{title:''评估意见'',amtswitch:false}'
where url ='/pmkpi/program/assessment/list' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{title:''审核意见'',amtswitch:false}'
where url ='/pmkpi/audit/index/opinion' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{title:''审核意见'',amtswitch:false}'
where url ='/pmkpi/audit/index/traceopinion' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{title:''审核意见'',amtswitch:false}'
where url ='/pmkpi/audit/index/perfconreview' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{title:''审核意见'',amtswitch:false}'
where url ='/pmkpi/audit/index/evaluation' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{name:''四性审核'',checkbox:false,title:''四性审核'',edit:true,addrow:false,amtswitch:false,exporttable:false}'
where url ='/pmkpi/audit/index/nature' and id = 'editform' and appid ='pmkpi';


--全过程调整
update bus_t_pageconsole set config ='{left:lefttree,main:[baseditform,totaleditform,totaldatatable,yeareditform,yeardatatable,monitoreditform1,monitoreditform2,monitoreditform3,monitoreditform4,monitoreditform5,selfeditform,deptevaleditform,finaneditform],heights:[null,null,600,null,600]}' where url ='/pmkpi/allseo/project/allinfo';

delete from perf_t_datasource where elementcode='proallseo';

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('baseditform', '101', '基本信息', null, '00', 1, 1, 101, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('totalperf', '201', '总体绩效', null, '00', 1, 0, 201, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('totaleditform', '202', '中长期目标', null, 'totalperf', 2, 1, 202, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('totaldatatable', '203', '中长期指标', null, 'totalperf', 2, 1, 203, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('yearperf', '301', '年度绩效', null, '00', 1, 0, 301, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('yeareditform', '302', '年度目标', null, 'yearperf', 2, 1, 302, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('yeardatatable', '303', '年度指标', null, 'yearperf', 2, 1, 303, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('protrace', '401', '绩效监控结果', null, '00', 1, 0, 401, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('selfeditform', '501', '绩效自评结果', null, '00', 1, 1, 501, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('deptevaleditform', '601', '部门评价结果', null, '00', 1, 1, 601, 'proallseo', 1, '20221102', '20221102', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('finaneditform', '701', '财政评价结果', null, '00', 1, 1, 701, 'proallseo', 1, '20221102', '20221102', 2016, '87');

update bus_t_pageconsolecomconfig set config = '{title:''基础信息'',tablecode:''V_PERF_T_TYPICALCASE'',pagetype:''manceinfo'',iswf:''true'',amtswitch:false}'
where url ='/pmkpi/setting/typicalcase/info' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/deptperformance/report/deptgoal'',title:''绩效目标'',tablecode:''v_bgt_perf_goal_info'',amtswitch:false}'
where url ='/pmkpi/deptperformance/report/edit' and id = 'deptgoaleditform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/evaluation/dept/result/edit'',iswf:''true'',tablecode:''v_perf_t_deptevaluation'',title:''评估结果'',amtswitch:false}'
where url ='/pmkpi/evaluation/dept/result/edit' and id = 'editform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/evaluation/deptreport/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation'',amtswitch:false}'
where url ='/pmkpi/evaluation/dept/result/edit' and id = 'infoeditform' and appid ='pmkpi';


update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/program/report/protabgoal'',headsort:false,name:''中长期目标'',edit:false,title:''中长期目标'',nextSibling:false,amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'totaleditform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/program/report/protabgoal'',headsort:false,name:''年度目标'',edit:false,title:''年度目标'',nextSibling:false,amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'yeareditform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',edit:false,amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id in ('monitoreditform1','monitoreditform2','monitoreditform3','monitoreditform4','monitoreditform5') and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/perfself/apply/edit/selfdesc'',headsort:false,edit:false,title:''绩效自评结果'',nextSibling:false,table:''V_PERF_T_SELFPERFDESC'',amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'selfeditform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/evaluation/dept/result/edit'',tablecode:''v_perf_t_deptevaluation'',title:''部门评价结果'',edit:false,amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'deptevaleditform' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''财政评价结果'',edit:false,amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'finaneditform' and appid ='pmkpi';


update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:false,nogroupbox:true,edit:false,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',rowtolist:false,title:''中长期绩效指标'',amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'totaldatatable' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:false,nogroupbox:true,edit:false,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',rowtolist:false,title:''年度绩效指标'',amtswitch:false}'
where url ='/pmkpi/allseo/project/allinfo' and id = 'yeardatatable' and appid ='pmkpi';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/yearprogram/query/list'',checkbox:false,radio:true,edit:false,title:''绩效全过程查询''}'
where url ='/pmkpi/allseo/project/index' and id = 'datatable' and appid ='pmkpi';

delete from bus_t_diccolumn where tablecode ='PERF_V_PROMONITOR_APPRESULT' and columncode ='PROGUID';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROGUID', '1', '2016', '87', sys_guid(), 'PROGUID', 'PERF_V_PROMONITOR_APPRESULT', '项目guid', 'S', '40', null, 1, 1, null, sysdate);


update p#busfw_t_uiqueryform set isvisiable = 0 where columncode ='COMPANY' and appid ='pmkpi';

update p#busfw_t_uicolumn set type = 'amt' where key 
in('/pmkpi/yearprogram/query/list','/pmkpi/program/report/list','/pmkpi/perfself/taskmanage','/pmkpi/seeting/evaluation/query','/pmkpi/evaluation/financial/program','/pmkpi/evaluation/financial/query','/pmkpi/program/trace/manage/prolist','/pmkpi/program/trace/manage/prolistimp','/pmkpi/perfself/apply/index') 
and columncode in('PRO_TOTAL_AMT','BGTAMT');

update p#busfw_t_uiqueryform set type = 'amt' where key 
in('/pmkpi/perfself/taskmanage','/pmkpi/seeting/evaluation/query','/pmkpi/evaluation/financial/program','/pmkpi/evaluation/financial/query','/pmkpi/program/trace/manage/prolist','/pmkpi/program/trace/manage/prolistimp','/pmkpi/perfself/apply/index') 
and columncode in('PRO_TOTAL_AMT','BGTAMT') and appid ='pmkpi';

update p#busfw_t_uifunction set action ='Ext.lt.pmkpi.expdata' where key ='/pmkpi/performance/query' and code ='export' and action ='performance.export';

update bus_t_diccolumn set csid ='PERFYEAR' where tablecode ='PERF_T_WORKEVALUATETASK' and columncode ='TASKYEAR' and csid is null;

update p#busfw_t_uiqueryform set columncode =replace(columncode,'t.','') where key ='/pmkpi/program/trace/manage/prolist' and columncode like 't.%';

update p#busfw_t_uiqueryform set columncode =replace(columncode,'t.','') where key ='/pmkpi/program/trace/manage/prolistimp' and columncode like 't.%';

update p#busfw_t_uiqueryform set columncode =replace(columncode,'t.','') where key ='/pmkpi/workevaluate/report/list' and columncode like 't.%';

update p#busfw_t_uiqueryform set columncode =replace(columncode,'t.','') where key ='/pmkpi/program/trace/manage/deptlist' and columncode like 't.%';

update p#busfw_t_uiqueryform set columncode =replace(columncode,'t.','') where key ='/pmkpi/program/trace/manage/deptlistimp' and columncode like 't.%';

update p#busfw_t_uiqueryform set columncode =replace(columncode,'T.','') where key ='/pmkpi/program/trace/manage/deptlist' and columncode like 'T.%';

update p#busfw_t_uiqueryform set columncode =replace(columncode,'T.','') where key ='/pmkpi/program/trace/manage/deptlistimp' and columncode like 'T.%';

update bus_t_pageconsole set config ='{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}' where url ='/pmkpi/setting/zjindexenum';

update bus_t_pageconsolecomconfig set config = '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',amtswitch:false}'
where url in('/pmkpi/program/trace/report/edit','/pmkpi/program/trace/report/ordinaryedit') and id ='analysisformaleditform';

update bus_t_pageconsolecomconfig set config = '{title:''审核意见'',tablecode:''V_PERF_T_TRACETHIRDAUDIT'',amtswitch:false}'
where url ='/pmkpi/protrace/thirdaudit/opinion' and id ='editform';

update bus_t_pagecomponent set jslib ='/buscommon/fileimport/js/import.js,'||jslib 
where id in('pmkpi_case','pmkpi_proagency','pmkpi_adjtraindex','pmkpi_deptproconfirm','pmkpi_finproconfirm','pmkpi_hbdeptindex','pmkpi_perfselfaudit','pmkpi_goalandindex','pmkpi_protraceappresult')
and jslib is not null and instr(jslib,'/buscommon/fileimport/js/import.js')=0;

update p#busfw_t_uicolumn set type = 'amt',name = replace(name,'（元）','') where key 
in('/pmkpi/evaluation/finconfirm/prorelation/procheck','/pmkpi/evaluation/finconfirm/prorelation') 
and columncode ='PRO_TOTAL_AMT';

update p#busfw_t_uicolumn set type = 'amt' where key 
in('/pmkpi/selfreview/manage') 
and columncode in('PRO_TOTAL_AMT','BUDGETAMOUNT');

update p#busfw_t_uicolumn set type = 'i',format = '{unit:1,dotname:2,qfw:true}' where key ='/pmkpi/arrangement/index' and columncode ='WEIGHT';