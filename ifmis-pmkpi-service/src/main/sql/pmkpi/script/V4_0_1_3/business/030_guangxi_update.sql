BEGIN
DELETE Bus_t_Pageconsolecomconfig where  URL = '/pmkpi/perfselftaskmanage/index';
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'pmkpi_perfselftaskmanage', '{}', 'perfselfmanage', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'header', '{}', 'header', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/perfselftaskmanage/index', 'busuidatatable', '{name:''绩效自评下达'',checkbox:true,title:''绩效自评下达'',edit:false,addrow:false,wheresql:wfstatus=''011'',pagetype:''report'',fromtables:[''v_perf_t_projperfindex'',''v_perf_t_projperfdesc''],deltables:[''v_perf_t_selfperfindex'',''v_perf_t_selfperfdesc''],delcols:[''mainguid''],viewtabcode:''v_perf_v_selfevaltask''}', 'datatable', 'pmkpi', NULL);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/index', 'dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfselftaskmanage/index', 'buseditform', '{}', 'editform', 'pmkpi', null);





 DELETE Bus_t_Pageconsolecomconfig where  URL = '/pmkpi/rectification/add/proj';
 INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/rectification/add/proj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', NULL);
 INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/rectification/add/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/rectification/add/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', NULL);
INSERT INTO Bus_t_Pageconsolecomconfig("URL", "COMPONENTID", "CONFIG", "ID", "APPID", "REGION") VALUES ('/pmkpi/rectification/add/proj', 'busuidatatable', '{name:''选择项目'',checkbox:true,title:''选择项目'',edit:false,addrow:false,wheresql:wfstatus=''011''}', 'datatable', 'pmkpi', NULL);
UPDATE p#BUSFW_T_UITABLE SET "TOTALTAG" = '0' WHERE "KEY" = '/pmkpi/perfself/apply/edit/bdgpay' AND "TABLECODE" = 'V_PERF_V_SELFBDGPAY';
UPDATE P#BUSFW_T_UICOLUMN SET "TOTALTAG" = '0' WHERE "KEY" = '/pmkpi/perfself/apply/edit/bdgpay';
UPDATE P#BUSFW_T_UITABLE SET "DEFQUERY" = ' t.wfstatus=011 and exists(select 1 from pm_perf_goal_info gl where gl.mainguid=t.guid and gl.yearflag=0) ' WHERE "KEY" = '/pmkpi/perfselftaskmanage/index' AND "TABLECODE" = 'V_PERF_V_SELFEVALPROGRAMS';
--视图重构V_PERF_V_SELFEVALPROGRAMS
execute immediate 'CREATE OR REPLACE VIEW V_PERF_V_SELFEVALPROGRAMS ("GUID", "PROJGUID", "PROJCODE", "NAME", "AGENCYGUID", "FININTORGGUID", "YEAR", "PROVINCE", "PROKIND", "BUSTYPE", "PROCATEGORY", "FUNC", "WFSTATUS", "REMAININGDAYS", "EVALEND", "EVALSTART", "EVALSTATUS", "UPDATETIME", "WFID", "BUDGETAMOUNT", "EXECAMOUNT", "EXECRATE") AS 
  SELECT nvl(tsk.GUID,sys_guid()) guid,
       pro.guid as projguid,
       pro.pro_code as projcode,
       pro.pro_name as name,
       pro.agencyguid,
       pro.mof_dep_code finintorgguid,
       pro.YEAR,
       pro.PROVINCE,
       pro.projectkind as prokind,
       1 as bustype,
       pro.pro_cat_code as procategory,
       pro.exp_func_code as func,
       pro.WFSTATUS as WFSTATUS,
       tsk.remainingdays,
       tsk.evalend,
       tsk.evalstart,
       tsk.evalstatus,
       tsk.UPDATETIME,
       tsk.WFID,
       0 as budgetamount,
       0 as execamount,
       a.amt5 as EXECRATE
  FROM V_PERF_PROJECT_INFO pro  --项目guid
  left join v_perf_t_selfevaltask tsk on pro.guid = tsk.PERFGOALGUID
  left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4, nvl(sum(amt5),0) amt5 from V_PERF_V_SELFBDGPAY group by proguid)a
  on a.proguid=tsk.projguid';