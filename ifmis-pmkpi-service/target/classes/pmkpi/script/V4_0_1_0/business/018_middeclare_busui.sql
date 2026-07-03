begin
--填报
delete from p#busfw_t_uitable where key = '/pmkpi/midprogram/report/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('2259FFA1A6504F13B0730C730E8FC124', '/pmkpi/midprogram/report/list', 'V_PERF_T_DEPTPERFMIDDECLARE', 100, 1, 0, null, null, 'pmkpi', null);
--审核
delete from p#busfw_t_uitable where key = '/pmkpi/midprogram/report/audit';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('2259FFA1A0504F13B0730C09000FC124', '/pmkpi/midprogram/report/audit', 'V_PERF_T_DEPTPERFMIDDECLARE', 100, 1, 0, null, null, 'pmkpi', null);


--查询
delete from p#busfw_t_uitable where key = '/pmkpi/midprogram/query/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('2259FFA1A0504F13B0730C730E8FC124', '/pmkpi/midprogram/query/list', 'V_PERF_T_DEPTPERFMIDDECLARE', 100, 1, 0, null, null, 'pmkpi', null);

--填报
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/report/list';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn014', '/pmkpi/midprogram/report/list', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn015', '/pmkpi/midprogram/report/list', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn001', '/pmkpi/midprogram/report/list', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn002', '/pmkpi/midprogram/report/list', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn006', '/pmkpi/midprogram/report/list', 'CREATETIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn003', '/pmkpi/midprogram/report/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn004', '/pmkpi/midprogram/report/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn009', '/pmkpi/midprogram/report/list', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn008', '/pmkpi/midprogram/report/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/listcolumn009', '/pmkpi/midprogram/report/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

--审核
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/report/audit';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn015', '/pmkpi/midprogram/report/audit', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn001', '/pmkpi/midprogram/report/audit', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn002', '/pmkpi/midprogram/report/audit', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn006', '/pmkpi/midprogram/report/audit', 'CREATETIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn003', '/pmkpi/midprogram/report/audit', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn004', '/pmkpi/midprogram/report/audit', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn014', '/pmkpi/midprogram/report/audit', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn009', '/pmkpi/midprogram/report/audit', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn008', '/pmkpi/midprogram/report/audit', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/report/auditcolumn009', '/pmkpi/midprogram/report/audit', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

--查询
delete from p#busfw_t_uicolumn where key = '/pmkpi/midprogram/query/list';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn014', '/pmkpi/midprogram/query/list', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn015', '/pmkpi/midprogram/query/list', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn001', '/pmkpi/midprogram/query/list', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn002', '/pmkpi/midprogram/query/list', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn006', '/pmkpi/midprogram/query/list', 'CREATETIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn003', '/pmkpi/midprogram/query/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn004', '/pmkpi/midprogram/query/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn009', '/pmkpi/midprogram/query/list', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn008', '/pmkpi/midprogram/query/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('midprogram/query/listcolumn009', '/pmkpi/midprogram/query/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

--填报
delete from p#busfw_t_uifunction where key = '/pmkpi/midprogram/report/list';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction04', '/pmkpi/midprogram/report/list', '查询', 1, 9, 'searchicon', 'pmkpimidreport.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction09', '/pmkpi/midprogram/report/list', '新增', 0, 2, 'searchicon', 'pmkpimidreport.add', null, '新增', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction02', '/pmkpi/midprogram/report/list', '审核情况', 1, 7, 'searchicon', 'pmkpimidreport.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction01', '/pmkpi/midprogram/report/list', '送审', 1, 5, 'searchicon', 'pmkpimidreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction05', '/pmkpi/midprogram/report/list', '修改', 1, 3, 'searchicon', 'pmkpimidreport.save', null, '修改', 'pmkpi', 'toEdit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction07', '/pmkpi/midprogram/report/list', '删除', 1, 4, 'searchicon', 'pmkpimidreport.del', null, '删除', 'pmkpi', 'del', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction08', '/pmkpi/midprogram/report/list', '取消送审', 1, 6, 'addicon', 'pmkpimidreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/listfunction08', '/pmkpi/midprogram/report/list', '选择项目', 1, 1, 'addicon', 'pmkpimidreport.checkpro', null, '选择项目', 'pmkpi', 'checkpro', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616324744E0PPPP1FA8C01BA3', '/pmkpi/midprogram/report/list', '查看明细', 1, 8, 'searchicon', 'pmkpimidreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');


--审核


delete from p#busfw_t_uifunction where key = '/pmkpi/midprogram/report/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('90763P5C86324ACD9EE930384EC3B2D9', '/pmkpi/midprogram/report/audit', '审核信息', 1, 7, 'searchicon', 'midprogramaudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B5671A60D7DO47DDAA4A176A7B52FE2B', '/pmkpi/midprogram/report/audit', '审核', 1, 1, null, 'midprogramaudit.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('EE28FAFF320F4008BAF89E5EE9D6CEA4', '/pmkpi/midprogram/report/audit', '取消审核', 1, 2, null, 'midprogramaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFA1002978E64124B5P67B538D46F087', '/pmkpi/midprogram/report/audit', '查询', 1, 3, 'searchicon', 'midprogramaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('EEFEC9BAB6D34E7B96020F1FPFAE0B5C', '/pmkpi/midprogram/report/audit', '审核情况', 1, 6, 'searchicon', 'midprogramaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E6163247PPE0PPPP1FA8C01BA3', '/pmkpi/midprogram/report/audit', '查看明细', 1, 8, 'searchicon', 'midprogramaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');




