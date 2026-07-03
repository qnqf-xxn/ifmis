i integer;
begin

select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PROJECT_INFO';
if i=1 then
execute immediate '
create or replace view v_perf_project_info as
select *
from PM_PROJECT_INFO t where PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and (projectkind not like ''1%'' and  projectkind not like ''21%'')';
end if;

execute immediate '
create or replace view pmkpi_fasp_t_pubagency as
select t.GUID,
         t.ISLEAF,
         t.UPDATE_TIME,
         t.CODE,
         t.NAME,
         t.SUPERGUID,
         t.STARTTIME,
         t.ENDTIME,
         t.STATUS,
         t.IS_DELETED,
         t.IS_STANDARD,
         t.CREATE_TIME,
         t.LEVELNO,
         t.PROVINCE,
         t.year,
         t.MOF_DIV_CODE,
         t.FISCAL_YEAR,
         t.FININTORG,
         t.AGENCYTYPE,
         t.AGENCYATTRIB,
         t.GUID ID,T.Finintorg finintorgguid,t.code ShowID,
         t.GUID agencyguid,
CASE WHEN SUPERGUID = ''0'' THEN ''#'' ELSE nvl(SUPERGUID,''#'') END SuperID,
  t.ISLEAF EndFlag, f_get_lpad(t.code,''3,3,3,3,3,3'') LvlID from FASP_T_PUBAGENCY t';
