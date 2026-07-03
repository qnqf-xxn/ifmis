begin

update busfw_t_uifunction t set title='删除菜单' where key='/pmkpi/busauditdefine/index' and action='busauditdefine.delmenu';
  
update busfw_t_uifunction t set title='修改菜单' where key='/pmkpi/busauditdefine/index' and action='busauditdefine.modmenu';
  
update busfw_t_uifunction t set title='新增菜单' where key='/pmkpi/busauditdefine/index' and action='busauditdefine.addmenu';
  
