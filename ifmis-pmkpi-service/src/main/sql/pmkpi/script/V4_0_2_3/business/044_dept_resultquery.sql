begin
--bug：部门评价查询页面没有页签
delete from bus_t_pageconsole where url ='/pmkpi/evaluation/dept/resultquery';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/resultquery', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.result.DeptResultPage', 'query', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 1);

