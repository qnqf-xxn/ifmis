begin

delete from p#busfw_t_uifunction where key ='/pmkpi/deptTJformance/report/edit' and action='pmkpideptTJedit.infosavetmp';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptTJformance/report/edit', 'ÔÝ´æ', 1, 0, 'Keepicon', 'pmkpideptTJedit.infosavetmp', null, 'ÔÝ´æ', 'pmkpi', null, null, null);