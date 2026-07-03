begin
delete FROM Perf_t_Systemset t where t.paramcode = 'proendtolib' and t.province = '87' and t.year = 2016;
insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('02A017157C15696BE0630A64A8C050F7', 'proendtolib', '项目库申报与调整终审，年度绩效新增入库指标部门指标库终审。', '2', '1启用，2不启用', 'pmkpi', 23, 2016, '87', 1);
