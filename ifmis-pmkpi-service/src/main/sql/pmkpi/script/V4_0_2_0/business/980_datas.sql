begin

--调整左侧树页签配置
delete from perf_t_treetab t where t.key in('/pmkpi/adjust/report','/pmkpi/adjust/audit','/pmkpi/adjust/query');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CE60EBF74CDF2923E0533315A8C0959C', '/pmkpi/adjust/report', 'program', '项目支出', 1, null, 1, '2016', '87', 'B9A12B5D94761164E053B11FA8C0460E', 'programadjusthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CE60EBF74CE02923E0533315A8C0959C', '/pmkpi/adjust/report', 'dept', '部门整体', 1, null, 2, '2016', '87', 'BBC128805C506A0AE053B11FA8C04258', 'deptadjusthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CEC03E0DDD9D4EDEE0533315A8C0DD87', '/pmkpi/adjust/audit', 'program', '项目支出', 1, null, 1, '2016', '87', 'B9A12B5D94761164E053B11FA8C0460E', 'programauditadjusthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CEC03E0DDD9E4EDEE0533315A8C0DD87', '/pmkpi/adjust/audit', 'dept', '部门整体', 1, null, 2, '2016', '87', 'BBC128805C506A0AE053B11FA8C04258', 'deptauditadjusthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CEC03E0DDDF04EDEE0533315A8C0DD87', '/pmkpi/adjust/query', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptqueryadjusthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CEC03E0DDDEF4EDEE0533315A8C0DD87', '/pmkpi/adjust/query', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programqueryadjusthide');

--监控左侧树页签配置
delete from perf_t_treetab where key in('/pmkpi/program/trace/report','/pmkpi/program/trace/audit','/pmkpi/program/trace/query','/pmkpi/program/trace/thirdaudit','/pmkpi/program/trace/auditresults');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43973375E0533315A8C0E105', '/pmkpi/program/trace/report', 'protrace', '项目支出', 1, null, 1, '2016', '87', 'B7279B405D487EB4E0530100007FD738', 'protracereporthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43983375E0533315A8C0E105', '/pmkpi/program/trace/report', 'depttrace', '部门整体', 1, null, 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttracereporthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43993375E0533315A8C0E105', '/pmkpi/program/trace/audit', 'protrace', '项目支出', 1, null, 1, '2016', '87', 'B7279B405D487EB4E0530100007FD738', 'protraceaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439A3375E0533315A8C0E105', '/pmkpi/program/trace/audit', 'depttrace', '部门整体', 1, null, 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttraceaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439B3375E0533315A8C0E105', '/pmkpi/program/trace/query', 'depttrace', '部门整体', 1, null, 2, '2016', '87', null, 'depttracequeryhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439C3375E0533315A8C0E105', '/pmkpi/program/trace/query', 'protrace', '项目支出', 1, null, 1, '2016', '87', null, 'protracequeryhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439D3375E0533315A8C0E105', '/pmkpi/program/trace/thirdaudit', 'protrace', '项目支出', 1, null, 1, '2016', '87', 'B7279B405D487EB4E0530100007FD738', 'protracethirdaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E105', '/pmkpi/program/trace/thirdaudit', 'depttrace', '部门整体', 1, null, 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttracethirdaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E105', '/pmkpi/program/trace/auditresults', 'protrace', '项目支出', 1, null, 1, '2016', '87', 'B7279B405D487EB4E0530100007FD738', 'protraceauditresultshide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43A03375E0533315A8C0E105', '/pmkpi/program/trace/auditresults', 'depttrace', '部门整体', 1, null, 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttraceauditresultshide');

