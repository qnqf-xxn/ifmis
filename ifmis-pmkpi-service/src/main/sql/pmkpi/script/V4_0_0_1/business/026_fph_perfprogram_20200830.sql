begin


--页面组件注册
--项目绩效目标查询
delete from p#busfw_T_uifunction t where t.key='/pmkpi/program/query/list';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA69CA3B40394675B6D98D6967E80FFE', '/pmkpi/program/query/list', '审核情况', 1, 2, 'searchicon', 'tlprogramquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6564363C668D4C5E83E9638269A85F57', '/pmkpi/program/query/list', '查询', 1, 1, 'searchicon', 'tlprogramquery.query', null, '查询', 'pmkpi', 'query', null, null);


delete from p#busfw_t_Uiqueryform t where t.key= '/pmkpi/program/query/list';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C8E0F094A25E46519053E0493FE004C9', '/pmkpi/program/query/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('6354656844F1452998CFED46BC75331A', '/pmkpi/program/query/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

delete from p#busfw_t_Uitable t where t.key='/pmkpi/program/query/list';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('952AF61A835E4759BA04B7CA5352B652', '/pmkpi/program/query/list', 'V_PERF_PROJECT_INFO', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/query/list';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FD4FF6F26F214961BCE6F394E358D23C', '/pmkpi/program/query/list', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1FD13731EC5A48FB97443ADB4377F1BD', '/pmkpi/program/query/list', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1791E90F58A6467F84E158FDBBD44D89', '/pmkpi/program/query/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8E450B01B1534ECEB44FE91CDA50384F', '/pmkpi/program/query/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8D04159D435D4971B2599E554A0C28DF', '/pmkpi/program/query/list', 'PRO_NAME', '名称', 3, 1, 0, 0, null, 0, 0, null, null, null, null, 100, 1, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5092031547AC456D87EDABFB6046DFCC', '/pmkpi/program/query/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2DE4AF3A70A54E2FA67F84B8D8701BC0', '/pmkpi/program/query/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ED9043C693DC49A6A539039A90FBC8FC', '/pmkpi/program/query/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

--项目绩效目标审核
delete from p#busfw_T_uifunction t where t.key='/pmkpi/program/report/audit';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('90763F5C86324ACD9EE930384EC3B2D9', '/pmkpi/program/report/audit', '审核信息', 1, 7, 'searchicon', 'tlprogramaudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5671A60D7DC47DDAA4A176A7B52FE2B', '/pmkpi/program/report/audit', '审核', 1, 1, null, 'tlprogramaudit.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('EE28FAFF320F4038BAF89E5EE9D6CEA4', '/pmkpi/program/report/audit', '取消审核', 1, 2, null, 'tlprogramaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFA1002978E64124B5267B538D46F087', '/pmkpi/program/report/audit', '查询', 1, 3, 'searchicon', 'tlprogramaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('EEFEC9BAB6D34E7B96020F1F1FAE0B5C', '/pmkpi/program/report/audit', '审核情况', 1, 6, 'searchicon', 'tlprogramaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

delete from p#busfw_t_Uiqueryform t where t.key='/pmkpi/program/report/audit';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('2C8EEF5C446344A5983B4B83A3885DBC', '/pmkpi/program/report/audit', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('07ADD9D6FF9C417BB1EBEA44A6B4063F', '/pmkpi/program/report/audit', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);


