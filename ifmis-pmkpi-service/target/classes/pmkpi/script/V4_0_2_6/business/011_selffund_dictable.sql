begin
  --自评预算执行情况业务表  表注册  
delete from bus_t_dictable where tablecode ='PERF_T_SELFPROFUND';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_SELFPROFUND', '绩效自评预算执行情况', '绩效自评预算执行情况', 1, 1, 'PERF_T_SELFPROFUND', 'pmkpi', null, '0', 1, '0', 1, 1, null, null, 1, 1, null, '1');
