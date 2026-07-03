begin

DELETE FROM Fasp_t_Dicdssource t WHERE t.guid='PMKPITRACETASK';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPITRACETASK', 'PMKPITRACETASK', 'PMKPITRACETASK', '¼¨Ð§¼à¿ØÈÎÎñ', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '2', 'select t.guid,t.guid code,name ,''00'' superguid,1 levelno,1 isleaf,t.status from v_Perf_t_Taskset t', sysdate, 1, 'pmkpi');
