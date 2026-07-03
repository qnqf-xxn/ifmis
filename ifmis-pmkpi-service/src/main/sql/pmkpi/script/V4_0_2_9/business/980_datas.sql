begin

--通版脚本
-- 监控填报定性指标数据源
delete from perf_t_datasource where elementcode = 'protraceindex';
insert into perf_t_datasource(guid,code,name,remark,superguid,levelno,isleaf,ordernum,elementcode,status,createtime,updatetime,year)
select guid,code,name,remark,superguid,levelno,isleaf,ordernum,'protraceindex' as elementcode,status,createtime,updatetime,year
from perf_t_datasource where elementcode = 'indexval';

--更新字段表配置
delete from PERF_T_UPCOLSET t;
insert into PERF_T_UPCOLSET (GUID, TABLECODE, RELEVANCYCOL, UPCOLTYPE, WHERESQL, REMARK)
values ('E49F07EC7E415250E0533315A8C0321A', 'pm_perf_indicator', 'mainguid', 'pro_id', 'is_deleted=2 and yearflag=''1'' and province=''#province#''', '更新项目指标表总体数据');

insert into PERF_T_UPCOLSET (GUID, TABLECODE, RELEVANCYCOL, UPCOLTYPE, WHERESQL, REMARK)
values ('E49F07EC7E425250E0533315A8C0321A', 'v_pm_perf_indicator', 'pro_code', null, 'yearflag=''0''', '更新项目指标表年度数据');

insert into PERF_T_UPCOLSET (GUID, TABLECODE, RELEVANCYCOL, UPCOLTYPE, WHERESQL, REMARK)
values ('E49F07EC7E435250E0533315A8C0321A', 'pm_perf_goal_info', 'mainguid', 'pro_id', 'is_deleted=2 and yearflag=''1'' and province=''#province#''', '更新项目目标表总体数据');

insert into PERF_T_UPCOLSET (GUID, TABLECODE, RELEVANCYCOL, UPCOLTYPE, WHERESQL, REMARK)
values ('E49F07EC7E445250E0533315A8C0321A', 'v_pm_perf_goal_info', 'pro_code', null, 'yearflag=''0''', '更新项目目标表年度数据');

insert into PERF_T_UPCOLSET (GUID, TABLECODE, RELEVANCYCOL, UPCOLTYPE, WHERESQL, REMARK)
values ('E66708BEB55D3D7DE0533315A8C06682', 'v_perf_t_assessment', 'mainguid', 'pro_id', null, '事前绩效评估');

insert into PERF_T_UPCOLSET (GUID, TABLECODE, RELEVANCYCOL, UPCOLTYPE, WHERESQL, REMARK)
values ('E66708BEB5613D7DE0533315A8C06682', 'v_perf_t_assessmentopinion', 'mainguid', 'pro_id', null, '事前绩效评估意见');

--系统参数配置
delete from perf_t_systemset t where t.paramcode='PROGRAMINPUTPERFISYEAR';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('E524C30FC51D797BE0533315A8C03033', 'PROGRAMINPUTPERFISYEAR', '项目录入绩效是否填报年度绩效目标、指标', '0', '0否、1是', 'pmkpi', 39, 2016, '87', 1);

delete from perf_t_systemset t where t.paramcode='IS_JIANGXI';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('E5B5382262D74614E0533315A8C03FDA', 'IS_JIANGXI', '是否江西', '0', '0否、1是', 'pmkpi', 40, 2016, '87', 1);

--审核定义配置
delete from perf_t_auditdefinemenu t where t.guid='B96A1051C0D34F49E053B11FA8C07F3C';
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('B96A1051C0D34F49E053B11FA8C07F3C', '007003005', '绩效目标完成情况_部门整体', null, 'B5A085C812D00888E0535164A8C0487E', 3, 1, 5, 1, '1', '20201230042116', null, '87', 2022);

--增加系统参数：ISCHECKINDEXNAME 是否校验三级指标名称重复  --默认为是 湖北安徽需要手动关闭
delete from perf_t_systemset where paramcode = 'ISCHECKINDEXNAME';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('DA61946DCA08101EE0533315A8C0D73D', 'ISCHECKINDEXNAME', '是否校验三级指标名称重复', '1', '1是其他否，默认为是', 'pmkpi', 35, 2016, '87', 1);

--数据权限
delete from pmkpi_t_datarule t where t.guid='bbmxsyxj';
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbmxsyxj', '本部门下所有下级', 'pub', ' exists (select guid from pmkpi_fasp_t_pubagency agen where agen.guid = ruletable.agencyguid and agen.guid like '''' || substr(''#curragency#'', 0, (length(''#curragency#'') - 3)) || ''%'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

--事前绩效评估配置菜单
delete from perf_t_pagemenu t where t.uikey='/pmkpi/program/assessment/list';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('74E677772D78CEE076838098EE17FF99', '9', '事前绩效评估', '/pmkpi/program/assessment/list', 'D574940480DC7ED4E0533315A8C059D3', 3, 1, 9, 1, '20220806103442', '20220806103442', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2022');

--解决除数为0的BUG
delete from perf_t_warnset t where t.type='bgttracewarn';
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DB8540E3EF9A46E0B82BC415F11CD0AD', 'bgttracewarn', '预算执行预警', 'bgttracewarn', 'select case when value < 60 then ''red'' when 60 <= value and value < 80 then ''yellow'' when 80 <= value then ''green'' end value from (select (select case when sum(amt3) is null or sum(amt4) is null or sum(amt3) = 0 then 0 else sum(amt4)/sum(amt3) end bgtget from v_perf_t_probgtfund where mainguid=''#mainguid#'')/(#month#/12)*100 value from dual) a', null, null, '2016', '87');