--数据权限查询sql进行优化
delete from pmkpi_t_datarule t where t.guid='bbmnbsyxjsyxj';
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbmnbsyxjsyxj', '本部门内部所有下级（多级下级单位）', 'pub', ' exists (select guid from pmkpi_fasp_t_pubagency agen where agen.guid = ruletable.agencyguid and agen.guid like''#curragency#%'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);


DELETE FROM  p#busfw_t_dcworkflowplan t WHERE t.GUID='D744F2E4176C4D79BC053C1FEE4274D8';
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('D744F2E4176C4D79BC053C1FEE4274D8', 'V_PERF_T_BUSWFPARALLEL', 'V_PERF_T_BUSWFPARALLEL', '部门整体绩效并行（绩效处）', '1', '2016', '87', null, null, null, null, '20200827225021776', 'B876713347C31372A297A0234F30FFB8');


--数据权限(资金归口处室相关)
delete from pmkpi_t_datarule where guid in ('zjgkbcs','zjgkbbm','uservbackoffice');
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('zjgkbcs', '资金归口本处室', 'pub', ' ruletable.manage_mof_dep_code = ''#busoffice#''', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservbackoffice', '用户对资金归口处室权限(设置中间表)', 'pub', ' exists (select * from pmkpi_t_uservagency agen where agen.agency = ruletable.manage_mof_dep_code and agen.userguid = ''#curruser#'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('zjgkbbm', '资金归口本部门', 'pub', ' ruletable.manage_dept_code = (select guid from pmkpi_fasp_t_pubagency where guid = (select superguid from pmkpi_fasp_t_pubagency where guid = ''#curragency#'') and isleaf = 0 and status = 1)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

--问题整改左侧树页签配置
delete from perf_t_treetab where key in('/pmkpi/rectification/index','/pmkpi/rectification/audit/index','/pmkpi/rectification/feedback/index','/pmkpi/rectification/feedback/audit/index');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E106', '/pmkpi/rectification/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'BD53404301784449E053B11FA8C0DF9A', 'deptrectificationhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E107', '/pmkpi/rectification/index', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD057E3C39B96759E053B11FA8C06040', 'programrectificationhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E108', '/pmkpi/rectification/audit/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'BD53404301784449E053B11FA8C0DF9A', 'deptrectiaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E109', '/pmkpi/rectification/audit/index', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD057E3C39B96759E053B11FA8C06040', 'programrectiaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E110', '/pmkpi/rectification/feedback/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'BD53404301784449E053B11FA8C0DF9A', 'deptfeedbackhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E111', '/pmkpi/rectification/feedback/index', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD057E3C39B96759E053B11FA8C06040', 'programfeedbackhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E112', '/pmkpi/rectification/feedback/audit/index', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'BD53404301784449E053B11FA8C0DF9A', 'deptfeedaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E113', '/pmkpi/rectification/feedback/audit/index', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD057E3C39B96759E053B11FA8C06040', 'programfeedaudithide');


-- 绩效目标修订左侧树页签配置
delete from perf_t_treetab where key in('/pmkpi/prorevision/report','/pmkpi/prorevision/audit');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E111', '/pmkpi/prorevision/report', 'dept', '部门整体', 0, null, 2, '2016', '87', 'PPC128805C506A0AE053B11FA8C04258', 'deptrevisionhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E122', '/pmkpi/prorevision/report', 'program', '项目支出', 1, null, 1, '2016', '87', 'PPA12B5D94761164E053B11FA8C0460E', 'programrevisionhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E133', '/pmkpi/prorevision/audit', 'dept', '部门整体', 0, null, 2, '2016', '87', 'PPC128805C506A0AE053B11FA8C04258', 'deptauditrevisionhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E144', '/pmkpi/prorevision/audit', 'program', '项目支出', 1, null, 1, '2016', '87', 'PPA12B5D94761164E053B11FA8C0460E', 'programauditrevisionhide');

--数据源 工作流状态 按照code排序
delete from fasp_t_dicdssource where guid='PMKPIWFSTATUS' and code ='PMKPIWFSTATUS';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIWFSTATUS', 'PMKPIWFSTATUS', 'PMKPIWFSTATUS', '工作流状态-绩效', '1', null, null, null, '2020', '87', null, '201901', null, '2', 'select * from pmkpi_t_wfstatus order by code', null, 1, 'pmkpi');
