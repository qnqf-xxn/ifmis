begin

delete from fasp_T_dicDssource where guid = 'INDEXCOMFUNC_ZJ';

insert into fasp_T_dicDssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXCOMFUNC_ZJ', 'INDEXCOMFUNC_ZJ', 'INDEXCOMFUNC_ZJ', '财政个性行业', '1', '20140422000000000', '20150423', '', '2020', '87', '', '8717', '1', '2', 'select * from v_perf_indexcomfunc', '', 1, 'pmkpi');

delete from fasp_T_dicDssource where guid = 'INDEXCOMFUNC_LEV1';

insert into fasp_T_dicDssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXCOMFUNC_LEV1', 'INDEXCOMFUNC_LEV1', 'INDEXCOMFUNC_LEV1', '财政个性行业-行业大类', '1', '20140422000000000', '20150423', '', '2020', '87', '', '8717', '1', '2', 'select pro_id as guid, pro_code as code, pro_name as name, mof_dep_code as dept,province,agency_code as agencyguid,''1'' as status  from PM_PROJECT_INFO where pro_lev = ''1'' union all select guid,code,name,SUPERGUID dept,province,code as agencyguid,''1'' as status from pmkpi_fasp_t_pubagency PF where pf.status = ''1''', '', 1, 'pmkpi');

delete from fasp_T_dicDssource where guid = 'INDEXCOMFUNC_LEV2';

insert into fasp_T_dicDssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXCOMFUNC_LEV2', 'INDEXCOMFUNC_LEV2', 'INDEXCOMFUNC_LEV2', '财政个性行业-行业类别', '1', '20140422000000000', '20150423', '', '2020', '87', '', '8717', '1', '2', 'select pro_id as guid, pro_code as code, pro_name as name, mof_dep_code as dept,province,agency_code as agencyguid,''1'' as status  from PM_PROJECT_INFO where pro_lev = ''2'' union all select * from PERF_T_INDEXCOMFUNC where status = ''2''', '', 1, 'pmkpi');
