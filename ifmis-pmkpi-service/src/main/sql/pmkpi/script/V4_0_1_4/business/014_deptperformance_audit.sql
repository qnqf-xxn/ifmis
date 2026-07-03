begin
-- 部门审核添加修改按钮
delete from p#busfw_t_uifunction where key='/pmkpi/deptperformance/audit/index' and name ='修改' and title='修改';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6E8BA708BED14EC185CB4D00A295DC43', '/pmkpi/deptperformance/audit/index', '修改', 1, 2, 'searchicon', 'deptperformanceaudit.addOredit', null, '修改', 'pmkpi', 'save', null, '{}');

-- 修改页面 添加组件配置
delete from bus_t_pageconsolecomconfig where url='/pmkpi/deptperformance/audit/index' and id ='reportdatatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/audit/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/deptperformance/report/edit'',deltables:[perf_t_deptfunction,v_bgt_perf_goal_info,v_bgt_perf_indicator],repeatflag:''false''}', 'reportdatatable', 'pmkpi', null);

