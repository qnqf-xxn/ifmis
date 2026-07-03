begin
 --部门整体隐藏 导入 按钮
delete from perf_t_treetab where key ='/pmkpi/program/trace/report';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43973375E0533315A8C0E105', '/pmkpi/program/trace/report', 'protrace', '项目支出', 1, null, 1, '2016', '87', 'B7279B405D487EB4E0530100007FD738', 'protracereporthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB43983375E0533315A8C0E105', '/pmkpi/program/trace/report', 'depttrace', '部门整体', 1, '导入', 2, '2016', '87', 'BBC491112EDB3877E053B11FA8C041AA', 'depttracereporthide');
