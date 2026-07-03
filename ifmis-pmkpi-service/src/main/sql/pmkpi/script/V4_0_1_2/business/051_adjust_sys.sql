begin
delete from perf_t_systemset where GUID = '733AC1ECE2D598B4DF47D1C8DAE4967D';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('733AC1ECE2D598B4DF47D1C8DAE4967D', 'isPushWfstatus', '根据流程节点展示按钮', '{"moni":"010,008","goal": "010,008"}', 'moni- 发起监控整改按钮； goal- 发起目标调整按钮；', null, 3, 2016, '87', 1);
