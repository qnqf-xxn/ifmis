begin

--update p#busfw_t_uicolumn t set t.coltype=1 where not (t.name like'%操作%' or t.name like'%附件%') and key in(select substr(a.url,1,instr(a.url,'.page',-1,1)-1) from fasp_t_pubmenu a where a.appid='pmkpi' and a.url<>'#');

update p#busfw_t_uicolumn t set t.coltype=1 where t.key like'/pmkpi/%' and not (t.name like'%操作%' or t.name like'%附件%');