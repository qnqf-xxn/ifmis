begin

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
CASE WHEN SUPERGUID = ''0'' THEN ''#'' ELSE nvl(SUPERGUID,''#'') END SuperID,
  t.ISLEAF EndFlag, f_get_lpad(t.code,''3,3,3,3,3,3'') LvlID from FASP_T_PUBAGENCY t';


execute immediate 'CREATE OR REPLACE VIEW PMKPI_T_WFSTATUS AS
select * from fasp_t_pubwfstatus where guid in(
SELECT WFSTATUS FROM BUSFW_T_DCWORKFLOWBRANCH T WHERE EXISTS(
select guid from BUSFW_T_DCWORKFLOWPLAN P where type =''B876713347C31372A297A0234F30FFB8'' and status =''1'' AND P.GUID = T.WFID)
UNION ALL
SELECT PREVWFSTATUS WFSTATUS FROM BUSFW_T_DCWORKFLOWBRANCH T WHERE EXISTS(
select guid from BUSFW_T_DCWORKFLOWPLAN P where type =''B876713347C31372A297A0234F30FFB8'' and status =''1'' AND P.GUID = T.WFID)
)';