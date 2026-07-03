begin
  
delete from perf_t_treetab t where key in('/pmkpi/self/parent/manage','/pmkpi/self/parent/result','/pmkpi/self/parent/audit','/pmkpi/self/parent/query');
insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('2F17CE2458D9CA06E063020011AC5581', '/pmkpi/self/parent/manage', 'parentprogram', '项目支出', 1, null, 1, '2016', '87', '2F17CE2458E2CA06E063020011AC5581', '2F17CE2458CBCA06E063020011AC5581', null);

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('2F17CE2458DACA06E063020011AC5581', '/pmkpi/self/parent/audit', 'parentprogram', '项目支出', 1, null, 1, '2016', '87', '2F17CE2458E2CA06E063020011AC5581', '2F17CE2458CDCA06E063020011AC5581', null);

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('2F17CE2458DBCA06E063020011AC5581', '/pmkpi/self/parent/query', 'parentprogram', '项目支出', 1, null, 1, '2016', '87', '2F17CE2458E2CA06E063020011AC5581', '2F17CE2458CECA06E063020011AC5581', null);

insert into v_perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('2F17CE2458DCCA06E063020011AC5581', '/pmkpi/self/parent/result', 'parentprogram', '项目支出', 1, null, 1, '2016', '87', '2F17CE2458E2CA06E063020011AC5581', '2F17CE2458CCCA06E063020011AC5581', null);
