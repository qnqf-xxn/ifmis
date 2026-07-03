begin

--浙江部门整体录入-复制上年指标按钮
delete from bus_t_pageconsole where url = '/pmkpi/deptZJformance/report/edit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptZJformance/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptZJformance.report.DeptPerfPage', 'editindex', '{main:[edittabpage,tabtoolbutton,infoeditform,perfindexdatatable,budgetdatatable,goaleditform,indexprodatatable],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/deptZJformance/report/edit' and id ='tabtoolbutton';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'bustoolbutton', '{key:''/pmkpi/deptZJformance/report/edittab''}', 'tabtoolbutton', 'pmkpi', null);


delete from p#busfw_t_uifunction t where key ='/pmkpi/deptZJformance/report/edittab';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/deptZJformance/report/edittab', '复制上年指标', 1, 1, 'Keepicon', 'pmkpideptZJedit.copyperf', null, '复制上年指标', 'pmkpi', 'copyperf', null, null, null, null);

