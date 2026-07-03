
begin

--÷’…ÛΩ”ø⁄
delete from FASP_T_SECURLFILTER where URL = '/pmkpi/perfprogram/auditHbPerformance/endformance';
insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values (sys_guid(), '/pmkpi/perfprogram/auditHbPerformance/endformance', 0, 'pmkpi');