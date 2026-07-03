begin

--按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/expertinifo' and guid in ('DF634DFA91540141F5F84F8E5DE34563','E1E7C9D309D44E175E2D5953FF7FF9D9');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DF634DFA91540141F5F84F8E5DE34563', '/pmkpi/setting/baseinfo/expertinifo', '修改(山西)', 0, 6, 'Keepicon', 'baseinfo.sxupdate', null, '修改(山西)', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E1E7C9D309D44E175E2D5953FF7FF9D9', '/pmkpi/setting/baseinfo/expertinifo', '新增(山西)', 0, 5, 'Keepicon', 'baseinfo.sxadd', null, '新增(山西)', 'pmkpi', null, null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/policylib' and guid in ('E7F89190E9799023BAD4E20EF6F9FEE3','560B67943B2238769105B3D8F7768EA2');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('560B67943B2238769105B3D8F7768EA2', '/pmkpi/setting/baseinfo/policylib', '修改(山西)', 0, 7, 'Keepicon', 'baseinfo.sxupdate', null, '修改(山西)', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7F89190E9799023BAD4E20EF6F9FEE3', '/pmkpi/setting/baseinfo/policylib', '新增(山西)', 0, 6, 'Keepicon', 'baseinfo.sxadd', null, '新增(山西)', 'pmkpi', null, null, null);



delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/standard' and guid in ('05E5B27AF9841B3ACE2BFB46947A5CF9','C7CCF9B35DD5954155BEF6431EB86909');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('05E5B27AF9841B3ACE2BFB46947A5CF9', '/pmkpi/setting/baseinfo/standard', '新增(山西)', 0, 6, 'Keepicon', 'baseinfo.sxadd', null, '新增(山西)', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C7CCF9B35DD5954155BEF6431EB86909', '/pmkpi/setting/baseinfo/standard', '修改(山西)', 0, 7, 'Keepicon', 'baseinfo.sxupdate', null, '修改(山西)', 'pmkpi', null, null, null);



--页签
delete from p#busfw_t_uitabpage where key = '/pmkpi/setting/baseinfo/expertinifo/addoredit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('3B48C8BB0211D741DBF3DB94169F4356', 'pmkpi', '/pmkpi/setting/baseinfo/expertinifo/addoredit', '附件管理', 'file', 1, 2, 'nomal', 'baseinfoedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('ECE8483249CB1301DC2CC3C71CAB8863', 'pmkpi', '/pmkpi/setting/baseinfo/expertinifo/addoredit', '基本信息', 'datainfo', 1, 1, 'choosed', 'baseinfoedit.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/setting/baseinfo/policylib/sxedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('08FDCB609D1B1292A856CD5167BEBCAD', 'pmkpi', '/pmkpi/setting/baseinfo/policylib/sxedit', '基本信息', 'datainfo', 1, 1, 'choosed', 'baseinfoedit.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A2D55AA69F499033F63A675A796DD35F', 'pmkpi', '/pmkpi/setting/baseinfo/policylib/sxedit', '附件管理', 'file', 1, 2, 'nomal', 'baseinfoedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);



delete from p#busfw_t_uitabpage where key = '/pmkpi/setting/baseinfo/standard/sxedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D7A02865B5F7B16CA3118BE001ECF9DC', 'pmkpi', '/pmkpi/setting/baseinfo/standard/sxedit', '基本信息', 'datainfo', 1, 1, 'choosed', 'baseinfoedit.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('FA19DB9F0C6223545D043AEEC23DE5EB', 'pmkpi', '/pmkpi/setting/baseinfo/standard/sxedit', '附件管理', 'file', 1, 2, 'nomal', 'baseinfoedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);
