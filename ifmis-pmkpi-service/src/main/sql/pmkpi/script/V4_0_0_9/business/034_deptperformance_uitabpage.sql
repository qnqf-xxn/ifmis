begin
  
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/deptperformance/report/edit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('072A10673CB144C4A171A85DD8BF6E6F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效指标', 'yearindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/deptperformance/report/perfindex.page'',action:''deptindex.save'',busguid:''4060E895AFB94626A13210D720A18E31''}', null, '0', 'indexiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('234AD87E066A4568A825C2DC753AABCF', 'pmkpi', '/pmkpi/deptperformance/report/edit', '考评一类指标', 'oneindex', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '考评一类指标', null, null, '{busguid:''022DDAA447DA4644ABD1E49811961F78''}', null, '0', 'auditindexdatatable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2ADBD526B0124C559511C082DEFD306F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('4CCF04B44A0D46638095CF709ADE94A1', 'pmkpi', '/pmkpi/deptperformance/report/edit', '整体绩效目标', 'depttarget', 0, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '整体绩效目标', null, null, '{busguid:''E0902146244E4BB8B33B3225FF34604C''}', null, '0', 'targetdatatable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67F400F6D1DF458095B6F0C0A40942E3', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门职能活动', 'deptfun', 0, 11, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{url:''/pmkpi/deptperformance/report/funcd.page'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC''}', null, '0', 'funciframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('74A652FB74804776B8045BBE186B74D5', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度主要任务', 'depttask', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度主要任务', null, null, '{busguid:''BB27AE971C71426EA4691F989CE61504''}', null, '0', 'perftaskdatatable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AA1CB9CAD6784E7F80E29057B9399D9C', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效目标', 'deptgoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度总体目标', null, null, '{busguid:''6584F846CE6D4CB8BF105577F0DC4C8C''}', null, '0', 'deptgoaleditform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C641AA5E82A2482C82FAE97F00B51962', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门基本信息', 'deptinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '部门基本信息', null, null, '{busguid:''C6CA191547FE416AB3C5694B2BCEA6E7''}', null, '0', 'formaleditform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D0E18D173E38461C9EA56BF9870D12D0', 'pmkpi', '/pmkpi/deptperformance/report/edit', '绩效指标情况表', 'indexsituation', 0, 13, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标情况表', null, '保存', '{reporttype:''word''}', null, '0', 'mancereport', null, null, null, null, null, null);
