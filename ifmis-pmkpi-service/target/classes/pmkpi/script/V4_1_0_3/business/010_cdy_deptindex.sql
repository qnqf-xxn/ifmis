begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/indexlib/deptlist') and t.code in('programimport','deptimport');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', '部门指标导入', 1, 7, 'searchicon', 'indexlib.import', null, '部门指标导入', 'pmkpi', 'programimport', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', '部门整体指标导入', 1, 7, 'searchicon', 'indexlib.import', null, '部门整体指标导入', 'pmkpi', 'deptimport', null, '{}');

update perf_t_treetab t set t.hidebtns='部门整体指标导入' where key in('/pmkpi/indexlib/deptlist') and t.code<>'PMKPIDEPT';
update perf_t_treetab t set t.hidebtns='部门指标导入' where key in('/pmkpi/indexlib/deptlist') and t.code='PMKPIDEPT';

delete from p#fw_t_importtemplate t where t.tempcode in('120011005') and t.appid='C43D8AA7015B7F8B25CA18C3277CA4BE';
insert into fw_t_importtemplate (GUID, TEMPCODE, TEMPNAME, COLSPLIT, TABLECODE, CALLBACKBEANID, DEFAULTVALUE, CALLBACKMETHOD, APPID, VCHTYPEID, YEAR, PROVINCE, PARENTCODE, PROCODE, JILIANXIANGMU)
values ('072BCB4EC3A25E83E0630A64A8C0F723', '120011005', '部门整体绩效指标导入模板', ',', 'V_BAS_PERF_INDICATOR', 'pmkpi.setting.indexlib.report.IndexRpBOTx', null, 'importIndexlibData', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '072BCB4EC3985E83E0630A64A8C0F723', '2016', '87', null, null, null);

delete from p#fw_t_importtempdetail t where t.tempid in('072BCB4EC3A25E83E0630A64A8C0F723');
insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('38601E0AD61BDC04F77E99BFB4A28B53', 'V412538AA08B62E3E0535164A8C0C98B', '072BCB4EC3A25E83E0630A64A8C0F723', 0, 'checked', 't.levelno=1 and t.frametype=''DEPT''', null, 'checked', '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('B3CE0298E017458B3FBD6F708091C65F', 'V412538AA08C62E3E0535164A8C0C98B', '072BCB4EC3A25E83E0630A64A8C0F723', 1, 'checked', 't.frametype=''DEPT'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''DEPT'') order by code', null, 'checked', '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('663DD2B5E1FB662B8879F66CE5A563F8', 'V412538AA09062E3E0535164A8C0C98B', '072BCB4EC3A25E83E0630A64A8C0F723', 2, null, null, null, 'checked', '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('E6D20B8EE526DD3C1A8CDA9FC98B8FDD', 'V7625FA0D4E347EAACD5F0253ABC5975', '072BCB4EC3A25E83E0630A64A8C0F723', 3, 'checked', null, null, 'checked', '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('A717F73D9341C43500B5002510BAFEB0', 'V355CD7C6150449AB1F16C4511697744', '072BCB4EC3A25E83E0630A64A8C0F723', 4, null, null, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('2E3E05C37E27086C8C649F50E3DD2146', 'VE7A505693F72B55E0530603A8C08935', '072BCB4EC3A25E83E0630A64A8C0F723', 5, null, null, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('E8EAA835EFAA25DF2A16522BD6D9C377', 'V5B910A16B2F4A3D931D2DFE7E7B0A73', '072BCB4EC3A25E83E0630A64A8C0F723', 6, null, null, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('9D57512950D3C16DA3A4D6DBE0924D05', 'V0DE94A00F7F44A9B5786A173314D717', '072BCB4EC3A25E83E0630A64A8C0F723', 7, null, null, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('1EB6A5B08D9BFDEB576E7765F34DD670', 'V47B7298D0724AF49D633884CA828B7A', '072BCB4EC3A25E83E0630A64A8C0F723', 8, null, null, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN, YEAR, PROVINCE)
values ('5BD4C32F02584FFDF05CB9D28F4D092C', 'VF084677245345768C45B2A70B0EE288', '072BCB4EC3A25E83E0630A64A8C0F723', 9, null, null, null, null, '2016', '87');
