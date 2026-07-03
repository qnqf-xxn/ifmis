begin

--部门绩效申报填报-附件管理（改为新版）
delete from perf_filetype where bustype = 'deptperformance';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D55FBA27F58E1411E0533315A8C0325B', '001', '附件材料', null, '#', 1, 0, 1, 1, 'deptperformance', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D55FBA27F58F1411E0533315A8C0325B', '001001', '部门绩效申报附件', null, 'D55FBA27F58E1411E0533315A8C0325B', 2, 1, 2, 1, 'deptperformance', null, null, 2016, '87');

update p#busfw_t_uitabpage set config = '{filebustype:''deptperformance'',url:''/pmkpi/upload/file/index.page''}' where key = '/pmkpi/deptperformance/report/edit' and code = 'file';
