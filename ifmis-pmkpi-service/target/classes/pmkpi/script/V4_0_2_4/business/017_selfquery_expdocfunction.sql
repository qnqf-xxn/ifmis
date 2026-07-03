begin
  

DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/perfself/query/index' and t.code in ('hbproexpdoc', 'hbdeptexpdoc');
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A2B57B7F1173496CA010224CFAF459C7', '/pmkpi/perfself/query/index', '导出项目支出支出绩效自评表（河北）', 0, 11, 'searchicon', 'perfselfquery.hbexpdoc', null, '导出项目支出支出绩效自评表（河北）', 'pmkpi', 'hbproexpdoc', null, '{tempatecode:''gzproperfself''}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C7E379E8C2E8465193BCCC8127470625', '/pmkpi/perfself/query/index', '导出部门整体支出绩效自评表（河北）', 0, 13, 'searchicon', 'perfselfquery.hbexpdoc', null, '导出部门整体支出绩效自评表（河北）', 'pmkpi', 'hbdeptexpdoc', null, '{tempatecode:''gzdeptperfself''}');

--通版自评导出按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/query/index' and title in('导出项目自评表','导出部门整体自评表') ;
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D613341C95511822E0533315A8C006A3', '/pmkpi/perfself/query/index', '导出项目自评表', 0, 6, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出项目自评表', 'pmkpi', 'expxls', null, '');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D613341C95521822E0533315A8C006A3', '/pmkpi/perfself/query/index', '导出部门整体自评表', 0, 7, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出部门整体自评表', 'pmkpi', 'expxls', null, '');
