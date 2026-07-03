begin

delete from p#busfw_t_uitable where key = '/pmkpi/deptoverallmerit/audit/edit/deptscore';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'PERF_V_DEPTEVALSECORE', 0, 1, 0, null, null, 'pmkpi', null);
