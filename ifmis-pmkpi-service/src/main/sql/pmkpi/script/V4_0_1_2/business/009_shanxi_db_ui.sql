begin
  
delete FROM Busfw_t_Uifunction t where t.key in ('/pmkpi/program/report/dpedit','/pmkpi/program/reportdp/list','/pmkpi/program/reportdp/audit');
 
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB16C3275E053C224280A22FC', '/pmkpi/program/reportdp/list', '新增', 1, 2, 'searchicon', 'pmkpitlproreportdp.add', null, '新增', 'pmkpi', 'add', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB1783275E053C224280A22FC', '/pmkpi/program/reportdp/list', '审核情况', 1, 7, 'searchicon', 'pmkpitlproreportdp.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('program/report/listfunction04', '/pmkpi/program/reportdp/list', '查询', 0, 9, 'searchicon', 'pmkpitlproreportdp.query', null, '查询', 'pmkpi', 'query', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB1793275E053C224280A22FC', '/pmkpi/program/reportdp/list', '送审', 1, 5, 'searchicon', 'pmkpitlproreportdp.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB17E3275E053C224280A22FC', '/pmkpi/program/reportdp/list', '修改', 1, 3, 'searchicon', 'pmkpitlproreportdp.save', null, '修改', 'pmkpi', 'toEdit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB17F3275E053C224280A22FC', '/pmkpi/program/reportdp/list', '删除', 1, 4, 'searchicon', 'pmkpitlproreportdp.del', null, '删除', 'pmkpi', 'del', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB1803275E053C224280A22FC', '/pmkpi/program/reportdp/list', '取消送审', 1, 6, 'addicon', 'pmkpitlproreportdp.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB1663275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '审核信息', 1, 7, 'searchicon', 'tlprogramauditdp.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB1673275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '审核', 1, 1, null, 'tlprogramauditdp.audit', null, '审核', 'pmkpi', 'audit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB1683275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '取消审核', 1, 2, null, 'tlprogramauditdp.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('DFA1002978E64124B5267B538D46F087', '/pmkpi/program/reportdp/audit', '查询', 0, 3, 'searchicon', 'tlprogramauditdp.query', null, '查询', 'pmkpi', 'query', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADDB16A3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '审核情况', 1, 6, 'searchicon', 'tlprogramauditdp.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('program/dpreport/edit003', '/pmkpi/program/report/dpedit', '保存', 1, 1, 'Keepicon', 'pmkpitlpdpedit.infosave', null, '保存', 'pmkpi', null, null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('program/dpreport/edit004', '/pmkpi/program/report/dpedit', '取消', 1, 2, 'Nofinishicon', 'pmkpitlpdpedit.close', null, '取消', 'pmkpi', null, null, null, '87', '2016');


delete FROM Busfw_t_Uieditform t where t.key in ('/pmkpi/program/report/dpedit');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('BCBfde3DfgfgfgBE053470A050A6189', '/pmkpi/program/report/dpedit', 'V_PERF_PROJECT_INFO', 's', '业务主键', 'GUID', 0, null, 0, null, 480, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('BCB2D3sf2fxxffsE053470A050A6189', '/pmkpi/program/report/dpedit', 'V_PERF_PROJECT_INFO', 's', '项目名称', 'PRO_NAME', 1, null, 0, null, 110, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('BCB2Djlsfjlsjfllsjdfl470A050A6189', '/pmkpi/program/report/dpedit', 'V_PERF_PROJECT_INFO', 's', '项目代码', 'PRO_CODE', 1, null, 0, null, 120, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

delete FROM Busfw_t_Uiqueryform t where t.key in ('/pmkpi/program/reportdp/list','/pmkpi/program/reportdp/audit');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF4D5ADDB9DC3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', null, null, '87', '2016');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF4D5ADDBFCE3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', null, null, '87', '2016');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('8C7D98A9BE4D4A15AAE910683A857CEB', '/pmkpi/program/reportdp/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', null, null, '87', '2016');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('B2F49912FD164C789B75157FCAFE2A7F', '/pmkpi/program/reportdp/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', null, null, '87', '2016');


delete FROM Busfw_t_Uitabpage t where t.key in ('/pmkpi/program/report/dpedit','/pmkpi/program/reportdp/list','/pmkpi/program/reportdp/audit');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('BF4D5ADED4B83275E053C2A4280A22FC', 'pmkpi', '/pmkpi/program/reportdp/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpitlproreportdp.clickTabpage', 0, '曾经办', null, '选择项目,删除,送审,新增,修改,取消送审', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('BF4D5ADED4BA3275E053C2V4280A22FC', 'pmkpi', '/pmkpi/program/reportdp/list', '未送审', 'waitaudit', 1, 1, 'choosed', 'pmkpitlproreportdp.clickTabpage', 0, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('BF4D5ADED4C43275E053C2D4280A22FC', 'pmkpi', '/pmkpi/program/reportdp/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'pmkpitlproreportdp.clickTabpage', 0, '已送审', null, '选择项目,删除,送审,新增,修改', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('BF4D5ADED2FE3275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'tlprogramauditdp.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('BF4D5ADED4BE3275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'tlprogramauditdp.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('BF4D5ADED4C53275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'tlprogramauditdp.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpidpreportedit90002', 'pmkpi', '/pmkpi/program/report/dpedit', '绩效指标', 'yeargoal', 1, 3, 'nomal', 'pmkpitlpdpedit.clickTabpage', null, '绩效指标', null, null, '{url:"/pmkpi/program/report/treeindex.page?showtab=1'||chr(38)||'isedittotal=0",action:''prjtreeindex.save'',busguid:''FDDCF71C312941CD9D3408ACC958DBAB''}', null, '0', 'iframegoaltable', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpidpreportedit90001', 'pmkpi', '/pmkpi/program/report/dpedit', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'pmkpitlpdpedit.clickTabpage', null, '项目基本信息', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A''}', null, '0', 'editform', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpidpreportedit90003', 'pmkpi', '/pmkpi/program/report/dpedit', '绩效目标', 'tabgoal', 1, 2, 'nomal', 'pmkpitlpdpedit.clickTabpage', null, '绩效目标', null, null, '{url:''/pmkpi/program/report/protabgoal.page?showtab=1'||chr(38)||'isedittotal=0'',action:''tlprotabgoal.save'',busguid:''C0B38427A5C119E4E053B11FA8C0573E''}', null, '0', 'iframetabgoal', null, null, null, null, null, null, '87', '2016');

delete FROM Busfw_t_Uitable t where t.key in ('/pmkpi/program/reportdp/list','/pmkpi/program/reportdp/audit');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADE06943275E0531224280A22FC', '/pmkpi/program/reportdp/list', 'V_PERF_PROJECT_INFODPVIEW', 100, 1, 0, 'PRO_CODE', null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('BF4D5ADE06A03275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'V_PERF_PROJECT_INFODPVIEW', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

delete FROM Busfw_t_Uicolumn t where t.key in ('/pmkpi/program/reportdp/list','/pmkpi/program/reportdp/audit');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn111', '/pmkpi/program/reportdp/list', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn112', '/pmkpi/program/reportdp/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn113', '/pmkpi/program/reportdp/list', 'MOF_DEP_CODE', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn114', '/pmkpi/program/reportdp/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn115', '/pmkpi/program/reportdp/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn116', '/pmkpi/program/reportdp/list', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn117', '/pmkpi/program/reportdp/list', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn118', '/pmkpi/program/reportdp/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn119', '/pmkpi/program/reportdp/list', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn120', '/pmkpi/program/reportdp/list', 'PRO_CODE', '项目编码', 1, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('program/report/listcolumn121', '/pmkpi/program/reportdp/list', 'PRO_ID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF4D5ADE99E83275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF633DE99D23275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF4455DE9AEA3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF4233DE9A703275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF556ADE9AB23275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF789ADE9B013275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF006ADE99E73275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'WFSTATUS', '绩效状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF456ADE99E73275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'BDMWFSTATUS', '预算状态', 18, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');