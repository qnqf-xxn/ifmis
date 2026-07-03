begin
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/report/proindex','/pmkpi/program/report/progoal');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'pmkpi_tlproindex', '{}', 'pmkpitlproindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:false,radio:true,title:''年度绩效指标'',indextable:''v_pm_perf_indicator'',nextSibling:false,nogroupbox:true}', 'indexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'pmkpi_tlprogoal', '{}', 'pmkpitlproindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'busuidatatable', '{key:''/pmkpi/program/report/proindex'',headsort:false,addrow:false,nogroupbox:false,name:''绩效指标表'',edit:true,checkbox:false,radio:true,title:''绩效指标表'',indextable:''v_pm_perf_indicator'',nextSibling:false,nogroupbox:true}', 'indexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'bustoolbutton', '{key:''/pmkpi/program/report/proindex''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'buseditform', '{key:''/pmkpi/program/report/proindex''}', 'editform', 'pmkpi', null);

