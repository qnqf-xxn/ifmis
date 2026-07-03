begin
--监控填报 添加预算执行情况页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/trace/report/deptedit' and CODE='tracefund';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DA71BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/trace/report/deptedit', '预算执行情况', 'tracefund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/program/trace/report/edit/fund.page'',busguid:''B74D29A870344446E0530100007F1A5A'',action:''tracefund.save''}', null, '0', 'taskfundiframe', null, null, null, null, null, null);


--监控 --阶段监控填报
delete from p#busfw_t_uitable where key='/pmkpi/trace/report/proedit/warn/fund';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BA6668DFDF851167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn where key='/pmkpi/trace/report/proedit/warn/fund';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF861167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'NAME', '资金来源', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF871167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT1', '年初预算', 3, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF881167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT2', '年度预算调整', 5, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF891167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT3', '调整后的预算', 6, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8A1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT4', '累计支出', 7, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8B1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'BGTGET', '预算执行率%', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'f', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8C1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'AMT5', '项目指标结余', 10, 1, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6668DFDF8D1167E053B11FA8C08965', '/pmkpi/trace/report/proedit/warn/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);


--自评填报 页签（项目、部门）
delete from p#busfw_t_uitabpage where key in('/pmkpi/perfself/apply/dept/edit','/pmkpi/perfself/apply/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1DA2EE3E07A249DDB79B75A45310303E', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '部门基本信息', 'projinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '部门基本信息', null, null, '{url:''/pmkpi/perfself/apply/dept/edit/projinfo.page'',tabcode:''v_pmkpi_t_prodetailinfo'',action:''projinfo.save''}', null, '0', 'projiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7D7345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '预算执行情况', 'selffund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/edit/bdgpay.page'',action:''bdgpay.save''}', null, '0', 'fundiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AA1CB9CAD6784E7F80E29057B1111D9C', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '年度绩效目标', 'deptgoal', 0, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, null, '{busguid:''6584F846CE6D4CB8BF105577F0DC4C8C''}', null, '0', 'deptgoaleditform', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7D7345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '资金使用情况', 'selffund', 0, 8, 'nomal', 'tabfreamedit.clickTabpage', null, '资金使用情况', null, null, '{url:''/pmkpi/perfself/apply/edit/selffund.page''}', null, '0', 'fundiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78A00A1E003B11FA1C07BA4', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''perfselfapplydeptedit'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('CD0D19E2DD734500851D188038A05981', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '指标完成情况', 'selfindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '指标完成情况', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfindex.page'',action:''selfindex.save''}', null, '0', 'indexiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67F400F6D1DF458095B6F0C0A40942E3', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '部门职能概述', 'deptfun', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{url:''/pmkpi/deptperformance/report/funcd.page?viewtype=query'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC''}', null, '0', 'funciframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('4DFAB37893334125ACF423C66CFC4BB0', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '自评补充信息', 'selfdesc', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '自评补充信息', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfdesc.page'',action:''selfdesc.save''}', null, '0', 'desciframe', null, null, null, null, null, null);


insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78A00A1E003B11FA8C0DBA4', 'pmkpi', '/pmkpi/perfself/apply/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''perfselfapplyedit'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('41FAB37893334125ACF423C66CFC4BB0', 'pmkpi', '/pmkpi/perfself/apply/edit', '自评补充信息', 'selfdesc', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '自评分析', null, null, '{url:''/pmkpi/perfself/apply/edit/selfdesc.page'',action:''selfdesc.save''}', null, '0', 'desciframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53C1BDAE7C5511E053B11FA8C098E1', 'pmkpi', '/pmkpi/perfself/apply/edit', '预算执行情况', 'bdgpay', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/edit/bdgpay.page'',action:''bdgpay.save''}', null, '0', 'bdgpayiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2C0D19E2DD734500851D188038A05981', 'pmkpi', '/pmkpi/perfself/apply/edit', '指标完成情况', 'selfindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '指标完成情况', null, null, '{url:''/pmkpi/perfself/apply/edit/selfindex.page'',action:''selfindex.save''}', null, '0', 'indexiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1AA2EE3E07A249DDB79B75A45310303E', 'pmkpi', '/pmkpi/perfself/apply/edit', '项目基本信息', 'projinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '项目基本信息', null, null, '{url:''/pmkpi/perfself/apply/edit/projinfo.page'',action:''projinfo.save''}', null, '0', 'projiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53C1BDAE7C5511E053B11FA8C098E1', 'pmkpi', '/pmkpi/perfself/apply/edit', '资金使用情况', 'bdgpay', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金使用情况', null, null, '{url:''/pmkpi/perfself/apply/edit/bdgpay.page''}', null, '0', 'bdgpayiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('767345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/edit', '资金使用情况1', 'selffund', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金使用情况1', null, null, '{url:''/pmkpi/perfself/apply/edit/selffund.page''}', null, '0', 'fundiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('767345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/edit', '资金使用情况', 'selffund', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金使用情况', null, null, '{url:''/pmkpi/perfself/apply/edit/selffund.page''}', null, '0', 'fundiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53C1BDAE7C5511E053B11FA8C098E1', 'pmkpi', '/pmkpi/perfself/apply/edit', '资金使用情况', 'bdgpay', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金使用情况', null, null, '{url:''/pmkpi/perfself/apply/edit/bdgpay.page''}', null, '0', 'bdgpayiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('767345D59B9B4FC39A485871C4B055FC', 'pmkpi', '/pmkpi/perfself/apply/edit', '资金使用情况1', 'selffund', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金使用情况1', null, null, '{url:''/pmkpi/perfself/apply/edit/selffund.page''}', null, '0', 'fundiframe', null, null, null, null, null, null);


-- 监控 预算执行情况页签
delete from bus_t_pageconsole where url in('/pmkpi/program/trace/report/edit/fund');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/fund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.fund.ProFundPage', 'list', '{main:[datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/program/trace/report/edit/fund');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/fund', 'pmkpi_protracefund', '{}', 'tracefund', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/fund', 'busuidatatable', '{addrow:false,name:''预算执行情况'',edit:false,checkbox:true,title:''预算执行情况''}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_protracefund';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protracefund', '项目绩效监控预算执行情况', null, '项目绩效监控预算执行情况', '/pmkpi/perfprotrace/fund/fundservice.js', 'Ext.lt.pmkpi.protrace.fundservice', 'pmkpi', 'pmkpi.perfprotrace.fund.ProFundService');

delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/report/edit/fund';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AD4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'BGTGET', '预算执行率(%)', 9, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'f', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B04446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT3', '调整后预算数', 7, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B14446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT4', '预算执行数', 8, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870B44446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AB4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'NAME', '资金来源', 1, 1, 0, 1, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AE4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT1', '年初预算', 5, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D29A870AF4446E0530100007F1A5A', '/pmkpi/program/trace/report/edit/fund', 'AMT2', '调整预算数', 6, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);

--自评 预算执行情况
delete from bus_t_pageconsole where url ='/pmkpi/perfself/apply/edit/bdgpay';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/bdgpay', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'payindex', '{main:[datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/apply/edit/bdgpay';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/bdgpay', 'pmkpi_selfbdgpay', '{}', 'bdgpay', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/bdgpay', 'busuidatatable', '{name:''资金明细'',checkbox:true,title:''资金明细'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_selfbdgpay';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfbdgpay', '资金使用情况', null, '资金使用情况', '/pmkpi/perfself/selfbdgpay.js', 'Ext.lt.pmkpi.selfbdgpay', 'pmkpi', 'pmkpi.perfSelf.tab.SelfFundService');

delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/apply/edit/bdgpay';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598810DAFE4530603A8C02DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT1', '年初预算', 2, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598820DAFE8530603A8C02DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT2', '年度预算调整', 3, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598850DAFE0530603A8C62DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT3', '调整后的预算', 4, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598860DAFE0530603A8C82DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT4', '全年执行数', 5, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598870DAFE0530603A8C02DD1', '/pmkpi/perfself/apply/edit/bdgpay', 'BGTGET', '预算执行率%', 6, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598800DAFE0530603A8C42DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'NAME', '资金来源', 1, 1, 0, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598800DAFE0530603A8C42DD2', '/pmkpi/perfself/apply/edit/bdgpay', 'SCORE', '自评得分', 7, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);
