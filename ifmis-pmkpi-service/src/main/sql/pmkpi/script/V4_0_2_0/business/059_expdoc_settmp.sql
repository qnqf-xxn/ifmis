begin
--导出模板表注册到刷新分区同步
delete from bus_t_settmp t where t.tablecode='V_PERF_T_EXPDOCMAIN';
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_EXPDOCMAIN', 'guid', '', '', '', 1);
delete from bus_t_settmp t where t.tablecode='V_PERF_T_EXPDOCSUB';
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_EXPDOCSUB', 'guid', '', '', '', 1);











