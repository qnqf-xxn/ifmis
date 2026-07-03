begin
update CFS_LT_ELEMENT e set e.value_ref = 'VD00001' WHERE e.lt_ele_code = 'BE09103';
update Bus_t_Diccolumn t set t.csid = 'VD00001' where t.tablecode = 'BAS_PERF_INDICATOR' and t.columncode = 'IS_COMMON_IND';