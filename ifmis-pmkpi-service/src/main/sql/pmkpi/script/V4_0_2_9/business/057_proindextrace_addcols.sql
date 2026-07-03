i number;
begin

--监控指标完成情况，增加全年预计完成情况偏离度
select count(1) into i from user_tab_columns where table_name = 'PERF_T_PROINDEXTRACE' and column_name = 'COMPDEVIATE';
if i < 1 then
    execute immediate 'alter table PERF_T_PROINDEXTRACE add COMPDEVIATE VARCHAR2(40)';
end if;

--监控主表，增加全年预计完成情况偏离度
select count(1) into i from user_tab_columns where table_name = 'PERF_T_PROMONITOR' and column_name = 'COMPDEVIATE';
if i < 1 then
    execute immediate 'alter table PERF_T_PROMONITOR add COMPDEVIATE VARCHAR2(40)';
end if;

--监控主表，增加全年预计完成情况偏离度预警
select count(1) into i from user_tab_columns where table_name = 'PERF_T_PROMONITOR' and column_name = 'COMPWARN';
if i < 1 then
    execute immediate 'alter table PERF_T_PROMONITOR add COMPWARN VARCHAR2(40)';
end if;

--表字段注册
delete from bus_t_diccolumn where tablecode = 'PERF_T_PROINDEXTRACE' and columncode = 'COMPDEVIATE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPDEVIATE', '1', '2016', '87', sys_guid(), 'COMPDEVIATE', 'PERF_T_PROINDEXTRACE', '全年预计完成情况偏离度', 'S', '40', null, 1, 0, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PERF_T_PROMONITOR' and columncode = 'COMPDEVIATE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPDEVIATE', '1', '2016', '87', sys_guid(), 'COMPDEVIATE', 'PERF_T_PROMONITOR', '全年预计完成情况偏离度', 'S', '40', null, 1, 0, null, sysdate);

delete from bus_t_diccolumn where tablecode = 'PERF_T_PROMONITOR' and columncode = 'COMPWARN';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPWARN', '1', '2016', '87', sys_guid(), 'COMPWARN', 'PERF_T_PROMONITOR', '全年预计完成情况偏离度预警', 'S', '40', null, 1, 0, null, sysdate);

--重构视图
execute immediate '
create or replace view V_PERF_T_PROINDEXTRACE as
select * from PERF_T_PROINDEXTRACE
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';

execute immediate '
create or replace view v_perf_t_promonitor as
select * from perf_t_promonitor
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';

execute immediate '
create or replace view perf_v_promonitor as
select t."GUID",t."NAME",t."TASKGUID",t."PROGUID",t."DEPTTASK",t."PROVINCETASK",t."BGTWARN",t."GOALWARN",t."COMPWARN",t."COMPDEVIATE",t."ISLAST",t."TRACENUM",t."TRACESTATUS",t."STATUS",t."AGENCYGUID",t."AGENCY_CODE",t."CREATER",t."CREATE_TIME",t."UPDATE_TIME",t."IS_DELETED",t."FISCAL_YEAR",t."MOF_DIV_CODE",t."YEAR",t."PROVINCE",t."WFSTATUS",t."AUDITOR",t."LASTUPDATETIME",t."FININTORGGUID",t."WFID",t."CONSTRUCTION",t."PROMANAGEMENT",t."FINMANAGEMENT",t."AUDITTYPE",t."GZDEVIATE",t."PRO_CODE",t."GZFUNDDEVIATE",t."MANAGE_DEPT_CODE",t."MANAGE_MOF_DEP_CODE",t."MOF_DEP_CODE",t."DEPT_CODE",t."FILLMAN",t."FILLCONTACTTYPE",
           case
             when to_number(to_date(b.enddate, ''yyyymmdd'') -
                              to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) >
                    to_number(b.warndays) then
                ''black''
               when to_number(to_date(b.enddate, ''yyyymmdd'') -
                              to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <=
                    to_number(b.warndays) then
                ''red''
               when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
                    to_date(b.enddate, ''yyyymmdd'') then
                ''000''
             end warn,
             to_date(b.enddate, ''yyyymmdd'') -
             to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') as warndays,
             t.update_time as updatetime,
             b.taskstage,
             b.startdate,
             b.enddate,
             b.tasktype,
             b.bustype,
             b.name as taskname
        from v_perf_t_promonitor t
        left join v_perf_t_taskset b
          on b.guid = t.taskguid
       where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >=
             to_date(b.startdate, ''yyyymmdd'') - 1
';

--ui列增加全年预计完成情况相关 默认隐藏
delete FROM p#busfw_t_uicolumn t where t.key ='/pmkpi/program/trace/report/edit/indextarget' and columncode = 'COMPDEVIATE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/indextarget', 'COMPDEVIATE', '全年预计完成情况偏离度', 13, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete FROM p#busfw_t_uicolumn t where t.key ='/pmkpi/trace/report/deptedit/indextarget' and columncode = 'COMPDEVIATE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/trace/report/deptedit/indextarget', 'COMPDEVIATE', '全年预计完成情况偏离度', 13, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);


delete FROM p#busfw_t_uicolumn t where t.key ='/pmkpi/program/trace/report' and columncode = 'COMPWARN';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report', 'COMPWARN', '全年预计完成情况预警', 15, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete FROM p#busfw_t_uicolumn t where t.key ='/pmkpi/program/trace/query' and columncode = 'COMPWARN';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/query', 'COMPWARN', '全年预计完成情况预警', 15, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);
