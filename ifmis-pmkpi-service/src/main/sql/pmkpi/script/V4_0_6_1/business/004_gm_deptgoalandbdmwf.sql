begin
  
delete from Perf_t_Systemset t where t.paramcode = 'DEPTGOALSINGLE' and t.province = '87';

insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('FBB80D4B8F5E5820E0533315A8C0B379', 'DEPTGOALSINGLE', '部门整体绩效申报是否与预算编制流程一起', '0', '0不是1是', 'pmkpi', 66, 2016, '87', 1);
