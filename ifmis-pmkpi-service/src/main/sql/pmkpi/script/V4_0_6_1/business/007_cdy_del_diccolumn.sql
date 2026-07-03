begin

delete from bus_t_diccolumn where  tablecode ='PERF_V_PROMONITOR' and COLUMNCODE in('ISRECTIFY','RECTIFYEND','TASKNAME');

delete from bus_t_diccolumn t where t.tablecode='PERF_V_PROMONITOR_APPRESULT' and t.columncode='ORDERNO';

delete from bus_t_diccolumn t where t.tablecode='PERF_V_PROMONITOR_APPRESULT' and t.columncode='AGENCYNAME';

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/appresult') and t.columncode='AGENCYNAME';