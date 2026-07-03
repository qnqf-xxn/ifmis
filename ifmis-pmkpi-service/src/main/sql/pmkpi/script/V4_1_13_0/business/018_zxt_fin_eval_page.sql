BEGIN
-- 申报新增 

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/finconfirm/proeditnx';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/proeditnx', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/proeditnx', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/proeditnx', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluation/finconfirm/proeditnx';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/proeditnx', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

-- 基本信息

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/finconfirm/infoedit' ;

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/infoedit', 'pmkpi_fininfoedit', '{}', 'fininedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/infoedit', 'buseditform', '{columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'editform', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluation/finconfirm/infoedit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/infoedit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.report.FinReportAddPage', 'editInfo', '{main:[editform]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_fininfoedit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_fininfoedit', '财政申报编辑', null, '财政申报编辑', '/pmkpi/evaluation/financial/report/reportadd.js', 'Ext.lt.pmkpi.reportadd', 'pmkpi', 'pmkpi.evaluation.financial.report.FinReportAddService');


-- 成果上传

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/result/editnx';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/editnx', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/editnx', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/editnx', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/editnx', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/result/evaledit'',iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'editform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/editnx', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/infoedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluation/financial/result/editnx' ;

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/result/editnx', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);



-- 评价成果
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/finconfirm/result/evaledit' ;

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/result/evaledit', 'pmkpi_finevalinfoedit', '{}', 'finevalinfoedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/finconfirm/result/evaledit', 'buseditform', '{columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'editform', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluation/finconfirm/result/evaledit' ;

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/result/evaledit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultPage', 'evaledit', '{main:[editform]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_finevalinfoedit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finevalinfoedit', '财政评价成果', null, '财政评价成果', '/pmkpi/evaluation/financial/result/resulteval.js', 'Ext.lt.pmkpi.resulteval', 'pmkpi', 'pmkpi.evaluation.financial.ResultEvalService');



-- 部门整体 成果上传
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/result/depteditnx';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/depteditnx', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/result/evaledit'',iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'editform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/depteditnx', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/depteditnx', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/depteditnx', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/financial/result/depteditnx', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/deptedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluation/financial/result/depteditnx';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/result/depteditnx', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

