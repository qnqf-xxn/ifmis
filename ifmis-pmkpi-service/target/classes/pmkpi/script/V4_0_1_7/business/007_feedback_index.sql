-- 整改情况反馈页面
begin
delete from bus_t_pageconsole where url ='/pmkpi/rectification/feedback/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedback/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/feedback/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'pmkpi_feedback', '{}', 'feedback', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'busuidatatable', '{name:''整改情况反馈'',checkbox:true,title:''整改情况反馈'',edit:false,addrow:false,pagetype:''audit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);


delete from bus_t_pagecomponent where id='pmkpi_feedback';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedback', '整改情况反馈', null, '整改情况反馈', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/feedbackIndex.js', 'Ext.lt.pmkpi.rectification.feedback.index', 'pmkpi', 'pmkpi.rectification.FeedbackIndexService');


--列表
delete from p#busfw_t_uitable where key ='/pmkpi/rectification/feedback/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('328760ED4A0DC4B19FD35621F78420AC', '/pmkpi/rectification/feedback/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);


--列表字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/feedback/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0C0794B6343D75B96962C7587E60D8D', '/pmkpi/rectification/feedback/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8E1C2F0958C4C99221330B202F3DF414', '/pmkpi/rectification/feedback/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E1FC534E4B98F857528BF74871650105', '/pmkpi/rectification/feedback/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8F89A9961F2CA80877F69B3BD27A996B', '/pmkpi/rectification/feedback/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4FCCD6D23BBC1FC4E25A1C88D47B6B75', '/pmkpi/rectification/feedback/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF8F02D9D20025216EA340DC0B6E8D55', '/pmkpi/rectification/feedback/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('111F702981887DEF3994631B81AD8542', '/pmkpi/rectification/feedback/index', 'RECTYPE', '整改类型', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

--查询区
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/feedback/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('110765D8743D9B766FC0F20FD15616D0', '/pmkpi/rectification/feedback/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);

--页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/rectification/feedback/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('26333A6799CF2C38E7F7F1CF604745F4', 'pmkpi', '/pmkpi/rectification/feedback/index', '待办', 'waitaudit', 1, 1, 'choosed', 'feedback.clickTabpage', null, '待审核', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0DF6CC35CCFE3C543DACA385CD25B26A', 'pmkpi', '/pmkpi/rectification/feedback/index', '已办', 'alreadyaudit', 1, 2, 'nomal', 'feedback.clickTabpage', null, '已审核', null, '填报/修改,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F2CFA4806E89730F9E5CD61E9278C36', 'pmkpi', '/pmkpi/rectification/feedback/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'feedback.clickTabpage', null, '曾经办', null, '填报/修改,送审/取消送审', '{}', null, '0', null, null, null, null, null, null, null);


--按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/feedback/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('63A977BA3F01E7E85CA73B60A9681F1A', '/pmkpi/rectification/feedback/index', '查询', 0, 1, 'addaction', 'feedback.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7A4B84E7BE5894CAFEFBF921F31DA52C', '/pmkpi/rectification/feedback/index', '填报/修改', 1, 3, 'addaction', 'feedback.add', null, '填报/修改', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7DA2987BC09A697B296CADE6E06BE46F', '/pmkpi/rectification/feedback/index', '送审', 1, 5, 'addaction', 'feedback.send', null, '送审', 'pmkpi', 'send', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C9F0C09D631CC75281243CFF29EF2A67', '/pmkpi/rectification/feedback/index', '取消送审', 1, 7, 'addaction', 'feedback.cancel', null, '取消送审', 'pmkpi', 'cancel', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0389A1DF24BED016FA76F4458A642B5B', '/pmkpi/rectification/feedback/index', '审核情况', 1, 8, 'addaction', 'feedback.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F2C9D38AEED59C57C3D34DA808EED307', '/pmkpi/rectification/feedback/index', '通过', 0, 13, 'addaction', 'feedback.pass', null, '通过', 'pmkpi', 'pass', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE51', '/pmkpi/rectification/feedback/index', '查看项目', 1, 4, 'addaction', 'feedback.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0ACDB', '/pmkpi/rectification/feedback/index', '查看明细', 1, 2, 'addaction', 'feedback.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

--情况反馈 填报修改
delete from bus_t_pageconsole where url ='/pmkpi/rectification/program/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/program/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackEdit', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/program/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'pmkpi_addprogram', '{}', 'addprogram', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_addprogram';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_addprogram', '整改新增项目', null, '整改新增项目', '/pmkpi/rectification/rectificationaddproj.js', 'Ext.lt.pmkpi.rectification.addproj', 'pmkpi', 'pmkpi.rectification.addproj.AddprojEditService');

--页签
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/program/edit','/pmkpi/rectification/dept/edit');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('25CCFA09C578C553CB3C77D945891EBD', 'pmkpi', '/pmkpi/rectification/program/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD19AA0879E10A55E053B11FA8C0A366', 'pmkpi', '/pmkpi/rectification/program/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B6A93ACFAEEFDFF75CCCBAEC5B3AA467', 'pmkpi', '/pmkpi/rectification/program/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'addprogram.clickTabpage', null, '整改反馈附件', null, null, '{filebustype:''feedback'',url:''/pmkpi/rectification/feedbackfile.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('FF950D27D2E61F4117846BF2F0CE5C49', 'pmkpi', '/pmkpi/rectification/program/edit', '反馈信息详情', 'feedbackInfo', 1, 4, 'nomal', 'addprogram.clickTabpage', null, '反馈信息详情', null, null, '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('87661BD514DC20D8B6C39A0461794B17', 'pmkpi', '/pmkpi/rectification/program/edit', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, null, '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016E4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存', '{url:''/pmkpi/rectification/program/deptinfo.page''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016F4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301704449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'addprogram.clickTabpage', null, '整改反馈附件', null, '保存', '{filebustype:''feedback'',url:''/pmkpi/rectification/feedbackfile.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301714449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '反馈信息详情', 'feedbackInfo', 1, 4, 'nomal', 'addprogram.clickTabpage', null, '反馈信息详情', null, null, '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301724449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);


--按钮
delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/program/edit','/pmkpi/rectification/dept/edit');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/edit', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/edit', '关闭', 1, 3, null, 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/program/edit', '保存并送审', 1, 2, null, 'addprogram.saveandsend', null, '保存并送审', 'pmkpi', 'saveandsend', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/edit', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/edit', '关闭', 1, 3, null, 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/dept/edit', '保存并送审', 1, 2, null, 'addprogram.saveandsend', null, '保存并送审', 'pmkpi', 'saveandsend', null, '{}');


--反馈附件
delete from bus_t_pageconsole where url ='/pmkpi/rectification/feedbackfile';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedbackfile', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.filelist.UploadFilePage', 'index', '{main:[editform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/feedbackfile';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'pmkpi_uploadfile', '{}', 'pmkpiuploadfile', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'busuidatatable', '{name:''整改反馈附件'',title:''整改反馈附件'',key:''/pmkpi/upload/file/index''}', 'datatable', 'pmkpi', null);

--编辑区
delete from p#busfw_t_uieditform where key ='/pmkpi/rectification/feedbackfile';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879E90A55E053B11FA8C0A366', '/pmkpi/rectification/feedbackfile', 'V_PERF_T_RECTIFY', 'textarea', '整改反馈内容', 'FEEDBACKDESC', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879EA0A55E053B11FA8C0A366', '/pmkpi/rectification/feedbackfile', 'V_PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);









