begin

--部门整体绩效（试点）
delete from bus_t_pagecomponent where id = 'pmkpi_deptperftest';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptperftest', '湖北部门绩效(试点)', null, '湖北部门绩效(试点)', '/buscommon/fileimport/js/import.js,/pmkpi/deptperformance/deptperfhbtest.js', 'Ext.lt.pmkpi.deptperftest', 'pmkpi', 'pmkpi.deptperformance.deptperftest.DeptPerfHbTestService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/deptperformance/report/deptperftest';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/deptperftest', 'pmkpi_deptperftest', '{}', 'deptperftest', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/deptperftest', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/deptperfgoal'',addrow:false,headsort:false,name:''部门整体绩效目标'',edit:true,checkbox:false,radio:true,title:''部门整体绩效目标'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/deptperftest', 'busuidatatable', '{headsort:false,addrow:false,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/deptperftest', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/deptperformance/report/deptperftest';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/deptperftest', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.deptperftest.DeptPerfHbTestPage', 'index', '{main:[tabpage,maintable,datatable]}', null, null, null);

