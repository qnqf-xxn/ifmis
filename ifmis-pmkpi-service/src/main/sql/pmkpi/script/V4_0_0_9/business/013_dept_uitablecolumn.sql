begin
delete FROM p#Busfw_t_Uicolumn t where t.key in 
('/pmkpi/perfselftaskmanage/dept/index','/pmkpi/perfself/apply/dept/index','/pmkpi/perfself/apply/editdept/selfindex');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/dept/index', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59538', '/pmkpi/perfself/apply/dept/index', 'WFSTATUS', '状态', 0, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE47B171213FEF62E053B11FA8C04FC6', '/pmkpi/perfself/apply/dept/index', 'CODE', '部门编码', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59558', '/pmkpi/perfself/apply/dept/index', 'NAME', '部门名称', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59598', '/pmkpi/perfself/apply/dept/index', 'FININTORGGUID', '业务处室', 3, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59588', '/pmkpi/perfself/apply/dept/index', 'BUDGETAMOUNT', '全年预算数', 4, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P4CC51DDE27C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/dept/index', 'EXECAMOUNT', '全年执行数', 5, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P53C53DDE37C4570BEA25AD5CED59548', '/pmkpi/perfself/apply/dept/index', 'EXECRATE', '预算执行率%', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59508', '/pmkpi/perfself/apply/dept/index', 'CREATER', '填报人', 8, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P24C54DDE47C4570BEA25AD5CED59578', '/pmkpi/perfself/apply/dept/index', 'SCORE', '得分', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P24555DDE77C4570BEA25AD5CED59578', '/pmkpi/perfself/apply/dept/index', 'SELFRESULT', '自评结论', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE6D53F294EC7828E053B11FA8C05E98', '/pmkpi/perfself/apply/dept/index', 'WARN', '自评预警', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59578', '/pmkpi/perfself/apply/dept/index', 'REMAININGDAYS', '截止天数', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PDCC52DDE57C4570BEA25AD5CED59568', '/pmkpi/perfself/apply/dept/index', 'AGENCYGUID', '预算单位', 12, 0, 0, 0, null, 0, 6, null, '#name', null, null, 180, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex014', '/pmkpi/perfself/apply/editdept/selfindex', 'SUPERID', '父级', 8, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex015', '/pmkpi/perfself/apply/editdept/selfindex', 'WEIGHT', '权重', 11, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 'f', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex013', '/pmkpi/perfself/apply/editdept/selfindex', 'SCORE', '实际得分', 12, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 'f', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex001', '/pmkpi/perfself/apply/editdept/selfindex', 'ACTUALVALUE', '实际完成值', 7, 1, 1, 0, '0', 0, null, null, null, null, 0, 150, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex002', '/pmkpi/perfself/apply/editdept/selfindex', 'COMPUTESIGN', '计算符号', 5, 1, 0, 0, '0', 0, null, null, '#name', null, 0, 50, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex003', '/pmkpi/perfself/apply/editdept/selfindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex004', '/pmkpi/perfself/apply/editdept/selfindex', 'INDEXVAL', '指标值', 6, 1, 0, 0, '0', 0, null, null, null, null, 0, 150, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex005', '/pmkpi/perfself/apply/editdept/selfindex', 'ISLEAF', '叶子节点', 9, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex006', '/pmkpi/perfself/apply/editdept/selfindex', 'LEVELNO', '级别', 0, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex012', '/pmkpi/perfself/apply/editdept/selfindex', 'KPI_REMARK', '备注', 13, 1, 1, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex011', '/pmkpi/perfself/apply/editdept/selfindex', 'NAME', '指标名称', 4, 1, 0, 0, '0', 0, null, null, null, null, 0, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex008', '/pmkpi/perfself/apply/editdept/selfindex', 'METERUNIT', '指标度量单位', 10, 1, 0, 0, '0', 0, null, null, null, null, 0, 20, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('perfselfeditdept/selfindex007', '/pmkpi/perfself/apply/editdept/selfindex', 'MAINGUID', '目标ID', 2, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F30FF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'EVALEND', '截止时间', 8, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F2FFF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'EVALSTART', '开始时间', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F2EFF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'EXECRATE', '预算执行率%', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F2DFF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'EXECAMOUNT', '全年执行数', 5, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F2CFF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'BUDGETAMOUNT', '全年预算数', 4, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F2AFF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'AGENCYGUID', '预算单位', 2, 0, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F2BFF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'FININTORGGUID', '业务处室', 3, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F29FF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'NAME', '部门名称', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE4689C05F28FF89E053B11FA8C08463', '/pmkpi/perfselftaskmanage/dept/index', 'PROJCODE', '部门编码', 0, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

