begin

delete from perf_T_warnset where type in ('positiveindex');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('434BA1A7F44A47DAB115B85F9E40DED1', 'positiveindex01', '正向指标', 'positiveindex', 'SELECT CASE when #indexval# = 0 then ''red'' when ( #indexval#/#targetvalue# * 100) >=120 then ''blue'' else case WHEN VALUE < 60 THEN ''red'' WHEN 60 <= VALUE AND VALUE < 80 THEN ''yellow'' WHEN 80 <= VALUE THEN ''green'' end end as value FROM (SELECT #indexval#/ (#targetvalue#/12 * #month#) * 100 AS VALUE FROM DUAL) A', null, null, '2016', '87');
