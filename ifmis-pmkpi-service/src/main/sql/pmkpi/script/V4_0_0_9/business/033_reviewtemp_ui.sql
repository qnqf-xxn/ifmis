begin 
  
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/dataset/reviewtemp';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BEE0AF68C4AF105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', 'V_PERF_T_REVIEWTEMP', 100, 0, null, 'order by ordernum', null, 'pmkpi', '{}');


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/dataset/reviewtemp';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE0AF68C4B0105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', 'CONTEXT', '内容', 3, 1, 1, null, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE0AF68C4B1105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', 'NAME', '名称', 1, 1, 1, null, null, 1, 6, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE0AF68C4B2105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', 'ORDERNUM', '排序', 5, 1, 1, null, null, 1, 6, null, null, null, null, 50, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BEE0AF68C4B3105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', 'GUID', '主键', 15, 0, 0, null, null, 1, null, null, null, null, null, null, 0, 's', '{}', null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/dataset/reviewtemp';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BEE0AF68C4B4105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', 'NAME', '名称', 1, 1, 's', null, 1, 1, 'pmkpi', null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/dataset/reviewtemp';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BEE0AF68C4B5105EE053B11FA8C01F61', '/pmkpi/setting/dataset/reviewtemp', '保存', 1, 1, 'searchicon', 'perfdataset.save', null, '保存', 'pmkpi', 'save', null, '{}');
