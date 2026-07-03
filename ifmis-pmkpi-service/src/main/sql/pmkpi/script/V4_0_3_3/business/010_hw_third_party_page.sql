begin

--2、评价成果上传，增加“第三方信息”页签，发版隐藏
delete from bus_t_pagecomponent where id = 'pmkpi_thirdparty';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_thirdparty', '第三方信息', null, '第三方信息', '/pmkpi/evaluation/dept/third/thirdparty.js', 'Ext.lt.pmkpi.thirdparty', 'pmkpi', 'pmkpi.evaluation.dept.third.ThirdPartyService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/thirdparty';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/thirdparty', 'pmkpi_thirdparty', '{}', 'thirdparty', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/thirdparty', 'busuidatatable', '{name:''第三方信息'',checkbox:true,title:''第三方信息'',edit:true,addrow:true,rowtolist:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/thirdparty';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/thirdparty', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.third.ThirdPartyPage', 'index', '{main:[datatable]}', null, null, 0);




