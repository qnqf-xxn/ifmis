begin

update p#busfw_t_uiqueryform t set t.columncode='NAME' where t.key in('/pmkpi/adjust/report/program') and t.columncode='PRO_NAME';
