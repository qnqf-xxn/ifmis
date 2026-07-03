begin
  
update p#busfw_t_uicolumn t set t.issource=0, t.format=null where t.type<>'tree' and t.key like'/pmkpi/%' and t.issource=1;

update p#busfw_t_uicolumn t set t.type='amt' where t.key in('/pmkpi/seeting/evaluation/report') and t.columncode='PRO_TOTAL_AMT';