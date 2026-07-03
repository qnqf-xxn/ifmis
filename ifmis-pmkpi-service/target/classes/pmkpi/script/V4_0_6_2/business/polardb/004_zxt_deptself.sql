begin

delete from perf_t_expdocmain where guid = 'EB13197294BD4FB2C2946669F5BB3265';
insert into perf_t_expdocmain (GUID, TEMPLATECODE, TEMPLATENAME, EXPFILENAME, EXPTYPE, ISZIP, ORDERNUM, PROVINCE, STATUS, CREATETIME, UPDATETIME, YEAR)
values ('EB13197294BD4FB2C2946669F5BB3265', 'zjdeptperfself', '浙江部门整体自评申报表', '#name#', 'xls', '0', 1, '87', 1, null, null, 2016);

delete from perf_t_expdocsub where mainguid = 'EB13197294BD4FB2C2946669F5BB3265';
insert into perf_t_expdocsub (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values (sys_guid(), 'prodata', 'EB13197294BD4FB2C2946669F5BB3265', 1, '87', '1', 1, 'perf_v_expdeptself', '1', '20210510205559', null, null, 2016);

insert into perf_t_expdocsub (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values (sys_guid(), 'selfprofund', 'EB13197294BD4FB2C2946669F5BB3265', 2, '87', '2', 1, 'pkg_perf_selfmain.getdeptexps', '1', '20210510205559', null, null, 2016);

insert into perf_t_expdocsub (GUID, DATAKEY, MAINGUID, ORDERNUM, PROVINCE, QUERYTYPE, STATUS, TABLECODE, CREATETIME, UPDATETIME, WHERESQL, WHOLENAME, YEAR)
values (sys_guid(), 'indexdata1', 'EB13197294BD4FB2C2946669F5BB3265', 3, '87', '2', 1, 'pkg_perf_indexexpdoc.getzjdeptself', '1', '20210510205559', null, null, 2016);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/audit/index') and code in('expdeptxlsx');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR,PROVINCE)
values ('29C57E220BCB603FDD5FB908700CF20D', '/pmkpi/perfself/audit/index', '导出报告（部门）', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告（部门）', 'pmkpi', 'expdeptxlsx', null, '{tempatecode:''zjdeptperfself''}','2016','87');
