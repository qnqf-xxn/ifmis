begin


delete from perf_t_systemset t where t.guid='B62AAF23FD5945CCA949FDC7A61BA730';
insert into perf_t_systemset (PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, GUID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('tlprogramindex_edit', '项目指标是否显示绩效目标(编辑区)', '1', '1、不显示 2、显示', 'pmkpi', 'B62AAF23FD5945CCA949FDC7A61BA730', 6, 1, 2016, '87');
