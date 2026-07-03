begin

delete from fasp_t_dicdssource where code = 'PMKPIZBXS';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, VERSION, APPID)
values ('PMKPIZBXS', 'PMKPIZBXS', 'PMKPIZBXS', '计算符号', '1', '20180424221721795', '20180424', null, '2019', '653100', null, null, null, '1', '[{guid:"1",code:"1",name:"≥"},{guid:"2",code:"2",name:"＞"},{guid:"3",code:"3",name:"＝"},{guid:"4",code:"4",name:"＜"},{guid:"5",code:"5",name:"≤"},{guid:"6",code:"6",name:"定性"}]', 1, 'pmkpi');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/deptperformance/report/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'pmkpi_tabfreamlist', '{}', 'tabfreamlist', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/deptperformance/report/edit'',deltables:[perf_t_deptfunction,v_bgt_perf_indicator],repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
