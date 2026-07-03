begin

---表初始化数据
DELETE FROM PMKPI_T_DATARULE t;

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bcsnbdw', '本处室内部单位', 'pub', ' ruletable.agencyguid in (select guid from pmkpi_fasp_t_pubagency aagency where finintorgguid = ''#busoffice#'' or exists (select 1 from pmkpi_fasp_t_pubagency bagency where bagency.guid = ''#curragency#'' and bagency.finintorgguid = aagency.finintorgguid)  and status = 1 and isleaf = 1)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bcs', '本处室', 'pub', ' ruletable.finintorgguid = ''#busoffice#''', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bqh', '本区划', 'pub', ' ruletable.province = ''#province#''', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('tjqh', '同级区划', 'pub', ' ruletable.province like SUBSTR(''#province#''，0，length(''#province#'')-2)||''%'' and length(ruletable.province) = length(''#province#'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('sjqh', '上级区划', 'pub', ' ruletable.province = SUBSTR(''#province#''，0，length(''#province#'')-2)', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('sjxsyzqh', '上级下所有子区划', 'pub', ' ruletable.province like SUBSTR(''#province#''，0，length(''#province#'')-2)||''%''', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbmnbtj', '本部门内部同级', 'pub', ' exists (select 1 from pmkpi_fasp_t_pubagency agen where agen.guid = ruletable.agencyguid and agen.superguid in (select case when superguid =''#'' then province else superguid end superguid from pmkpi_fasp_t_pubagency where guid = ''#curragency#'') )', '20180531172208211', '20180531172208210', 0, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbmnbtjdw', '本部门内部同级单位', 'pub', ' exists (select 1 from pmkpi_fasp_t_pubagency agen where agen.guid = ruletable.agencyguid and agen.superguid in (select case when superguid =''#'' then province else superguid end superguid from pmkpi_fasp_t_pubagency where guid = ''#curragency#'') and agen.isleaf = 1 )', '20180531172208210', '20180531172208210', 0, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bdw', '本单位', 'pub', ' ruletable.agencyguid = ''#curragency#'' ', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbmnbsyxj', '本部门内部所有下级', 'pub', ' exists (select guid from pmkpi_fasp_t_pubagency agen where agen.guid = ruletable.agencyguid and agen.superguid=(select case when superguid =''#'' then guid else superguid end superguid from pmkpi_fasp_t_pubagency where guid = ''#curragency#'') )', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bbm', '本部门', 'pub', ' ruletable.agencyguid = (select guid from pmkpi_fasp_t_pubagency where guid = (select superguid from pmkpi_fasp_t_pubagency where guid = ''#curragency#'') and isleaf = 0 and status = 1) ', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('bcsnbbm', '本处室内部部门', 'pub', 'ruletable.agencyguid in       (select guid          from pmkpi_fasp_t_pubagency tagency         where tagency.isleaf = 0           and exists         (select 1                  from pmkpi_fasp_t_pubagency aagency                 where aagency.superguid = tagency.guid                   and (aagency.finintorgguid = ''#busoffice#'' or exists                        (select 1                           from pmkpi_fasp_t_pubagency bagency                          where bagency.guid = ''#curragency#''                            and bagency.finintorgguid = aagency.finintorgguid))                   and status = 1                   and isleaf = 1))', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservagency', '用户对单位权限(设置中间表)', 'pub', ' exists (select * from pmkpi_t_uservagency agen where agen.agency = ruletable.agency and agen.userguid = ''#curruser#'') ', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservbusoffice', '用户对处室权限(设置中间表)', 'pub', ' exists (select * from pmkpi_t_uservagency agen where agen.agency = ruletable.finintorgguid and agen.userguid = ''#curruser#'')', '20180531172208210', '20180531172208210', 1, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('zjgkbcs', '资金归口本处室', 'pub', ' ruletable.finintorgguid = ''#busoffice#''', '20180531172208210', '20180531172208210', 0, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('uservbackoffice', '用户对资金归口处室权限(设置中间表)', 'pub', ' exists (select * from pmkpi_t_uservagency agen where agen.agency = ruletable.finintorgguid and agen.userguid = ''#curruser#'')', '20180531172208210', '20180531172208210', 0, 0, '87', 0);

insert into PMKPI_T_DATARULE (GUID, NAME, APPID, WHERESQL, CREATETIME, UPDATETIME, STATUS, ISPRIVATE, PROVINCE, YEAR)
values ('brcj', '本人创建', 'pub', ' ruletable.creater = ''#curruser#''', '20180531172208210', '20180531172208210', 1, 0, '87', 0);
