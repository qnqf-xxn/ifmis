begin
  
UPDATE  P#busfw_t_Uitabpage t set t.config='{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A'',action:''thirdauditopinion.save''}' where t.key='/pmkpi/protrace/thirdaudit/opinion' and t.code='opinioninfo';

UPDATE p#Busfw_t_Uieditform t set t.requirement=1 where t.key='/pmkpi/protrace/thirdaudit/opinion';

UPDATE  P#busfw_t_Uitabpage t set t.config='{filebustype=''traceproreport'',url:''/pmkpi/upload/file/index.page?filebustype=traceproreport''}' where t.key='/pmkpi/protrace/thirdaudit/opinion' and t.code='file';