delete from p#busfw_t_Uitabpage t where t.key='/pmkpi/program/report/audit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E339E58352B644A8A711A4B4B5F743D0', 'pmkpi', '/pmkpi/program/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'tlprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F55700063D445809C438EC1D7069D37', 'pmkpi', '/pmkpi/program/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'tlprogramaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6DF3B8906740429A90D99664D29EAAE2', 'pmkpi', '/pmkpi/program/report/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'tlprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_Uitable t where t.key='/pmkpi/program/report/audit';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('49A79A8302714308B34D4D0AF286B62D', '/pmkpi/program/report/audit', 'V_PERF_PROJECT_INFO', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/report/audit';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8974E6D88C5A461FAA4A55491C66695C', '/pmkpi/program/report/audit', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE8906064B404427B883FA79F2831410', '/pmkpi/program/report/audit', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('475057AA28C840BAA58A50F44131D6C1', '/pmkpi/program/report/audit', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('467FAB677FCD4677AAB49A8BC335ED8C', '/pmkpi/program/report/audit', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('69D82CC0EA374AA290526661F5F83516', '/pmkpi/program/report/audit', 'PRO_NAME', '名称', 3, 1, 0, 0, null, 0, 0, null, null, null, null, 100, 1, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AB39AF56EB904813B7663AE629E9580F', '/pmkpi/program/report/audit', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BAFAA20A5DE44A068BFDDEAAED65980B', '/pmkpi/program/report/audit', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E9B741DB57834C5190A9CB5B04E0B3E8', '/pmkpi/program/report/audit', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

---项目绩效目标填报
delete from p#busfw_T_uifunction t where t.key='/pmkpi/program/report/list';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction04', '/pmkpi/program/report/list', '查询', 1, 9, 'searchicon', 'pmkpitlproreport.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction012', '/pmkpi/program/report/list', '新增', 1, 2, 'searchicon', 'pmkpitlproreport.add', null, '新增', 'pmkpi', 'add', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction02', '/pmkpi/program/report/list', '审核情况', 1, 7, 'searchicon', 'pmkpitlproreport.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction01', '/pmkpi/program/report/list', '送审', 1, 5, 'searchicon', 'pmkpitlproreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction05', '/pmkpi/program/report/list', '修改', 1, 3, 'searchicon', 'pmkpitlproreport.save', null, '修改', 'pmkpi', 'toEdit', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction07', '/pmkpi/program/report/list', '删除', 1, 4, 'searchicon', 'pmkpitlproreport.del', null, '删除', 'pmkpi', 'del', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction08', '/pmkpi/program/report/list', '取消送审', 1, 6, 'addicon', 'pmkpitlproreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

delete from p#busfw_t_Uiqueryform t where t.key= '/pmkpi/program/report/list';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('A755BE0D773440F1A19B99D564AB4FAE', '/pmkpi/program/report/list', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

delete from p#busfw_t_Uitabpage t where t.key='/pmkpi/program/report/list';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage03', 'pmkpi', '/pmkpi/program/report/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpitlproreport.clickTabpage', 0, '曾经办', null, '选择项目,删除,送审,新增,修改,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage02', 'pmkpi', '/pmkpi/program/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'pmkpitlproreport.clickTabpage', 0, '已送审', null, '选择项目,删除,送审,新增,修改', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/list/uitabpage01', 'pmkpi', '/pmkpi/program/report/list', '未送审', 'waitaudit', 1, 1, 'choosed', 'pmkpitlproreport.clickTabpage', 0, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_Uitable t where t.key= '/pmkpi/program/report/list';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('2259FFA1A6504F13B6730C730E8FC124', '/pmkpi/program/report/list', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', null, 'pmkpi', null);

delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/report/list';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn001', '/pmkpi/program/report/list', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn002', '/pmkpi/program/report/list', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn006', '/pmkpi/program/report/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn003', '/pmkpi/program/report/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn004', '/pmkpi/program/report/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn009', '/pmkpi/program/report/list', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn008', '/pmkpi/program/report/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B618CEBB4753405EAB894638AC34FECD', '/pmkpi/program/report/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

--项目绩效目标填报：基本信息
delete from p#busfw_T_uifunction t where t.key= '/pmkpi/program/report/edit';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/edit004', '/pmkpi/program/report/edit', '取消', 1, 2, 'Nofinishicon', 'pmkpitlprogramedit.close', null, '取消', 'pmkpi', null, null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/edit003', '/pmkpi/program/report/edit', '保存', 1, 1, 'Keepicon', 'pmkpitlprogramedit.infosave', null, '保存', 'pmkpi', null, null, null);

