begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/apply/index') and t.code='hfimpdoc';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/index', '合肥自评导入', 1, 23, 'searchicon', 'perfselfapply.impdoc', null, '合肥自评导入', 'pmkpi', 'hfimpdoc', null, '{impServicetype:''hfimp'',protempatecode:''hfxmzczpj'',depttempatecode:''hfbmztzpj''}');

update perf_t_treetab t set t.hidebtns='查看项目,合肥自评模板导出,合肥自评导入' where t.key in('/pmkpi/perfself/apply') and code='dept';

delete from perf_t_imptemp t where t.temptype ='hfxmzczpj';

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('EF3524C57CD9635BE0533315A8C0F3A0', 'hfxmzczpj', 'bgtget', 7, 'name', 'amt1', 'amt3', 'amt4', 'bgtget', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('EF3524C57CDA635BE0533315A8C0F3A0', 'hfxmzczpj', 'desc', 13, 'yeargoal', 'allyeargoal', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('EF3524C57CDC635BE0533315A8C0F3A0', 'hfxmzczpj', 'index', 15, 'findex', 'sindex', 'name', 'yearindexval', 'actualvalue', 'actualweight', 'score', 'kpi_remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');
