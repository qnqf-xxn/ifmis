  i number;
begin

--财政评价管理-预算部门自评-部门评分表key修改
update p#busfw_t_uitabpage set config = '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page'',action:''deptfillscore.save''}' where key = '/pmkpi/evaluation/financial/deptfill/deptedit' and code = 'info' and componentid = 'proscoreiframe';
