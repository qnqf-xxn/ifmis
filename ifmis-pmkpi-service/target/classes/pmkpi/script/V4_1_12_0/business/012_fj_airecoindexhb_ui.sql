begin

--湖北的引用指标按钮
delete from p#Busfw_t_uifunction t where t.key='/pmkpi/program/airecoindex' and code ='addindexhb' and action = 'airecoindex.addindexhb';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/airecoindex', '引用(湖北)', 0, 1, 'keepicon', 'airecoindex.addindexhb', null, '引用', 'pmkpi', 'addindexhb', null, null,'87', '2016');

--修复之前错误的code
update p#Busfw_t_uifunction set code = 'addindex' where key='/pmkpi/program/airecoindex' and action = 'airecoindex.addindex';

update p#Busfw_t_uifunction set code = 'closewin' where key='/pmkpi/program/airecoindex' and action = 'airecoindex.closewin';

update p#Busfw_t_uifunction set code = 'query' where key='/pmkpi/program/airecoindex' and action = 'airecoindex.query';