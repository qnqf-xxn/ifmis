begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/query/index') and code in('gxdeptexpxls','gxproexpxls');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query/index', '导出部门整体自评表（广西）', 0, 5, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出部门整体自评表（广西）', 'pmkpi', 'gxdeptexpxls', null, '{tempatecode:''gxnewbmztjxzpb''}', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query/index', '导出项目自评表（广西）', 0, 5, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出项目自评表（广西）', 'pmkpi', 'gxproexpxls', null, '{tempatecode:''gxnewxmzcjxzpb''}', null, null);

update perf_t_treetab t set t.hidebtns='导出部门整体自评表,导出部门整体支出绩效自评表（河北）,导出部门整体自评表（湖北）,导出部门整体支出绩效自评表(山西),导出部门整体自评表（广西）' where t.key='/pmkpi/perfself/query' and t.code='program';

update perf_t_treetab t set t.hidebtns='查看项目,导出项目自评表,导出项目支出支出绩效自评表（河北）,导出项目支出绩效自评表(山西),导出项目自评表（广西）' where t.key='/pmkpi/perfself/query' and t.code='dept';