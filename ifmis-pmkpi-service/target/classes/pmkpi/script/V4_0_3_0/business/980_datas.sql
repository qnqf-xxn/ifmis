begin

--新建层次分类数据源，查87,2016数据
delete from fasp_t_dicdssource t where t.elementcode='PMKPIINDEXFRAME'; 
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIINDEXFRAME', 'PMKPIINDEXFRAME', 'PMKPIINDEXFRAME', '指标库指标体系', '1', '20190508135902672', '20161208', null, '2016', '87', null, null, null, '2', 'select t.guid,code,name ,t.superid superguid,t.levelno levelno,t.isleaf isleaf,t.status,t.frametype from v_perf_t_indexframe t', sysdate, 1, 'pmkpi');



--系统参数
delete from  Perf_t_Systemset t where t.paramcode = 'HUBEITRACEINDEX';
insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('3AD203710E57FC5EC5E40CC1DC255796', 'HUBEITRACEINDEX', '需要监控的指标层级code', '{"frame":""}', '如只监控产出指标,则配置产出指标的code', 'pmkpi', 40, 2016, '87', 1);

delete from  perf_t_systemset t where t.paramcode = 'PILOT_DEPTS';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DA61946DCA0D101EE0533315A8C0D73D', 'PILOT_DEPTS', '湖北-试点部门', '{"agencys":""}', '试点部门', 'pmkpi', 36, 2016, '87', 1);



