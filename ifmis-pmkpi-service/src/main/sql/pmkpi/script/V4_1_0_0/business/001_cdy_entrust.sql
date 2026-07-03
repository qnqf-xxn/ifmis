begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/review/entrust/expert') and t.id in('datatable');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/entrust/expert', 'busuidatatable', '{key:''/pmkpi/review/entrust/expert'',name:''专家库'',checkbox:true,title:''专家库'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

update p#busfw_t_uitable t set t.pagenum=0 where t.key in('/pmkpi/review/entrust/selexpert');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/review/entrust/expert') and t.columncode in('ISGROUP');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/review/entrust/expert', 'ISGROUP', '是否组长', 1, 1, 1, 0, null, 0, 2, null, null, null, null, null, 0, 's', null, null, null, null,'87',2016);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/review/entrust/selexpert') and t.columncode in('ISGROUP');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/review/entrust/selexpert', 'ISGROUP', '是否组长', 1, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, null, 1, 'tree', null, null, null, null,'87',2016);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/entrust/expert');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/review/entrust/expert', '保存', 0, 1, 'searchicon', 'pmkpientrustexpert.save', null, '保存', 'pmkpi', 'save', null, '{}', null, null,'87',2016);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/review/entrust/expert', '删除', 1, 2, 'searchicon', 'pmkpientrustexpert.del', null, '删除', 'pmkpi', 'del', null, '{}', null, null,'87',2016);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/review/entrust/expert', '审核', 0, 3, 'searchicon', 'pmkpientrustexpert.saveaudit', null, '审核', 'pmkpi', 'audit', null, '{}', null, null,'87',2016);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/review/entrust/expert', '保存并审核', 1, 4, 'searchicon', 'pmkpientrustexpert.saveaudit', null, '保存并审核', 'pmkpi', 'saveaudit', null, '{}', null, null,'87',2016);
