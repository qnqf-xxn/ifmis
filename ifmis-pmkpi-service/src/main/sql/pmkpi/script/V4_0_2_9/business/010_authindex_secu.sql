
begin

delete from FASP_T_SECURLFILTER where URL = '/pmkpi/indexauth/getAuthLefttree';
insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values (sys_guid(), '/pmkpi/indexauth/getAuthLefttree', 0, 'pmkpi');

delete from FASP_T_SECURLFILTER where URL = '/pmkpi/indexauth/getAuthIndexByPage';
insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values (sys_guid(), '/pmkpi/indexauth/getAuthIndexByPage', 0, 'pmkpi');

delete from FASP_T_SECURLFILTER where URL = '/pmkpi/indexauth/saveIndexAuth';
insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values (sys_guid(), '/pmkpi/indexauth/saveIndexAuth', 0, 'pmkpi');