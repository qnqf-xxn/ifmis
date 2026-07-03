begin
delete from busfw_t_uicolumn where key = '/pmkpi/setting/modelinfo/index' and columncode in ('EXPLAIN','KPI_REMARK');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('483F801BB3553559E5ADC34BE8766001', '/pmkpi/setting/modelinfo/index', 'EXPLAIN', '参考指标值', 5, 0, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8E40ED673D2971A101749DABE27736F', '/pmkpi/setting/modelinfo/index', 'KPI_REMARK', '备注', 7, 0, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
