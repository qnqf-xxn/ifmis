begin
  
delete FROM Fasp_t_Dicdssource t where t.guid in ('INDEXIMPORT');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXIMPORT', 'INDEXIMPORT', 'INDEXIMPORT', '指标重要性', '1', '20180613113621631', '20180101', null, '2016', '109900000', null, '200600', '1', '1', '[{guid:"1",code:"1",name:"一类"},{guid:"2",code:"2",name:"二类"}]', null, 1, 'pmkpi');
