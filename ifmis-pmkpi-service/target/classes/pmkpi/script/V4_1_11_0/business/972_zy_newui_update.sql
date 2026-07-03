begin


update bus_t_pageconsole t set 
t.page='/busfw/common/template/template_defautl.jsp',
t.JSLIB='/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js' 
where t.appid = 'pmkpi' and  t.page = '/pmkpi/common/template/template_defautl.jsp' and t.JSLIB = '/pmkpi/common/template/template_default.js';


delete from  bus_t_pageconsole t where t.url = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/finconfirm/prorelation/procheck', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.relation.ProRelationPage', 'check', '{left:lefttree,main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

update bus_t_pageconsolecomconfig t set t.config='{name:''预算执行情况'',checkbox:true,title:''资金明细'',edit:true ,addrow:true}'
where t.url='/pmkpi/perfself/apply/edit/bdgpay' and t.id='datatable';


update bus_t_pageconsolecomconfig t set CONFIG =  '{headsort:false,addrow:false,nogroupbox:false,edit:true,checkbox:true,title:''专项转移支付到期绩效评价情况表'',treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,query:''querydata''}' where t.url = '/pmkpi/transpaypro/evalindex' and componentid = 'busuidatatable';


UPDATE bus_t_pageconsolecomconfig SET config = REPLACE(config, 'tip', '') WHERE config LIKE '%tip%';

update  bus_t_pageconsolecomconfig  set config = '{key:''/pmkpi/perfself/apply/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}' where url in ('/pmkpi/self/parent/result','/pmkpi/self/parent/audit','/pmkpi/self/parent/query') and componentid = 'busqueryform';
