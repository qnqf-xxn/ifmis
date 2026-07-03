begin
  --部门指标表-ui注册 添加字段
delete from busfw_t_uicolumn where key = '/pmkpi/deptperformance/report/perfindex' and columncode in('ENDVALTYPE','ENDVALSOURCE','WEIGHT','VALRULE','EVIDENCEFILE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', 'ENDVALTYPE', '取值方式', 30, 0, 1, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', 'ENDVALSOURCE', '指标完成值数据来源', 31, 0, 1, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', 'WEIGHT', '指标分值权重', 32, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', 'VALRULE', '赋分规则', 33, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', 'EVIDENCEFILE', '佐证资料要求', 34, 0, 1, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

