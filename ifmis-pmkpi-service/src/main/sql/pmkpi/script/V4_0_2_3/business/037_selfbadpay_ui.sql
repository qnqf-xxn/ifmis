begin

-- 预算执行情况列表默认不可编辑
delete from bus_t_pageconsolecomconfig where url in('/pmkpi/perfself/apply/edit/bdgpay','/pmkpi/perfself/apply/dept/edit/bdgpay');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/bdgpay', 'pmkpi_selfbdgpay', '{}', 'bdgpay', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/bdgpay', 'busuidatatable', '{name:''预算执行情况'',checkbox:true,tiptiptiptiptiptiptiptiptitle:''资金明细'',edit:true ,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/bdgpay', 'pmkpi_selfbdgpay', '{}', 'bdgpay', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/edit/bdgpay', 'busuidatatable', '{name:''预算执行情况'',checkbox:true,tiptiptiptiptiptitle:''资金明细'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);


--预算执行情况页签 通版默认显示，合肥默认隐藏
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/perfself/apply/edit') and t.code ='selfbdgpay';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A1D274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/apply/edit', '预算执行情况(合肥)', 'selfbdgpay', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况(合肥)', null, null, '{url:''/pmkpi/perfself/apply/edit/fund.page'',action:''selffund.save''}', null, '0', 'fundsiframe', null, null, null, null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/perfself/apply/edit') and t.code ='bdgpay';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A1E274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/apply/edit', '预算执行情况', 'bdgpay', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/edit/bdgpay.page'',action:''bdgpay.save''}', null, '0', 'bdgpayiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage t where t.key ='/pmkpi/perfself/apply/dept/edit' and t.code ='selfbdgpay';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3797A274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '预算执行情况(合肥)', 'selfbdgpay', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况(合肥)', null, null, '{url:''/pmkpi/perfself/apply/dept/edit/fund.page'',action:''selffund.save''}', null, '0', 'fundsiframe', null, null, null, null, null, null);

delete from p#busfw_t_uitabpage t where t.key ='/pmkpi/perfself/apply/dept/edit' and t.code ='selffund';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A6D274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '预算执行情况', 'selffund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/perfself/apply/dept/edit/bdgpay.page'',action:''bdgpay.save''}', null, '0', 'fundiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitable where key ='/pmkpi/perfself/apply/edit/bdgpay';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30F94274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'V_PERF_T_SELFPROFUND', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uitable where key ='/pmkpi/perfself/apply/dept/edit/bdgpay';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30F9D274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'V_PERF_T_SELFPROFUND', 0, 1, 0, null, null, 'pmkpi', null);


--自评预算执行情况列表字段、默认不可编辑
delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/apply/dept/edit/bdgpay';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D04274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'NAME', '资金来源', 1, 1, 0, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D12274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'AMT1', '年初预算', 2, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D13274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'AMT2', '年度预算调整', 3, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D14274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'AMT3', '调整后的预算', 4, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D15274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'AMT4', '全年执行数', 5, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D16274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'BGTGET', '预算执行率%', 6, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D17274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/dept/edit/bdgpay', 'SCORE', '自评得分', 7, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);

delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/apply/edit/bdgpay';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D67274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'NAME', '资金来源', 1, 1, 0, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D68274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT1', '年初预算', 2, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D69274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT2', '年度预算调整', 3, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D6A274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT3', '调整后的预算', 4, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D6B274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT4', '全年执行数', 5, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D6C274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'BGTGET', '预算执行率%', 6, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32D6D274CE0533315A8C0ACDD', '/pmkpi/perfself/apply/edit/bdgpay', 'SCORE', '自评得分', 7, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);



