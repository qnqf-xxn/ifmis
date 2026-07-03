begin
  
--删除多余的组件权限页面配置
delete from bus_t_pageconsole t where t.url='/pmkpi/perfset/component';
delete from bus_t_pageconsolecomconfig t where t.url='/pmkpi/perfset/component';
delete from bus_t_pagecomponent where id ='pmkpi_component';