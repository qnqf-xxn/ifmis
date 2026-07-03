begin

execute immediate '
create or replace view perf_v_reviewquery as
select t.*
       ,a.fopinion,
       a.sopinion,
       a.remark,
       g.name shjl,
       b.freviewname,
       b.sreviewname
from v_perf_t_review t
left join v_perf_t_auditmain a on a.mainguid=t.guid
left join perf_t_datasource g on a.CONCLUSION=g.guid and g.elementcode=''PMKPICONCLUSION''
left join (select c.*,e.name as freviewname,f.name as sreviewname from perf_t_audititems c
left join v_perf_enum e on e.guid=c.freview
left join v_perf_enum f on f.guid=c.sreview
 where exists(select 1 from v_perf_t_reviewtemp d where d.name=''×ÛºÏÆÀ¶¨'' and d.guid=c.tempguid))b on b.mainguid=t.guid
 where t.islast=1
';
