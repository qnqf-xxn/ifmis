begin

--定时任务配置
delete from fw_t_jobdetail t where appid='pmkpi' and t.jobid='pmkpi.SyncDataTimeTask';
insert into fw_t_jobdetail (JOBID, JOBNAME, CRONEXPRESSION, JOBCLASS, PROVINCE, YEAR, ENABLE, APPID, REMARK)
values ('pmkpi.SyncDataTimeTask', '同步预算资金落地定时任务', '0 */30 0-23 * * ? *', 'gov.mof.fasp2.pmkpi.syncdata.SyncDataTimeTask#syncBdmDatas', null, null, '0', 'pmkpi', '默认每30分钟执行一次');

--评价领域数据源
delete from fasp_t_dicdssource where code = 'EVALUATEAREA';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EVALUATEAREA', 'EVALUATEAREA', 'EVALUATEAREA', '评价领域', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''EVALUATEAREA'' order by t.ordernum', null, null, 'pmkpi');


delete from perf_enum where elementcode = 'EVALUATEAREA';
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEAREA01', '01', 'EVALUATEAREA', '政府投资基金', '1', '20230330140928', '20230330140928', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEAREA02', '02', 'EVALUATEAREA', '政府和社会资本合作(PPP)', '1', '20230330140928', '20230330140928', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEAREA03', '03', 'EVALUATEAREA', '政府采购', '1', '20230330140928', '20230330140928', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 3);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEAREA04', '04', 'EVALUATEAREA', '政府购买服务', '1', '20230330140928', '20230330140928', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 4);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EVALUATEAREA05', '05', 'EVALUATEAREA', '政府债务项目', '1', '20230330140928', '20230330140928', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 5);



--一级项目编码数据源注册
delete from fasp_t_dicdssource where guid ='PMKPIPROLEVONECODE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPROLEVONECODE', 'PMKPIPROLEVONECODE', 'PMKPIPROLEVONECODE', '一级项目编码', '1', '20230404180100000', '20230404180100000', null, '2016', '87', null, null, null, '2', 'select pro_code as guid,pro_code as code,pro_name as name from v_perf_project_info t where t.PRO_LEV =''1''', sysdate, 1, 'pmkpi');

delete from fasp_t_dicdssource t where t.guid='PERFNAME';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFNAME', 'NAME', 'NAME', '专家名称', '1', null, null, null, '2021', '87', null, null, null, '2', 'select (t.guid||''#''||t.CODE) as guid,code ,NAME as name,STATUS from FASP_T_CAUSER t  order by t.ordernum', null, null, 'pmkpi');
