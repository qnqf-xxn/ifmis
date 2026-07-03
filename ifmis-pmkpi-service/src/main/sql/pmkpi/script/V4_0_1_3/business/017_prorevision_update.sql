begin

update bus_t_diccolumn t set t.csid = '099003',t.deid='DE03026' where t.COLUMNCODE = 'FININTORGGUID' and t.TABLECODE = 'PERF_T_PROVISIONDECLARE';
