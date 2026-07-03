begin
  
delete from perf_t_uitabpage_chec t where t.key = '/pmkpi/evaluation/dept/result/deptedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1A079D9CCD844F57E0635B03A8C02FF2', 'E4257E79F6892FF4E0533315A8C02DE5', '项目附件', '/pmkpi/evaluation/dept/result/deptedit', 'file', 2, 'v_perf_file', '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1A079D9CCD854F57E0635B03A8C02FF2', 'E4257E79F68A2FF4E0533315A8C02DE5', '评价成果', '/pmkpi/evaluation/dept/result/deptedit', 'resultfile', 2, 'v_perf_file', '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1A079D9CCD894F57E0635B03A8C02FF2', 'E4257E79F6882FF4E0533315A8C02DE5', '基本信息', '/pmkpi/evaluation/dept/result/deptedit', 'basinfo', 2, null, '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1A079D9CCD864F57E0635B03A8C02FF2', 'E4257E79F6872FF4E0533315A8C02DE5', '评估结论', '/pmkpi/evaluation/dept/result/deptedit', 'info', 1, 'v_perf_t_deptevaluation', '20220831160349', '20220831160349', '2016', '87');

insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1A079D9CCD874F57E0635B03A8C02FF2', 'E4257E79F6882FF4E0533315A8C02DE5', '第三方信息', '/pmkpi/evaluation/dept/result/deptedit', 'thirdparty', 1, 'v_perf_third_party_info', '20220831160349', '20220831160349', '2016', '87');
