begin
delete FROM p#Busfw_t_Uitable t where t.key in 
('/pmkpi/perfselftaskmanage/index','/pmkpi/perfself/apply/index','/pmkpi/perfself/apply/edit/bdgpay','/pmkpi/perfself/apply/edit/selfindex');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD547EED79AC0EABE053B11FA8C0BC8D', '/pmkpi/perfself/apply/edit/bdgpay', 'V_PERF_V_SELFBDGPAY', 0, 1, 0, null, null, 'pmkpi', null);

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('SF60D3C21193BA69E053E100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'V_PERF_T_SELFPERFINDEX', 0, 1, 0, null, null, 'pmkpi', null);

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('P2F11138AFAD4E739AAEBEAA8435FD8B', '/pmkpi/perfself/apply/index', 'V_PERF_V_SELFEVALTASK', 20, 0, 0, null, null, 'pmkpi', '{}');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('P5F11138AFAD4E739AAEBEAA8435FD8B', '/pmkpi/perfselftaskmanage/index', 'V_PERF_V_SELFEVALPROGRAMS', 20, 0, 0, null, null, 'pmkpi', null);

