begin

update p#busfw_t_uicolumn t set t.columncode='NAME' where t.key in('/pmkpi/adjust/report/list') and t.columncode='PRO_NAME';
update p#busfw_t_uicolumn t set t.columncode='AGENCYGUID' where t.key in('/pmkpi/adjust/report/list') and t.columncode='CODE';
