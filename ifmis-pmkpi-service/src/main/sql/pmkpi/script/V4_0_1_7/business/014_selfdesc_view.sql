begin

--1.自评补充信息-项目
execute immediate 'CREATE OR REPLACE VIEW V_PERF_SELFPERFDESC AS
SELECT t.GUID,
       s.MAINGUID,
       t.YEARGOAL,
       t.ALLYEARGOAL,
       t.SELFADDINFO,
       t.DEVIATIONANALY,
       t.RECTIFICATION,
       t.PROJGUID,
       t.AGENCYGUID,
       t.WFSTATUS,
       t.STATUS,
       t.CREATETIME,
       t.UPDATETIME,
       t.CREATER,
       t.PROVINCE,
       t.YEAR,
       t.FININTORGGUID,
       t.WFID,
       t.VCOL1,
       t.VCOL2,
       t.VCOL3,
       t.VCOL4,
       t.VCOL5,
       t.VCOL6,
       t.VCOL7,
       t.VCOL8,
       t.VCOL9,
       t.VCOL10
--       case when nvl(s.score,0) + nvl(a.bgtscore,0) > 90 then
--          ''优''
--        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then
--          ''良''
--        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then
--          ''中''
--        when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then
--          ''差''
--        end as SELFRESULT,
--        nvl(s.score, 0) + nvl(a.bgtscore,0) score,
--        case when nvl(s.score,0) = 0 then
--          ''''
--        when  (nvl(s.score,0)/90-bgtscore/10)/(nvl(s.score,0)/90)>0.05 then
--          ''red''
--        when a.amt3 = 0 then
--          ''yellow''
--        when  (a.amt3-a.amt4)/a.amt3>0.2 then
--          ''yellow''
--          end warn
  FROM
    (select c.mainguid,c.projguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid,c.projguid) s
    left join V_PERF_T_SELFPERFDESC t on s.mainguid = t.mainguid
--     left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4 from V_PERF_V_SELFBDGPAY group by proguid)a
--   on a.proguid=s.projguid
';

--2.自评补充信息-部门
execute immediate 'CREATE OR REPLACE VIEW V_PERF_SELFDEPTDESC AS
SELECT t.GUID,
       s.MAINGUID,
       t.YEARGOAL,
       t.ALLYEARGOAL,
       t.SELFADDINFO,
       t.DEVIATIONANALY,
       t.RECTIFICATION,
       t.PROJGUID,
       t.AGENCYGUID,
       t.WFSTATUS,
       t.STATUS,
       t.CREATETIME,
       t.UPDATETIME,
       t.CREATER,
       t.PROVINCE,
       t.YEAR,
       t.FININTORGGUID,
       t.WFID,
       t.VCOL1,
       t.VCOL2,
       t.VCOL3,
       t.VCOL4,
       t.VCOL5,
       t.VCOL6,
       t.VCOL7,
       t.VCOL8,
       t.VCOL9,
       t.VCOL10
--       case when nvl(s.score,0) + nvl(a.bgtscore,0) > 90 then
--          ''优''
--        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then
--          ''良''
--        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then
--         ''中''
--        when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then
--          ''差''
--        end as SELFRESULT,
--        nvl(s.score,0) + nvl(a.bgtscore,0) score,
--     case when nvl(s.score,0) = 0 then
--         ''
--       when  (nvl(s.score,0)/90-bgtscore/10)/(nvl(s.score,0)/90)>0.05 then
--         ''red''
--       when a.amt3 = 0 then
--         ''yellow''
--       when  (a.amt3-a.amt4)/a.amt3>0.2 then
--         ''yellow''
--         end warn
  FROM
      (select c.mainguid,c.projguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid,c.projguid) s
      left join V_PERF_T_SELFPERFDESC t on s.mainguid = t.mainguid
--      left join (select nvl(sum(amt5)/100*10,0) bgtscore , proguid, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4 from V_PERF_V_SELFBDGPAY group by proguid)a
--  on a.proguid=s.projguid
';

