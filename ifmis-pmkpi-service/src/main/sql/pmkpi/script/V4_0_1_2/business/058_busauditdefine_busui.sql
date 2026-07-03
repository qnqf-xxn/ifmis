begin

update p#busfw_t_uicolumn t set t.isvisiable=0 where key='/pmkpi/busauditdefine/index' and t.columncode='BUSGUID';

update p#busfw_t_uicolumn t set t.requirement=1 where key='/pmkpi/busauditdefine/index' and t.columncode='AUDITDEFINE';
