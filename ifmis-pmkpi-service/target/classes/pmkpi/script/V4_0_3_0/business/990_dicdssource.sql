begin

delete from fasp_t_dicdssource t where t.elementcode='PMKPIDEPT';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIDEPT', 'PMKPIDEPT', 'PMKPIDEPT', '≤ø√≈', '1', '20180613113621631', '20180101', null, '2016', '87', null, '201901', '1', '2', 'select * from PMKPI_FASP_T_PUBAGENCY where isleaf = 0 and length(guid)=3  order by code', sysdate, 1, 'pmkpi');
