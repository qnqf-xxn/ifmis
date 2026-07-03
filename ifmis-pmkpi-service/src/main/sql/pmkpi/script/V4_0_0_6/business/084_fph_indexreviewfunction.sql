begin

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/deptperformance/report/perfindex' and t.code='reviewinfo';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BCAC837AF858A4B3E053B11FA8C0F8B7', '/pmkpi/deptperformance/report/perfindex', '查看评审意见', 1, 8, 'keepicon', 'deptindex.reviewinfo', null, '查看评审意见', 'pmkpi', 'reviewinfo', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/program/report/treeindex' and t.code='reviewinfo';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BCAC837AF857A4B3E053B11FA8C0F8B7', '/pmkpi/program/report/treeindex', '查看评审意见', 1, 8, 'keepicon', 'prjtreeindex.reviewinfo', null, '查看评审意见', 'pmkpi', 'reviewinfo', null, null);

