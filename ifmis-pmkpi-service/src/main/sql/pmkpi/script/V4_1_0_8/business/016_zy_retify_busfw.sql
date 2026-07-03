begin
  
delete from busfw_t_uitabpage where key = '/pmkpi/rectification/program/edit' and code = 'resultOpinion';
insert into p#busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/rectification/program/edit', '结果应用意见', 'resultOpinion', 0, 6, 'nomal', 'addprogram.clickTabpage', null, '结果应用意见', null, null, '{url:''/pmkpi/rectification/feedback/resultopinion.page'',action:''resultopinion.infosave''}', null, '0', 'resultopinioniframe', null, null, null, null, null, null, null, null);


delete from p#busfw_t_uieditform where key = '/pmkpi/rectification/feedback/resultopinion';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedback/resultopinion', 'V_PERF_T_RECTIFY', 'tree', '业务处室预算调整意见', 'FINADJUSTADVICE', 1, null, 1, null, 0, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 1, null, null, null, null);



delete from p#busfw_t_uifunction where key = '/pmkpi/rectification/feedback/resultopinion';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedback/resultopinion', '保存', 1, 1, 'Keepicon', 'resultopinion.infosave', null, '保存', 'pmkpi', null, null, null, null, null);
