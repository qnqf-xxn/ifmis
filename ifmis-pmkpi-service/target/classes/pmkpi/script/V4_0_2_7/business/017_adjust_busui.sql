begin

--删除原有调整指标按钮
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/adjust/report/edit/index');

--调整指标按钮
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/adjust/report/proedit/index','/pmkpi/adjust/report/deptedit/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/index', '指标推荐', 0, 1, 'keepicon', 'adjustindex.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/index', '新增指标', 0, 2, 'keepicon', 'adjustindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/index', '修改指标', 0, 3, 'keepicon', 'adjustindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/index', '删除指标', 1, 4, 'keepicon', 'adjustindex.del', null, '删除指标', 'pmkpi', 'del', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', '指标推荐', 1, 1, 'keepicon', 'adjustindex.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', '新增指标', 0, 2, 'keepicon', 'adjustindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', '修改指标', 0, 3, 'keepicon', 'adjustindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/index', '删除指标', 1, 4, 'keepicon', 'adjustindex.del', null, '删除指标', 'pmkpi', 'del', null, null);

--绩效目标调整-项目指标显示列改为可编辑
update p#busfw_t_uicolumn t set t.isedit=1 where t.key in('/pmkpi/adjust/report/proedit/index') and t.isvisiable=1 and not t.columncode in('OBLIGATE1','STATUS','OBLIGATE3');

--绩效目标调整-部门整体指标显示列改为可编辑
update p#busfw_t_uicolumn t set t.isedit=1 where t.key in('/pmkpi/adjust/report/deptedit/index') and t.isvisiable=1 and not t.columncode in('OBLIGATE1','STATUS','OBLIGATE3');
