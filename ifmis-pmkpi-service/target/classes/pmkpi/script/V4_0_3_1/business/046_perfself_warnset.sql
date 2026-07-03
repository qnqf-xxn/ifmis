begin
  
delete from perf_t_warnset t where t.type in('selfresultprogram','selfscoreprogram','selfscoredept','selfresultdept');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E12E94E0533315A8C0F50E', 'selfscoredept', '自评得分-部门', 'selfscoredept', 'select to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value FROM v_perf_t_selfevaltask t left join (select c.mainguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid) s on t.guid=s.mainguid left join (select case when nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,0) >10 then 10 else nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,
           0) end as bgtscore, mainguid from v_perf_t_selfprofund group by mainguid) a on t.guid=a.mainguid where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('C88FE6C873E02E94E0533315A8C0F50E', 'selfresultdept', '自评结论-部门', 'selfresultdept', 'select case when nvl(s.score,0) + nvl(a.bgtscore,0) >= 80 then ''优'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 70 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80)  then ''良'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 70) then ''中'' when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差'' end as value FROM v_perf_t_selfevaltask t left join (select c.mainguid, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid) s on t.guid=s.mainguid left join (select case when nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,0) >10 then 10 else nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,
           0) end as bgtscore, mainguid from v_perf_t_selfprofund group by mainguid) a on t.guid=a.mainguid where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('82D0DB61BF2C4141BAC71290DE2EF1EF', 'selfscoreprogram', '自评得分-项目', 'selfscoreprogram', 'select to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value FROM v_perf_t_selfevaltask t left join (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s on t.pro_code=s.pro_code left join (select case when nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,0) >10 then 10 else nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,
           0) end as bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a on t.pro_code = a.pro_code where t.guid = ''#mainguid#''', null, null, '2016', '87');


insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('42B24123FF9B4AEA8B2EF6AC467B1C69', 'selfresultprogram', '自评结论-项目', 'selfresultprogram', 'select case when nvl(s.score,0) + nvl(a.bgtscore,0) >= 80 then ''优'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 70 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80)  then ''良'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 70) then ''中'' when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差'' end as value FROM v_perf_t_selfevaltask t left join (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s on t.pro_code=s.pro_code left join (select case when nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,0) >10 then 10 else nvl(nvl(sum(AMT4), 0) /
           decode(nvl(sum(AMT3), 1), 0, 1, nvl(sum(AMT3), 1)) * 10,
           0) end as bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a on t.pro_code = a.pro_code where t.guid = ''#mainguid#''', null, null, '2016', '87');
