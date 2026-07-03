begin

delete from perf_t_treetab t where t.key in('/pmkpi/evaluation/financial/resultaudit','/pmkpi/evaluation/financial/proconfirm','/pmkpi/evaluation/financial/resultupload','/pmkpi/evaluation/financial/feedback','/pmkpi/evaluation/financial/acceptnotice','/pmkpi/evaluation/financial/audit','/pmkpi/evaluation/financial/deptassessment/list');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E106', '/pmkpi/evaluation/financial/resultaudit', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinresultaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E200', '/pmkpi/evaluation/financial/resultaudit', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinresultaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F1375E0533315A8C0E208', '/pmkpi/evaluation/financial/audit', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinresultaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0433315A8C0E008', '/pmkpi/evaluation/financial/audit', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinresultaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F1375E0533315A8C0E203', '/pmkpi/evaluation/financial/deptassessment/list', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfindeptfillhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0433315A8C0E003', '/pmkpi/evaluation/financial/deptassessment/list', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfindeptfillhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E202901F2CE0533315A8C01584', '/pmkpi/evaluation/financial/proconfirm', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinconfirmhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E201', '/pmkpi/evaluation/financial/proconfirm', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinconfirmhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F1375E0533315A8C0E101', '/pmkpi/evaluation/financial/resultupload', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinresultuploadhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0433315A8C0E205', '/pmkpi/evaluation/financial/resultupload', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinresultaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F1375E0533315A8C0E205', '/pmkpi/evaluation/financial/feedback', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinfeedbackhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0433315A8C0E002', '/pmkpi/evaluation/financial/feedback', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinfeedbackhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F2355E0533315A8C0E200', '/pmkpi/evaluation/financial/acceptnotice', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinacceptnoticehide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0433315A8C0E800', '/pmkpi/evaluation/financial/acceptnotice', 'dept', '部门整体', 1, '审核情况', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinacceptnoticehide');

--整改类型数据源
delete from fasp_t_dicdssource where code ='RECTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('RECTYPE', 'RECTYPE', 'RECTYPE', '整改类型', '1', '20160106155820402', '20160106', null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"问题整改"},{guid:"1",code:"1",name:"绩效监控"},{guid:"2",code:"2",name:"绩效自评"},{guid:"3",code:"3",name:"部门评价"},{guid:"4",code:"4",name:"财政评价"}]', null, 1, null);

--问题整改 选择项目页面左侧树
delete from perf_t_datasource where guid in('rectifytrace','rectifyperfself','rectifydepteval','rectifyfinancialeval') and elementcode ='rectifytype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('rectifytrace', '0001', '绩效监控', null, '00', 1, 0, 1, 'rectifytype', 1, '20210714', '20210714', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('rectifyperfself', '0002', '绩效自评', null, '00', 1, 1, 5, 'rectifytype', 1, '20210714', '20210714', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('rectifydepteval', '0003', '部门评价', null, '00', 1, 1, 6, 'rectifytype', 1, '20210714', '20210714', 2016, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('rectifyfinancialeval', '0004', '财政评价', null, '00', 1, 1, 7, 'rectifytype', 1, '20210714', '20210714', 2016, '87');
--问题整改 选择项目页面左侧树  监控任务阶段
delete from perf_t_datasource where elementcode = 'taskstage';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '1~1月', null, 'rectifytrace', null, null, 1, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '1~2月', null, 'rectifytrace', null, null, 2, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '1~3月', null, 'rectifytrace', null, null, 3, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4', '4', '1~4月', null, 'rectifytrace', null, null, 4, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('5', '5', '1~5月', null, 'rectifytrace', null, null, 5, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('6', '6', '1~6月', null, 'rectifytrace', null, null, 6, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('7', '7', '1~7月', null, 'rectifytrace', null, null, 7, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('8', '8', '1~8月', null, 'rectifytrace', null, null, 8, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('9', '9', '1~9月', null, 'rectifytrace', null, null, 9, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('10', '10', '1~10月', null, 'rectifytrace', null, null, 10, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('11', '11', '1~11月', null, 'rectifytrace', null, null, 11, 'taskstage', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('12', '12', '1~12月', null, 'rectifytrace', null, null, 12, 'taskstage', 1, '20201204', '20201204', 2020, '87');


