BEGIN

delete from bus_t_diccolumn where tablecode = 'PERF_T_ADJUSTGOAL' and COLUMNCODE = 'ADJREASON' ;

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ADJREASON', null, '1', 'ADJREASON', '1', '2016', '87', 'AD8C08620B20297PPP53B11FA8C0125A', 'ADJREASON', 'PERF_T_ADJUSTGOAL', '调整原因', 'S', '40', null, null, 1, null, sysdate);


delete from fasp_T_dicdssource where code = 'ADJREASON' ;

insert into fasp_T_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ADJREASON', 'ADJREASON', 'ADJREASON', '调整原因', '1', null, null, null, '2016', '87', null, null, null, '2', 'select * from v_perf_enum t where t.elementcode=''ADJREASON'' order by t.ordernum', null, null, 'pmkpi');


delete from perf_enum t where t.elementcode='ADJREASON' ;

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('ADJREASON01', '1', 'ADJREASON', '预算调整调剂', '1', '20260615172948', '20260615172948', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('ADJREASON02', '2', 'ADJREASON', '政策规定调整', '1', '20260615172948', '20260615172948', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 2);
