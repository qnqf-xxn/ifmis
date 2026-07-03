begin
  --枚举表字段改为数据类型
delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/perfenumset' and columncode in('ISLEAF','STATUS');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323C1274CE0533315A8C0ACDD', '/pmkpi/setting/perfenumset', 'ISLEAF', '是否末节点', 9, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323C7274CE0533315A8C0ACDD', '/pmkpi/setting/perfenumset', 'STATUS', '状态', 7, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

--表注册字段 注册数据源
delete from bus_t_diccolumn where tablecode ='PERF_ENUM' and  columncode in('ISLEAF','STATUS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '1', 'ISLEAF', '1', '2016', '87', '0FEE6547AF9641769B3051C8F0C7676D', 'ISLEAF', 'PERF_ENUM', '是否末节点', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '1', 'STATUS', '1', '2016', '87', 'D0FDDACB668F4AFF8E4EEECC96A2A05', 'STATUS', 'PERF_ENUM', '状态', 'S', '1', null, 1, 1, null, sysdate);


--枚举表增加 复制 按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/setting/perfenumset' and name ='复制';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/setting/perfenumset', '复制', 1, 3, 'Keepicon', 'tempdataset.copydatas', null, '复制', 'pmkpi', null, null, null);
