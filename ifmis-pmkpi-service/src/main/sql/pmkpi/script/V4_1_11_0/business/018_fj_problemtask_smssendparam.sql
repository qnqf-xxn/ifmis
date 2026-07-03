begin


delete from perf_t_systemset t where t.paramcode = 'smssendparams';

insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('47Q605651ACCB0F88AD6AD89BF0935GD', 'smssendparams', '平台短信发送参数', '{"appid":"pmkpi","channel":"yhSms","url":"http://192.168.100.148:8001/fasp3/openapi/v1/gateway/sms/send","accesskey":"18B3CF96F3BA39BF0188C8BC1BDEC840","threadcount":"2"}', 'json格式，根据现场环境修改url的IP端口和accesskey', null, 98, 1, 2016, '87');


