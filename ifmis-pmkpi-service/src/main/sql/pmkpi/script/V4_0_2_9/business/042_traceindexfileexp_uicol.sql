begin


delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/query' and COLUMNCODE ='TASKNAME';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/query', 'TASKNAME', 'ÈÎÎñÃû³Æ', 20, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);
