begin

--定时任务配置
delete from fw_t_jobdetail t where appid='pmkpi' and t.jobid='pmkpi.ModProjectDataTask';
insert into fw_t_jobdetail (JOBID, JOBNAME, CRONEXPRESSION, JOBCLASS, PROVINCE, YEAR, ENABLE, APPID, REMARK)
values ('pmkpi.ModProjectDataTask', '项目基本信息修改同步修改绩效数据', '0 */1 0-23 * * ? *', 'gov.mof.fasp2.pmkpi.timetask.ModProjectDataTask#updateProjectDatas', null, null, '0', 'pmkpi', '默认每分钟执行一次');

--合肥监控导入配置
delete from perf_t_imptemp t where t.temptype in('hfxmzczdjkmb','hfbmztjkmb');
insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC802531E0533315A8C03422', 'hfxmzczdjkmb', 'bgtget', 8, 'amt1', 'amt7', 'amt8', 'amt3', 'amt4', 'bgtget', 'amt6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC812531E0533315A8C03422', 'hfxmzczdjkmb', 'analysis', 10, 'yeargoal', 'measures', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC822531E0533315A8C03422', 'hfxmzczdjkmb', 'index', 13, 'findex', 'sindex', 'name', 'targetvalue', 'indexval', 'completeanalyscon', 'completeanalysis', 'otherreasons', 'remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC842531E0533315A8C03422', 'hfbmztjkmb', 'bgtget', 7, 'amt1', 'amt7', 'amt8', 'amt3', 'amt4', 'bgtget', 'amt6', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC852531E0533315A8C03422', 'hfbmztjkmb', 'analysis', 9, 'yeargoal', 'measures', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('DFD030E8EC862531E0533315A8C03422', 'hfbmztjkmb', 'index', 12, 'findex', 'sindex', 'name', 'targetvalue', 'indexval', 'completeanalyscon', 'completeanalysis', 'otherreasons', 'remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

--监控填报左侧树页签
delete from perf_t_treetab t where key in('/pmkpi/program/trace/report') and t.code='depttrace';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('CF3C5CCB43983375E0533315A8C0E105', '/pmkpi/program/trace/report', 'depttrace', '部门整体', 1, '导入,一般监控模板导出（合肥）,一般监控导入（合肥）,导出项目监控报告(WORD山西),导出项目监控报告(EXCEL山西)', 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttracereporthide', null);

--绩效自评查询左侧树隐藏按钮
delete from perf_t_treetab t where t.key = '/pmkpi/perfself/query';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2E6E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'program', '项目支出', 1, '导出部门整体自评表,导出部门整体支出绩效自评表（河北）,导出部门整体自评表（湖北）', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfqueryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2F6E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'dept', '部门整体', 1, '查看项目,导出项目自评表,导出项目支出支出绩效自评表（河北）', 2, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfqueryhide');

--添加指标页弹出、行新增参数
delete from v_perf_t_systemset t where t.paramcode='INDEXISADDROW';
insert into v_perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('EC50813200761CE0E0533315A8C0819F', 'INDEXISADDROW', '指标页面是否是新增行', '0', '1弹出新增，其他是行新增，默认为行新增', 'pmkpi', 40, 2016, '87', 1);







