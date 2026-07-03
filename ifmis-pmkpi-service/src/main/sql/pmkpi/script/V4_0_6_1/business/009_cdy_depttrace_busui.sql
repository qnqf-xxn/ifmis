begin

update p#busfw_t_uicolumn t set t.columncode='AGENCYGUID' where t.key in('/pmkpi/program/trace/manage/deptlistimp','/pmkpi/program/trace/manage/deptlist') and t.columncode='CODE';
