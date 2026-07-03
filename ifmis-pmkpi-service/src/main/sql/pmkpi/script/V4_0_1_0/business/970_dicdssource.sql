begin

DELETE FROM Fasp_t_Dicdssource t where t.guid in ('PMKPIFRAMESYSTEM');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIFRAMESYSTEM', 'PMKPIFRAMESYSTEM', 'PMKPIFRAMESYSTEM', '绩效指标体系', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '2', 'select t.guid,code,name ,''00'' superguid,1 levelno,1 isleaf,t.status from v_perf_t_framesystem t', sysdate, 1, 'pmkpi');


delete from fasp_t_dicdssource where  guid  in ('EXPDOCMAINEXPTYPE','EXPDOCSUBQUERYTYPE','ISZIP');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EXPDOCMAINEXPTYPE', 'EXPDOCMAINEXPTYPE', 'EXPDOCMAINEXPTYPE', '导出类型', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"xls",code:"xls",name:"xls"},{guid:"doc",code:"doc",name:"doc"}]', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('EXPDOCSUBQUERYTYPE', 'EXPDOCSUBQUERYTYPE', 'EXPDOCSUBQUERYTYPE', '查询类型', '1', '20210901113621631', '20150901', null, '2021', '87', null, null, null, '1', '[{guid:"1",code:"1",name:"sql语句"},{guid:"2",code:"2",name:"存储过程"}]', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISZIP', 'ISZIP', 'ISZIP', '是否可压缩', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"否"},{guid:"1",code:"1",name:"是"}]', null, 1, 'pmkpi');


