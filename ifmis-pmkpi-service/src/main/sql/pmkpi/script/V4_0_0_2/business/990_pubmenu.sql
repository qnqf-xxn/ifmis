begin
delete from fasp_t_pubmenu t where t.appid like'%pmkpi%';

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('C43D8AA7015B7F8B25CA18C3277CA4BE', 0, 0, '1', '0', '预算绩效管理', '0', null, 0, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('AB42C9B6FF83483989025AEF862402CB', 1, 0, '1', '001', '部门绩效申报', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 1, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('E612AE4B4B6546F2BAAEB3E7CF8B9567', 2, 1, '1', '001001', '部门绩效申报填报', 'AB42C9B6FF83483989025AEF862402CB', '/pmkpi/deptperformance/report/index.page?pagetype=report'||chr(38)||'workflow=D00E439AFACC701EDEE1DBA1EADE225F', 2, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('a6973002b22a4a96f373feccc3ce0d7f', 2, 1, '1', '001002', '部门绩效申报审核', 'AB42C9B6FF83483989025AEF862402CB', '/pmkpi/deptperformance/audit/index.page?pagetype=audit'||chr(38)||'workflow=D00E439AFACC701EDEE1DBA1EADE225F', 3, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('4E9F44DF9E664CD582A915FA79913FC9', 2, 1, '1', '001003', '部门绩效申报查询', 'AB42C9B6FF83483989025AEF862402CB', '/pmkpi/deptperformance/query/index.page', 4, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020110', 1, 0, '1', '005', '项目绩效目标申报', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 50, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020111', 2, 1, '1', '005001', '项目绩效目标填报', 'pmkpiprogram2020110', '/pmkpi/program/report/list.page?prolev=3'||chr(38)||'workflow=3DC76BC9CDA14F510E6D1B92AA561BE0', 51, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020113', 2, 1, '1', '005002', '项目绩效目标审核', 'pmkpiprogram2020110', '/pmkpi/program/report/audit.page?prolev=3'||chr(38)||'workflow=3DC76BC9CDA14F510E6D1B92AA561BE0', 52, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogram2020112', 2, 1, '1', '005003', '项目绩效目标查询', 'pmkpiprogram2020110', '/pmkpi/program/query/list.page?prolev=3', 53, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030110', 1, 0, '1', '006', '项目绩效调整', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 60, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030111', 2, 1, '1', '006001', '项目绩效调整填报', 'pmkpiprogramadjust2030110', '/pmkpi/proadjust/report/list.page?prolev=3'||chr(38)||'workflow=ACB7014749AFD762BBFD99D8304BA3F2', 61, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030113', 2, 1, '1', '006002', '项目绩效调整审核', 'pmkpiprogramadjust2030110', '/pmkpi/proadjust/report/audit.page?prolev=3'||chr(38)||'workflow=ACB7014749AFD762BBFD99D8304BA3F2', 62, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('pmkpiprogramadjust2030112', 2, 1, '1', '006003', '项目绩效调整查询', 'pmkpiprogramadjust2030110', '/pmkpi/proadjust/report/query.page?prolev=3', 63, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812CD0888E0535164A8C0487E', 1, 0, '1', '007', '项目绩效监控', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 70, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812CE0888E0535164A8C0487E', 2, 1, '1', '007001', '部门布置任务', 'B5A085C812CD0888E0535164A8C0487E', '/pmkpi/program/trace/manage/tasklist.page?pagetype=dept', 71, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812CF0888E0535164A8C0487E', 2, 1, '1', '007002', '财政布置任务', 'B5A085C812CD0888E0535164A8C0487E', '/pmkpi/program/trace/manage/tasklist.page?pagetype=province', 72, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812D00888E0535164A8C0487E', 2, 1, '1', '007003', '项目绩效监控填报', 'B5A085C812CD0888E0535164A8C0487E', '/pmkpi/program/trace/report.page', 73, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812D10888E0535164A8C0487E', 2, 1, '1', '007004', '项目绩效监控审核', 'B5A085C812CD0888E0535164A8C0487E', '/pmkpi/program/trace/audit.page', 74, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812D20888E0535164A8C0487E', 2, 1, '1', '007005', '项目绩效监控查询', 'B5A085C812CD0888E0535164A8C0487E', '/pmkpi/program/trace/query.page', 75, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('7237F27E0C5F4A758709690EE70A74D7', 2, 0, '1', '110', '审核流程管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 110, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('F8C821C3F95842EEB181C54C13137F41', 3, 1, '1', '110001', '流程节点审核配置', '7237F27E0C5F4A758709690EE70A74D7', '/pmkpi/auditnode/index.page', 111, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('242EFA05E95346F7B08D1EFF323F7196', 3, 1, '1', '110002', '评分配置', '7237F27E0C5F4A758709690EE70A74D7', '/pmkpi/setting/question.page', 112, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('A73AB0D6DF7F4CB29BE38D87548B3AF1', 3, 1, '1', '110003', '四性审核模板维护', '7237F27E0C5F4A758709690EE70A74D7', '/pmkpi/naturesaudit/index.page', 113, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('A01BEE41C8944C9B8E3A96B8116F7A52', 2, 0, '1', '120', '指标管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 120, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('AB6EF9AD91EC468899F5918ADAB173AC', 3, 1, '1', '120001', '指标库', 'A01BEE41C8944C9B8E3A96B8116F7A52', '/pmkpi/index/list.page', 121, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('DFD6CB32183F427481410D932C447738', 3, 1, '1', '120002', '模板库', 'A01BEE41C8944C9B8E3A96B8116F7A52', '/pmkpi/setting/model/list.page', 122, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('31F69D7C7C4142B8BBB71696FDBD9D39', 3, 1, '1', '120003', '案例库', 'A01BEE41C8944C9B8E3A96B8116F7A52', '/pmkpi/setting/case/list.page', 123, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('ff7e2d2946d98ac734ecbd6798cba1e2', 2, 0, '1', '140', '审核定义', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 140, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('BC22D74299EF90451B79EDB3F93804DD', 3, 1, '1', '140001', '自定义视图信息', 'ff7e2d2946d98ac734ecbd6798cba1e2', '/pmkpi/auditviewinfo/index.page', 141, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('d449c51e117616c3fd99b5f7962123f0', 3, 1, '1', '140002', '审核定义信息配置', 'ff7e2d2946d98ac734ecbd6798cba1e2', '/pmkpi/auditdefine/index.page', 142, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('5FF38D40BF87427A8E3E9D528A100AF3', 3, 1, '1', '140003', '审核定义业务配置', 'ff7e2d2946d98ac734ecbd6798cba1e2', '/pmkpi/busauditdefine/index.page', 143, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812BC0888E0535164A8C0487E', 2, 0, '1', '160', '绩效任务管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '#', 160, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('B5A085C812BD0888E0535164A8C0487E', 3, 1, '1', '160001', '绩效任务配置', 'B5A085C812BC0888E0535164A8C0487E', '/pmkpi/setting/taskset/list.page', 161, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('19242357040761A9497366E7B01D14C6', 2, 0, '1', '999', '系统配置管理', 'C43D8AA7015B7F8B25CA18C3277CA4BE', null, 999, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('DC741A8CCA70420CACB057C518FDE525', 3, 1, '1', '999001', '绩效系统配置', '19242357040761A9497366E7B01D14C6', '/pmkpi/setting/kpisystemset.page', 991, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('E412DE2E152545178FC8BF9E8A29F36D', 3, 1, '1', '999001', '绩效事前评估模板配置', '19242357040761A9497366E7B01D14C6', '/pmkpi/setting/assessment/list.page', 992, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('0209D9B3C98F41EBAB07D89D40355235', 3, 1, '1', '999001', '绩效数据权限', '19242357040761A9497366E7B01D14C6', '/pmkpi/perfset/datarule.page', 993, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);

insert into fasp_t_pubmenu (GUID, LEVELNO, ISLEAF, STATUS, CODE, NAME, PARENTID, URL, MENUORDER, REMARK, DBVERSION, APPSYSID, PROVINCE, YEAR, APPID, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, SSOFLAG, ADMINTYPE, ALIAS, ISPTADMIN, ADMDIV)
values ('E8A79278CC9E42A1B73B148BA5F3BAFE', 3, 1, '1', '999001', '用户对单位', '19242357040761A9497366E7B01D14C6', '/pmkpi/setting/uservagency.page', 994, null, sysdate, 1, null, null, 'pmkpi', null, null, null, null, null, null, 1, null, null, null);
