begin
delete FROM FASP_T_SECURLFILTER t where t.appid = 'pmkpi' and t.url = '/pmkpi/indexauth/getBasIndicator';

insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values ('ED1A40C73C9A1C46E0535064A8C0EF2D', '/pmkpi/indexauth/getBasIndicator', 0, 'pmkpi');