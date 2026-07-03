begin

--监控布置任务 
--项目
delete from p#busfw_t_uitable t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B5A085C812ED0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'V_PERF_ADJUSTPROJECT_INFO', 100, 1, 0, 't.pro_code', 'exists(select 1 from v_pm_perf_goal_info a where a.pro_code=t.pro_code and a.yearflag=''0'')', 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F10888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812EE0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812EF0888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F40888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F30888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'FININTORGGUID', '业务科室', 5, 0, 0, null, null, null, null, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F00888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'YEAR', '预算年份', 6, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F20888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'CREATE_TIME', '创建时间', 7, 0, 0, null, null, null, null, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/trace/manage/prolist');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('CFB0962F96EC4925E0533315A8C009D9', '/pmkpi/program/trace/manage/prolist', 'T.PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812F70888E0535164A8C0487E', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

--部门
delete from p#busfw_t_uitable t where t.key in('/pmkpi/program/trace/manage/deptlist');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('172F9DAE8708472A9D13E6C6C0B4A725', '/pmkpi/program/trace/manage/deptlist', 'V_PERF_T_DEPTPERFDECLARE', 100, 1, 0, null, 't.wfstatus=''011'' and exists(select 1 from v_bgt_perf_goal_info a where a.mainguid=t.guid)', 'pmkpi', null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/trace/manage/deptlist');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('1D47F123B7D64F059CFFD065303E75EC', '/pmkpi/program/trace/manage/deptlist', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('CFB0962F96A24925E0533315A8C009D9', '/pmkpi/program/trace/manage/deptlist', 'T.NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);


--填报
delete from p#busfw_t_uitable t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B6FF9A5A131017AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PERF_V_PROMONITOR', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131517AFE0530100007FC89C', '/pmkpi/program/trace/report', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131517AFE0530100007FC89C', '/pmkpi/program/trace/report', 'TASKTYPE', '任务类型', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131417AFE0530100007FC89C', '/pmkpi/program/trace/report', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131117AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PRO_CODE', '项目编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{type:"protrace"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131217AFE0530100007FC89C', '/pmkpi/program/trace/report', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{type:"protrace"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131317AFE0530100007FC89C', '/pmkpi/program/trace/report', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 180, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131617AFE0530100007FC89C', '/pmkpi/program/trace/report', 'TASKSTAGE', '监控阶段', 9, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131717AFE0530100007FC89C', '/pmkpi/program/trace/report', 'WARNDAYS', '预警截止天数', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131D17AFE0530100007FC89C', '/pmkpi/program/trace/report', 'FININTORGGUID', '业务处室', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131817AFE0530100007FC89C', '/pmkpi/program/trace/report', 'BGTWARN', '预算执行预警', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131917AFE0530100007FC89C', '/pmkpi/program/trace/report', 'GOALWARN', '目标完成预警', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131A17AFE0530100007FC89C', '/pmkpi/program/trace/report', 'DEPTTASK', '自行监控', 15, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B6FF9A5A131B17AFE0530100007FC89C', '/pmkpi/program/trace/report', 'PROVINCETASK', '重点监控', 16, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B7279B405D667EB4E0530100007FD738', '/pmkpi/program/trace/report', 'WARN', '预警', 17, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/report') and code in('export','detailed');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF3C5CCB43DF3375E0533315A8C0E105', '/pmkpi/program/trace/report', '查看明细', 1, 8, 'searchicon', 'protaskreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8E849BE30C494CE9B90A907776A5F9AE', '/pmkpi/program/trace/report', '导出列表', 1, 5, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('CF610A5FB1A46763E0533315A8C0A8FA', '/pmkpi/program/trace/report', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B71F832B8AF303B0E0530100007FA9FF', '/pmkpi/program/trace/report', 'NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B71F832B8AF403B0E0530100007FA9FF', '/pmkpi/program/trace/report', 'WFSTATUS', '状态', 3, 0, 'tree', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/trace/report/dept');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('CFB0962F96F04925E0533315A8C009D9', '/pmkpi/trace/report/dept', 'AGENCYGUID', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FC106D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BA6C49818FC206D6E053B11FA8C0AD20', '/pmkpi/trace/report/dept', 'WFSTATUS', '状态', 3, 0, 'tree', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('CF610A5FB1A46763E0533315A8C0A8FA', '/pmkpi/program/trace/report', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B71F832B8AF303B0E0530100007FA9FF', '/pmkpi/program/trace/report', 'NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B71F832B8AF403B0E0530100007FA9FF', '/pmkpi/program/trace/report', 'WFSTATUS', '状态', 3, 0, 'tree', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null);

--审核
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/audit') and code in('expdata','detailed');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF3C5CCB44253375E0533315A8C0E105', '/pmkpi/program/trace/audit', '查看明细', 1, 13, 'searchicon', 'protraceaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4D4011F3455B444FB0C58CF7D5C5EFC8', '/pmkpi/program/trace/audit', '导出列表', 1, 12, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

--查询
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/query') and code in('expdata','detailed');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF610A5FB15E6763E0533315A8C0A8FA', '/pmkpi/program/trace/query', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF610A5FB15D6763E0533315A8C0A8FA', '/pmkpi/program/trace/query', '查看明细', 1, 10, 'searchicon', 'protracequery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

--成果上传
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/thirdaudit') and code in('export','resultsquery');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF610A5FB1AA6763E0533315A8C0A8FA', '/pmkpi/program/trace/thirdaudit', '成果查看', 1, 7, 'searchicon', 'protracethirdaudit.uploadresults', null, '成果查看', 'pmkpi', 'resultsquery', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF610A5FB1AC6763E0533315A8C0A8FA', '/pmkpi/program/trace/thirdaudit', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');

--成果审核
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/auditresults') and code in('export');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CF610A5FB1AD6763E0533315A8C0A8FA', '/pmkpi/program/trace/auditresults', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}');
