begin

delete from perf_t_systemset t where t.paramcode='finproconfirm';

--删除 绩效自评左侧树参数
delete from perf_t_systemset t where t.paramcode='selfquery';

--删除 问题整改左侧树参数
delete from perf_t_systemset t where t.paramcode = 'rectification';