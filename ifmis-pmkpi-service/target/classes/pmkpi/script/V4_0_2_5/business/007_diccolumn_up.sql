begin

update bus_t_diccolumn t set t.datatype='N' where t.tablecode like'PERF_%' and t.datatype='F';
update bus_t_diccolumn t set t.datalength='6' where t.tablecode like'PERF_%' and t.datalength='5' and t.datatype='N';
