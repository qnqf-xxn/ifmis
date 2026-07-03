begin

--°´Å¥
delete from P#busfw_t_Uifunction t where t.key='/pmkpi/setting/uservagency';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C079694025664C39BF980DB450956CE8', '/pmkpi/setting/uservagency', '±£´æ', 1, 1, 'save', 'Ext.lt.uatemplate.save', null, '±£´æ', 'pmkpi', 'save', null, '{}');
