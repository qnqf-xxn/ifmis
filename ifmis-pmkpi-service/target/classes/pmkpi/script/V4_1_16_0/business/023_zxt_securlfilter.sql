begin

delete FROM FASP_T_SECURLFILTER t where t.appid = 'pmkpi' and t.url in('/pmkpi/perfquery/getprotracedatas','/pmkpi/perfquery/getprofinevaldatas');

insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values ('ED1A40C73C9A1C46E0535064A8C0EF2A', '/pmkpi/perfquery/getprotracedatas', 0, 'pmkpi');
insert into FASP_T_SECURLFILTER (GUID, URL, TYPE, APPID)
values ('ED1A40C73C9A1C46E0535064A8C0EF2B', '/pmkpi/perfquery/getprofinevaldatas', 0, 'pmkpi');