begin
  
DELETE FROM p#Busfw_t_Uifunction t where t.key='/pmkpi/program/report/mergeindex' and t.code='export';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('ED60A2B4D07E44A68B336FCA6B1B12B4', '/pmkpi/program/report/mergeindex', '导出指标', 0, 10, 'keepicon', 'mergeindex.export', null, '导出指标', 'pmkpi', 'export', null, null, '87', '2016');

DELETE FROM perf_t_expdocmain t where t.guid='A8BAB38169F72DD751C31AF0ED17F22A';
insert into perf_t_expdocmain (GUID, TEMPLATECODE, TEMPLATENAME, EXPFILENAME, EXPTYPE, ISZIP, ORDERNUM, PROVINCE, STATUS, CREATETIME, UPDATETIME, YEAR)
values ('A8BAB38169F72DD751C31AF0ED17F22A', 'progoalandindex', '预算项目绩效信息表（项目入库阶段）', '预算项目绩效信息表（项目入库阶段）', 'xls', '0', 1, '87', 1, null, null, 2016);

DELETE FROM perf_t_expdocsub t where t.guid in ('A05B5476BC46AF6FAAA7AF6082AFB293','4703885076B0F24E23F7D7F307E07E27');
insert into perf_t_expdocsub (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values ('A05B5476BC46AF6FAAA7AF6082AFB293', 'indexdata', 'A8BAB38169F72DD751C31AF0ED17F22A', 2, '87', '1', 1, 'rpt_v_gzperfindex', '20160622203833', '20160623165002', null, null, 2016);

insert into perf_t_expdocsub (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values ('4703885076B0F24E23F7D7F307E07E27', 'prodata', 'A8BAB38169F72DD751C31AF0ED17F22A', 1, '87', '1', 1, 'rpt_v_gzperfgoal', '20160623165002', '20160623165002', null, null, 2016);
