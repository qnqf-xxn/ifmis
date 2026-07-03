begin
  
delete from fasp_t_dicdssource where guid = 'RANDOMGRADE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('RANDOMGRADE', 'RANDOMGRADE', 'RANDOMGRADE', '抽评等级', '1', '20140422000000000', '20140422000000000', null, '2016', '87', null, null, '1', '2', 'select * from v_perf_enum where elementcode = ''RANDOMGRADE'' order by ordernum', null, 1, 'pmkpi');

delete from perf_enum where elementcode = 'RANDOMGRADE';
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('0E1A78514C98930DBCAD1B9A81FA733A', '4', 'RANDOMGRADE', '差', '1', '20210118162733', '20231031172948', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 4);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('7A648FCEC6D2785210FC70CB0F0144A3', '3', 'RANDOMGRADE', '中', '1', '20210118162733', '20231031172948', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 3);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FCF7F8ADE9A8DF9976088987447F8D56', '2', 'RANDOMGRADE', '良', '1', '20210118162733', '20231031172948', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('EE3F8AA3DA6E8856C167CE3CC93B46EE', '1', 'RANDOMGRADE', '优', '1', '20210118162733', '20231031172948', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 1);

delete from perf_t_systemset t where t.paramcode in('tlprogram_lefttree_1','tlprogram_lefttree_2','tlprogram_lefttree_3');
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('0CD4D6FFB39D213CE0630A64A8C00A88', 'tlprogram_lefttree_1', '项目左侧树数据源', 'PMKPIAGENCYALLPAY', '数据源', 'pmkpi', 1, 2016, '87', 1);

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('0CD4D6FFB39E213CE0630A64A8C00A88', 'tlprogram_lefttree_2', '项目左侧树数据源', 'PMKPIAGENCYALLPAY', '数据源', 'pmkpi', 1, 2016, '87', 1);

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('0CD4D6FFB39F213CE0630A64A8C00A88', 'tlprogram_lefttree_3', '项目左侧树数据源', 'PMKPIAGENCYALLPAY', '数据源', 'pmkpi', 1, 2016, '87', 1);

delete from perf_t_systemset where paramcode ='isNoticeOA';

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DB66CF8R342E5F9FE0533315A8C016E8', 'isNoticeOA', '是否更新通知OA参数', '0', '1是否其他否"', 'pmkpi', 99, 2016, '87', 1);
