begin

--datatable 来源类型下拉改为文本
delete from p#busfw_t_uicolumn where key = '/pmkpi/set/uidatatablecols/edit' and columncode = 'TYPE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E326C6274CE0533315A8C0ACDD', '/pmkpi/set/uidatatablecols/edit', 'TYPE', '来源类型', 5, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

