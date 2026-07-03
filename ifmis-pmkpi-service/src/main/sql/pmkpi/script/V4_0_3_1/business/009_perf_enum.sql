begin
  --枚举表字段名
delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/perfenumset' and columncode ='STATUS';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/perfenumset', 'STATUS', '是否启用', 7, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

