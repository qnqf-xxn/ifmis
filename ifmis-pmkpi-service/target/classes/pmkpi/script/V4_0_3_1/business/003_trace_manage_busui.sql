begin

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/trace/manage/prolist') and t.columncode in('PRO_CODE','PRO_NAME','PROCODE','PRONAME');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{type:''waitaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PROCODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{type:''alreadyaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRONAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''alreadyaudit''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{type:''waitaudit''}', null);

update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/program/trace/manage/prolist') and t.code='query';

update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/program/trace/manage/tasklist') and t.code='query';