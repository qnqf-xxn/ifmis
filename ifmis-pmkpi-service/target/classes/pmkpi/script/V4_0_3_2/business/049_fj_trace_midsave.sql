begin 

delete from p#busfw_t_uifunction where key ='/pmkpi/program/trace/report/edit/indextarget' and action='proindextrace.saveDrafts';

delete from p#busfw_t_uifunction where key ='/pmkpi/trace/report/deptedit/indextarget' and action='proindextrace.saveDrafts';

delete from p#busfw_t_uifunction where key ='/pmkpi/program/trace/report/edit' and action='tabfreamedit.midsave';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/report/edit', 'ÔÝ´æ', 1, 0, 'Keepicon', 'tabfreamedit.midsave', null, 'ÔÝ´æ', 'pmkpi', null, null, null);

delete from p#busfw_t_uifunction where key ='/pmkpi/trace/report/deptedit' and action='tabfreamedit.midsave';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/trace/report/deptedit', 'ÔÝ´æ', 1, 0, 'Keepicon', 'tabfreamedit.midsave', null, 'ÔÝ´æ', 'pmkpi', null, null, null);


update p#busfw_t_uitabpage set hidebtns = '±£´æ,ÔÝ´æ' where key ='/pmkpi/program/trace/report/ordinaryedit' and code ='tracefile';

update p#busfw_t_uitabpage set hidebtns = '±£´æ,ÔÝ´æ' where key ='/pmkpi/program/trace/report/edit' and code ='tracefile';

update p#busfw_t_uitabpage set hidebtns = '±£´æ,ÔÝ´æ' where key ='/pmkpi/trace/report/deptedit' and code ='depttracefile';
