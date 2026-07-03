begin
  
update p#busfw_t_uitable t set t.pagenum=0 where t.key in('/pmkpi/evaluate/thirdevaluate/selentrust');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/evaluate/thirdevaluate/entrust');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluate/thirdevaluate/entrust', '±£´æ', 0, 1, 'searchicon', 'evaluateentrustservice.save', null, '±£´æ', 'pmkpi', 'save', null, '{}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluate/thirdevaluate/entrust', 'É¾³ý', 1, 2, 'searchicon', 'evaluateentrustservice.del', null, 'É¾³ý', 'pmkpi', 'del', null, '{}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluate/thirdevaluate/entrust', 'ÉóºË', 0, 3, 'searchicon', 'evaluateentrustservice.saveaudit', null, 'ÉóºË', 'pmkpi', 'audit', null, '{}', null, null, '2016','87');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluate/thirdevaluate/entrust', '±£´æ²¢ÉóºË', 1, 4, 'searchicon', 'evaluateentrustservice.saveaudit', null, '±£´æ²¢ÉóºË', 'pmkpi', 'saveaudit', null, '{}', null, null, '2016','87');
