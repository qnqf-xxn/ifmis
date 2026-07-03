begin

--页签表权限配置表-升级分区同步注册
delete from bus_t_settmp where tablecode in('V_PERF_T_UITABPAGE_CHEC');

--整改反馈预算调整建议
delete from perf_enum where elementcode in ('PMKPIADJUSTADVICE');
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('pmkpiadjustadvice01', '01', 'PMKPIADJUSTADVICE', '退回', '1', null, null, '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 1);
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('pmkpiadjustadvice02', '02', 'PMKPIADJUSTADVICE', '优化', '1', null, null, '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 2);

