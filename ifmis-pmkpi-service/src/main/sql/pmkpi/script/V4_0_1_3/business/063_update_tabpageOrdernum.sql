begin
update p#busfw_t_uitabpage t set t.ordernum = '1' where key='/pmkpi/evaluation/financial/deptfill/deptedit' and t.componentid = 'infoeditform'; 
update p#busfw_t_uitabpage t set t.ordernum = '0' where key='/pmkpi/evaluation/financial/deptfill/deptedit' and t.componentid = 'manceiframe' and title = '项目资料'; 
update p#busfw_t_uitabpage t set t.ordernum = '2' where key='/pmkpi/evaluation/financial/deptfill/deptedit' and t.componentid = 'proscoreiframe'; 
update p#busfw_t_uitabpage t set t.ordernum = '3' where key='/pmkpi/evaluation/financial/deptfill/deptedit' and t.componentid = 'manceiframe'and title = '附件上传'; 
  

