begin

--部门绩效申报审核
update p#busfw_t_uitable t set t.tablecode='V_PERF_T_DEPTPERFDECLARE' where t.key in('/pmkpi/deptperformance/audit/index');
--部门绩效申报填报
update p#busfw_t_uitable t set t.tablecode='V_PERF_T_DEPTPERFDECLARE' where t.key in('/pmkpi/deptperformance/report/index');

