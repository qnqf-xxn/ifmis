begin
  
update busfw_t_Uitabpage t set t.isvisiable=0 where t.key='/pmkpi/adjust/report/proedit' and t.code='bugamt';
