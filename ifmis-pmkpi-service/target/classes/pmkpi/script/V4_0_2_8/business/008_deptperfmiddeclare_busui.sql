begin

--年中追加项目列表增加 设立年度
delete from busfw_t_uicolumn where key = '/pmkpi/midprogram/report/list' and columncode = 'SETUP_YEAR';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'SETUP_YEAR', '设立年度', 5, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
