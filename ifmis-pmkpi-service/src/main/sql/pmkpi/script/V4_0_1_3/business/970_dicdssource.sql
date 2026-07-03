begin
delete from fasp_t_dicdssource where guid = 'KPIVALSOURCE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('KPIVALSOURCE', 'KPIVALSOURCE', 'KPIVALSOURCE', '定量待定', '1', '20180424221721795', '20180424', null, '2019', '340000000', null, null, null, '2', 'select t.name as guid,t.code,t.name,t.elementcode,t.remark,t.status from V_perf_enum t', null, 2, 'pmkpi');

delete from fasp_t_dicdssource where guid ='ISLEAF';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('ISLEAF', 'ISLEAF', 'ISLEAF', '是否末节点', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"否"},{guid:"1",code:"1",name:"是"}]', null, 1, 'pmkpi');

delete from fasp_t_dicdssource where guid ='BUSSTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('BUSSTYPE', 'BUSSTYPE', 'BUSSTYPE', '业务类型', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"项目"},{guid:"1",code:"1",name:"部门"}]', null, 1, 'pmkpi');

-- 审核定义信息配置   添加视图，选择报表的数据源分年度区划
update fasp_t_dicdssource set DATASOURCE ='select t.guid,t.name,t.code from v_perf_t_customauditview t' where CODE ='VIEWCODE' and ELEMENTCODE = 'VIEWCODE';
