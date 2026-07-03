BEGIN

delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/edit/bdgpay' and COLUMNCODE in ('AMT6','BGTGET');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/edit/bdgpay', 'AMT6', '全年执行数(其他)(元)', 6, 1, 1, 1, null, 0, null, null, null, null, null, 150, 0, 'amt', '{}', null, '87','2016');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/apply/edit/bdgpay', 'BGTGET', '预算执行率%', 7, 1, 0, 1, null, 0, null, null, null, null, null, 150, 0, 'f', '{}', null, '87','2016');
