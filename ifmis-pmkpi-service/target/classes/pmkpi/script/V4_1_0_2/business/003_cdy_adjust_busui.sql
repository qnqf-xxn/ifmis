begin
  
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/adjust/report/list') and t.COLUMNCODE in('NAME','AGENCY_CODE','AGENCYGUID');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/adjust/report/list', 'NAME', 'Ãû³Æ', 5, 1, 0, 0, null, null, 0, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/adjust/report/list', 'AGENCY_CODE', '±àÂë', 3, 1, 0, 0, null, null, 0, null, null, null, null, 150, 0, 's', '{lefttabtype:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/adjust/report/list', 'AGENCYGUID', 'Ô¤Ëãµ¥Î»', 6, 1, 0, 0, null, null, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{lefttabtype:''program''}', null);

update p#busfw_t_uicolumn t set isedit=0 where t.key ='/pmkpi/adjust/report/list' and t.columncode='WFSTATUS';