    i number;
begin

--绩效监控结果应用
--视图
execute immediate '
create or replace view perf_v_promonitor_appresult as
select
    t.*,
    case
     when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > to_number(b.warndays) then ''black''
     when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <= to_number(b.warndays) then ''red''
     when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') > to_date(b.enddate, ''yyyymmdd'') then ''000''
    end warn,
    to_date(b.enddate, ''yyyymmdd'') -
    to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') as warndays,
    t.update_time as updatetime,
    b.taskstage,
    b.startdate,
    b.enddate,
    b.tasktype,
    b.bustype,
    b.name as taskname,
    ps.appresult_details,
    ag.name as agencyname
from
    v_perf_t_promonitor t
    left join v_perf_t_taskset b on b.guid = t.taskguid
    left join v_perf_t_protraceanalysis ps on ps.mainguid = t.guid
    left join pmkpi_fasp_t_pubagency ag on ag.guid = t.agencyguid
where
    to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >= to_date(b.startdate, ''yyyymmdd'') - 1
';

--dic
delete from bus_t_dictable where tablecode = 'PERF_V_PROMONITOR_APPRESULT';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_V_PROMONITOR_APPRESULT', '绩效监控结果应用视图', '绩效监控结果应用视图', 1, 1, 'PERF_V_PROMONITOR_APPRESULT', 'pmkpi', null, '0', 1, '0', 1, 1, null, null, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode = 'PERF_V_PROMONITOR_APPRESULT';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'AGENCYGUID', '1', '2016', '87', 'EF492763C0E44D97E0533315A8C0B4A1', 'AGENCYGUID', 'PERF_V_PROMONITOR_APPRESULT', '单位编码', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AGENCYNAME', '1', '2016', '87', 'EF492763C0E54D97E0533315A8C0B4A1', 'AGENCYNAME', 'PERF_V_PROMONITOR_APPRESULT', '单位名称', 'S', '200', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'APPRESULT_DETAILS', '1', '2016', '87', 'EF492763C0EC4D97E0533315A8C0B4A1', 'APPRESULT_DETAILS', 'PERF_V_PROMONITOR_APPRESULT', '处理措施和结果运用情况', 'S', '4000', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'BGTWARN', '1', '2016', '87', 'EF492763C0E74D97E0533315A8C0B4A1', 'BGTWARN', 'PERF_V_PROMONITOR_APPRESULT', '预算执行预警', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'DEPTTASK', '1', '2016', '87', 'EF492763C0E94D97E0533315A8C0B4A1', 'DEPTTASK', 'PERF_V_PROMONITOR_APPRESULT', '部门任务下达1是2否', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', '2016', '87', 'EF492763C0E14D97E0533315A8C0B4A1', 'FININTORGGUID', 'PERF_V_PROMONITOR_APPRESULT', '业务处室', 'N', '20', 5, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALWARN', '1', '2016', '87', 'EF492763C0E84D97E0533315A8C0B4A1', 'GOALWARN', 'PERF_V_PROMONITOR_APPRESULT', '目标完成预警', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2016', '87', 'EF492763C0E34D97E0533315A8C0B4A1', 'NAME', 'PERF_V_PROMONITOR_APPRESULT', '项目名称', 'S', '200', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNO', '1', '2016', '87', 'EED47FE19ABD0202E0533315A8C02FDB', 'ORDERNO', 'PERF_V_PROMONITOR_APPRESULT', '序号', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'PROVINCETASK', '1', '2016', '87', 'EF492763C0EA4D97E0533315A8C0B4A1', 'PROVINCETASK', 'PERF_V_PROMONITOR_APPRESULT', '财政任务下达1是2否', 'S', '40', null, 1, 0, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_CODE', '1', '2016', '87', 'EF492763C0E24D97E0533315A8C0B4A1', 'PRO_CODE', 'PERF_V_PROMONITOR_APPRESULT', '项目编码', 'S', '21', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITASKSTAGE', null, '1', 'TASKSTAGE', '1', '2016', '87', 'EF492763C0E64D97E0533315A8C0B4A1', 'TASKSTAGE', 'PERF_V_PROMONITOR_APPRESULT', '监控阶段', 'S', '40', null, 1, 1, null, sysdate);
-- insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
-- values (null, null, null, '1', 'TREATMENT_MEASURE', '1', '2016', '87', 'EF492763C0EB4D97E0533315A8C0B4A1', 'TREATMENT_MEASURE', 'PERF_V_PROMONITOR_APPRESULT', '处理措施', 'S', '4000', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIWFSTATUS', null, '1', 'WFSTATUS', '1', '2016', '87', 'EF492763C0E04D97E0533315A8C0B4A1', 'WFSTATUS', 'PERF_V_PROMONITOR_APPRESULT', '工作流状态', 'S', '40', null, 1, 1, null, sysdate);





