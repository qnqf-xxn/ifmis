begin

delete from pmkpi_t_datarule t where t.guid in('bcsnbdw','bcsnbbm');
insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bcsnbdw', '本处室内部单位', 'pub', 'ruletable.agencyguid in(select guid from pmkpi_fasp_t_pubagency tagency where tagency.finintorgguid=''#busoffice#'' and tagency.isleaf=1)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into pmkpi_t_datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bcsnbbm', '本处室内部部门', 'pub', 'ruletable.agencyguid in(select guid from pmkpi_fasp_t_pubagency tagency where tagency.finintorgguid=''#busoffice#'' and tagency.isleaf=0)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);
