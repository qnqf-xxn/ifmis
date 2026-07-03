begin
  
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/upload/file/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BEE5E20ADBDFEE4FE053B11FA8C02857', '/pmkpi/upload/file/index', 'PERF_FILETYPE', 100, 0, null, 'order by ordernum', null, 'pmkpi', '{}');

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/upload/file/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEF48E7F142FB126E053B11FA8C07C5A', '/pmkpi/upload/file/index', 'SUPERID', '父级id', 16, 0, 0, null, null, 1, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE5E20ADBE0EE4FE053B11FA8C02857', '/pmkpi/upload/file/index', 'REMARK', '备注', 4, 0, 1, null, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE5E20ADBE1EE4FE053B11FA8C02857', '/pmkpi/upload/file/index', 'NAME', '附件分类', 3, 1, 0, null, null, 1, 6, null, null, null, null, 250, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE5E20ADBE2EE4FE053B11FA8C02857', '/pmkpi/upload/file/index', 'ORDERNUM', '排序', 5, 0, 0, null, null, 1, 6, null, null, null, null, 50, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE5E20ADBE3EE4FE053B11FA8C02857', '/pmkpi/upload/file/index', 'GUID', '主键', 15, 0, 0, null, null, 1, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEF5BDE3FF5AD6A1E053B11FA8C0588A', '/pmkpi/upload/file/index', 'SUPERNAME', '上级附件类型', 1, 1, 0, null, null, 1, 6, null, null, null, null, 250, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ddggE20ADBE3EE4FE053B11FA3457da2', '/pmkpi/upload/file/index', 'CODE', '编码', 2, 0, 0, null, null, 1, 6, null, null, null, null, null, 0, 's', '{}', null);
