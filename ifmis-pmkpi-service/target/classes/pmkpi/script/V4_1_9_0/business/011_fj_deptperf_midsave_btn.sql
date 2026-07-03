begin

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/deptperformance/report/edit' and code in ('midsave','delmidsave');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/edit', 'ÔÝ´æ', 0, 1, 'Keepicon', 'tabfreamedit.midsave', null, 'ÔÝ´æ', 'pmkpi', 'midsave', null, null,'87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/deptperformance/report/edit', 'Çå³ýÔÝ´æ', 0, 2, 'Keepicon', 'tabfreamedit.delmidsave', null, 'Çå³ýÔÝ´æ', 'pmkpi', 'delmidsave', null, null,'87', '2016');


