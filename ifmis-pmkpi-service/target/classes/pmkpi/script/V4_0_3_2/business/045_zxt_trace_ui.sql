begin 

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report' and COLUMNCODE = 'AUDITTYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR, PROVINCE)
values ('BF5EDC3A1D83A028E053B11FA8C0F7AA', '/pmkpi/program/trace/report', 'AUDITTYPE', '审核结论', 20, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null,2016,87);

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/query' and COLUMNCODE = 'AUDITTYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR, PROVINCE)
values ('BF5EDC3A1D83A028E053B11FA8C0F7BB', '/pmkpi/program/trace/query', 'AUDITTYPE', '审核结论', 20, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null,2016,87);

delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report' and COLUMNCODE = 'AUDITTYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR, PROVINCE)
values ('BF5EDC3A1D83A028E053B11FA8C0F7CC', '/pmkpi/program/trace/report', 'AUDITTYPE', '审核结论', 20, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null,2016,87);

delete FROM BUS_t_DICCOLUMN WHERE TABLECODE = 'PERF_V_PROMONITOR' AND DBCOLUMNCODE = 'AUDITTYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'AUDITTYPE_ZJ', null, '1', 'AUDITTYPE', '1', '2020', '87', 'B73465ACA41840FCE0530100007F91AA', 'AUDITTYPE', 'PERF_V_PROMONITOR', '审核结论', 'S', '40', null, 1, 1, null, sysdate);

delete from fasp_t_dicdssource t where t.CODE='AUDITTYPE_ZJ';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('AUDITTYPE_ZJ', 'AUDITTYPE_ZJ', 'AUDITTYPE_ZJ', '浙江审核结论', '1', null, null, null, '2016', '87', null, null, null, '2', 'select guid,guid as code,name from perf_t_datasource where elementcode = ''perfconreview'' order by ordernum', null, 1, 'pmkpi');
