begin
delete FROM v_Perf_t_Systemset t where t.paramcode = 'midprowfstatus';

insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('E9B6B4413C5F4FA5E0535164A8C03AA1', 'midprowfstatus', '年中追加项目的终审状态', '011,814,007,008,804,808', '下达指标的时候判断年中追加项目的状态', 'pmkpi', 55, 2016, '87', 1);
