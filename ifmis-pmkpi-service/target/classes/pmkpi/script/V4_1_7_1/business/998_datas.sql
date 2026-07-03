begin
  
delete from perf_t_uitabpage_chec t where t.key='/pmkpi/adjust/report/proedit' and t.code='traindex';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2DC44E4DA822D7ACE063020011ACC473', 'D4D3D3E37A62274CE0533315A8C0ACDD', '细化区域年度绩效', '/pmkpi/adjust/report/proedit', 'traindex', 2, 'v_perf_t_adjustallindex', '20220719174409', '20220719174409', '2016', '87');
