begin
delete from p#busfw_t_uicolumn where key = '/pmkpi/review/report/program' and COLUMNCODE = 'PRO_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D3P0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'PRO_CODE', 'ÏîÄ¿±àÂë', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
