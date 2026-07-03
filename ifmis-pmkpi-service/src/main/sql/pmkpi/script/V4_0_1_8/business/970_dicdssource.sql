begin

delete from fasp_t_dicdssource t where t.elementcode='PMKPIPROGRAM';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIPROGRAM', 'PMKPIPROGRAM', 'PMKPIPROGRAM', '绩效项目表', '1', '20201116221721795', '20101116', null, '2016', '87', null, null, null, '2', 'select pro_code guid,pro_code code,pro_name name,1 status from v_perf_project_info ', null, 1, 'pmkpi');
