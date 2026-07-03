begin
delete FROM Busfw_t_Uitabpage t where t.key = '/pmkpi/deptperformance/report/edit' and t.code in ('deptamt','deptproexp','deptperf');
delete FROM Busfw_t_Uieditform t where t.KEY = '/pmkpi/deptperformance/report/edit' and t.COLUMNCODE = 'ENDYEAR';
delete FROM Busfw_t_Uitable t where t.key in ('/pmkpi/deptperformance/report/deptamt','/pmkpi/deptperformance/report/deptproexp');
delete FROM Busfw_t_Uicolumn t where t.key in ('/pmkpi/deptperformance/report/deptamt','/pmkpi/deptperformance/report/deptproexp');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门总体资金情况', 'deptamt', 0, 15, 'nomal', 'tabfreamedit.clickTabpage', null, '部门总体资金情况', null, null, '{busguid:''DE67AEC7AF8E2376E0533315A8C0165D''}', null, '0', 'deptamtdatatable', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/edit', '项目支出情况', 'deptproexp', 0, 16, 'nomal', 'tabfreamedit.clickTabpage', null, '项目支出情况', null, null, '{busguid:''DE67AEC7AF8E2476E0533315A8C0165D''}', null, '0', 'deptproexpdatatable', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门整体绩效', 'deptperf', 0, 17, 'nomal', 'tabfreamedit.clickTabpage', null, '部门整体绩效', null, null, '{url:''/pmkpi/deptperformance/report/deptperf.page'',action:''deptperf.save'',busguid:''DE67AEC7AF8E2576E0533315A8C0165D''}', null, '0', 'deptperfiframe', null, null, null, null, null, null, '87', '2016');


insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
values (sys_guid(), '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'tree', '长期目标截止年份', 'ENDYEAR', 0, null, 1, null, 17, null, null, 'pmkpi', 1, null, '{"format":"#name"}', null, null, null, '87', '2016', null);

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'V_PERF_T_DEPTAMT', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'V_PERF_T_DEPTPROEXP', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'FAMT', '上年金额', 6, 1, 1, 0, null, 1, 1, '[''近两年收支金额'']', null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'RATE', '占比', 5, 1, 0, 0, null, 1, 1, null, null, null, null, 200, 0, 's', '{width:100}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'YEARAMT', '当年金额', 4, 1, 1, 0, null, 1, 1, null, null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'FUNDNAME', '资金性质', 3, 1, 0, 0, null, 0, 1, '[''总体资金情况'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'TYPENAME', '资金分类', 2, 1, 0, 0, null, 0, 1, '[''总体资金情况'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'PROTYPE', '项目类型', 3, 1, 1, 0, null, 1, 1, null, null, null, null, 300, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'TOTALAMT', '总预算', 4, 1, 1, 0, null, 1, 1, null, null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'EXPUSAGE', '主要支出方向和用途', 6, 1, 1, 0, null, 1, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'YEARAMT', '本年度预算', 5, 1, 1, 0, null, 1, 1, null, null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptproexp', 'PRO_NAME', '项目名称', 2, 1, 1, 0, null, 1, 1, null, null, null, null, 300, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/deptamt', 'SAMT', '前年金额', 7, 1, 1, 0, null, 1, 1, '[''近两年收支金额'']', null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');
