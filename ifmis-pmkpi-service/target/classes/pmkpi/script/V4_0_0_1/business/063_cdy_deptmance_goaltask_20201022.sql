begin

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{title:''基础信息'',tablecode:''v_perf_t_deptperfdeclare'',pagetype:''manceinfo'',iswf:''true''}', 'formaleditform', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{title:''基础信息'',tablecode:''v_perf_t_deptperfdeclare'',pagetype:''manceinfo'',iswf:''true''}', 'formaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/auditindex'',headsort:false,addrow:true,name:''考评一类指标'',edit:true,checkbox:true,title:''考评一类指标'',initlevel:6,isuphide:false,nextSibling:false}', 'auditindexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/target'',headsort:false,addrow:true,name:''部门整体目标'',edit:true,checkbox:true,title:''部门整体目标'',initlevel:6,isuphide:false,nextSibling:false}', 'targetdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',headsort:false,addrow:true,name:''主要任务'',edit:true,checkbox:true,title:''主要任务'',initlevel:6,isuphide:false,nextSibling:false}', 'perftaskdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/deptgoal'',title:''绩效目标'',tablecode:''perf_t_deptgoal''}', 'deptgoaleditform', 'pmkpi', null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/deptperformance/report/perfindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perfindex', 'pmkpi_deptindex', '{}', 'deptindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/report/perfindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''年度绩效指标'',edit:true,checkbox:true,title:''年度绩效指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true}', 'datatable', 'pmkpi', null);


delete from busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/perftask');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('A41C179A380C4ED2AA1056185AB0DE88', '/pmkpi/deptperformance/report/perftask', 'V_PERF_T_DEPTTASK', 0, 0, 0, null, null, 'pmkpi', null);

delete from busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/perftask');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('876D9A31D2F84B1999CB44836B72ADF4', '/pmkpi/deptperformance/report/perftask', 'NAME', '任务名称', 1, 1, 1, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD567A4E20D8476C9543BC9B184BECC2', '/pmkpi/deptperformance/report/perftask', 'CONTEXT', '主要内容', 2, 1, 1, 0, null, null, 0, null, null, null, null, 500, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('91813EE2641D4DB7840240446873890B', '/pmkpi/deptperformance/report/perftask', 'TOTALAMT', '总金额', 3, 1, 1, 0, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D87FCE4FB2164A33823EC0C6E1353430', '/pmkpi/deptperformance/report/perftask', 'FINANCIALFUND', '财政资金', 4, 1, 1, 0, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2FBDFA115CE14FE4982636B4CBC6A155', '/pmkpi/deptperformance/report/perftask', 'OTHERFUND', '其他资金', 5, 1, 1, 0, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 's', null, null);



delete from p#busfw_t_uitabpage t where key in('/pmkpi/deptperformance/report/edit');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('4CCF04B44A0D46638095CF709ADE94A1', 'pmkpi', '/pmkpi/deptperformance/report/edit', '整体绩效目标', 'depttarget', 0, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '整体绩效目标', null, null, '{busguid:''E0902146244E4BB8B33B3225FF34604C''}', null, '0', 'targetdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('9C01A08F9FD648158ABDF5D0CB32B01D', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效指标', 'deptindex', 0, 8, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/deptperformance/report/hnindex.page'',action:''depthnindex.save'',busguid:''75BBE7B861194B809EA57D2EC61256A9''}', null, '0', 'hnindexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('74A652FB74804776B8045BBE186B74D5', 'pmkpi', '/pmkpi/deptperformance/report/edit', '主要任务', 'depttask', 0, 9, 'nomal', 'tabfreamedit.clickTabpage', null, '主要任务', null, null, '{busguid:''BB27AE971C71426EA4691F989CE61504''}', null, '0', 'perftaskdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AA1CB9CAD6784E7F80E29057B9399D9C', 'pmkpi', '/pmkpi/deptperformance/report/edit', '绩效目标', 'deptgoal', 0, 10, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, null, '{busguid:''6584F846CE6D4CB8BF105577F0DC4C8C''}', null, '0', 'deptgoaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2ADBD526B0124C559511C082DEFD306F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C641AA5E82A2482C82FAE97F00B51962', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门基本信息', 'deptinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '部门基本信息', null, null, '{busguid:''C6CA191547FE416AB3C5694B2BCEA6E7''}', null, '0', 'formaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67F400F6D1DF458095B6F0C0A40942E3', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门职能活动', 'deptfun', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{url:''/pmkpi/deptperformance/report/funcd.page'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC''}', null, '0', 'funciframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('072A10673CB144C4A171A85DD8BF6E6F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/deptperformance/report/perfindex.page'',action:''deptindex.save'',busguid:''4060E895AFB94626A13210D720A18E31''}', null, '0', 'indexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('234AD87E066A4568A825C2DC753AABCF', 'pmkpi', '/pmkpi/deptperformance/report/edit', '考评一类指标', 'oneindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '考评一类指标', null, null, '{busguid:''022DDAA447DA4644ABD1E49811961F78''}', null, '0', 'auditindexdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D0E18D173E38461C9EA56BF9870D12D0', 'pmkpi', '/pmkpi/deptperformance/report/edit', '绩效指标情况表', 'indexsituation', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标情况表', null, '保存', '{reporttype:''word''}', null, '0', 'mancereport', null, null, null, null, null, null);