delete from p#busfw_t_Uieditform t where t.key= '/pmkpi/program/report/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('program/report/editinfo003', '/pmkpi/program/report/edit', 'V_PERF_PROJECT_INFO', 's', '项目名称', 'PRO_NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('program/report/editinfo002', '/pmkpi/program/report/edit', 'V_PERF_PROJECT_INFO', 's', '项目编号', 'PRO_CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('program/report/editinfo001', '/pmkpi/program/report/edit', 'V_PERF_PROJECT_INFO', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

delete from p#busfw_t_Uitabpage t where t.key='/pmkpi/program/report/edit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab004', 'pmkpi', '/pmkpi/program/report/edit', '年度绩效目标', 'yearindex', 1, 3, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '年度绩效目标', null, null, '{url:"/pmkpi/program/report/proindex.page",action:''pmkpitlproindex.save'',busguid:''2AA2F7C3AA54442AB529CEBA1DABAF96''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab001', 'pmkpi', '/pmkpi/program/report/edit', '附件管理', 'file', 1, 4, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab002', 'pmkpi', '/pmkpi/program/report/edit', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'pmkpitlprogramedit.clickTabpage', null, '项目基本信息', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('program/report/edittab003', 'pmkpi', '/pmkpi/program/report/edit', '预算支出明细', 'mxdatatable', 1, 2, 'nomal', 'pmkpitlprogramedit.clickTabpage', null, '预算支出明细', null, null, '{busguid:''B54067D4212C4D89972CE3984FC17DE0''}', null, '0', 'mxdatatable', null, null, null, null, null, null);

--项目绩效目标填报：预算支出明细
delete from p#busfw_t_Uitable t where t.key='/pmkpi/program/report/mxdatatable';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('report/indextable001', '/pmkpi/program/report/mxdatatable', 'V_PERF_T_OUTPAYPROJECT', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/report/mxdatatable';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F25D76C0662B496EB78F279139F927FC', '/pmkpi/program/report/mxdatatable', 'C1', '总计', 5, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4AD280E7BF49029A404997D35190B9', '/pmkpi/program/report/mxdatatable', 'C10', '非税专户收入', 16, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4DA15AEF9E947AA9A86450AA827DFB5', '/pmkpi/program/report/mxdatatable', 'C11', '纳入财政专户管理的行政事业性收费收入', 17, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9F44EB594F974F139939FC234A2496CE', '/pmkpi/program/report/mxdatatable', 'C12', '上年财政专户结存安排', 18, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('372883043564414EB7CEE15C53FA584C', '/pmkpi/program/report/mxdatatable', 'C13', '上级补助收入', 19, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CEE7E19D48794B14A4C34E95723E5F47', '/pmkpi/program/report/mxdatatable', 'C14', '附属单位上缴收入', 20, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7EFEA626EEBF4F8A924F87385EC4FE29', '/pmkpi/program/report/mxdatatable', 'C15', '事业单位经营收入', 21, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A21D195C91204C5D9CFD63CEB1F9780F', '/pmkpi/program/report/mxdatatable', 'C16', '用事业基金弥补收支差额', 24, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D9F67C0291484E1FA8F89051E10B09EB', '/pmkpi/program/report/mxdatatable', 'C17', '债务收入', 22, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4E4D3934D64E45B5ABAB3D855343BFCD', '/pmkpi/program/report/mxdatatable', 'C18', '其他收入', 23, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E65F8A9639E840CCAAC7D60E275EDAE3', '/pmkpi/program/report/mxdatatable', 'C19', '上年结转、结余', 25, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('87C4DB929CC8409B80745F4F33A302FE', '/pmkpi/program/report/mxdatatable', 'C2', '财政拨款', 6, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('53206261B41C4D28A3A868AF379745FA', '/pmkpi/program/report/mxdatatable', 'C20', '单位财政性结转结余', 96, 0, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('800A3A927F8940C7888F49879594340B', '/pmkpi/program/report/mxdatatable', 'C21', '财政性单位结转', 97, 0, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('439C9678E76B40C3B5EF655278F083FA', '/pmkpi/program/report/mxdatatable', 'C22', '财政性单位结余', 98, 0, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('31E02ADF897A4F3AA71406AC929C7FFA', '/pmkpi/program/report/mxdatatable', 'C23', '单位非财政性结转结余', 99, 0, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3E7ADB3C01804627B45C2BC5C2C23B58', '/pmkpi/program/report/mxdatatable', 'C24', '捐赠收入', 14, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('88BA16B765E24D9BA4AF3E3B383BF699', '/pmkpi/program/report/mxdatatable', 'C25', '其他收入（经营性收入）', 15, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('04593ED29A0E426B83B38E33533F3862', '/pmkpi/program/report/mxdatatable', 'C26', '教育专户结转', 100, 0, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BCEFDA224E2644858AC81DAEC30733EC', '/pmkpi/program/report/mxdatatable', 'C3', '经费拨款', 7, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0FF5F347ABC74FC78635984CAAB8B6AB', '/pmkpi/program/report/mxdatatable', 'C4', '罚没收入', 9, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6F6A6807E254471FBFF8E36567F286CB', '/pmkpi/program/report/mxdatatable', 'C5', '专项收入', 10, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F8BFCEBF6CD14FF4A40BBE999648DB81', '/pmkpi/program/report/mxdatatable', 'C6', '行政事业性收费', 8, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0AA92248AA69429CA5ECBAE6F2943588', '/pmkpi/program/report/mxdatatable', 'C7', '国有资本经营收入', 13, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF71B8146ABB498695CE067041D0F8D4', '/pmkpi/program/report/mxdatatable', 'C8', '国有资源(资产)有偿使用收入', 12, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5088AEA5144C405B920A8D7E42A9B4FB', '/pmkpi/program/report/mxdatatable', 'C9', '政府性基金收入', 11, 1, 1, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4FBA14C3FD42401F9CEF59F970EFFE71', '/pmkpi/program/report/mxdatatable', 'ECONOMIC', '经济科目', 3, 1, 1, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1D984E1E247545D3B8262140A909C6DA', '/pmkpi/program/report/mxdatatable', 'EXPFUNC', '功能科目', 2, 1, 1, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6E5C352EED5E454D9CED162E989684AA', '/pmkpi/program/report/mxdatatable', 'GOVECONOMIC', '政府经济科目', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C6EE41D6DFCD4D5F91927F8A41243089', '/pmkpi/program/report/mxdatatable', 'GUID', '主键', 1, 0, 1, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);


