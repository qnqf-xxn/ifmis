begin
delete from p#busfw_t_uicolumn where key = '/pmkpi/upload/file/index' and COLUMNCODE = 'FILENAME';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ddggE20ADBE3EE4FE053BPPPA3457da2', '/pmkpi/upload/file/index', 'FILENAME', '上传文件名', 16, 1, 0, null, null, 1, 6, null, null, null, null, null, 0, 's', '{}', null);
