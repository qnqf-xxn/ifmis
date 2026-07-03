begin
delete from Busfw_t_Nextyeartable t where t.appid = 'pmkpi';
insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_FRAME', 'pmkpi', '层次分类表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_FRAMESYSTEM', 'pmkpi', '层次分类类型表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_SYSTEMSET', 'pmkpi', '系统配置表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_WARNSET', 'pmkpi', '预警规则表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_REVIEWTEMP', 'pmkpi', '绩效目标评审模板表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PMKPI_T_ROLEDATARULE', 'pmkpi', '绩效数据权限中间表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_TREETAB', 'pmkpi', '绩效左侧树页签配置表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_AUDITDEFINE', 'pmkpi', '审核定义表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_CUSTOMAUDITVIEW', 'pmkpi', '自定义视图表', null);

insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_BUSAUDITDEFINE', 'pmkpi', '审核定义业务配置表', null);
