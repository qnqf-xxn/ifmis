begin

update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/audit/view') and t.code='save';
