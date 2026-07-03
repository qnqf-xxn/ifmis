begin
delete from p#BUSFW_T_UIFUNCTION where key in ('/pmkpi/evaluate/thirdevaluate/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4911C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '委托机构', 0, 1, 'searchicon', 'thirdevaluateservice.entrust', null, '委托机构', 'pmkpi', 'entrust', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4D11C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '确认第三方机构评审', 1, 2, 'searchicon', 'thirdevaluateservice.confirm', null, '确认第三方机构评审', 'pmkpi', 'confirm', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4711C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '取消第三方机构评审', 1, 3, 'searchicon', 'thirdevaluateservice.confirm', null, '取消第三方机构评审', 'pmkpi', 'unconfirm', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4811C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '退回', 1, 4, 'searchicon', 'thirdevaluateservice.confirm', null, '退回', 'pmkpi', 'back', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4B11C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '查看明细', 0, 7, 'searchicon', 'thirdevaluateservice.viewdetail', null, '查看明细', 'pmkpi', 'viewdetail', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4C11C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '审核情况', 0, 8, 'searchicon', 'thirdevaluateservice.viewlogs', null, '审核情况', 'pmkpi', 'viewlogs', null, null);