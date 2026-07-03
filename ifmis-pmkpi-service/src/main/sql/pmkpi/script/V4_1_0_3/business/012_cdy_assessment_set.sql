begin
  
update p#busfw_t_uitable t set t.tablecode='V_PERF_T_ASSESSMENTTEMP' , t.orderby='order by bustype,ordernum' where t.key in('/pmkpi/setting/assessment/list');

delete p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/assessment/list') and t.columncode in('BUSTYPE','ORDERNUM');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/assessment/list', 'BUSTYPE', '¿‡–Õ', 5, 1, 1, 0, null, 0, 1, null, null, null, null, 500, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/assessment/list', 'ORDERNUM', '≈≈–Ú', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 500, 0, 's', null, null);
