begin
-- 审核定义业务配置 选择审核定义的数据源分年度区划
delete from fasp_t_dicdssource where guid ='VIEWCODE' and code ='VIEWCODE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('VIEWCODE', 'VIEWCODE', 'VIEWCODE', '审核定义视图表', '1', null, null, null, '2016', '87', null, null, '1', '2', 'select t.guid,t.name,t.code,t.status from v_perf_t_customauditview t', sysdate, 1, 'pmkpi');
  

delete from fasp_t_dicdssource a where a.guid in('TRACEAUDITTYPE');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('TRACEAUDITTYPE', 'TRACEAUDITTYPE', 'TRACEAUDITTYPE', '监控审核类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT * FROM perf_t_datasource t where t.elementcode=''traceaudittype'' order by t.ordernum', null, 1, 'pmkpi');
