begin

--广西四个部门指标页签改版配置
delete from perf_t_systemset where paramcode in('NEWAPPLYDEPTS_PROGRAM','NEWAPPLYDEPTS_DEPT','NEWAPPLYDEPTS','NEWAPPLYDEPTSPROGRAM');
insert into v_perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values (sys_guid(), 'NEWAPPLYDEPTS_PROGRAM', '部门配置-项目支出', '{"agencys":""}', '指定部门实行新的指标填报方式', 'pmkpi', 34, 2016, '87', 1);
insert into v_perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values (sys_guid(), 'NEWAPPLYDEPTS_DEPT', '部门配置-部门整体', '{"agencys":""}', '指定部门实行新的指标填报方式', 'pmkpi', 36, 2016, '87', 1);

--页签表权限-数据源
delete from perf_t_datasource where elementcode = 'ISCHECKTAB';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '是', null, null, null, null, 1, 'ISCHECKTAB', 1, '20220627', '20220627', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '否', null, null, null, null, 2, 'ISCHECKTAB', 1, '20220627', '20220627', 2016, '87');

--页签表权限配置表-升级分区同步注册
delete from bus_t_settmp where tablecode in('V_PERF_T_UITABPAGE_CHEC');
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_UITABPAGE_CHEC', 'guid', null, null, null, 1);

--案例左侧树页签
delete from perf_t_treetab t where t.key in('/pmkpi/case/audit','/pmkpi/case/query','/pmkpi/setting/case/list');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('E2F5483E6C692CBAE0533315A8C00CB1', '/pmkpi/case/audit', 'PM001', '项目支出', 1, null, 1, '2016', '87', 'E2A5CA708C55131DE0533315A8C01809', 'pm001caseaudithide', '{"leftsource":"PMKPIAGENCYALLPAY"}');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('E2F5483E6C6A2CBAE0533315A8C00CB1', '/pmkpi/case/audit', 'DEPT', '部门整体', 1, null, 2, '2016', '87', 'E2A5CA708C56131DE0533315A8C01809', 'deptcaseraudithide', '{"leftsource":"PMKPIDEPT"}');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('E2F5483E6C6B2CBAE0533315A8C00CB1', '/pmkpi/case/query', 'PM001', '项目支出', 1, null, 1, '2016', '87', 'E2A5CA708C55131DE0533315A8C01809', 'pm001casequeryhide', '{"leftsource":"PMKPIAGENCYALLPAY"}');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('E2F5483E6C6C2CBAE0533315A8C00CB1', '/pmkpi/case/query', 'DEPT', '部门整体', 1, null, 2, '2016', '87', 'E2A5CA708C56131DE0533315A8C01809', 'deptcaserqueryhide', '{"leftsource":"PMKPIDEPT"}');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('E2A5CA708BFF131DE0533315A8C01809', '/pmkpi/setting/case/list', 'PM001', '项目支出', 1, null, 1, '2016', '87', 'E2A5CA708C55131DE0533315A8C01809', 'pm001casereporthide', '{"leftsource":"PMKPIAGENCYALLPAY"}');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('E2A5CA708C00131DE0533315A8C01809', '/pmkpi/setting/case/list', 'DEPT', '部门整体', 1, null, 2, '2016', '87', 'E2A5CA708C56131DE0533315A8C01809', 'deptcasereporthide', '{"leftsource":"PMKPIDEPT"}');

--数据类型
delete from perf_t_datasource t where t.elementcode='perfdatatype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '新增', null, null, null, null, 1, 'perfdatatype', 1, '20210127', '20210127', 2021, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '修改', null, null, null, null, 2, 'perfdatatype', 1, '20210127', '20210127', 2021, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '删除', null, null, null, null, 3, 'perfdatatype', 1, '20210127', '20210127', 2021, '87');

--指标值变动情况
delete from perf_t_datasource t where t.elementcode='PERFVALUECHANGE';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '变动值', null, '0', 1, 1, 1, 'PERFVALUECHANGE', 1, '20220711', '20220711', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '固定值', null, '0', 1, 1, 2, 'PERFVALUECHANGE', 1, '20220711', '20220711', 2016, '87');

--案例库工作流
delete from p#busfw_t_dcworkflowplan t where t.guid in('E2A5CA708C56131DE0533315A8C01809','E2A5CA708C55131DE0533315A8C01809');
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('E2A5CA708C55131DE0533315A8C01809', 'PERF_CASE_PRO', 'V_PERF_T_CASE', '案例库维护（项目支出）', '1', '2016', '87', null, null, null, null, null, 'B876713347C31372A297A0234F30FFB8');

insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('E2A5CA708C56131DE0533315A8C01809', 'PERF_CASE_DEPT', 'V_PERF_T_CASE', '案例库维护（部门整体）', '1', '2016', '87', null, null, null, null, null, 'B876713347C31372A297A0234F30FFB8');

--案例页面配置
delete from perf_t_pagemenu t where t.guid in('E37F581A54832C17E0533315A8C0BDDA','E37F581A54842C17E0533315A8C0BDDA','E37F581A54852C17E0533315A8C0BDDA','E37F581A54862C17E0533315A8C0BDDA','E37F581A54882C17E0533315A8C0BDDA');
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E37F581A54832C17E0533315A8C0BDDA', '1', '项目支出', '/pmkpi/setting/caseinfo/edit', '31F69D7C7C4142B8BBB71696FDBD9D39', 3, 0, 1, 1, '20220713151301', '20220713151301', null, '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E37F581A54842C17E0533315A8C0BDDA', '2', '部门整体', '/pmkpi/case/deptedit', '31F69D7C7C4142B8BBB71696FDBD9D39', 3, 0, 2, 1, '20220713151301', '20220713151301', null, '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E37F581A54862C17E0533315A8C0BDDA', '3', '基本信息', '/pmkpi/case/info', '31F69D7C7C4142B8BBB71696FDBD9D39', 3, 1, 3, 1, '20220713151301', '20220713151301', null, '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E37F581A54882C17E0533315A8C0BDDA', '1', '指标', '/pmkpi/case/proindex', 'E37F581A54832C17E0533315A8C0BDDA', 4, 1, 4, 1, '20220713151301', '20220713151301', null, '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('E37F581A54852C17E0533315A8C0BDDA', '1', '指标', '/pmkpi/case/deptindex', 'E37F581A54842C17E0533315A8C0BDDA', 4, 1, 5, 1, '20220713151301', '20220713151301', null, '87', '2016');
