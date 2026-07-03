begin

delete from p#busfw_t_uicolumn t where key='/pmkpi/program/prjindex/recomindex' and t.columncode='GUID';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D84291007BD86958E0533315A8C08058', '/pmkpi/program/prjindex/recomindex', 'GUID', 'guid', 48, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
