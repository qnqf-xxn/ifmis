begin


delete from  p#Busfw_t_Uitabpage t where t.guid='BD2A3B90E53E3AC1E053B11FAPPP6F54';

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW,COMPONENTSERVICEID,COMPONENTCALLBACKFN,DEFAULTFILTER) 
values ('BD2A3B90E53E3AC1E053B11FAPPP6F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '项目关联', 'relation', 0, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '项目关联', null, null, '{url:''/pmkpi/evaluation/finconfirm/prorelation.page'',busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'relationiframe', null, null, null, null, null, null);