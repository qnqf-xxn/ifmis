begin

delete from p#busfw_t_uitable where key = '/pmkpi/setting/model/indexlist';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E43C8D654BE14E17BCCA3960BC7277E2', '/pmkpi/setting/model/indexlist', 'PERF_T_CASEMODELINDEX', 0, 0, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uitable where key = '/pmkpi/setting/case/indexlist';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1A5EAF9AB51F45AD8B095C1AC131B760', '/pmkpi/setting/case/indexlist', 'PERF_T_CASEMODELINDEX', 0, 0, 0, null, null, 'pmkpi', '{}');
