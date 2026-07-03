begin
  
--编辑区
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uieditformcols/edit' and t.columncode='ISQUERY';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C07838A97ED66FA2E053B11FA8C06BD9', '/pmkpi/set/uieditformcols/edit', 'ISQUERY', '是否查询（判断用）', 99, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

--按钮
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uifunctioncols/edit' and t.columncode='ISQUERY';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C07838A97ED76FA2E053B11FA8C06BD9', '/pmkpi/set/uifunctioncols/edit', 'ISQUERY', '是否查询（判断用）', 99, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);


--页签
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uitabcols/edit' and t.columncode='ISQUERY';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C07838A97ED86FA2E053B11FA8C06BD9', '/pmkpi/set/uitabcols/edit', 'ISQUERY', '是否查询（判断用）', 99, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

--查询区
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uiqueryformcols/edit' and t.columncode='ISQUERY';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C07838A97EDA6FA2E053B11FA8C06BD9', '/pmkpi/set/uiqueryformcols/edit', 'ISQUERY', '是否查询（判断用）', 99, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

--表格
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uidatatablecols/edit' and t.columncode='ISQUERY';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C07838A97EDF6FA2E053B11FA8C06BD9', '/pmkpi/set/uidatatablecols/edit', 'ISQUERY', '是否查询（判断用）', 99, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);
