begin

DELETE FROM p#busfw_t_uitabpage t WHERE t.key='/pmkpi/workflow/parallel/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B80E3E9698FB467E87690ED0251B7EE5', 'pmkpi', '/pmkpi/workflow/parallel/audit', '审核', 'waitaudit', 1, 1, 'choosed', 'wfparallelaudit.clickTabpage', 0, '审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('9ABB5781DBA645FE8EF1CB9467FB7E01', 'pmkpi', '/pmkpi/workflow/parallel/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'wfparallelaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C6132E081FBB40A58C0781952D265888', 'pmkpi', '/pmkpi/workflow/parallel/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'wfparallelaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);


DELETE FROM p#busfw_t_uifunction t WHERE t.key='/pmkpi/workflow/parallel/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3F5CC9D79EFE404E8774282992E738BE', '/pmkpi/workflow/parallel/audit', '取消审核', 1, 2, 'searchicon', 'wfparallelaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A0B11C6A7DE34A8DA7A16EB25A6CD29A', '/pmkpi/workflow/parallel/audit', '审核情况', 1, 3, 'searchicon', 'wfparallelaudit.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D565DEF7378E4761B3206171E9FFC5F7', '/pmkpi/workflow/parallel/audit', '查看明细', 1, 4, 'searchicon', 'wfparallelaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6206CA53F88C44A09E882C8E6FA33475', '/pmkpi/workflow/parallel/audit', '审核', 1, 1, 'searchicon', 'wfparallelaudit.audit', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit"}');


