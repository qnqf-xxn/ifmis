begin 

delete from p#busfw_t_uifunction where key ='/pmkpi/perfself/apply/edit/selfindex' and action='selfindex.saveDrafts';

delete from p#busfw_t_uifunction where key ='/pmkpi/perfself/apply/editdept/selfindex' and action='selfindex.saveDrafts';

delete from p#busfw_t_uifunction where key ='/pmkpi/perfself/apply/edit' and action='tabfreamedit.midsave';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/edit', 'ÔÝ´æ', 1, 0, 'Keepicon', 'tabfreamedit.midsave', null, 'ÔÝ´æ', 'pmkpi', null, null, null);


update p#busfw_t_uitabpage set hidebtns = '±£´æ,ÔÝ´æ' where key ='/pmkpi/perfself/apply/edit' and code in ('file','opinion');

update p#busfw_t_uitabpage set hidebtns = '±£´æ,ÔÝ´æ' where key ='/pmkpi/perfself/apply/dept/edit' and code in ('file','opinion');