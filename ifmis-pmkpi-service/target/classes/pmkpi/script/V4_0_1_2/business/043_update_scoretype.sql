begin 
  

UPDATE p#Busfw_t_Uicolumn t set t.type='f' where t.key='/pmkpi/workevaluate/report/deptedit/score' and t.columncode in ('SELFSCORE','RATISCORE','SCORE');
UPDATE p#Busfw_t_Uicolumn t set t.type='f' where t.key='/pmkpi/evaluation/financial/deptfill/score' and t.columncode in ('SELFSCORE','SCORE');
 
