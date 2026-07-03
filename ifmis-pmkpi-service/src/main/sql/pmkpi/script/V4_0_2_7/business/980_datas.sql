begin


  --事前绩效评估页面配置维护菜单
delete from PERF_T_PAGEMENU where guid in('39CD1921EB656CC9AEED85FDCAF88DA1','F7D1443C0E91842792DC1AF33D811D41','61DABD148DF10359DB8B0059A9E97A80');
insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('39CD1921EB656CC9AEED85FDCAF88DA1', '22000102', '填报/修改', '/pmkpi/evaluation/report/proedit', 'DE69B2BD201C578BE0533315A8C06380', 3, 1, 2, 1, '20220606094405', '20220606094405', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('F7D1443C0E91842792DC1AF33D811D41', '22000101', '选择项目', '/pmkpi/evaluation/report/procheck', 'DE69B2BD201C578BE0533315A8C06380', 3, 1, 1, 1, '20220520150700', '20220606092933', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('61DABD148DF10359DB8B0059A9E97A80', '2200010201', '事前绩效评估信息', '/pmkpi/report/evaluationinfo', '39CD1921EB656CC9AEED85FDCAF88DA1', 4, 1, 1, 1, '20220606094533', '20220606094533', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');


-- 审核定义表
delete from bus_t_settmp t where t.tablecode='perf_t_auditdefine';
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('perf_t_auditdefine', 'guid', null, null, null, 1);

--自定义视图表
delete from bus_t_settmp t where t.tablecode='perf_t_customauditview';
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('perf_t_customauditview', 'guid', null, null, null, 1);

--合肥监控导入配置
update perf_t_imptemp t set t.c8='deviationanalysis' where t.temptype='hfxmzczdjkmb' and datatype='index';
update perf_t_imptemp t set t.c8='deviationanalysis' where t.temptype='hfbmztjkmb' and datatype='index';



--绩效监控查询左侧页签
delete from perf_t_treetab t where t.key='/pmkpi/program/trace/query';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439B3375E0533315A8C0E105', '/pmkpi/program/trace/query', 'depttrace', '部门整体', 1, '一般监控导出（合肥）,项目监控导出(广西)', 2, '2016', '87', null, 'depttracequeryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439C3375E0533315A8C0E105', '/pmkpi/program/trace/query', 'protrace', '项目支出', 1, '部门监控导出(广西)', 1, '2016', '87', null, 'protracequeryhide');



--监控填报 绩效指标完成情况页面 完成可能性字段 数据源注册到分区表
delete from  perf_enum where elementcode ='completeanalysis';
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('completeanalysis1', '1', 'completeanalysis', '确定能', '1', null, '20210622160242', '2016', '87', null, 'pmkpi', '0', 1, 0, null, '1', 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('completeanalysis2', '2', 'completeanalysis', '有可能', '1', null, '20210622160242', '2016', '87', null, 'pmkpi', '0', 1, 0, null, '1', 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('completeanalysis3', '3', 'completeanalysis', '完全不可能', '1', null, '20210622160242', '2016', '87', null, 'pmkpi', '0', 1, 0, null, '1', 3);

--数据源 来源改为查分区表
delete from fasp_t_dicdssource where guid ='PMKPICOMPLETEANALYSIS';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICOMPLETEANALYSIS', 'PMKPICOMPLETEANALYSIS', 'PMKPICOMPLETEANALYSIS', '绩效监控完成可行性分析', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from v_perf_enum t where t.elementcode=''completeanalysis'' order by ordernum', null, 1, 'pmkpi');
