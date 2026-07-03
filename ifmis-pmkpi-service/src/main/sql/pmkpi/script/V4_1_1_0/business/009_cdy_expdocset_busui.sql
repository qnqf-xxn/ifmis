begin
  
update p#busfw_t_uieditform t set t.isedit=0 where key='/pmkpi/setting/expdoctemp' and t.columncode in('EXPTYPE','TEMPLATECODE');
