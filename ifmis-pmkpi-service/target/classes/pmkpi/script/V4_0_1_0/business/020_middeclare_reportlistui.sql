begin
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/list' and COLUMNCODE = 'PRO_CODE';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E5143AC1E053B11FA8C06F54', '/pmkpi/program/report/list', 'PRO_CODE', 'ÏîÄ¿±àÂë', 1, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