delete from p#busfw_T_uifunction t where t.key= '/pmkpi/program/report/proindex';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F2BC5280DBB849EDA71CE6C03E15DD7D', '/pmkpi/program/report/proindex', '精准推荐', 1, 1, 'keepicon', 'pmkpitlproindex.recom', null, '精准推荐', 'pmkpi', 'recom', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('1968685EF934498784BAAA65A8557045', '/pmkpi/program/report/proindex', '新增指标', 1, 2, 'keepicon', 'pmkpitlproindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('311C144756E6491FB3700CA82B36D3FF', '/pmkpi/program/report/proindex', '修改指标', 1, 3, 'keepicon', 'pmkpitlproindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A909ED0C17D24C8EADE716A4BC9A9DD2', '/pmkpi/program/report/proindex', '删除指标', 1, 4, 'keepicon', 'pmkpitlproindex.del', null, '删除指标', 'pmkpi', 'del', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BE641D3AF0534F35A5816B35E111A76D', '/pmkpi/program/report/proindex', '挑选指标', 1, 5, 'keepicon', 'pmkpitlproindex.pick', null, '挑选指标', 'pmkpi', 'pick', null, null);

delete from p#busfw_t_Uitable t where t.key='/pmkpi/program/report/proindex';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('8A3A0020D20D43A5A03D3F9FE1E56D14', '/pmkpi/program/report/proindex', 'V_PM_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', '{title:"绩效指标表"}');

delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/report/proindex';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('490A893F51CA495B9673847B241A891B', '/pmkpi/program/report/proindex', 'CZ', '操作', 6, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9B9EDBC004F94B1487F00942414C2E25', '/pmkpi/program/report/proindex', 'FINDEX', '一级指标', 1, 1, 0, 0, null, null, 1, null, '#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1EC42B484785448797A2AD22129B4CE4', '/pmkpi/program/report/proindex', 'INDEXVAL', '目标值', 4, 1, 1, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('43F617A737604357999DC1D85153B138', '/pmkpi/program/report/proindex', 'NAME', '三级指标', 3, 1, 0, 0, null, null, 1, null, null, null, null, 350, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7E8BAC514C4E4F15B582AE4F45F3EB5E', '/pmkpi/program/report/proindex', 'SINDEX', '二级指标', 2, 1, 0, 0, null, null, 1, null, '#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C7EE3BBF033E4209B13F2022C22D2E41', '/pmkpi/program/report/proindex', 'WEIGHT', '权重', 5, 1, 1, 1, null, null, 1, null, null, null, null, 100, 1, 'amt', null, null);


--项目绩效目标填报：年度绩效目标 精准推荐
delete from p#busfw_T_uifunction t where t.key='/pmkpi/program/prjindex/recomindex';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('/prjindex/recomindexbtn003', '/pmkpi/program/prjindex/recomindex', '查询', 1, 1, 'addicon', 'pmkpirecomindex.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('/prjindex/recomindexbtn002', '/pmkpi/program/prjindex/recomindex', '确定', 1, 2, 'addicon', 'pmkpirecomindex.addindex', null, '确定', 'pmkpi', 'addindex', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('/prjindex/recomindexbtn001', '/pmkpi/program/prjindex/recomindex', '取消', 1, 3, 'delicon', 'pmkpirecomindex.closewin', null, '取消', 'pmkpi', 'closewin', null, null);


delete from p#busfw_t_Uiqueryform t where t.key='/pmkpi/program/prjindex/recomindex';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindex001', '/pmkpi/program/prjindex/recomindex', 'name', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindex0023', '/pmkpi/program/prjindex/recomindex', 'code', '编码', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null);



delete from p#busfw_t_Uitabpage t where t.key='/pmkpi/program/prjindex/recomindex';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('prjindex/recomindex002', 'pmkpi', '/pmkpi/program/prjindex/recomindex', '推荐案例', 'case', 1, 2, 'nomal', 'pmkpirecomindex.clicktab', 0, '推荐案例', null, null, '{qf:["code"]}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('prjindex/recomindex001', 'pmkpi', '/pmkpi/program/prjindex/recomindex', '推荐模板', 'mode', 1, 3, 'nomal', 'pmkpirecomindex.clicktab', 0, '推荐模板', null, null, '{qf:["name"]}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('prjindex/recomindex003', 'pmkpi', '/pmkpi/program/prjindex/recomindex', '推荐指标', 'index', 1, 1, 'choosed', 'pmkpirecomindex.clicktab', 0, '推荐指标', null, null, '{qf:["code","name"]}', null, '0', null, null, null, null, null, null, null);


delete from p#busfw_t_Uitable t where t.key='/pmkpi/program/prjindex/recomindex';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('prjindex/recomindextable001', '/pmkpi/program/prjindex/recomindex', 'PERF_V_ALLINDEX', 100, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/prjindex/recomindex';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn0011', '/pmkpi/program/prjindex/recomindex', 'ANLI', '案例扩展', 8, 1, 0, 0, '0', 0, 0, null, null, null, null, 80, 0, 's', '{tabcol:''case''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn001', '/pmkpi/program/prjindex/recomindex', 'COMPUTESIGN', '计算符号', 4, 1, 0, 0, '0', 0, 0, null, '#name', null, 0, 80, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn002', '/pmkpi/program/prjindex/recomindex', 'FINDEX', '一级指标', 1, 1, 0, 0, '0', 0, 0, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn006', '/pmkpi/program/prjindex/recomindex', 'INDEXVALUE', '参考指标值', 5, 1, 0, 0, '0', 0, 0, null, null, null, null, null, 0, 's', '{}', '0');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn003', '/pmkpi/program/prjindex/recomindex', 'NAME', '指标名称', 3, 1, 0, 0, '0', 1, 0, null, null, null, null, 190, 0, 's', '{}', '0');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn004', '/pmkpi/program/prjindex/recomindex', 'SINDEX', '二级指标', 2, 1, 0, 0, '0', 0, 0, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn005', '/pmkpi/program/prjindex/recomindex', 'TARGETUNIT', '计量单位', 6, 1, 0, 0, '0', 0, 0, null, null, null, 0, 80, 0, 's', '{}', '0');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn007', '/pmkpi/program/prjindex/recomindex', 'TINDEX', '引用指标', 7, 0, 0, 0, '0', 0, 0, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prjindex/recomindexcolumn0023', '/pmkpi/program/prjindex/recomindex', 'ZHBIAO', '指标扩展', 33, 1, 0, 0, '0', 0, 0, null, null, null, null, 80, 0, 's', '{tabcol:''index''}', null);


--项目绩效目标填报：年度绩效目标  挑选指标
delete from p#busfw_T_uifunction t where t.key='/pmkpi/program/prjindex/pickindex';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('prjindex/pickindexbtn003', '/pmkpi/program/prjindex/pickindex', '取消', 1, 3, 'delicon', 'pmkpipickindex.closewin', null, '取消', 'pmkpi', 'closewin', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('prjindex/pickindexbtn002', '/pmkpi/program/prjindex/pickindex', '确定', 1, 2, 'addicon', 'pmkpipickindex.addindex', null, '确定', 'pmkpi', 'addindex', null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('prjindex/pickindexbtn001', '/pmkpi/program/prjindex/pickindex', '查询', 1, 1, 'addicon', 'pmkpipickindex.query', null, '查询', 'pmkpi', 'query', null, null);

delete from p#busfw_t_Uiqueryform t where t.key='/pmkpi/program/prjindex/pickindex';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('programpickqueryform001', '/pmkpi/program/prjindex/pickindex', 'NAME', '指标名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null);

delete from p#busfw_t_Uitable t where t.key='/pmkpi/program/prjindex/pickindex';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('program/prjindex/pickindex001', '/pmkpi/program/prjindex/pickindex', 'PERF_V_ALLINDEX', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/program/prjindex/pickindex';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn001', '/pmkpi/program/prjindex/pickindex', 'CODE', '指标编号', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn002', '/pmkpi/program/prjindex/pickindex', 'COMPUTESIGN', '计算符号', 24, 1, 0, 0, '0', 0, null, null, null, null, 0, null, 1, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn003', '/pmkpi/program/prjindex/pickindex', 'EXPLAIN', '指标值描述', 5, 1, 0, 0, '0', 1, null, null, null, null, 0, 0, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn004', '/pmkpi/program/prjindex/pickindex', 'FINDEX', '一级指标', 7, 1, 0, 0, '0', 0, null, null, '#name', null, 0, 0, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn009', '/pmkpi/program/prjindex/pickindex', 'INDEXVALUE', '指标内容', 14, 1, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn006', '/pmkpi/program/prjindex/pickindex', 'NAME', '指标名称', 2, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn007', '/pmkpi/program/prjindex/pickindex', 'SINDEX', '二级指标', 8, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn008', '/pmkpi/program/prjindex/pickindex', 'TARGETUNIT', '计量单位', 22, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/pickindexcolumn011', '/pmkpi/program/prjindex/pickindex', 'WEIGHT', '评(扣)分标准', 20, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{}', null);


--项目绩效目标填报：年度绩效目标  修改指标
delete from p#busfw_T_uifunction t where t.key= '/pmkpi/program/prjindex/editindex';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('12C66CF5B6AC4664AC2412C0F1F22837', '/pmkpi/program/prjindex/editindex', '保存', 1, 1, 'Keepicon', 'pmkpieditindex.save', null, '保存', 'pmkpi', null, null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('17D0AD9F099C41A2A264B6301F9B0D6D', '/pmkpi/program/prjindex/editindex', '取消', 1, 2, 'Nofinishicon', 'pmkpieditindex.close', null, '取消', 'pmkpi', null, null, null);





