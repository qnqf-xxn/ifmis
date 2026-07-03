begin

--增加展示列
delete from p#busfw_t_uicolumn where key = '/pmkpi/set/uitabcols/edit' and columncode in('ISCHECKTAB','CHECKTABLE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/uitabcols/edit', 'ISCHECKTAB', '启用非空校验', 6, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/uitabcols/edit', 'CHECKTABLE', '非空校验表名', 6, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

