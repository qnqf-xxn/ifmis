begin
  
delete from Fw_t_Systemset t where t.paramcode = 'BUSCOMMON_UPLOAD_MAX_MB_PMKPI';

insert into Fw_t_Systemset (PARAMCODE, PARAMNAME, PARAMOPTION, PARAMDATA, REMARK, ISUSED, DATATYPE, DISPENSABLE, EDITABLE, DATALENGTH, EDITMASK, SYSTEMTYPE, EDITTYPE, ELEMENTCODE, APPID, DBVERSION)
values ('BUSCOMMON_UPLOAD_MAX_MB_PMKPI', '绩效系统上传文件最大大小（单位MB）', null, '100', null, 1, null, 1, 1, null, null, null, 1, null, 'buscommon', sysdate);
