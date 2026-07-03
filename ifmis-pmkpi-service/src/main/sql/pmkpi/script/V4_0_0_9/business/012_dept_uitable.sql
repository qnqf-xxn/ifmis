begin
delete FROM Busfw_t_Uitable t where t.key in 
('/pmkpi/perfselftaskmanage/dept/index','/pmkpi/perfself/apply/dept/index','/pmkpi/perfself/apply/editdept/selfindex');
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('PDF11138AFAD4E739AAEBEAA8435FD8B', '/pmkpi/perfself/apply/dept/index', 'V_PERF_DEPT_SELFEVALTASK', 20, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('BD7BA0A6AFD52370E053B11FA8C01F87', '/pmkpi/perfself/apply/editdept/selfindex', 'V_PERF_T_SELFPERFINDEX', 0, 1, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('BD7A4ADF14BF0AADE053B11FA8C015A7', '/pmkpi/perfselftaskmanage/dept/index', 'V_PERF_V_SELFEVALDEPT', 20, 0, 0, null, null, 'pmkpi', null, '87', '2016');
