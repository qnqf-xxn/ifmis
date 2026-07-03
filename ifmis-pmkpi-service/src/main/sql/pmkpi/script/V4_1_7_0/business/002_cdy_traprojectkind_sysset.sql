begin
  
delete from perf_t_systemset t where t.paramcode='TRAPROJECTKIND';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('29AAED16CBB40B83E0638516A8C017AC', 'TRAPROJECTKIND', '转移支付项目类型', '00', '项目信息表中转移支付类型编码', 'pmkpi', 1, 2016, '87', 1);
