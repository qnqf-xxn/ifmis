begin
--自评预算执行情况页签  项目支出、部门整体用不同的key
delete from p#busfw_t_uitabpage where key ='/pmkpi/perfself/apply/dept/edit' and code ='selffund' and name ='预算执行情况';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7D7345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '预算执行情况', 'selffund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/dept/edit/bdgpay.page'',action:''bdgpay.save''}', null, '0', 'fundiframe', null, null, null, null, null, null);



--部门整体用一个新的key
delete from bus_t_pageconsole where url ='/pmkpi/perfself/apply/dept/edit/bdgpay';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/dept/edit/bdgpay', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'payindex', '{main:[datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url='/pmkpi/perfself/apply/dept/edit/bdgpay';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/bdgpay', 'pmkpi_selfbdgpay', '{}', 'bdgpay', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/bdgpay', 'busuidatatable', '{name:''预算执行情况'',checkbox:true,tiptiptiptiptiptitle:''预算执行情况'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);



