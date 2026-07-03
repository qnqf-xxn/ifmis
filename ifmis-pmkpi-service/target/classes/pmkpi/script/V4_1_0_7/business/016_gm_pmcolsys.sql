begin
  update bus_t_diccolumn t set t.issys = 0 where t.TABLECODE = 'PM_PERF_INDICATOR' and t.columncode in ('NAME','COMPUTESIGN','INDEXVAL','METERUNIT','LV1_PERF_IND_CODE','LV2_PERF_IND_CODE','LV3_PERF_IND_CODE');
