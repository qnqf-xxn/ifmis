begin
  
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/rectification/programquery');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/programquery', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/programquery', '整改通知详情', 'rectification', 0, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, null, '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/programquery', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/programquery', '反馈信息详情', 'feedbackInfo', 0, 4, 'nomal', 'addprogram.clickTabpage', null, '反馈信息详情', null, null, '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/programquery', '整改反馈附件', 'file', 1, 5, 'nomal', 'addprogram.clickTabpage', null, '整改反馈附件', null, null, '{filebustype:''feedback'',url:''/pmkpi/rectification/feedbackfile.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/programquery', '结果应用意见', 'resultOpinion', 1, 6, 'nomal', 'addprogram.clickTabpage', null, '结果应用意见', null, null, '{url:''/pmkpi/rectification/feedback/resultopinion.page?showfin=1'',action:''resultopinion.infosave''}', null, '0', 'resultopinioniframe', null, null, null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/rectification/feedback/resultopinion') and t.COLUMNCODE in('FINFEEDBACKAMT','FINFEEDBACKREMARK');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedback/resultopinion', 'V_PERF_T_RECTIFY', 'amt', '资金', 'FINFEEDBACKAMT', 0, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedback/resultopinion', 'V_PERF_T_RECTIFY', 'textarea', '具体情况说明', 'FINFEEDBACKREMARK', 0, null, 0, null, 4, 3, '2', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);
