begin
  update bus_T_diccolumn t set t.csid = '099003' where t.tablecode = 'PERF_T_DEPTPERFMIDDECLARE' and t.columncode = 'FININTORGGUID';
  delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/midprogram/report/list' and t.code = 'query';
  delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/midprogram/query/list' and t.code = 'query';
  delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/midprogram/report/audit' and t.code = 'query';
  delete FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/midprogram/report/audit' and t.code = 'auditinfo';