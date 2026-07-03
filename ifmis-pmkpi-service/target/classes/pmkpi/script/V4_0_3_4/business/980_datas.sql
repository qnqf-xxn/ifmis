begin

--是否校验自评指标权重大于0
delete from perf_t_systemset where paramcode='isCheckWeightGtZero';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('F25A54AAAD023A61E0533315A8C08A83', 'isCheckWeightGtZero', '是否校验自评指标权重大于0', '1', '1-是，0-否；', 'pmkpi', 35, 2016, '87', 1);

--监控指标规则
delete from perf_t_warnset t where t.type='traceindexequalzero';
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE, STATUS)
values ('F25CA4F01E136DB8E0533315A8C0D31D', 'traceequalzero', '监控正向指标年度指标值等于0', 'traceindexequalzero', 'select case when #indexval#=#targetvalue# then ''green'' else ''red'' end value from dual', null, null, '2016', '87', '1');
--自评指标规则
delete from perf_t_warnset t where t.type='selfindexequalzero';
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE, STATUS)
values ('F299F8B2646C2330E0533315A8C042D1', 'selfindexequalzero', '自评价正向指标年度指标值等于0', 'selfindexequalzero', 'select case when #actualvalue#<0 or #actualvalue#=0 then #weight# else 0 end value from dual', null, null, '2016', '87', '1');

--添加安徽系统参数
delete from perf_t_systemset t where t.paramcode='IS_ANHUI';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('F3A0532DEF690B68E0533315A8C0A59D', 'IS_ANHUI', '判断是否是安徽模式', '0', '1是其他否，默认为否', 'pmkpi', 16, 2016, '87', 1);