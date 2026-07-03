begin

update p#busfw_t_uicolumn t set t.isvisiable=0 where t.key like'/pmkpi/%' and t.columncode='YEAR';
