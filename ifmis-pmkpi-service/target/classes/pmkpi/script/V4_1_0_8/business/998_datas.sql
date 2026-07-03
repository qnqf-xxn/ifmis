begin
  
delete from perf_t_systemset t where t.paramcode='ISTRACEMANAGEKEYNOTE';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('108904A9FDED76B3E0630A64A8C026A9', 'ISTRACEMANAGEKEYNOTE', '一般监控是否标记重点项目，注意：开启该参数时，请隐藏重点项目监控任务布置菜单', '0', '0否、1是', 'pmkpi', 1, 2016, '87', 1);


delete from perf_t_systemset where paramcode = 'RECTIFYRESULTOPINION';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('FAC9425BD9F7D2F50A725519031BDAF3', 'RECTIFYRESULTOPINION', '控制整改情况审核-结果应用意见-页面是否可编辑', '{"isedit":""}', '根据角色控制 引号中配置可编辑的角色guid 多个角色用,隔开', 'pmkpi', 4, 2016, '87', 1);


--浙江项目查询/pmkpi/performance/query
delete from perf_t_treetab where key ='/pmkpi/performance/query';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/performance/query', 'project', '二级项目', 1, null, 1, '2016', '87', null, 'projectperformance_targethide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/performance/query', 'firstpro', '一级项目', 1, null, 2, '2016', '87', null, 'firstproperformance_targethide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/performance/query', 'transpay', '转移支付', 0, null, 3, '2016', '87', null, 'transpayperformance_targethide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/performance/query', 'dept', '部门整体', 0, null, 4, '2016', '87', null, 'deptperformance_targethide');

--浙江监审/pmkpi/supervision/index
delete from perf_t_treetab where key ='/pmkpi/supervision/index';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/supervision/index', 'prodetail', '二级项目', 1, null, 1, '2016', '87', null, 'prodetailreporthide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/supervision/index', 'promain', '一级项目', 1, null, 2, '2016', '87', null, 'promainreporthide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/supervision/index', 'propay', '转移支付', 0, null, 3, '2016', '87', null, 'propayreporthide');

--事前绩效评估报告配置菜单
delete from perf_t_pagemenu t where guid='82B8580639B0025FBD4CC20E7313227E';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('82B8580639B0025FBD4CC20E7313227E', '11', '事前绩效评估报告', '/pmkpi/program/beforeview', 'D574940480DC7ED4E0533315A8C059D3', 3, 1, 11, 1, '20240315144620', '20240315144620', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2024');

--监控指标定性指标规则sql去除空格
update perf_t_warnset t set t.warnsql=replace(t.warnsql, '#indexval# ', '#indexval#') where t.type='qualitativeindex';

--自评复核左侧页签
delete from perf_t_treetab t where key in('/pmkpi/selfreview/manage','/pmkpi/selfreview/result','/pmkpi/selfreview/audit','/pmkpi/selfreview/query');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('13E68723611F4949E0630A64A8C07FBA', '/pmkpi/selfreview/manage', 'program', '项目支出', 1, null, 1, '2016', '87', '13E6872362764949E0630A64A8C07FBA', 'programselfreviewmanagehide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('13E6872362734949E0630A64A8C07FBA', '/pmkpi/selfreview/result', 'program', '项目支出', 1, null, 1, '2016', '87', '13E6872362764949E0630A64A8C07FBA', 'programselfreviewresulthide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('13E6872362D24949E0630A64A8C07FBA', '/pmkpi/selfreview/audit', 'program', '项目支出', 1, null, 1, '2016', '87', '13E6872362764949E0630A64A8C07FBA', 'programselfreviewaudithide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('13E6872362D34949E0630A64A8C07FBA', '/pmkpi/selfreview/query', 'program', '项目支出', 1, null, 1, '2016', '87', '13E6872362764949E0630A64A8C07FBA', 'programselfreviewqueryhide', null);

--自评复核流程配置
delete from p#busfw_t_dcworkflowplan t where t.guid='13E6872362764949E0630A64A8C07FBA';
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE, PARTITIONTYPE)
values ('13E6872362764949E0630A64A8C07FBA', 'PERF_PROSELFREVIEW', 'PERF_T_SELFREVIEWTASK', '绩效自评复核表', '1', '2016', '87', null, null, null, null, '20200829172956946', 'B876713347C31372A297A0234F30FFB8', '1');

--自评复核页签必填配置
delete from perf_t_uitabpage_chec t where t.key='/pmkpi/selfreview/result/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('13E6872362A54949E0630A64A8C07FBA', '13E6872362A54949E0630A64A8C07FBA', '项目基本信息', '/pmkpi/selfreview/result/edit', 'proinfo', 2, 'V_PERF_T_SELFREVIEWTASK', '20240321175554', '20240321175554', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('13E6872362A64949E0630A64A8C07FBA', '13E6872362A64949E0630A64A8C07FBA', '复核成果', '/pmkpi/selfreview/result/edit', 'file', 2, null, '20240321175554', '20240321175554', '2016', '87');

--自评复核页面配置
delete from perf_t_pagemenu t where t.uikey ='/pmkpi/selfreview/result/edit';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('FC2918674C8E2A37314A244A840C5DD4', '1', '复核成果上传', '/pmkpi/selfreview/result/edit', '13E6872360864949E0630A64A8C07FBA', 3, 1, 1, 1, '20240322092737', '20240322092737', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--自评复核附件配置
delete from perf_filetype t where t.bustype='selfreviewpro';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('13E6872362CF4949E0630A64A8C07FBA', '001', '附件材料', null, '#', 1, 0, 1, 1, 'selfreviewpro', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('13E6872362D04949E0630A64A8C07FBA', '001001', '成果附件', null, '13E6872362CF4949E0630A64A8C07FBA', 2, 1, 2, 1, 'selfreviewpro', null, null, 2016, '87');
