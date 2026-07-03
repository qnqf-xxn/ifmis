begin

delete from bus_t_pageconsole t where t.URL='/pmkpi/deptperformance/deptperf/recomindex';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.index.DeptIndexPage', 'recomindex', '{header:[tab],main:[queryform,recomtable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.URL='/pmkpi/deptperformance/deptperf/recomindex';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'pmkpi_deptrecomindex', '{}', 'pmkpideptrecomindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'busuidatatable', '{headsort:false,addrow:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'',nogroupbox:true}', 'recomtable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'bustabpage', '{}', 'tab', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''recomtable'',drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/deptperf/recomindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.ID='pmkpi_deptrecomindex';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptrecomindex', '部门指标精准推荐', null, '部门指标精准推荐', '/pmkpi/deptperformance/deptrecoindex.js', 'Ext.lt.pmkpi.deptrecomindexservice', 'pmkpi', 'pmkpi.deptperformance.DeptRecomIndexService');
