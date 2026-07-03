begin
delete from p#busfw_t_uifunction t where t.key ='/pmkpi/program/trace/audit' and t.action ='protraceaudit.addOredit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C1F697B4C6166ECEE053B11FA8C01111', '/pmkpi/program/trace/audit', 'ÐÞ¸Ä', 0, 9, 'searchicon', 'protraceaudit.addOredit', null, 'ÐÞ¸Ä', 'pmkpi', 'addOredit', null, '{}');
