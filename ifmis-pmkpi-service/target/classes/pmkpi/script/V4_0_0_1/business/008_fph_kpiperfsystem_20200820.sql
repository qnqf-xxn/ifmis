begin

DELETE FROM P#busfw_t_Uitable t WHERE t.key='/pmkpi/setting/kpisystemset';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB527F40E597D464A3E8A31860', '/pmkpi/setting/kpisystemset', 'V_PERF_T_SYSTEMSET', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t WHERE t.key='/pmkpi/setting/kpisystemset';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC6810CD684F1791', '/pmkpi/setting/kpisystemset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548C2A1F551547078A224', '/pmkpi/setting/kpisystemset', 'PARAMCODE', '编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18ED264EED90C8E66719D46885', '/pmkpi/setting/kpisystemset', 'PARAMNAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC44D36A5B0D9AD97A4A513', '/pmkpi/setting/kpisystemset', 'PARAMVALUE', '参数', 4, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964343B1E224626E3DB144', '/pmkpi/setting/kpisystemset', 'REMARK', '描述', 5, 1, 1, 0, null, 1, null, null, null, null, null, 200, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E71C38F9FCF940B18D2410570F6A6B22', '/pmkpi/setting/kpisystemset', 'APPID', '系统', 6, 0, 0, 0, null, 0, null, null, null, null, null, 50, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6FBD88D7D3864FADAEFBD723356C2853', '/pmkpi/setting/kpisystemset', 'ORDERNUM', '排序', 10, 1, 0, 0, null, 0, null, null, null, null, null, 50, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B514879D0BD5D33A', '/pmkpi/setting/kpisystemset', 'YEAR', '年度', 8, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9C9B19C854D41D8D', '/pmkpi/setting/kpisystemset', 'PROVINCE', '区划', 9, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7886678D7B4E48928E8C1ED72B47067B', '/pmkpi/setting/kpisystemset', 'STATUS', '状态', 7, 1, 0, 0, null, 0, null, null, '#name', null, null, 50, null, 'tree', null, null);


DELETE FROM P#busfw_t_Uifunction t WHERE t.key='/pmkpi/setting/kpisystemset';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33E85834461EA5A1E96CAF11253E', '/pmkpi/setting/kpisystemset', '保存', 1, 1, 'searchicon', 'kpisystemset.saveSystem', null, '保存', 'pmkpi', 'saveSystem', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('43B3D3E65D7F4795932AAC7C9E57052D', '/pmkpi/setting/kpisystemset', '启用', 1, 2, 'openstat', 'kpisystemset.openstat', null, '启用', 'pmkpi', 'openstat', '1', '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('31A5D20132224AF88162EF7D29C42FA6', '/pmkpi/setting/kpisystemset', '关闭', 1, 3, 'downstat', 'kpisystemset.downstat', null, '关闭', 'pmkpi', 'downstat', '0', '{}');
