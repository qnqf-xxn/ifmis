begin

--新页面的嵌入项目库配置url：/pmkpi/program/report/progoalnewedit.page?showtab=2&isedittotal=0&projId=$(#guid)&pro_code=$(#pro_code)&authorization=$(#authorization)&stagid=$(#midguid)&projtype=2&tokenid=$(#tokenid)&crossreturl=%2Fpmkpi%2Fperfprogram%2Fgoal%2Fcross_responsenewgoal.jsp%3Ftokenid%3D%24(%23tokenid)%26authorization%3D%24(%23authorization)

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/program/report/progoalnewedit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/progoalnewedit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'listpage', '{main:[toolbutton,tabpage,totaleditform,yeareditform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/report/progoalnewedit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/report/progoalnewedit', 'pmkpi_progoalnewedit', '{}', 'progoalnewedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/report/progoalnewedit', 'buseditform', '{key:''/pmkpi/program/report/protabgoal''}', 'totaleditform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/report/progoalnewedit', 'buseditform', '{key:''/pmkpi/program/report/protabgoal''}', 'yeareditform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/report/progoalnewedit', 'bustoolbutton', '{key:''/pmkpi/program/report/protabgoal''}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/report/progoalnewedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

delete from bus_t_pagecomponent where id ='pmkpi_progoalnewedit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_progoalnewedit', '绩效目标新页面', null, '绩效目标新页面', '/pmkpi/perfprogram/goal/progoalnewedit.js', 'Ext.lt.pmkpi.prjgoalneweditservice', 'pmkpi', 'pmkpi.goal.PrjGoalTabService');

--tabpage无法引用，复制一份替换click事件，编辑区目标的显示名与页签名一致
delete from p#busfw_t_uitabpage where key ='/pmkpi/program/report/progoalnewedit';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/program/report/progoalnewedit', '中期绩效目标', 'total', 1, 1, 'choosed', 'progoalnewedit.clickTabpage', 0, '中期绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/program/report/progoalnewedit', '年度绩效目标', 'year', 1, 2, 'nomal', 'progoalnewedit.clickTabpage', 0, '年度绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);
