begin
  
execute immediate 'create or replace view rpt_v_gzperfgoal as
select m.guid,
       m.mainguid,
       m.mainguid as proguid,
       m.mainguid as busguid,
       m.kpi_target,
       n.PRO_CODE as procode,
       n.PRO_NAME as proname
  from pm_perf_goal_info m left join v_perf_project_info n on
  m.mainguid = n.guid where m.yearflag = ''1'' and m.is_deleted =2
  and m.province = global_multyear_cz.secu_f_global_parm(''DIVID'')';

execute immediate 'CREATE OR REPLACE VIEW RPT_V_GZPERFINDEX AS
select m.guid,
       m.mainguid,
       m.mainguid as proguid,
       m.mainguid as busguid,
       m.findex,
       m.sindex,
       (select a.name
          from v_perf_t_frame a
         where a.frametype = ''PM001''
           and a.guid = m.findex) as findexname,
       (select a.name
          from v_perf_t_frame a
         where a.frametype = ''PM001''
           and a.guid = m.sindex) as sindexname,
       m.name,
       (select a.name
          from v_perf_enum a
         where a.elementcode = ''PMKPIZBXS''
           and a.code = m.computesign) as computesign,
       m.indexval,
       m.meterunit,
       m.kpi_remark as zbbz,
       m.value_remark as zbzsm,
       m.yearflag,
       e.findexnum,
       f.sindexnum
  from pm_perf_indicator m
  left join v_perf_project_info n
    on n.guid = m.mainguid
  left join (SELECT p.guid,p.sindex,q.mainguid,q.findex,q.findexnum FROM pm_perf_indicator p left join (
select a.mainguid,a.findex,count(a.findex) as findexnum
  from (SELECT * FROM pm_perf_indicator where yearflag = ''1'' and is_deleted =2) a group by a.findex,a.mainguid) q
  on p.findex = q.findex and  p.mainguid = q.mainguid ) e
  on m.guid = e.guid and m.findex = e.findex and m.sindex = e.sindex
  left join
  (SELECT p.guid,p.findex,q.mainguid,q.sindex,q.sindexnum FROM pm_perf_indicator p left join (
select a.mainguid,a.sindex,count(a.sindex) as sindexnum
  from (SELECT * FROM pm_perf_indicator where yearflag = ''1'' and is_deleted =2) a group by a.sindex,a.mainguid) q
  on p.sindex = q.sindex and  p.mainguid = q.mainguid) f
  on m.guid = f.guid and m.findex = f.findex and m.sindex = f.sindex
 where  m.yearflag = ''1'' and m.is_deleted =2 and m.province = global_multyear_cz.secu_f_global_parm(''DIVID'')
 order by m.sindex
';
