begin
  
DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/evaluate/thirdevaluate/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC4E595CCE4B11C7E053B11FA8C0AD52', '/pmkpi/evaluate/thirdevaluate/index', '查看明细', 1, 7, 'searchicon', 'thirdevaluateservice.viewdetail', null, '查看明细', 'pmkpi', 'viewdetail', null, null);
