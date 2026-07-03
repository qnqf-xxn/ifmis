begin

--项目支出
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/trace/report/edit/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'pmkpi_protraceinfo', '{}', 'protraceinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''项目基础信息'',tablecode:''v_perf_project_info''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'buseditform', '{tablecode:''v_perf_t_promonitor''}', 'traceeditform', 'pmkpi', null);


update p#busfw_t_uieditform t set t.isvisiable=0 where t.key in('/pmkpi/program/trace/report/edit/info');


--部门整体
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/trace/report/deptedit/info');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'pmkpi_protraceinfo', '{}', 'protraceinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''部门项目信息'',tablecode:''v_perf_t_deptperfdeclare''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'buseditform', '{}', 'traceeditform', 'pmkpi', null);

update p#busfw_t_uieditform t set t.isvisiable=0 where t.key in('/pmkpi/trace/report/deptedit/info');
