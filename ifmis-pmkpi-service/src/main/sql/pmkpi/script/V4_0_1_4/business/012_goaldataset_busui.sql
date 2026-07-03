begin
--绩效目标默认数据配置2.busui
--业务表注册
delete from p#busfw_t_uitable where key = '/pmkpi/setting/goaldataset'; 
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('6CAE208E67F440048B411611B6698359', '/pmkpi/setting/goaldataset', 'PERF_GOAL_DATA', 0, 0, 0, null, null, 'pmkpi', null);

--展示列注册
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/setting/goaldataset';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC71FFC48FF043CBB464C85DDE5CB571', '/pmkpi/setting/goaldataset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('50E23AF574F242A1A8DC13A664A35A89', '/pmkpi/setting/goaldataset', 'TOTALGOAL', '总体（中期）绩效目标', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C56DBA16D14C4177872840846946F46A', '/pmkpi/setting/goaldataset', 'YEARGOAL', '年度绩效目标', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('22A96EB992834868B5810324EF5AE66C', '/pmkpi/setting/goaldataset', 'PROJECTKIND', '支出项目类别', 4, 1, 1, 0, null, 1, null, null, '#code-#name', null, null, 150, 1, 'tree', null, null);

--按钮注册
delete from p#busfw_t_uifunction where key = '/pmkpi/setting/goaldataset'; 
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6E2B58FF9EA64073B3AFF6A7AB04DA47', '/pmkpi/setting/goaldataset', '保存', 1, 1, 'searchicon', 'perfdataset.savemajorkey', null, '保存', 'pmkpi', 'savemajorkey', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('12A36CA079494DA3870CBD752E11FA4F', '/pmkpi/setting/goaldataset', '初始化', 1, 2, 'openstat', 'perfdataset.initset', null, '初始化', 'pmkpi', 'initset', '1', '{}');

--查询区注册
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/goaldataset'; 
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD3086AFACDB4F7E97246D78D1B69E47', '/pmkpi/setting/goaldataset', 'TOTALGOAL', '总体绩效目标', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_GOAL_DATA', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('A9B445B870364F1D85DB33B6E62C54A3', '/pmkpi/setting/goaldataset', 'YEARGOAL', '年度绩效目标', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_GOAL_DATA', '{}', null);
