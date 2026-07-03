begin
  
update p#busfw_t_uifunction t set t.config='{protempatecode:''ahxmzczpmb'',depttempatecode:''ahbmztzpmb'',proexptype:''ahprogram'',deptexptype:''ahdept'',viewtype:''query''}' where t.key='/pmkpi/perfself/query/index' and t.code='expdoc' and t.config like'%ahxmzczpmb%';
