begin

--广西部门整体绩效目标查看改为只读
delete from bus_t_pageconsole t where t.url in('/pmkpi/deptperformance/report/funcd');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptperformance/report/funcd', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.func.DeptFuncPage', 'index', '{main:[toolbutton,datatable]}', null, null, 0);

update p#busfw_t_uitabpage t set t.config='{busguid:''E0902146244E4BB8B33B3225FF34604C'',viewtype:''query''}' where t.key='/pmkpi/perfself/apply/dept/edit' and t.code='depttarget';
