begin

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/report/protabgoal');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C07BE778599325B6E053B11FA8C0B323', 'pmkpi', '/pmkpi/program/report/protabgoal', '中期绩效目标', 'total', 1, 1, 'choosed', 'tlprotabgoal.clickTabpage', 0, '中期绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C07BE778599225B6E053B11FA8C0B323', 'pmkpi', '/pmkpi/program/report/protabgoal', '年度绩效目标', 'year', 1, 2, 'nomal', 'tlprotabgoal.clickTabpage', 0, '年度绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/program/report/protabgoal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58239BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 'textarea', '绩效目标', 'KPI_TARGET', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57239BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57839BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '单位', 'AGENCYGUID', 0, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57939BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '主单guid', 'MAINGUID', 0, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57A39BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '创建时间', 'CREATETIME', 0, null, 1, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57B39BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '创建人', 'CREATER', 0, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57C39BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '区划', 'PROVINCE', 0, null, 1, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57D39BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '年度', 'YEAR', 0, null, 1, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57F39BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '财政区划代码', 'MOF_DIV_CODE', 0, null, 1, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58039BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '预算年度', 'FISCAL_YEAR', 0, null, 1, null, 20, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58139BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '项目代码', 'PRO_CODE', 0, null, 1, null, 21, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57E39BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '项目绩效目标主键', 'KPI_PER_ID', 0, null, 1, null, 22, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58339BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '业务类型代码', 'BUSI_TYPE', 0, null, 1, null, 23, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58439BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '版本号', 'VERSION', 0, null, 1, null, 24, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58539BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '版本说明', 'VERSION_NAME', 0, null, 1, null, 25, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F58639BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '下级财政区划代码', 'SUB_MOF_CODE', 0, null, 1, null, 26, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57439BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '更新时间', 'UPDATE_TIME', 0, null, 1, null, 27, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57539BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '是否删除1是2否', 'IS_DELETED', 0, null, 1, '2', 28, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57639BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '创建时间', 'CREATE_TIME', 0, null, 1, null, 29, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C07C8252F57739BAE053B11FA8C05F65', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '单位', 'AGENCY_CODE', 0, null, 1, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C08C672A373023C2E053B11FA8C0E800', '/pmkpi/program/report/protabgoal', 'V_PM_PERF_GOAL_INFO', 's', '是否年度指标', 'YEARFLAG', 0, null, 1, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/report/edit') and t.guid='C0B38427A5BF19E4E053B11FA8C0573E';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C0B38427A5BF19E4E053B11FA8C0573E', 'pmkpi', '/pmkpi/program/report/edit', '年度绩效目标', 'tabgoal', 0, 6, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/program/report/protabgoal.page?showtab=1'',action:''tlprotabgoal.save'',busguid:''C0B38427A5C119E4E053B11FA8C0573E''}', null, '0', 'iframetabgoal', null, null, null, null, null, null);

