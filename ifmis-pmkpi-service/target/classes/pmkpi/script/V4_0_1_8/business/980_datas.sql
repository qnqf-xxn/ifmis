begin

--自评补充信息规则(部门bug)--start--
delete from perf_t_warnset where type in('selfscoredept','selfresultdept','selfwarndept');
--部门
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E02E94E0533315A8C0F50E', 'selfresultdept', '自评结论-部门', 'selfresultdept', 'select
    case
        when nvl(s.score,0) + nvl(a.bgtscore,0) > 90 then ''优''
        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 80 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 90)  then ''良''
        when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80) then ''中''
        when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差''
    end as value
FROM
    (select c.mainguid, c.agencyguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.agencyguid) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, agencyguid from v_perf_t_selfprofund group by agencyguid) a
    on a.agencyguid = ''#agencyguid#'' where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E12E94E0533315A8C0F50E', 'selfscoredept', '自评得分-部门', 'selfscoredept', 'select
     to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value
FROM
    (select c.mainguid, c.agencyguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.agencyguid) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, agencyguid from v_perf_t_selfprofund group by agencyguid) a
    on a.agencyguid = ''#agencyguid#'' where s.mainguid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E22E94E0533315A8C0F50E', 'selfwarndept', '自评预警-部门', 'selfwarndept', 'select
    case
        when nvl(s.score,0) = 0 then ''''
        when  (nvl(s.score,0)/90-a.bgtscore/10)/(nvl(s.score,0)/90)>0.05 then ''red''
        when a.amt3 = 0 then ''yellow''
        when  (a.amt3-a.amt4)/a.amt3>0.2 then ''yellow''
    end value
FROM
    (select c.mainguid, c.agencyguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.agencyguid) s
    left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, agencyguid, nvl(sum(amt3), 0) amt3, nvl(sum(amt4), 0) amt4 from v_perf_t_selfprofund group by agencyguid) a
    on a.agencyguid = ''#agencyguid#'' where s.mainguid = ''#mainguid#''', null, null, '2016', '87');
--自评补充信息规则(部门bug)--end--

