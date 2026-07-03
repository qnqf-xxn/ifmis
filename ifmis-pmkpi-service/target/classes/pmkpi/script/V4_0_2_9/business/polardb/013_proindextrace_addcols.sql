begin

--ÖØ¹¹ÊÓÍ¼
execute immediate '
create or replace view V_PERF_T_PROINDEXTRACE as
select * from PERF_T_PROINDEXTRACE
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid
';

execute immediate '
create or replace view v_perf_t_promonitor as
select * from perf_t_promonitor
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid
';

execute immediate '
create or replace view perf_v_promonitor as
select t."GUID",t."NAME",t."TASKGUID",t."PROGUID",t."DEPTTASK",t."PROVINCETASK",t."BGTWARN",t."GOALWARN",t."COMPWARN",t."COMPDEVIATE",t."ISLAST",t."TRACENUM",t."TRACESTATUS",t."STATUS",t."AGENCYGUID",t."AGENCY_CODE",t."CREATER",t."CREATE_TIME",t."UPDATE_TIME",t."IS_DELETED",t."FISCAL_YEAR",t."MOF_DIV_CODE",t."YEAR",t."PROVINCE",t."WFSTATUS",t."AUDITOR",t."LASTUPDATETIME",t."FININTORGGUID",t."WFID",t."CONSTRUCTION",t."PROMANAGEMENT",t."FINMANAGEMENT",t."AUDITTYPE",t."GZDEVIATE",t."PRO_CODE",t."GZFUNDDEVIATE",t."MANAGE_DEPT_CODE",t."MANAGE_MOF_DEP_CODE",t."MOF_DEP_CODE",t."DEPT_CODE",t."FILLMAN",t."FILLCONTACTTYPE",
        CASE
            WHEN (to_number((date_part(''day''::text, (to_date(b.enddate, ''yyyymmdd''::character varying) - to_date(to_char(sysdate, ''yyyymmdd''::character varying), ''yyyymmdd''::character varying))))::text) > to_number((b.warndays)::text)) THEN ''black''::text
            WHEN (to_number((date_part(''day''::text, (to_date(b.enddate, ''yyyymmdd''::character varying) - to_date(to_char(sysdate, ''yyyymmdd''::character varying), ''yyyymmdd''::character varying))))::text) <= to_number((b.warndays)::text)) THEN ''red''::text
            WHEN (to_date(to_char(sysdate, ''yyyymmdd''::character varying), ''yyyymmdd''::character varying) > to_date(b.enddate, ''yyyymmdd''::character varying)) THEN ''000''::text
            ELSE NULL::text
        END AS warn,
		date_part(''day''::text, (to_date(b.enddate, ''yyyymmdd''::character varying) - to_date(to_char(sysdate, ''yyyymmdd''::character varying), ''yyyymmdd''::character varying))) AS warndays,
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
