begin

delete from Perf_t_Systemset t where t.paramcode = 'isGD_PMKPI' and t.province = '87';

insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('0136E87CC48E7E0FE0633315A8C0758B', 'isGD_PMKPI', '债券绩效同步终审开关', '0', '0关闭1启用', 'pmkpi', 66, 2016, '87', 1);
