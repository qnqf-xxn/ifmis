begin

DELETE FROM p#busfw_t_uifunction t where t.key='/pmkpi/program/report/adjustindex' and t.code='export';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/report/adjustindex', '导出指标', 1, 5, 'keepicon', 'mergeindexadjustpro.export', null, '导出指标', 'pmkpi', 'export', null, null);

DELETE FROM PERF_T_EXPDOCMAIN t where t.TEMPLATECODE='hbproadjtotalgoalandindex';

insert into PERF_T_EXPDOCMAIN (GUID, TEMPLATECODE, TEMPLATENAME, EXPFILENAME, EXPTYPE, ISZIP, ORDERNUM, PROVINCE, STATUS, CREATETIME, UPDATETIME, YEAR)
values ('E7984D31979C545EE0533315A8C0FE27', 'hbproadjtotalgoalandindex', '预算项目绩效信息表（项目变更阶段）', '预算项目绩效信息表（项目变更阶段）', 'xls', '0', 1, '87', 1, null, null, 2016);

DELETE FROM PERF_T_EXPDOCSUB t where t.MAINGUID ='E7984D31979C545EE0533315A8C0FE27';

insert into PERF_T_EXPDOCSUB (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values ('E7984D31979D545EE0533315A8C0FE27', 'prodata', 'E7984D31979C545EE0533315A8C0FE27', 1, '87', '1', 1, 'rpt_v_gztotalperfadjgoal', '20160623165002', '20160623165002', null, null, 2016);

insert into PERF_T_EXPDOCSUB (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values ('E7984D31979E545EE0533315A8C0FE27', 'indexdata', 'E7984D31979C545EE0533315A8C0FE27', 2, '87', '1', 1, 'rpt_v_gztotalperfadjindex', '20160622203833', '20160623165002', null, null, 2016);

