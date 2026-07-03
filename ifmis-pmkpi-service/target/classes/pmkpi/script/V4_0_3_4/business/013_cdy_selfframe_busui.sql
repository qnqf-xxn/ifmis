begin

update p#busfw_t_uitable t set t.tablecode='V_PERF_T_SELFFRAME' where t.key in('/pmkpi/curingindex/index');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/curingindex/index') and t.columncode in('ORDERNUM','FRAMETYPE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/curingindex/index', 'ORDERNUM', '排序', 6, 1, 1, 0, null, 1, 1, null, null, null, null, 50, 0, 'i', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/curingindex/index', 'FRAMETYPE', '指标类型', 15, 1, 1, 0, null, 1, 1, null, '#name', null, null, 80, 1, 'tree', null, null);
