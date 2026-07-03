
i number;
begin
  select count(1) into i from perf_t_audittypecfg t where t.year='2016' and t.province='87';
  if i=0 then
    insert into perf_t_audittypecfg (guid, wfid, nodeguid, audittype, agencyguid, year, province, creater, createtime, updatetime)
    select guid, wfid, nodeguid, audittype, agencyguid, '2016', '87', creater, createtime, updatetime from perf_t_audittypecfg t;
    delete perf_t_audittypecfg t where t.year<>'2016' and t.province<>'87';
  end if;