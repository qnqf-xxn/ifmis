begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/resultaudit' and code = 'evalaudit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/dept/resultaudit', '成果审核', 0, 8, 'searchicon', 'deptevaluationresult.evalaudit', null, '成果审核', 'pmkpi', 'evalaudit', null, '{}', null, null, '2016','87');


delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/result/edit' and code = 'finresultfile';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/edit', '评价成果(处室)', 'finresultfile', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果(处室)', null, '保存', '{filebustype:''findeptevaproresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null, null, null, '2016','87');


