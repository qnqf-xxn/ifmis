i number;
begin
--修改视图（此视图改为只查询总体指标-用于项目库项目明细导出）
execute immediate '
create or replace view v_perf_indicator_export as
select t.GUID,
       t.CODE,
       t.EXPLAIN,
       t.WEIGHT,
       t.ISLINKED,
       t.AGENCYGUID,
       t.WFSTATUS,
       t.STATUS,
       t.CREATETIME,
       t.UPDATETIME,
       t.CREATER,
       t.PROVINCE,
       t.YEAR,
       t.ORDERNUM,
       t.FININTORGGUID,
       t.MAINGUID,
       t.SUPERID,
       t.LEVELNO,
       t.RULE,
       e.name as COMPUTESIGN,
       t.METERUNIT,
       t.TINDEX,
       t.WFID,
       t.PROGUID,
       t.TARGETVALUE,
       t.KPI_ID,
       t.MOF_DIV_CODE,
       t.FISCAL_YEAR,
       t.PRO_CODE,
       a.name as KPI_LV1,
       b.name as KPI_LV2,
       t.KPI_LV3,
       t.KPI_CONTENT,
       t.KPI_EVALSTD,
       t.KPI_VAL,
       t.KPI_REMARK,
       t.BUSI_TYPE_CODE,
       t.VERSION,
       t.VERSION_NAME,
       t.SUB_MOF_CODE,
       t.UPDATE_TIME,
       t.IS_DELETED,
       t.CREATE_TIME,
       t.AGENCY_CODE,
       c.name as findex,
       d.name as sindex,
       t.NAME,
       t.INDEXVAL,
       t.FROMGUID,
       t.YEARFLAG,
       t.KPIVALSOURCE,
       t.VALUE_DESC,
       t.VALUE_REMARK,
       ''总体指标'' as type
  FROM PM_PERF_INDICATOR t
  left join v_perf_t_frame a on t.KPI_LV1 = a.guid
  left join v_perf_t_frame b on t.KPI_LV2 = b.guid
  left join v_perf_t_frame c on t.FINDEX = c.guid
  left join v_perf_t_frame d on t.Sindex = d.guid
  left join v_perf_enum    e on t.computesign = e.code and e.elementcode=''PMKPIZBXS''
WHERE
  t.yearflag = ''1'' and t.is_deleted =2 and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
