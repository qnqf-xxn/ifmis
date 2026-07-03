
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SUPERVISION';
  if i=0 then
     execute immediate '
create table PERF_T_SUPERVISION
(
  GUID           VARCHAR2(40) not null,
  MAINGUID       VARCHAR2(40) not null,
  WFID           VARCHAR2(40),
  WFSTATUS       VARCHAR2(40),
  AUDITOR        VARCHAR2(40),
  STATUS         NUMBER(1),
  CREATETIME     VARCHAR2(40),
  UPDATETIME     VARCHAR2(40),
  CREATER        VARCHAR2(40),
  PROVINCE       VARCHAR2(32) not null,
  YEAR           NUMBER(4) not null,
  ADJOPTION      VARCHAR2(4000),
  OPTIONS        VARCHAR2(4000),
  AGENCYGUID     VARCHAR2(40),
  PROTYPE        VARCHAR2(10),
  FININTORGGUID  VARCHAR2(40),
  INDEXGUID      VARCHAR2(40),
  LASTUPDATETIME VARCHAR2(40)
)';

execute immediate 'comment on column PERF_T_SUPERVISION.GUID
  is ''guid''';
execute immediate 'comment on column PERF_T_SUPERVISION.MAINGUID
  is ''关联guid''';
execute immediate 'comment on column PERF_T_SUPERVISION.WFID
  is ''流程guid''';
execute immediate 'comment on column PERF_T_SUPERVISION.WFSTATUS
  is ''流程状态''';
execute immediate 'comment on column PERF_T_SUPERVISION.STATUS
  is ''数据状态''';
execute immediate 'comment on column PERF_T_SUPERVISION.CREATETIME
  is ''创建时间''';
execute immediate 'comment on column PERF_T_SUPERVISION.UPDATETIME
  is ''更新时间''';
execute immediate 'comment on column PERF_T_SUPERVISION.CREATER
  is ''创建人''';
execute immediate 'comment on column PERF_T_SUPERVISION.PROVINCE
  is ''区划''';
execute immediate 'comment on column PERF_T_SUPERVISION.YEAR
  is ''年度''';
execute immediate 'comment on column PERF_T_SUPERVISION.ADJOPTION
  is ''监审意见''';
execute immediate 'comment on column PERF_T_SUPERVISION.OPTIONS
  is ''其他意见''';
execute immediate 'comment on column PERF_T_SUPERVISION.AGENCYGUID
  is ''单位id''';
execute immediate 'comment on column PERF_T_SUPERVISION.PROTYPE
  is ''项目类别（一级pormain，二级peodetail，转移支付propay）''';
execute immediate 'comment on column PERF_T_SUPERVISION.FININTORGGUID
  is ''处室id''';
execute immediate 'comment on column PERF_T_SUPERVISION.INDEXGUID
  is ''三级指标guid''';
execute immediate 'alter table PERF_T_SUPERVISION
  add constraint PK_GUID primary key (GUID)
  using index ';
   end if;


execute immediate '
create or replace view v_perf_t_supervision as
select * from PERF_T_SUPERVISION
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
  
execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_SUPERVISIONVIEW AS
SELECT t."GUID",t."MAINGUID",t."WFID",t."AUDITOR",t."STATUS",t."CREATETIME",t."UPDATETIME",t."CREATER",t."PROVINCE",t."YEAR",t."OPTIONS",t."PROTYPE",t."INDEXGUID",t."LASTUPDATETIME",
          --(select name from pmkpi_t_wfstatus where code = t.wfstatus) as WFSTATUS,
          (select name from pmkpi_t_wfstatus where code = t.wfstatus) as WFSTATUSNAME,
          t.WFSTATUS,
          case when t.ADJOPTION = ''1'' then ''指标不够完整''
            when t.ADJOPTION = ''2'' then ''指标不够细化、量化''
              when t.ADJOPTION = ''3'' then ''指标与项目的相关性不够''
            when t.ADJOPTION = ''4'' then ''指标与指标值不匹配''
              when t.ADJOPTION = ''5'' then ''建议拆分指标''
              when t.ADJOPTION = ''6'' then ''一级指标类型错误''
                when t.ADJOPTION = ''7'' then ''二级指标类型错误''
                  when t.ADJOPTION = ''8'' then ''建议增加明确效益指标''
                    when t.ADJOPTION = ''9'' then ''建议增加明确产出指标''
                    when t.ADJOPTION = ''10'' then ''建议增加满意度指标''
                      when t.ADJOPTION = ''11'' then ''其他''  end ADJOPTION,
          t1.pro_name        AS PRONAME,

          t1.agency_code     as agencyguid,
          t1.FININTORGGUID as finintirgguid,
          t1.MANAGE_DEPT_CODE as dept,
          (select name from  PMKPI_FASP_T_PUBAGENCY where code = t1.agency_code) as agencyname,
          (select name from  Fasp_t_Pubdepartment where code = t1.manage_mof_dep_code) as finintirgname,
          (select name from  PMKPI_FASP_T_PUBAGENCY where code = t1.MANAGE_DEPT_CODE) as deptname,
          t1.pro_total_amt   as proamt,
          t1.PRO_LEVONE_NAME         as YJPRONAME,
          t1.PRO_LEVONE_ID        as YJPROID,
          t1.PRO_LEVONE_code         as YJPROCODE,
          (select name from v_perf_t_frame where code = t2.kpi_lv1) as kpi_lv1,
          (select name from v_perf_t_frame where code = t2.kpi_lv2) as kpi_lv2,
          --t2.kpi_lv1,
          --t2.kpi_lv2,
          t2.name as kpi_lv3,
          case when t2.computesign = 1 then ''≥''||t2.kpi_val||t2.meterunit
          when t2.computesign = 2 then ''＞''||t2.kpi_val||t2.meterunit
          when t2.computesign = 3 then ''＝''||t2.kpi_val||t2.meterunit
          when t2.computesign = 4 then ''＜''||t2.kpi_val||t2.meterunit
          when t2.computesign = 5 then ''≤''||t2.kpi_val||t2.meterunit
          when t2.computesign = 6 then t2.kpi_val end kpi_val,
          --t2.kpi_val,
          t2.weight,
          case when t1.V_COL12 = ''1'' then ''是''
            when t1.V_COL12 = ''0'' then ''否'' end as ISPEREVAL
     FROM V_PERF_T_SUPERVISION t
     left join V_PM_PROJECT_INFO t1
       on t.MAINGUID = t1.pro_id
     left join pm_perf_indicator t2
       on t.INDEXGUID = t2.kpi_id
     --left join (select a.guid,b.proname from Pdm_t_Prodetailinfo a left join Pdm_t_Promaininfo b on a.promaininfo = b.guid) t3
       --on t1.pro_id = t3.guid
';


