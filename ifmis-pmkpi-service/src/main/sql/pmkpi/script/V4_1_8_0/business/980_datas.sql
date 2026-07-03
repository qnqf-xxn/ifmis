begin

--是否校验字段内空格 默认不校验
delete from perf_t_systemset where paramcode='isCheckSpace';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('2F66F304BA8C560AE065CAE22F328D41', 'isCheckSpace', '是否校验字段内空格', '0', '1-是，0-否；', 'pmkpi', 98, 2016, '87', 1);

