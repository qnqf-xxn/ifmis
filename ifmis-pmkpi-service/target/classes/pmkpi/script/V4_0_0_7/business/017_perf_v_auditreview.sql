
begin

execute immediate '
create or replace view perf_v_auditreview as
select t.name,t.context,a.MAINGUID,a.PROGUID,a.PROPOSAL,a.freview,a.sreview,'''' FOPINION,''''SOPINION from v_perf_t_reviewtemp t left join perf_t_audititems a on t.guid=a.tempguid order by t.ordernum
';
