begin
  
delete from busfw_t_uicolumn where key = '/pmkpi/program/reportdp/jxaudit';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9AEA6275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9AB23275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9A733275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99E53275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'PRO_NAME', '名称', 3, 1, 0, 0, null, 0, 0, null, null, null, null, 100, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99E83275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99D28275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4123DE99E81275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF789ADE9B012275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF006ADE99E73275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'WFSTATUS', '绩效状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF456ADE99E74275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'BDMWFSTATUS', '预算状态', 18, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);



delete from busfw_t_uifunction where key = '/pmkpi/program/reportdp/jxaudit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D3434416A3275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', '审核情况', 1, 6, 'searchicon', 'jxauditdp.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFA65445454124B5267B538D46F087', '/pmkpi/program/reportdp/jxaudit', '查询', 0, 3, 'searchicon', 'jxauditdp.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5555B1683275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', '取消审核', 1, 2, null, 'jxauditdp.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D444DB1673275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', '审核', 1, 1, null, 'jxauditdp.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D232363275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', '审核信息', 1, 7, 'searchicon', 'jxauditdp.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);


delete from busfw_t_uiqueryform where key = '/pmkpi/program/reportdp/jxaudit';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BF4555622FCE3275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_REVIEW', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BF4D233343275E053C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_REVIEW', null, null);



delete from busfw_t_uitabpage where key = '/pmkpi/program/reportdp/jxaudit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF45567ED4C53275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/jxaudit', '曾经办', 'alldeals', 1, 3, 'nomal', 'jxauditdp.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D444D4BE3275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/jxaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'jxauditdp.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D23232FE3275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/jxaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'jxauditdp.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);


delete from busfw_t_uitable where key = '/pmkpi/program/reportdp/jxaudit';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BF4D5ADE06A03kjslf53C224280A22FC', '/pmkpi/program/reportdp/jxaudit', 'V_PERF_PROJECT_REVIEW', 0, 0, 0, null, null, 'pmkpi', null);


delete from busfw_t_dcworkflowplan where guid = 'B9C7D80EC0188933E053B11FA8C0A5D6';
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('B9C7D80EC0188933E053B11FA8C0A5D6', 'V_PERF_T_REVIEW', 'V_PERF_T_REVIEW', '绩效项目(评审/双绩效sx)', '1', '2016', '87', null, null, null, null, '20210421102117739', 'B876713347C31372A297A0234F30FFB8');
