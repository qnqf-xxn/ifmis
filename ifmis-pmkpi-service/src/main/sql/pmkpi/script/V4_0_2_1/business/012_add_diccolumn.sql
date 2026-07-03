begin
--部门表/项目表字段注册添加 阶段 字段
delete from bus_t_diccolumn where tablecode in ('PERF_T_DEPTPERFDECLARE') and columncode = 'TASKSTAGE';

delete from bus_t_diccolumn where tablecode = 'PERF_PROJECT_INFO' and columncode in('TASKSTAGE','NAME');
