begin
  
update p#busfw_t_uieditform t set t.defaultvalue= null where t.key in('/pmkpi/program/prjindex/editindex') and t.columncode='SUB_MOF_CODE';
