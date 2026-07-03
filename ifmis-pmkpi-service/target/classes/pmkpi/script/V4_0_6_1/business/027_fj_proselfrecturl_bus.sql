begin
 
--项目绩效自评整改反馈详情页面 
delete FROM bus_t_pageconsole t where t.url = '/pmkpi/rectification/selfpro';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/selfpro', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selfrectProj', '{main:[tabpage,toolbutton,editform,datatable]}', null, null, null);



