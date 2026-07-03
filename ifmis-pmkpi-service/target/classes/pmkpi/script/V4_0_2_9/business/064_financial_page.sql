begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/confirm/editor');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/confirm/editor', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.confirmnew.ConfirmNewPage', 'editInfo', '{main:[infoeditform]}', null, null, 0);
