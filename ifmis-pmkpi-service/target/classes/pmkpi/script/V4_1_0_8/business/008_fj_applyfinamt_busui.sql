begin

delete from bus_t_diccolumn where tablecode in('PM_PERF_GOAL_INFO','PERF_PROVISION_GOAL_INFO','PERF_T_ADJUSTGOAL') and columncode ='APPLYFINAMT';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'APPLYFINAMT', '1', '2016', '87', sys_guid(), 'APPLYFINAMT', 'PM_PERF_GOAL_INFO', '申请财政资金', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'APPLYFINAMT', '1', '2016', '87', sys_guid(), 'APPLYFINAMT', 'PERF_PROVISION_GOAL_INFO', '申请财政资金', 'N', '22', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'APPLYFINAMT', '1', '2016', '87', sys_guid(), 'APPLYFINAMT', 'PERF_T_ADJUSTGOAL', '申请财政资金', 'N', '22', null, 1, 1, null, sysdate);


--年度绩效目标增加“申请财政资金(万元)”，默认隐藏
delete from p#busfw_t_uieditform where key ='/pmkpi/program/report/protabgoal' and columncode ='APPLYFINAMT';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 'amt', '申请财政资金(万元)', 'APPLYFINAMT', 0, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uieditform where key ='/pmkpi/prorevision/report/proedit/goal' and columncode ='APPLYFINAMT';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 'amt', '申请财政资金(万元)', 'APPLYFINAMT', 0, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uieditform where key ='/pmkpi/adjust/report/proedit/goal' and columncode ='APPLYFINAMT';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/proedit/goal', 'V_PERF_T_ADJUSTGOAL', 'amt', '申请财政资金(万元)', 'APPLYFINAMT', 0, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);


--修改目标页面组件配置，金额单位为万元
update  bus_t_pageconsolecomconfig set config = '{amtflag:2}' where 
url in('/pmkpi/program/report/protabgoal','/pmkpi/prorevision/report/proedit/goal','/pmkpi/adjust/report/proedit/goal')
and componentid = 'buseditform' and config ='{}';

update  bus_t_pageconsolecomconfig set config = SUBSTR(config, 1, LENGTH(config)-1)||',amtflag:2}' where 
url in('/pmkpi/program/report/protabgoal','/pmkpi/prorevision/report/proedit/goal','/pmkpi/adjust/report/proedit/goal')
 and componentid = 'buseditform'and config <>'{}';