begin

-- 去掉页面配置的分页
update P#BUSFW_T_UItable set pagenum = null where key in('/pmkpi/set/uiqueryformcols/edit','/pmkpi/set/uitabcols/edit','/pmkpi/set/uieditformcols/edit','/pmkpi/set/uidatatablecols/edit','/pmkpi/set/uifunctioncols/edit');