--自评价左侧树配置
delete from perf_t_treetab t where t.key in('/pmkpi/perfself/taskmanage','/pmkpi/perfself/apply','/pmkpi/perfself/audit','/pmkpi/perfself/query');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B039DC6E68E0533315A8C0AFF2', '/pmkpi/perfself/taskmanage', 'program', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselftaskmanagehide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B039DD6E68E0533315A8C0AFF2', '/pmkpi/perfself/taskmanage', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselftaskmanagehide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2A6E68E0533315A8C0AFF2', '/pmkpi/perfself/apply', 'program', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfapplyhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2B6E68E0533315A8C0AFF2', '/pmkpi/perfself/apply', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfapplyhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2C6E68E0533315A8C0AFF2', '/pmkpi/perfself/audit', 'program', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2D6E68E0533315A8C0AFF2', '/pmkpi/perfself/audit', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2E6E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'program', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfqueryhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2F6E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfqueryhide');

--自评预警规则
delete from perf_t_warnset t where t.type in('selfscoredept','selfscoreproject','selfresultdept','selfresultproject','selfpositiveindex');
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E02E94E0533315A8C0F50E', 'selfresultdept', '自评结论-部门', 'selfresultdept', 'select case when nvl(s.score,0) + nvl(a.bgtscore,0) >= 80 then ''优'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 70 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80)  then ''良'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 70) then ''中'' when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差'' end as value FROM v_perf_t_selfevaltask t left join (select c.mainguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid) s on t.guid=s.mainguid left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, mainguid from v_perf_t_selfprofund group by mainguid) a on t.guid=a.mainguid where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('42B24123FF9B4AEA8B2EF6AC467B1C69', 'selfresultproject', '自评结论-项目', 'selfresultproject', 'select case when nvl(s.score,0) + nvl(a.bgtscore,0) >= 80 then ''优'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 70 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80)  then ''良'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 70) then ''中'' when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差'' end as value FROM v_perf_t_selfevaltask t left join (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s on t.pro_code=s.pro_code left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a on t.pro_code = a.pro_code where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E12E94E0533315A8C0F50E', 'selfscoredept', '自评得分-部门', 'selfscoredept', 'select to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value FROM v_perf_t_selfevaltask t left join (select c.mainguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid) s on t.guid=s.mainguid left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, mainguid from v_perf_t_selfprofund group by mainguid) a on t.guid=a.mainguid where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('82D0DB61BF2C4141BAC71290DE2EF1EF', 'selfscoreproject', '自评得分-项目', 'selfscoreproject', 'select to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value FROM v_perf_t_selfevaltask t left join (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s on t.pro_code=s.pro_code left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a on t.pro_code = a.pro_code where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C8266FDCF99D5659E0533315A8C0E6EB', 'selfpositiveindex01', '正向指标-绩效自评', 'selfpositiveindex', 'select case when #actualvalue# < #indexval# or #actualvalue# = #indexval# then round((#actualvalue#/#indexval#)*#weight#,2) when #indexval#<#actualvalue# and #actualvalue#<#indexval#*1.2 then #weight# when #actualvalue# >= #indexval#*1.2 then #weight# end as value from (select #weight# as value from dual)', null, null, '2016', '87');
	
--添加是否山西模式系统参数	
delete from perf_t_systemset t where t.paramcode ='isSX';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('B9D9D7F4F19E58BA3BB0EC4F0F2B3A8A', 'isSX', '是否是山西环境', '2', '1.山西环境 2.非山西环境', null, 3, 2016, '87', 1);

--自评定性指标值选项
delete from perf_t_datasource t where t.elementcode ='indexval';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('达成年度指标', '1', '达成年度指标', null, null, null, null, 1, 'indexval', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('部分达成年度指标并具有一定效果', '2', '部分达成年度指标并具有一定效果', null, null, null, null, 2, 'indexval', 1, '20201224', '20201224', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('未达成年度指标且效果较差', '3', '未达成年度指标且效果较差', null, null, null, null, 3, 'indexval', 1, '20201224', '20201224', 2020, '87');


--同步分区表
delete from bus_t_settmp where TABLECODE in('perf_t_systemset','perf_t_warnset','V_PERF_T_SYSTEMSET','V_PERF_T_WARNSET');
insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_SYSTEMSET', 'guid', null, null, null, 1);

insert into bus_t_settmp (TABLECODE, ONEKEY, SECKEY, THRKEY, SQLFILTER, FILTERTYPE)
values ('V_PERF_T_WARNSET', 'guid', null, null, null, 1);

--结转表
delete from busfw_t_nextyeartable t where t.tablecode='PERF_T_TREETAB';
insert into Busfw_t_Nextyeartable (TABLECODE, APPID, TABLENAME, ISUSE)
values ('PERF_T_TREETAB', 'pmkpi', '绩效左侧树页签配置表', null);
