begin
  
update p#busfw_t_uieditform t set t.isedit=0 where t.columncode='AUDITSQL';

update p#busfw_t_uieditform t set t.isvisiable=0 where t.key='/pmkpi/auditdefine/viewedit' and t.columncode in('ISALLTABLE','RECORDADOPT');
