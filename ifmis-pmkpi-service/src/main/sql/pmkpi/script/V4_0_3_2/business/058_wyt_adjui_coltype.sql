begin
 update p#busfw_t_uicolumn set COLTYPE ='0' where key ='/pmkpi/adjust/report/list' and columncode in('PRO_CODE','CODE','PRO_NAME','NAME');