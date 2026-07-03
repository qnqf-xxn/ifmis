begin
  
update p#busfw_t_uicolumn t set t.requirement=1 where t.key in('/pmkpi/program/trace/report/edit/indextarget') and t.columncode='INDEXVAL';
