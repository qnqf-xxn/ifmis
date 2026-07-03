begin
delete FROM p#Busfw_t_Uicolumn t where t.key in 
('/pmkpi/perfselftaskmanage/index','/pmkpi/perfself/apply/index','/pmkpi/perfself/apply/edit/bdgpay','/pmkpi/perfself/apply/edit/selfindex');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598810DAFE4530603A8C02DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT1', '年初预算', 2, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598820DAFE8530603A8C02DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT2', '年度预算调整', 3, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598850DAFE0530603A8C62DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT3', '调整后的预算', 4, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598860DAFE0530603A8C82DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT4', '全年执行数', 5, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598870DAFE0530603A8C02DD1', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT5', '预算执行率%', 6, 1, 0, null, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598800DAFE0530603A8C42DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMTNAME', '资金来源', 1, 1, 0, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDABD6B412367EE053470A050A2333', '/pmkpi/perfself/apply/edit/bdgpay', 'SCORE', '得分', 6, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);


insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C211A3BA69E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'INDEXVAL', '指标值', 6, 1, 0, 0, '0', 0, null, null, null, null, 0, 150, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C211A2BA11E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'WEIGHT', '权重', 11, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 'f', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('S8F4EBD5BB205FECE0530603A8C0B67C', '/pmkpi/perfself/apply/edit/selfindex', 'SUPERID', '父级', 8, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C211A2BA11Q053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'SCORE', '实际得分', 12, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 'f', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('S50AC9D3BB0B1105E053B10A10ACCC73', '/pmkpi/perfself/apply/edit/selfindex', 'KPI_REMARK', '备注', 13, 1, 1, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('S50AC9D3BB071105E053B10A10ACCC73', '/pmkpi/perfself/apply/edit/selfindex', 'NAME', '指标名称', 4, 1, 0, 0, '0', 0, null, null, null, null, 0, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SAAEADD6DB982963E0530603A8C08AD1', '/pmkpi/perfself/apply/edit/selfindex', 'METERUNIT', '指标度量单位', 10, 1, 0, 0, '0', 0, null, null, null, null, 0, 20, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C21195BA69E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'MAINGUID', '目标ID', 2, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF80D3C21194BA69E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'LEVELNO', '级别', 0, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('S8F4EBD5BB205FECE0530603A8C0B67C', '/pmkpi/perfself/apply/edit/selfindex', 'ISLEAF', '叶子节点', 9, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C21194BA69E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('S4F657602AF00D51E053B10A10AC7BAF', '/pmkpi/perfself/apply/edit/selfindex', 'COMPUTESIGN', '计算符号', 5, 1, 0, 0, '0', 0, null, null, '#name', null, 0, 50, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SF60D3C211ABBA69E053D100A8C02F03', '/pmkpi/perfself/apply/edit/selfindex', 'ACTUALVALUE', '实际完成值', 7, 1, 1, 0, '0', 0, null, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59538', '/pmkpi/perfself/apply/index', 'WFSTATUS', '状态', 0, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/index', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59558', '/pmkpi/perfself/apply/index', 'NAME', '项目名称', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59568', '/pmkpi/perfself/apply/index', 'AGENCYGUID', '预算单位', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59598', '/pmkpi/perfself/apply/index', 'FININTORGGUID', '业务处室', 3, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P41C52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/index', 'BUDGETAMOUNT', '全年预算数', 4, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P4CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/index', 'EXECAMOUNT', '全年执行数', 5, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P53C52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/index', 'EXECRATE', '预算执行率%', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59508', '/pmkpi/perfself/apply/index', 'CREATER', '填报人', 8, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P24C52DDE57C4570BEA25AD5CED59578', '/pmkpi/perfself/apply/index', 'SCORE', '得分', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P24552DDE57C4570BEA25AD5CED59578', '/pmkpi/perfself/apply/index', 'SELFRESULT', '自评结论', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE6D53F294EB7828E053B11FA8C05E98', '/pmkpi/perfself/apply/index', 'WARN', '自评预警', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59578', '/pmkpi/perfself/apply/index', 'REMAININGDAYS', '截止天数', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2FC252932BC931E053B11FA8C0EE7B', '/pmkpi/perfself/apply/index', 'PROJGUID', '项目GUID', 99, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P5CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfselftaskmanage/index', 'EXECRATE', '预算执行率%', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PB174FC9FB14451ABF9EC829284834FB', '/pmkpi/perfselftaskmanage/index', 'EVALSTART', '开始时间', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P779FD9708CC483EA6DB414BF576D158', '/pmkpi/perfselftaskmanage/index', 'EVALEND', '截止时间', 8, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8E795E29D30568E053B11FA8C0FD95', '/pmkpi/perfselftaskmanage/index', 'PROJCODE', '项目编码', 0, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P1CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfselftaskmanage/index', 'AGENCYGUID', '预算单位', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P0CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfselftaskmanage/index', 'NAME', '项目名称', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P2CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfselftaskmanage/index', 'FININTORGGUID', '业务处室', 3, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P3CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfselftaskmanage/index', 'BUDGETAMOUNT', '全年预算数', 4, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P4CC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfselftaskmanage/index', 'EXECAMOUNT', '全年执行数', 5, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

