begin

delete from p#busfw_t_uitabpage where key = '/pmkpi/adjust/report/deptedit' and code = 'deptgoallist';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/report/deptedit', '年度绩效目标调整', 'deptgoallist', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标调整', null, null, '{url:''/pmkpi/adjust/report/deptedit/goallist.page'',action:''adjustgoallist.save'',busguid:''0CCC95286D3F814220C19DB6BC2537F2''}', null, '0', 'goallistiframe', null, null, null, null, null, null, null, null,'2016','87');



delete from p#busfw_t_uicolumn where key = '/pmkpi/adjust/report/deptedit/goallist';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/goallist', 'ADJUSTNDGOAL', '绩效目标', 3, 1, 1, 0, null, 0, 1, null, null, null, null, 200, 0, 's', '{}', null, null, null,'2016','87');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/goallist', 'GUID', 'guid', 1, 0, 0, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, null, null,'2016','87');



delete from p#busfw_t_uitable where key = '/pmkpi/adjust/report/deptedit/goallist';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/goallist', 'V_PERF_T_ADJUSTGOAL', 0, 1, 0, null, null, 'pmkpi', null,'2016','87');


delete from PERF_T_PAGEMENU where uikey = '/pmkpi/adjust/report/deptedit/goallist';
insert into PERF_T_PAGEMENU (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('158A0D9E7E249F1875CFDD9E2B44939C', '5', '绩效目标调整（广西）', '/pmkpi/adjust/report/deptedit/goallist', 'CCF16B4354E46519E0530B4B050A695B', 4, 1, 5, 1, '20230420155555', '20230420155555', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');