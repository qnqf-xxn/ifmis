begin
update perf_t_systemset t set t.appid = 'pmkpi' where nvl(t.appid, '0') = '0';
update PERF_T_CUSTOMAUDITVIEW t set t.appid = 'pmkpi' where nvl(t.appid, '0') = '0';
update PERF_ENUM t set t.appid = 'pmkpi' where nvl(t.appid, '0') = '0';