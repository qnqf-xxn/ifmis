begin
  
UPDATE p#Busfw_t_Uitabpage t set t.config='{filebustype:''traceresulupload'',url:''/pmkpi/upload/file/index.page?filebustype=traceresulupload''}' WHERE t.key='/pmkpi/protrace/thirdaudit/opinion' and t.code='file';

DELETE FROM perf_filetype t where t.bustype='traceresulupload';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CAD8EC5CE7C97506E0533315A8C09674', '001', '项目申报附件', null, '#', 1, 0, 1, 1, 'traceresulupload', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CAD8EC5CE7CA7506E0533315A8C09674', '001001', '附件材料', null, 'PPP6P23PP8190CC3E053B11FA8C0BCC1', 2, 1, 2, 1, 'traceresulupload', null, null, 2016, '87');

