begin

delete from perf_T_systemset where paramcode = 'dismodel';
insert into perf_t_systemset (PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, GUID, ORDERNUM, STATUS, YEAR, PROVINCE)
values ('dismodel', '监控下发模式', '1', '1同阶段不同任务下发一笔监控项目 2同阶段不同任务下发两笔监控项目', 'pmkpi', 'A5C729CF3B76538131510B48743B18E5', 6, 1, 2016, '87');
