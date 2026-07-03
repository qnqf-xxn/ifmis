begin

delete from fasp_t_dicdssource t where t.guid='PERFCOLOR';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFCOLOR', 'PERFCOLOR', 'PERFCOLOR', 'ÑÕÉ«·­Òë', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"blue",code:"1",name:"À¶"},{guid:"green",code:"2",name:"ÂÌ"},{guid:"yellow",code:"3",name:"»Æ"},{guid:"red",code:"4",name:"ºì"}]', null, null, 'pmkpi');

update bus_t_diccolumn t set t.csid='PERFCOLOR' where t.tablecode in('PERF_V_PROMONITOR','PERF_T_PROMONITOR') and t.columncode in('BGTWARN','GOALWARN');

update p#busfw_t_uicolumn t set t.type='tree', t.issource=1, t.format='#name' where t.key in('/pmkpi/program/trace/report','/pmkpi/program/trace/query') and t.columncode in('BGTWARN','GOALWARN');
