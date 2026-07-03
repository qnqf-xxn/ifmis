begin
  
delete from p#busfw_t_uitable where key = '/pmkpi/setting/tempdataset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B84E9D5606117E4AE0530100007F3871', '/pmkpi/setting/tempdataset', 'V_PERF_T_EVALUATETEMP', 0, 0, 0, null, null, 'pmkpi', null);
