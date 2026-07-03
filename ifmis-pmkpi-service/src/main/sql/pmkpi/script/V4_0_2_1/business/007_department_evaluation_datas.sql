begin


delete from perf_t_treetab t where t.key in('/pmkpi/evaluation/dept/resultquery','/pmkpi/evaluation/dept/resultaudit','/pmkpi/evaluation/dept/result','/pmkpi/evaluation/dept/report','/pmkpi/evaluation/dept/audit'); 


insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F1375E0533315A8C0E111', '/pmkpi/evaluation/dept/resultaudit', 'program', '项目支出', 1, null, 1, '2016', '87', 'BE2FB8A81CF30A3DE053B11FA8C0BF96', 'programdeptevaluaresultaudithide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252901F2CE0533315A8C01580', '/pmkpi/evaluation/dept/resultquery', 'program', '项目支出', 1, null, 1, '2016', '87', 'BE2FB8A81CF30A3DE053B11FA8C0BF96', 'programdeptevaluaresultqueryhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252901F2CE0533315A8C01582', '/pmkpi/evaluation/dept/result', 'program', '项目支出', 1, null, 1, '2016', '87', 'BE2FB8A81CF30A3DE053B11FA8C0BF96', 'programdeptevaluationresulthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252901F2CE0533315A8C01588', '/pmkpi/evaluation/dept/report', 'program', '项目支出', 1, null, 1, '2016', '87', 'BE2FB8A81CF30A3DE053B11FA8C0BF96', 'programdeptevaluationreporthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252901F2CE0533315A8C01589', '/pmkpi/evaluation/dept/audit', 'program', '项目支出', 1, null, 1, '2016', '87', 'BE2FB8A81CF30A3DE053B11FA8C0BF96', 'programdeptevaluationaudithide');