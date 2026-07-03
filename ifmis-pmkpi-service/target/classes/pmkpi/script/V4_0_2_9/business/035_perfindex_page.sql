begin

--监控指标保存草稿
--项目支出-page
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/trace/report/edit/indextarget';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/indextarget', 'pmkpi_proindextrace', '{}', 'proindextrace', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/indextarget', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标完成情况'',edit:true,checkbox:false,title:''绩效指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/indextarget', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
delete from bus_t_pageconsole where url = '/pmkpi/program/trace/report/edit/indextarget';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/indextarget', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetPage', 'list', '{main:[toolbutton,datatable]}', null, null, 0);
--部门整体-page
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/trace/report/deptedit/indextarget';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/indextarget', 'pmkpi_proindextrace', '{}', 'proindextrace', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/indextarget', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效指标完成情况'',edit:true,checkbox:false,title:''绩效指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/indextarget', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
delete from bus_t_pageconsole where url = '/pmkpi/trace/report/deptedit/indextarget';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/indextarget', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetPage', 'list', '{main:[toolbutton,datatable]}', null, null, 0);

--自评指标保存草稿
--项目支出-page
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/selfindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfindex', 'pmkpi_selfindex', '{}', 'selfindex', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,title:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/selfindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/selfindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/selfindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'selfindex', '{main:[toolbutton,datatable]}', null, null, 0);
--部门整体-page
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editdept/selfindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'pmkpi_selfindex', '{}', 'selfindex', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,name:''指标完成情况'',edit:true,checkbox:false,title:''指标完成情况'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/editdept/selfindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/editdept/selfindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'selfindex', '{main:[toolbutton,datatable]}', null, null, 0);







