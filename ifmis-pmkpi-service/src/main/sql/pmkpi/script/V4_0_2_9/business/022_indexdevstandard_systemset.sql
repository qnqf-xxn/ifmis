begin

delete from perf_T_systemset where paramcode = 'indexdevstandard';

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('7EB16F820E665273944AD01FE8AE376D', 'indexdevstandard', '监控指标偏差度标准', '15', '参数为X,即为偏差度X%,用于判定偏差过大提醒校验', null, 3, 2016, '87', 1);
