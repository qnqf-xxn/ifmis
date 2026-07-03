begin
  --绩效批复查询字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/approval/program/query';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, 120, 0, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_TOTAL_AMT', '项目总额', 4, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 'amt', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'SETUP_YEAR', '设立年度', 5, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_ID', '项目guid', 0, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'GUID', 'GUID', 0, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);

delete from p#busfw_t_uitable where key ='/pmkpi/approval/program/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/approval/program/query', 'V_PERF_BGT_PROJECTPF', 100, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/approval/program/query';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_BGT_PROJECTPF', '{}', null,  null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_CODE', '项目编码', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_BGT_PROJECTPF', '{}', null,  null, null, null);


delete from p#busfw_t_uifunction where key ='/pmkpi/approval/program/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', '查看项目明细', 1, 1, 'searchicon', 'approvalquery.queryView', null, '查看项目明细', 'pmkpi', 'proinfoview', null, null,  null, null);



--查看详情页面 页签注册
delete from p#busfw_t_uitabpage where key ='/pmkpi/approval/query';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query', '年度绩效目标', 'tabgoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/approval/query/protabgoal.page?showtab=3&ispf=1'',busguid:''C0B38427A5C119E4E053B11FA8C0573E''}', null, '0', 'iframetabgoal', null, null, null, null, null,  null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/approval/query/treeindex.page?showtab=3&ispf=1''}', null, '0', 'iframeindextable', null, null, null, null, null,  null, null, null);


--绩效目标页面 页签注册
delete from  p#busfw_t_uitabpage where key ='/pmkpi/approval/query/protabgoal';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query/protabgoal', '中期绩效目标', 'total', 1, 1, 'choosed', 'approvalgoal.clickTabpage', 0, '中期绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null,  null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query/protabgoal', '年度绩效目标', 'year', 1, 2, 'nomal', 'approvalgoal.clickTabpage', 0, '年度绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null,  null, null, null);


delete from  p#busfw_t_uitabpage where key ='/pmkpi/approval/query/treeindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query/treeindex', '年度绩效指标', 'year', 1, 2, 'nomal', 'approvalindex.clickTabpage', 0, '年度绩效指标', null, '复制年度绩效指标', '{}', null, '0', null, null, null, null, null, null,  null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,  DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query/treeindex', '总体绩效指标', 'total', 1, 1, 'choosed', 'approvalindex.clickTabpage', 0, '总体绩效指标', null, '查看评审意见,复制总体绩效指标,复制上年指标,参考历年指标', '{}', null, '0', null, null, null, null, null, null,  null, null, null);

