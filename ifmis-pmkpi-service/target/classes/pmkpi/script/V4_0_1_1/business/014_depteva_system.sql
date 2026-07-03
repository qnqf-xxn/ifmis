begin
delete from PERF_T_SYSTEMSET where paramcode = 'deptproconfirm';
insert into V_PERF_T_SYSTEMSET (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('EC41AF16F4C740A15FB88770F8F442EE', 'deptproconfirm', '部门评价项目确认左侧树页签', '{"types":"program","dept":"新增项目,修改项目,取消提交","program":"取消提交"}', 'types为页签类型，可根据页签进行按钮隐藏显示', null, 3, 2016, '87', 1);