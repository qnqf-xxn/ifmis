begin
  --预警规则配置
  delete from p#busfw_t_uitable where key = '/pmkpi/setting/warnset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB527F40E597D464A3E8A31FH0', '/pmkpi/setting/warnset', 'PERF_T_WARNSET', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/warnset';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC6810sf684F1791', '/pmkpi/setting/warnset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548C2A1F55154SF78A224', '/pmkpi/setting/warnset', 'CODE', '编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18ED264EED9SD8E66719D46885', '/pmkpi/setting/warnset', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC44D36A5B0D9GJ97A4A513', '/pmkpi/setting/warnset', 'TYPE', '类别', 4, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964343SGE224626E3DB144', '/pmkpi/setting/warnset', 'WARNSQL', 'SQL语句', 5, 1, 1, 0, null, 1, null, null, null, null, null, 200, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B5GS879D0BD5D33A', '/pmkpi/setting/warnset', 'YEAR', '年度', 8, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9ASB19C854D41D8D', '/pmkpi/setting/warnset', 'PROVINCE', '区划', 9, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/setting/warnset';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33E85834461EA5A1E96CAF1KK3E', '/pmkpi/setting/warnset', '保存', 1, 1, 'searchicon', 'perfdataset.savemajorkey', null, '保存', 'pmkpi', 'savemajorkey', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('43B3D3E65D7F47959KOAAC7C9E57052D', '/pmkpi/setting/warnset', '初始化', 1, 2, 'openstat', 'perfdataset.initset', null, '初始化', 'pmkpi', 'initset', '1', '{}');

delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/warnset';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC999AD6884E5EECB0DA7DB633B07718', '/pmkpi/setting/warnset', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_WARNSET', '{}', null);


--公式编辑区配置
delete from p#busfw_t_uitable where key = '/pmkpi/setting/editformal';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB509F40E597Dss4A3E8A31FH0', '/pmkpi/setting/editformal', 'PERF_T_EDITFORMAL', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/editformal';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC68sdsf684F1709', '/pmkpi/setting/editformal', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548dsA1F55154SF78A224', '/pmkpi/setting/editformal', 'TABLECODE', null, 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18fg2609ED9SD8E66719D46885', '/pmkpi/setting/editformal', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40sf6A5B0D9GJ97A4A513', '/pmkpi/setting/editformal', 'COLUMNCODE', null, 4, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F9640sdSGE224sf6E3DB144', '/pmkpi/setting/editformal', 'QUERYSQL', '查询语句', 5, 1, 1, 0, null, 1, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494sd8B09S879D0BD5D33A', '/pmkpi/setting/editformal', 'YEAR', '年度', 10, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764asD9AS099C854D41D8D', '/pmkpi/setting/editformal', 'PROVINCE', '区划', 11, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9Aas99C854DsiD8D', '/pmkpi/setting/editformal', 'ORDERNUM', '排序', 9, 1, 1, 0, null, 1, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B09S879gdBD5D33A', '/pmkpi/setting/editformal', 'VALUE', '值', 8, 1, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B0gd879D0BD5D33A', '/pmkpi/setting/editformal', 'SUMCOL', null, 7, 1, 1, 0, null, 1, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964093SGE2246gdE3DB144', '/pmkpi/setting/editformal', 'AGENCYGUID', '单位guid', 6, 1, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/editformal';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('43B3D3E65D7F479afKOAAC7C9E57052D', '/pmkpi/setting/editformal', '初始化', 1, 2, 'openstat', 'perfdataset.initset', null, '初始化', 'pmkpi', 'initset', '1', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33sf5834461EA5A1E96CAF1KK3E', '/pmkpi/setting/editformal', '保存', 1, 1, 'searchicon', 'perfdataset.savemajorkey', null, '保存', 'pmkpi', 'savemajorkey', null, '{}');

delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/editformal';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC995AD6884E5EECB0DA7DB633B07718', '/pmkpi/setting/editformal', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_EDITFORMAL', '{}', null);


--审核定义下级菜单
delete from p#busfw_t_uitable where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB509F40E597D464A3E8A31FH0', '/pmkpi/setting/auditdefinemenu', 'PERF_T_AUDITDEFINEMENU', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC6810sf684F1709', '/pmkpi/setting/auditdefinemenu', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548C2A1F55154SF78A224', '/pmkpi/setting/auditdefinemenu', 'CODE', '编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18ED2609ED9SD8E66719D46885', '/pmkpi/setting/auditdefinemenu', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40936A5B0D9GJ97A4A513', '/pmkpi/setting/auditdefinemenu', 'SUPERID', '父级菜单ID', 4, 1, 1, 0, null, 1, null, null, '#code-#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964093SGE224626E3DB144', '/pmkpi/setting/auditdefinemenu', 'REMARK', '备注', 5, 1, 1, 0, null, 1, null, null, null, null, null, 200, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B09S879D0BD5D33A', '/pmkpi/setting/auditdefinemenu', 'YEAR', '年度', 10, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9AS099C854D41D8D', '/pmkpi/setting/auditdefinemenu', 'PROVINCE', '区划', 11, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9AS099C854DsiD8D', '/pmkpi/setting/auditdefinemenu', 'ORDERNUM', '排序', 6, 1, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9AS09sd854DsiD8D', '/pmkpi/setting/auditdefinemenu', 'LEVELNO', '层级', 7, 0, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40936A5Bok9GJ97A4A513', '/pmkpi/setting/auditdefinemenu', 'ISLEAF', '是否是叶子节点', 8, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40936A5B0olGJ97A4A513', '/pmkpi/setting/auditdefinemenu', 'STATUS', '状态', 9, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33E85834461EA5foE96CAF1KK3E', '/pmkpi/setting/auditdefinemenu', '保存', 1, 1, 'searchicon', 'perfdataset.save', null, '保存', 'pmkpi', 'save', null, '{}');

delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC994AD6884E5EECB0DA7DB633B07718', '/pmkpi/setting/auditdefinemenu', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_AUDITDEFINEMENU', '{}', null);

