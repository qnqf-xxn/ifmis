begin

update p#busfw_t_uieditform t set t.fromsource=0 ,t.bottomcontrl=1 where t.key='/pmkpi/indexlib/edit' and t.columncode='SINDEX';
