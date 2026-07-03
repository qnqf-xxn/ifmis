BEGIN

UPDATE P#busfw_t_uitable SET TABLECODE = 'V_PERF_PROJECT_INFOASSESS' where key ='/pmkpi/assess/query';

delete from P#busfw_t_uicolumn t where key ='/pmkpi/assess/query' AND COLUMNCODE IN ('GUID','AGENCYGUID');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/assess/query', 'GUID', 'GUID', 15, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/assess/query', 'AGENCYGUID', 'µ¥Î»', 16, 0, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null,'2016','87');
