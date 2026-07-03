begin
  
execute immediate '
create or replace view v_perf_indicator_export as
select t.guid,
       t.code,
       t.explain,
       t.weight,
       t.islinked,
       t.agencyguid,
       t.ordernum,
       t.mainguid,
       t.snindexval,
       t.qnindexval,
       t.endvaltype,
       t.endvalsource,
       t.valrule,
       t.evidencefile,
       t.computetype,
       t.isstandpush,
       t.referenceval,
       t.opinion_remark,
       t.referencestandards,
       t.indexstandards,
       e.name as computesign,
       t.meterunit,
       t.targetvalue,
       t.pro_code,
       t.kpi_content,
       t.kpi_evalstd,
       t.kpi_val,
       t.kpi_remark,
       t.agency_code,
       a.name as findex,
       b.name as sindex,
       t.name,
       t.indexval,
       t.yearflag,
       t.kpivalsource,
       t.value_desc,
       t.value_remark,
	   t.year,
       t.province,
       case when t.yearflag = ''1'' then ''总体指标'' else ''年度指标'' end as type
  from pm_perf_indicator t
  left join v_perf_t_frame a on t.findex = a.guid
  left join v_perf_t_frame b on t.sindex = b.guid
  left join v_perf_enum    e on t.computesign = e.code and e.elementcode=''PMKPIZBXS''
where
  t.is_deleted =2 and t.is_backup = 2 and t.province = global_multyear_cz.secu_f_global_parm(''DIVID'')'
;
