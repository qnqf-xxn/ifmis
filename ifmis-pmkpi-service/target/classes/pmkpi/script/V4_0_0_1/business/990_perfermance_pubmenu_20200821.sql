begin



delete from fasp_t_pubmenu t where t.guid='AB42C9B6FF83483989025AEF862402CB';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('AB42C9B6FF83483989025AEF862402CB', 1, 0, '1', '20', '部门绩效申报', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 20, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

delete from fasp_t_pubmenu t where t.parentid='AB42C9B6FF83483989025AEF862402CB';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('E612AE4B4B6546F2BAAEB3E7CF8B9567', 2, 1, '1', '20001', '部门绩效申报填报', 'AB42C9B6FF83483989025AEF862402CB', '/pmkpi/deptperformance/report/index.page?pagetype=report'||chr(38)||'workflow=D00E439AFACC701EDEE1DBA1EADE225F', 21, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('4E9F44DF9E664CD582A915FA79913FC9', 2, 1, '1', '20004', '部门绩效申报查询', 'AB42C9B6FF83483989025AEF862402CB', '/pmkpi/deptperformance/query/index.page', 24, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('a6973002b22a4a96f373feccc3ce0d7f', 2, 1, '1', '20003', '部门绩效申报审核', 'AB42C9B6FF83483989025AEF862402CB', '/pmkpi/deptperformance/audit/index.page?pagetype=audit'||chr(38)||'workflow=D00E439AFACC701EDEE1DBA1EADE225F', 23, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

delete from fasp_t_pubmenu t where t.code='110' and t.name = '审核流程管理';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('7237F27E0C5F4A758709690EE70A74D7', 1, 0, '1', '110', '审核流程管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 110, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

delete from fasp_t_pubmenu t where t.parentid='7237F27E0C5F4A758709690EE70A74D7';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('F8C821C3F95842EEB181C54C13137F41', 2, 1, '1', '110001', '流程节点审核配置', '7237F27E0C5F4A758709690EE70A74D7', '/pmkpi/auditnode/index.page', 111, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('A73AB0D6DF7F4CB29BE38D87548B3AF1', 2, 1, '1', '110003', '四性审核模板维护', '7237F27E0C5F4A758709690EE70A74D7', '/pmkpi/naturesaudit/index.page', 113, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

delete from fasp_t_pubmenu t where t.code='120' and t.name = '指标管理';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('A01BEE41C8944C9B8E3A96B8116F7A52', 1, 0, '1', '120', '指标管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 120, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

delete from fasp_t_pubmenu t where t.parentid='A01BEE41C8944C9B8E3A96B8116F7A52';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('DFD6CB32183F427481410D932C447738', 2, 1, '1', '120002', '模板库', 'A01BEE41C8944C9B8E3A96B8116F7A52', '/pmkpi/setting/model/list.page', 122, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('AB6EF9AD91EC468899F5918ADAB173AC', 2, 1, '1', '120001', '指标库', 'A01BEE41C8944C9B8E3A96B8116F7A52', '/pmkpi/index/list.page', 121, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('31F69D7C7C4142B8BBB71696FDBD9D39', 2, 1, '1', '120003', '案例库', 'A01BEE41C8944C9B8E3A96B8116F7A52', '/pmkpi/setting/case/list.page', 123, '', sysdate, 1, '', '', 'pmkpi', '', '', '', '', '', '', 1, '', '', '');


DELETE FROM fasp_T_pubmenu t where t.guid='0209D9B3C98F41EBAB07D89D40355235';
insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('0209D9B3C98F41EBAB07D89D40355235', 2, 1, '1', '20008', '绩效数据权限', '19242357040761A9497366E7B01D14C6', '/pmkpi/perfset/datarule.page', 29, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

delete from Fasp_t_Pubmenu t where t.guid='E8A79278CC9E42A1B73B148BA5F3BAFE';
insert into Fasp_t_Pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('E8A79278CC9E42A1B73B148BA5F3BAFE', 2, 1, '1', '20009', '用户对单位', '19242357040761A9497366E7B01D14C6', '/pmkpi/setting/uservagency.page', 30, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

delete from Fasp_t_Pubmenu t where t.guid='242EFA05E95346F7B08D1EFF323F7196';
insert into Fasp_t_Pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('242EFA05E95346F7B08D1EFF323F7196', 2, 1, '1', '110002', '评分配置', '7237F27E0C5F4A758709690EE70A74D7', '/pmkpi/setting/question.page', 112, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

--项目绩效调整
delete from fasp_T_pubmenu t where t.guid in('pmkpiprogramadjust2030111','pmkpiprogramadjust2030112','pmkpiprogramadjust2030113');
insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030111', 2, 1, '1', '2030111', '项目绩效调整填报(新)', 'pmkpiprogramadjust2030110', '/pmkpi/proadjust/report/list.page?prolev=3'||chr(38)||'workflow=ACB7014749AFD762BBFD99D8304BA3F2', 21, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030112', 2, 1, '1', '2030112', '项目绩效调整查询(新)', 'pmkpiprogramadjust2030110', '/pmkpi/proadjust/report/query.page?prolev=3', 24, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030113', 2, 1, '1', '2030113', '项目绩效调整审核(新)', 'pmkpiprogramadjust2030110', '/pmkpi/proadjust/report/audit.page?prolev=3'||chr(38)||'workflow=ACB7014749AFD762BBFD99D8304BA3F2', 23, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);


--项目绩效目标
delete from fasp_T_pubmenu t where t.guid in('pmkpiprogram2020113','pmkpiprogram2020112','pmkpiprogram2020111');
insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020113', 2, 1, '1', '2020113', '项目绩效目标审核(新)', 'pmkpiprogram2020110', '/pmkpi/program/report/audit.page?prolev=3'||chr(38)||'workflow=3DC76BC9CDA14F510E6D1B92AA561BE0', 23, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020112', 2, 1, '1', '2020112', '项目绩效目标查询(新)', 'pmkpiprogram2020110', '/pmkpi/program/query/list.page?prolev=3', 24, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020111', 2, 1, '1', '2020111', '项目绩效目标填报(新)', 'pmkpiprogram2020110', '/pmkpi/program/report/list.page?prolev=3'||chr(38)||'workflow=3DC76BC9CDA14F510E6D1B92AA561BE0', 21, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

--父级菜单
delete from fasp_T_pubmenu t where t.guid in('19242357040761A9497366E7B01D14C6','pmkpiprogram2020110',
'7237F27E0C5F4A758709690EE70A74D7','pmkpiprogramadjust2030110');

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('19242357040761A9497366E7B01D14C6', 1, 0, '1', '99', '系统配置管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', null, 99, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020110', 1, 0, '1', '2020110', '项目绩效目标申报(新)', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 20, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030110', 1, 0, '1', '2030110', '项目绩效调整(新)', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 20, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_T_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('7237F27E0C5F4A758709690EE70A74D7', 1, 0, '1', '110', '审核流程管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 110, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

delete from fasp_t_pubmenu t where t.guid in('ff7e2d2946d98ac734ecbd6798cba1e2','BC22D74299EF90451B79EDB3F93804DD','d449c51e117616c3fd99b5f7962123f0','5FF38D40BF87427A8E3E9D528A100AF3');
insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('ff7e2d2946d98ac734ecbd6798cba1e2', 1, 0, '1', '140', '审核定义', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 140, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('BC22D74299EF90451B79EDB3F93804DD', 2, 1, '1', '140001', '自定义视图信息', 'ff7e2d2946d98ac734ecbd6798cba1e2', '/pmkpi/auditviewinfo/index.page', 141, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('d449c51e117616c3fd99b5f7962123f0', 2, 1, '1', '140002', '审核定义信息配置', 'ff7e2d2946d98ac734ecbd6798cba1e2', '/pmkpi/auditdefine/index.page', 142, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('5FF38D40BF87427A8E3E9D528A100AF3', 2, 1, '1', '140003', '审核定义业务配置', 'ff7e2d2946d98ac734ecbd6798cba1e2', '/pmkpi/busauditdefine/index.page', 143, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

--绩效事前评估模板配置
delete from fasp_t_pubmenu t where guid ='E412DE2E152545178FC8BF9E8A29F36D';
insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('E412DE2E152545178FC8BF9E8A29F36D', 2, 1, '1', '20050', '绩效事前评估模板配置', '19242357040761A9497366E7B01D14C6', '/pmkpi/setting/assessment/list.page', 50, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);
