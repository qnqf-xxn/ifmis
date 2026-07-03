begin

delete from fw_t_sysapp t where t.appid='pmkpi';
insert into fw_t_sysapp (APPID, APPNAME, STATUS, DEVELOPER, DBVERSION, ISBGT, ISCOMMONMENU, DIIDE, ORDERNUM)
values ('pmkpi', '预算绩效管理', null, 'LT', sysdate, 0, null, null, null);

delete from bus_t_diccolumn t where t.TABLECODE='PERF_V_ALLINDEX'; 
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIZBXS', null, '1', 'COMPUTESIGN', '1', '2016', '87', 'BD08A7255C65DB24E053651EA8C01F5B', 'COMPUTESIGN', 'PERF_V_ALLINDEX', '计算符号', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAME', null, '1', 'FINDEX', '1', '2016', '87', 'BD08A7255C63DB24E053651EA8C01F5B', 'FINDEX', 'PERF_V_ALLINDEX', '一级指标', 'S', '30', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAME', null, '1', 'SINDEX', '1', '2016', '87', 'BD08A7255C64DB24E053651EA8C01F5B', 'SINDEX', 'PERF_V_ALLINDEX', '二级指标', 'S', '30', null, 1, 1, null, sysdate);

delete from p#busfw_t_uicolumn t where key='/pmkpi/program/prjindex/recomindex' and t.columncode='ZHBIAO';

delete from p#busfw_t_uicolumn t where t.key='/pmkpi/program/prjindex/recomindex' and t.columncode='ANLI';

delete from p#busfw_t_uicolumn t where t.key='/pmkpi/program/prjindex/recomindex' and t.columncode='TINDEX';

UPDATE p#busfw_t_uifunction t set t.name='指标推荐',t.title='指标推荐' where t.code='recom' and t.key='/pmkpi/program/report/treeindex' and t.guid='B9C5A23C0BFD2C8BE053B11FA8C03A18';
UPDATE p#busfw_t_uifunction t set t.isvisiable='0' where t.code='pick' and t.key='/pmkpi/program/report/treeindex' and t.guid='B9C5A23C0BF92C8BE053B11FA8C03A18';