--查询

delete from p#busfw_t_uifunction where key = '/pmkpi/midprogram/query/list';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('Dw69CA3B40394675B6D98D6967E80FFE', '/pmkpi/midprogram/query/list', '审核情况', 1, 2, 'searchicon', 'midprogramquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('656P363C668D4C5E83E9638269A85F57', '/pmkpi/midprogram/query/list', '查询', 1, 1, 'searchicon', 'midprogramquery.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DPPPE6163247PPE0PPPP1FA8C01BA3', '/pmkpi/midprogram/query/list', '查看明细', 1, 8, 'searchicon', 'midprogramquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

--选择


delete from p#busfw_t_uifunction where key = '/pmkpi/midprogram/report/procheck';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C975E5A7F3F59EE053B11FA8C00A31', '/pmkpi/midprogram/report/procheck', '确定', 1, 1, 'Keepicon', 'midreportcheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C975E5A7F3F59EE053B11FA8C00A32', '/pmkpi/midprogram/report/procheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);


--编辑
delete from p#busfw_t_uifunction where key = '/pmkpi/midprogram/report/edit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/edit004', '/pmkpi/midprogram/report/edit', '取消', 1, 2, 'Nofinishicon', 'pmkpimidprogramedit.close', null, '取消', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('midprogram/report/edit003', '/pmkpi/midprogram/report/edit', '保存', 1, 1, 'Keepicon', 'pmkpimidprogramedit.infosave', null, '保存', 'pmkpi', null, null, null);

--填报
delete from p#busfw_t_uiqueryform where key = '/pmkpi/midprogram/report/list';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('2C8EEF5C446344A59J3B4B83A3885DBC', '/pmkpi/midprogram/report/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('07ADD9D6FF9C417B01EBEA44A6B4063F', '/pmkpi/midprogram/report/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', null, null);

--审核

delete from p#busfw_t_uiqueryform where key = '/pmkpi/midprogram/report/audit';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('2C8EEF5C446344A59J3B4B83A3885DBC', '/pmkpi/midprogram/report/audit', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('07ADD9D6FF9C417B01EBEA44A6B4063F', '/pmkpi/midprogram/report/audit', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', null, null);

--查询

delete from p#busfw_t_uiqueryform where key = '/pmkpi/midprogram/query/list';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C8E0F094A25E465190P3E0493FE004C9', '/pmkpi/midprogram/query/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('6354656844F145299PCFED46BC75331A', '/pmkpi/midprogram/query/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', null, null);


--编辑

delete from p#busfw_t_uitabpage where key = '/pmkpi/midprogram/report/edit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/edittab004', 'pmkpi', '/pmkpi/midprogram/report/edit', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'pmkpimidprogramedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/program/report/treeindex.page?showtab=1'',action:''prjtreeindex.save'',busguid:''2AA2F7C3AA54442AB529CEBA1DABAF96''}', null, '0', 'indextableiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C07BE77859905B6E053B11FA8C0B323', 'pmkpi', '/pmkpi/midprogram/report/edit', '年度绩效目标', 'yeargoal', 1, 2, 'nomal', 'pmkpimidprogramedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/program/report/protabgoal.page?showtab=1'||chr(38)||'isedittotal=1'',action:''tlprotabgoal.save'',busguid:''FDDCF71C312941CD9D3408ACC958DBAB''}', null, '0', 'goaliframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/edittab002', 'pmkpi', '/pmkpi/midprogram/report/edit', '项目基本信息', 'proinfo', 1, 1, 'choosed', 'pmkpimidprogramedit.clickTabpage', null, '项目基本信息', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A'',viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/midprogram/report/list';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage03', 'pmkpi', '/pmkpi/midprogram/report/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpimidreport.clickTabpage', 0, '曾经办', null, '选择项目,删除,送审,新增,修改,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage02', 'pmkpi', '/pmkpi/midprogram/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'pmkpimidreport.clickTabpage', 0, '已送审', null, '选择项目,删除,送审,新增,修改', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('midprogram/report/list/tabpage01', 'pmkpi', '/pmkpi/midprogram/report/list', '未送审', 'waitaudit', 1, 1, 'choosed', 'pmkpimidreport.clickTabpage', 0, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/midprogram/report/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E339E58352B644APA711A4B4BPO43D0', 'pmkpi', '/pmkpi/midprogram/report/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'midprogramaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F55700063D44580PLL38EC1D7069D37', 'pmkpi', '/pmkpi/midprogram/report/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'midprogramaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6DF3B890674042POO0D99664D29EAAE2', 'pmkpi', '/pmkpi/midprogram/report/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'midprogramaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);




