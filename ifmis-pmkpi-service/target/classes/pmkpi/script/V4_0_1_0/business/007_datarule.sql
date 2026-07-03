begin

delete from pmkpi_t_datarule t where t.guid='bbmnbsyxj';
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbmnbsyxj', '本部门内部所有下级', 'pub', ' exists (select guid from pmkpi_fasp_t_pubagency agen where agen.guid = ruletable.agencyguid and agen.guid in (select guid from pmkpi_fasp_t_pubagency start with guid = ''#curragency#'' connect by prior guid = superguid))', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

