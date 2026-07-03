begin

delete from fasp_t_dicdssource t where t.guid='INDEXTRANPAY';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXTRANPAY', 'INDEXTRANPAY', 'INDEXTRANPAY', '财政转移支付', '1', '20140422000000000', '20150423', null, '2022', '87', null, '8717', '1', '2', 'select * from v_perf_enum where elementcode = ''INDEXTRANPAY'' order by ordernum', null, 1, 'pmkpi');
