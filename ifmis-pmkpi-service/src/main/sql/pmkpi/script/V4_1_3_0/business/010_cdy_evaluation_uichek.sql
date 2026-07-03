begin
  
delete from perf_t_uitabpage_chec t where t.key='/pmkpi/evaluation/dept/result/edit' and t.province='87' and t.code in('basinfo','finresultfile','resultfile','thirdparty');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1F2424DFE71ADC39E063030011AC0A86', 'E4257E79F6872FF4E0533315A8C02DE5', '基本信息', '/pmkpi/evaluation/dept/result/edit', 'basinfo', 2, null, '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1F2424DFE71BDC39E063030011AC0A86', 'E4257E79F6882FF4E0533315A8C02DE5', '评价成果(处室)', '/pmkpi/evaluation/dept/result/edit', 'finresultfile', 2, null, '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1F2424DFE71CDC39E063030011AC0A86', 'E4257E79F6892FF4E0533315A8C02DE5', '评价成果', '/pmkpi/evaluation/dept/result/edit', 'resultfile', 1, 'v_perf_third_party_info', '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1F2424DFE71DDC39E063030011AC0A86', 'E4257E79F68A2FF4E0533315A8C02DE5', '第三方信息', '/pmkpi/evaluation/dept/result/edit', 'thirdparty', 2, null, '20220831160349', '20220831160349', '2016', '87');
