begin
  
delete from p#busfw_t_uieditform where columncode = 'BUSI_TYPE_CODE' and key like '%/pmkpi%';
delete from p#busfw_t_uieditform t where t.key like'/pmkpi/%' and t.columncode='SUB_MOF_CODE';
update p#busfw_t_uicolumn t set t.columncode='findex' where t.columncode='KPI_LV1' and t.key like'/pmkpi/%';