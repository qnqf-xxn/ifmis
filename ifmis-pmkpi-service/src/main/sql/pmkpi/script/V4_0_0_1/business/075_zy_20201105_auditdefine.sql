begin

delete from PERF_T_AUDITDEFINE where guid in ('F05C0FFBDFA971ED7F274486286520E7','21D1B1C243EB187334CCFFB8717E94FE','80F88F7244109885C87DEBDDE54E5A29');

delete from p#busfw_t_uitabpage t where key in('/pmkpi/auditdefine/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0098b1df431fa8c72f38ec6299671263', 'pmkpi', '/pmkpi/auditdefine/index', '存储过程', 'procedure', 1, 1, 'choosed', 'auditdefine.clickTabpage', null, '存储过程', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('ca4d2e25471faa662a2979c0edbc4236', 'pmkpi', '/pmkpi/auditdefine/index', 'beanid', 'auditbeanid', 1, 2, 'nomal', 'auditdefine.clickTabpage', null, 'beanid', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('b22b3baf4eca3edf40b99d3271373681', 'pmkpi', '/pmkpi/auditdefine/index', '视图', 'singletable', 1, 3, 'nomal', 'auditdefine.clickTabpage', null, '视图', null, null, '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/kpisystemset' and columncode = 'GUID';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC6810CD684F1791', '/pmkpi/setting/kpisystemset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);