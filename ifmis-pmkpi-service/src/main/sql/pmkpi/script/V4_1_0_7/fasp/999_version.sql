begin
delete from fw_t_sysversion where appid = 'pmkpi';
insert into fw_t_sysversion(guid,appid,version,updatetime)
values(sys_guid(),'pmkpi','V4_1_0_7',TO_CHAR(SYSDATE,'YYYY-MM-DD'));
