begin

delete from P#busfw_t_uifunction where key = '/pmkpi/supervision/index' and NAME in('一上监审补录','二上监审补录','项目监审补录');							  
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR,PROVINCE)
values ('8FF836B81412192FE053B1100A0A5AAA', '/pmkpi/supervision/index', '一上监审补录', 1, 9, 'searchicon', 'supervision.saveIndex', null, '一上监审补录', 'pmkpi', 'saveIndex', '', '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR,PROVINCE)
values ('8FF836B81412192FE053B1100B6A5AAA', '/pmkpi/supervision/index', '二上监审补录', 1, 10, 'searchicon', 'supervision.saveIndexES', null, '二上监审补录', 'pmkpi', 'saveIndexES', '', '{}','2016','87');

delete from p#busfw_t_uiqueryform where key = '/pmkpi/promain/supervision/index' and columncode = 'BGTWF';
delete from p#busfw_t_uiqueryform where key = '/pmkpi/prodetail/supervision/index' and columncode = 'BGTWF';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(),'/pmkpi/promain/supervision/index','BGTWF','预算流程',7,1,'tree','',null,null,'pmkpi','V_PERF_T_SUPERVISIONVIEW','{format:''#name''}',null,2016,'87');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,YEAR,PROVINCE)
values (sys_guid(),'/pmkpi/prodetail/supervision/index','BGTWF','预算流程',7,1,'tree','',null,null,'pmkpi','V_PERF_T_SUPERVISIONVIEW','{format:''#name''}',null,2016,'87');

delete  bus_t_diccolumn where tablecode= 'V_PERF_T_SUPERVISIONVIEW' and COLUMNCODE = 'BGTWF';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'BGTWF', null, '1', 'BGTWF', '1', '2021', '87', 'PC6B157FC6094PPP9A78D4FPPPBA2DA8', 'BGTWF', 'V_PERF_T_SUPERVISIONVIEW', '是否新增', 'S', '40', null, 1, 1, null, sysdate);


delete from fasp_T_dicdssource where guid= 'BGTWF';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('BGTWF', 'BGTWF', 'BGTWF', '预算流程', '1', '20180613113621631', '20180101', null, '2016', '109900000', null, '200600', '1', '1', '[{guid:"A69147082E975D0733386A42C3E5F4B5",code:"A69147082E975D0733386A42C3E5F4B5",name:"预算一上"},{guid:"9EE3A842793449818960559B00660C1B",code:"9EE3A842793449818960559B00660C1B",name:"预算二上"}]', sysdate, 1, 'pmkpi');

