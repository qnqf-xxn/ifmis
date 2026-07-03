begin
--财政终稿报告上传
--财政终稿报告上传-上传终稿评价报告-page-项目支出
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/report/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/edit', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/edit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/financial/report/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

--财政终稿报告上传-上传终稿评价报告-page-部门整体
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/report/deptedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/report/deptedit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/deptedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/financial/report/deptedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/report/deptedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);



