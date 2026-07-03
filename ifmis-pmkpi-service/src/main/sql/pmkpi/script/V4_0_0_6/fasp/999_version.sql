begin
delete from fw_t_sysversion where appid = 'pmkpi';
insert into fw_t_sysversion(guid,appid,version,updatetime)
values(sys_guid(),'pmkpi','V4_0_0_6','2020-12-30');
