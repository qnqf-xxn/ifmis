begin
delete FROM Perf_t_Systemset t where t.paramcode = 'finagivelev';
insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DC94F3E42ACF5560E0533315A8C0BC00', 'finagivelev', '财政个性指标默认二级如果是一级设置此参数', '2', '1、一级 其他：二级', 'pmkpi', 77, 2016, '87', 1);
