begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/protrace/thirdaudit/opinion');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion', '取消', 1, 4, 'searchicon', 'tabfreamedit.close', null, '取消', 'pmkpi', 'close', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/protrace/thirdaudit/opinion', '保存', 1, 1, 'searchicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', 'save', null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/protrace/thirdaudit/opinion');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/protrace/thirdaudit/opinion', '审核意见', 'opinioninfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '审核意见', null, null, '{busguid:''8DB78FE7219440ADA2DD4D8B93384D2A''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/protrace/thirdaudit/opinion', '附件管理', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''traceproreport'',url:''/pmkpi/upload/file/index.page?filebustype=traceproreport''}', null, '0', 'iframemance', null, null, null, null, null, null);
