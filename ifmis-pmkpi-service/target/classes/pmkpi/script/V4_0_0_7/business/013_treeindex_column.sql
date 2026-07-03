begin
  
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/program/report/treeindex' and t.columncode in ('VALUE_REMARK');
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/treeindexcolum077', '/pmkpi/program/report/treeindex', 'VALUE_REMARK', '指标值说明', 47, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);


UPDATE P#busfw_t_Uicolumn t set t.name='参考指标值' where t.columncode='VALUE_DESC' and t.key='/pmkpi/program/prjindex/recomindex';
UPDATE P#busfw_t_Uicolumn t set t.name='参考指标值' where t.columncode='VALUE_DESC' and t.key='/pmkpi/program/report/treeindex';