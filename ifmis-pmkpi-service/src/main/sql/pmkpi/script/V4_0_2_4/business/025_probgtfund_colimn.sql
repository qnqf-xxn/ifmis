begin 
  --bug: 监控阶段填报页签  没有合计行
delete from p#busfw_t_uitable where key ='/pmkpi/trace/report/deptedit/warn/fund';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B97DC9E424938618E053B11FA8C06469', '/pmkpi/trace/report/deptedit/warn/fund', 'V_PERF_T_PROBGTFUND', 0, 1, 0, null, null, 'pmkpi', null);
 
delete from p#busfw_t_uicolumn where key ='/pmkpi/trace/report/deptedit/warn/fund';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32688274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'NAME', '资金来源', 1, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32689274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT1', '年初预算', 3, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3268A274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT2', '年度预算调整', 5, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3268B274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT3', '调整后的预算', 6, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3268C274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT4', '累计支出', 7, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3268D274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'BGTGET', '预算执行率%', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3268E274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'AMT5', '项目指标结余', 10, 1, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3268F274CE0533315A8C0ACDD', '/pmkpi/trace/report/deptedit/warn/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D7B638A6A8567F18E0533315A8C0556A', '/pmkpi/trace/report/deptedit/warn/fund', 'AGENCY_NAME', '单位名称', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D7B638A6A85E7F18E0533315A8C0556A', '/pmkpi/trace/report/deptedit/warn/fund', 'PRO_NAME', '项目名称', 1, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);


-- 表字段  agency_name、 pro_name
delete from bus_t_diccolumn where TABLECODE = 'PERF_T_PROBGTFUND' and COLUMNCODE in('AGENCY_NAME','PRO_NAME');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'AGENCY_NAME', '1', '2020', '87', 'D7B638A6A8587F18E0533315A8C0556A', 'AGENCY_NAME', 'PERF_T_PROBGTFUND', '单位名称', 'S', '200', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_NAME', '1', '2020', '87', 'D7B638A6A85F7F18E0533315A8C0556A', 'PRO_NAME', 'PERF_T_PROBGTFUND', '项目名称', 'S', '200', null, 1, 1, null, sysdate);


