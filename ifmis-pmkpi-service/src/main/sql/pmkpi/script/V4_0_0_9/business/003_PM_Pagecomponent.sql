begin
delete FROM Bus_t_Pagecomponent t where t.id in ('pmkpi_perfselftaskmanage','pmkpi_perfselfapply','pmkpi_tabfreamedit',
'pmkpi_selfprojinfo','pmkpi_selfbdgpay','pmkpi_selfindex','pmkpi_selfdesc','pmkpi_perfselfaudit','pmkpi_perfselfquery');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfbdgpay', '资金使用情况', null, '资金使用情况', '/pmkpi/perfself/selfbdgpay.js', 'Ext.lt.pmkpi.selfbdgpay', 'pmkpi', 'pmkpi.perfSelf.tab.SelfFundService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfselfapply', '绩效自评填报', null, '绩效自评填报', '/pmkpi/perfself/perfselfapply.js', 'Ext.lt.pmkpi.perfself.perfselfapplyservice', 'pmkpi', 'pmkpi.perfSelf.PerfSelfApplyService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tabfreamedit', '绩效申报填报', null, '绩效申报填报', '/pmkpi/tabfream/tabfreamedit.js', 'Ext.lt.pmkpi.tabfreamedit', 'pmkpi', 'pmkpi.tabfream.TabfreamEditService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfselfaudit', '绩效自评审核', null, '绩效自评审核', '/pmkpi/perfself/perfselfaudit.js', 'Ext.lt.pmkpi.perfself.perfselfauditservice', 'pmkpi', 'pmkpi.perfSelf.PerfSelfAuditService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfdesc', '自评补充信息', null, '自评补充信息', '/pmkpi/perfself/selfdesc.js', 'Ext.lt.pmkpi.selfdesc', 'pmkpi', 'pmkpi.perfSelf.tab.SelfDescService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfindex', '指标完成情况', null, '指标完成情况', '/pmkpi/perfself/selfindex.js', 'Ext.lt.pmkpi.selfindex', 'pmkpi', 'pmkpi.perfSelf.tab.SelfIndexService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfprojinfo', '项目基本信息', null, '项目基本信息', '/pmkpi/perfself/projinfo.js', 'Ext.lt.pmkpi.selfprojinfo', 'pmkpi', 'pmkpi.perfSelf.tab.SelfProjinfoService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfselfquery', '绩效自评查询', null, '绩效自评查询', '/pmkpi/perfself/perfselfquery.js', 'Ext.lt.pmkpi.perfself.perfselfqueryservice', 'pmkpi', 'pmkpi.perfSelf.PerfSelfQueryService');

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfselftaskmanage', '绩效自评下达', null, '绩效自评下达', '/pmkpi/perfself/perfselfmanage.js', 'Ext.lt.pmkpi.perfself.perfselfmanageservice', 'pmkpi', 'pmkpi.perfSelf.PerfSelfTaskManageService');

