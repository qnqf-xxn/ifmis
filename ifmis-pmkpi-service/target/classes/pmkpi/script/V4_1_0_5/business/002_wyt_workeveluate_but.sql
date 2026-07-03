begin
  --绩效管理工作考核页面添加 查看任务 按钮
delete from p#busfw_t_uifunction t where key ='/pmkpi/workevaluate/report/list'and name ='查看任务';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/report/list', '查看任务', 1, 8, 'searchicon', 'workevalreport.queryTask', null, '查看任务', 'pmkpi', 'queryTask', null, '{}',  null, null);

delete from p#busfw_t_uifunction t where key ='/pmkpi/workevaluate/audit/list'and name ='查看任务';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/audit/list', '查看任务', 1, 7, 'searchicon', 'workevalaudit.queryTask', null, '查看任务', 'pmkpi', 'queryTask', null, '{}',  null, null);

delete from p#busfw_t_uifunction t where key ='/pmkpi/workevaluate/query/list'and name ='查看任务';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/query/list', '查看任务', 1, 8, 'searchicon', 'workevalquery.queryTask', null, '查看任务', 'pmkpi', 'queryTask', null, '{}',  null, null);

