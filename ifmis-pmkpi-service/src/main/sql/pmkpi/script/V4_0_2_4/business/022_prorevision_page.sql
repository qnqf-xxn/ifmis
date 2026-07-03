begin

--绩效目标修订填报--选择项目--总体目标条件改为年度目标条件
--页面配置
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/prorevision/report/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'pmkpi_revisionreportcheck', '{}', 'revisionreportcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

