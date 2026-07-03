i number;
begin
  select count(*) into i from user_views  t where t.VIEW_NAME='V_BGT_PM_ANNUAL';
    if i=1 then
      execute immediate'
      CREATE OR REPLACE VIEW V_PERF_PROJECT_YEAR AS
    select a.GUID,
           a.PRO_ID,
           a.PRO_CODE,
           a.PRO_NAME,
           a.AGENCYGUID,
           a.AGENCY_CODE,
           a.DEPT_CODE,
           a.FININTORGGUID,
           a.MOF_DEP_CODE,
           a.MANAGE_DEPT_CODE,
           a.CREATER,
           a.CREATE_TIME,
           a.UPDATE_TIME,
           a.VERSION,
           a.VERSION_NAME,
           a.MOF_DIV_CODE,
           a.SETUP_YEAR,
           a.PROVINCE,
           a.YEAR,
           a.WFID,
           a.WFSTATUS,
           a.TRAOBJ_AGENCY_CODE,
           a.CEN_TRA_PRO_CODE,
           a.PRO_SOURCE_CODE,
           a.PRO_TERM,
           a.PRO_START_YEAR,
           a.FUN_RES_CODE,
           a.PRO_CAT_CODE,
           a.DISTRI_TYPE_CODE,
           a.IS_TRACK,
           a.IS_CAPTIAL_CONS_PRO,
           a.PRO_TOTAL_AMT,
           a.SCOI_INVEST_FUND,
           a.PRO_DESC,
           a.DRAFT_TEMPLATE_CODE,
           a.IS_END,
           a.IS_SCIENTIFIC,
           a.IS_DELETED,
           a.IS_USESET,
           a.ISPUBLISH,
           a.ISHISTORY,
           a.LASTUPDATETIME,
           a.FROMGUID,
           a.ADJSTATUS,
           a.PROJECTKIND,
           b.bgtamt
      from V_PERF_PROJECT_INFO a,
           (SELECT p.pro_code,
                   case
                     when p.REPLY_AMT <> 0 then
                      p.REPLY_AMT
                     when p.REPLY_AMT = 0 and p.FIN_AUDIT_MONEY <> 0 then
                      p.FIN_AUDIT_MONEY
                     when p.REPLY_AMT = 0 and p.FIN_AUDIT_MONEY = 0 then
                      p.APPLY_UP
                     else
                      0
                   end bgtamt
              FROM (Select t.PRO_CODE,
                           sum(t.APPLY_UP) APPLY_UP, --申报数,
                           sum(FIN_AUDIT_MONEY) FIN_AUDIT_MONEY, --审核数,
                           sum(REPLY_AMT) REPLY_AMT --批复数 
                      from V_BGT_PM_ANNUAL t --部门预算项目
                     where t.is_deleted = 2
                       and taskguid in
                           (''A69147082E975D0733386A42C3E5F4B5'',
                            ''9EE3A842793449818960559B00660C1B'')
                     group by t.PRO_CODE
                    Union all
                    Select t.PRO_CODE,
                           sum(t.APPLY_UP) APPLY_UP, --申报数,
                           sum(FIN_AUDIT_MONEY) FIN_AUDIT_MONEY, --审核数,
                           sum(REPLY_AMT) REPLY_AMT --批复数 
                      from V_BGT_TRA t --转移支付项目
                     where t.is_deleted = 2
                     group by t.PRO_CODE) p) b
     WHERE a.PRO_CODE = b.PRO_CODE
     
     union
     
     select a.GUID,
           a.PRO_ID,
           a.PRO_CODE,
           a.PRO_NAME,
           a.AGENCYGUID,
           a.AGENCY_CODE,
           a.DEPT_CODE,
           a.FININTORGGUID,
           a.MOF_DEP_CODE,
           a.MANAGE_DEPT_CODE,
           a.CREATER,
           a.CREATE_TIME,
           a.UPDATE_TIME,
           a.VERSION,
           a.VERSION_NAME,
           a.MOF_DIV_CODE,
           a.SETUP_YEAR,
           a.PROVINCE,
           a.YEAR,
           a.WFID,
           a.WFSTATUS,
           a.TRAOBJ_AGENCY_CODE,
           a.CEN_TRA_PRO_CODE,
           a.PRO_SOURCE_CODE,
           a.PRO_TERM,
           a.PRO_START_YEAR,
           a.FUN_RES_CODE,
           a.PRO_CAT_CODE,
           a.DISTRI_TYPE_CODE,
           a.IS_TRACK,
           a.IS_CAPTIAL_CONS_PRO,
           a.PRO_TOTAL_AMT,
           a.SCOI_INVEST_FUND,
           a.PRO_DESC,
           a.DRAFT_TEMPLATE_CODE,
           a.IS_END,
           a.IS_SCIENTIFIC,
           a.IS_DELETED,
           a.IS_USESET,
           a.ISPUBLISH,
           a.ISHISTORY,
           a.LASTUPDATETIME,
           a.FROMGUID,
           a.ADJSTATUS,
           a.PROJECTKIND,
           a.PRO_TOTAL_AMT as bgtamt
      from V_PERF_PROJECT_INFO a
      where exists (select 1
                from v_perf_t_deptperfmiddeclare nz  --年中追加项目
               where nz.pro_code = a.PRO_CODE and nz.wfstatus = ''011'')';
    end if;
