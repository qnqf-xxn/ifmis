begin
   
delete from p#busfw_t_uifunction where  key = '/pmkpi/index/query' and guid in ('C78FE0C82416FE31151F7EE4A88E7B3A','312C460AC33A1A7BFD2CB8BBC9B392EA','991BCDBBFE93E78A5AFFE5CEEA3DE0F8');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('991BCDBBFE93E78A5AFFE5CEEA3DE0F8', '/pmkpi/index/query', '县级指标', 0, 7, 'searchicon', 'indexquery.countyindex', null, '县级指标', 'pmkpi', 'countyindex', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('312C460AC33A1A7BFD2CB8BBC9B392EA', '/pmkpi/index/query', '市级指标', 0, 6, 'searchicon', 'indexquery.cityindex', null, '市级指标', 'pmkpi', 'cityindex', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C78FE0C82416FE31151F7EE4A88E7B3A', '/pmkpi/index/query', '省级指标', 0, 5, 'searchicon', 'indexquery.provinceindex', null, '省级指标', 'pmkpi', 'provinceindex', null, '{}');
