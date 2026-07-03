begin
delete FROM Pmkpi_t_Datarule t where t.guid = 'xjqh';
insert into Pmkpi_t_Datarule (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('xjqh', '下级区划', 'pub', 'ruletable.province in (select prov.guid from V_ELE_VD08001 prov where prov.isleaf = 1 start with prov.superguid = (select superguid from V_ELE_VD08001 where guid = ''#province#'') connect by prior prov.guid =prov.superguid)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);
