begin

--财政评价查看项目库信息按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/proconfirm' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/proconfirm', '查看项目库信息', 0, 18, 'searchicon', 'finproconfirm.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/deptassessment/list' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/deptassessment/list', '查看项目库信息', 0, 18, 'searchicon', 'findeptassessment.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/audit' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/audit', '查看项目库信息', 0, 18, 'searchicon', 'finevalaudit.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/resultupload' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/resultupload', '查看项目库信息', 0, 18, 'searchicon', 'finevaluationresult.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/resultaudit' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/resultaudit', '查看项目库信息', 0, 18, 'searchicon', 'finevaluationresult.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/feedback' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/feedback', '查看项目库信息', 0, 18, 'searchicon', 'finevaluationresult.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/evaluation/financial/query' and code ='showProjView';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/query', '查看项目库信息', 0, 18, 'searchicon', 'finevalquery.showProjView', null, '查看项目库信息', 'pmkpi', 'showProjView', null, '{}', '87', '2016');


--财政评价部门整体页签隐藏查看项目库信息按钮
update perf_t_treetab t set t.hidebtns='查看项目库信息' 
where key in('/pmkpi/evaluation/financial/proconfirm','/pmkpi/evaluation/financial/deptassessment/list','/pmkpi/evaluation/financial/audit','/pmkpi/evaluation/financial/resultupload','/pmkpi/evaluation/financial/resultaudit','/pmkpi/evaluation/financial/feedback','/pmkpi/evaluation/financial/query')
 and t.code='dept' and hidebtns is null;
 
update perf_t_treetab t set t.hidebtns= hidebtns||',查看项目库信息' 
where key in('/pmkpi/evaluation/financial/proconfirm','/pmkpi/evaluation/financial/deptassessment/list','/pmkpi/evaluation/financial/audit','/pmkpi/evaluation/financial/resultupload','/pmkpi/evaluation/financial/resultaudit','/pmkpi/evaluation/financial/feedback','/pmkpi/evaluation/financial/query')
 and t.code='dept' and hidebtns is not null and instr(hidebtns,'查看项目库信息')=0; 