begin


--复制上年目标按钮，默认隐藏
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperformance/report/edit' and code ='copylastyeargoal';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/report/edit', '复制上年目标', 0, 0, 'Keepicon', 'tabfreamedit.copylastyeargoal', null, '复制上年目标', 'pmkpi', 'copylastyeargoal', null, '{}', null, null);


--复制上年指标按钮，默认隐藏
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperformance/report/perfindex' and code ='copylastyearindex';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', '复制上年指标', 0, 9, 'keepicon', 'deptindex.copylastyearindex', null, '复制上年指标', 'pmkpi', 'copylastyearindex', null, null, null, null);


--更新部门整体编辑页签除了【绩效目标】外的其他页签，隐藏【复制上年目标】按钮hidebtns
update p#busfw_t_uitabpage set hidebtns = '复制上年目标' where key ='/pmkpi/deptperformance/report/edit' and hidebtns is null and code <>'deptgoal';
update p#busfw_t_uitabpage set hidebtns = hidebtns||',复制上年目标' where key ='/pmkpi/deptperformance/report/edit' and hidebtns is not null and instr(hidebtns,'复制上年目标')=0 and code <>'deptgoal';