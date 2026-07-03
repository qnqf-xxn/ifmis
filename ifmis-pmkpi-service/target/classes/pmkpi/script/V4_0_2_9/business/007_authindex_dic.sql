
begin

--数据源
delete from fasp_t_dicdssource where GUID ='PMKPIINDEXAUTHLEFT';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIINDEXAUTHLEFT', 'PMKPIINDEXAUTHLEFT', 'PMKPIINDEXAUTHLEFT', '指标库授权左侧树节点', '1', '20210518113621631', '20150901', null, '2016', '87', null, null, null, '1', '[{guid:"01",code:"01",name:"共性"},{guid:"02",code:"02",name:"个性"},{guid:"03",code:"03",name:"部门指标"}]', null, 1, 'pmkpi');

delete from fasp_t_dicdssource where GUID ='INDEXAUTHSTATUS';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXAUTHSTATUS', 'INDEXAUTHSTATUS', 'INDEXAUTHSTATUS', '指标库授权状态', '1', '20151015095618892', '20151015', null, '2016', '87', null, null, null, '1', '[{guid:"1",code:"1",name:"是"},{guid:"0",code:"0",name:"否"}]', null, 1, 'pmkpi');

--DIC表注册
delete from bus_t_dictable where tablecode='PERF_T_INDEXAUTH';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_INDEXAUTH', '绩效指标授权配置', '绩效指标授权配置', 2, 1, 'PERF_T_INDEXAUTH', 'pmkpi', null, '0', 1, null, 1, 1, null, sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode='PERF_T_INDEXAUTH';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AUTHCODE', '1', '2016', '87', 'E3331DB163816D07E0533315A8C0E14C', 'AUTHCODE', 'PERF_T_INDEXAUTH', '地区编码', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AUTHNAME', '1', '2016', '87', 'E3331DB163826D07E0533315A8C0E14C', 'AUTHNAME', 'PERF_T_INDEXAUTH', '授权地区', 'S', '2000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'E3331DB1637F6D07E0533315A8C0E14C', 'GUID', 'PERF_T_INDEXAUTH', '主键', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXURL', '1', '2016', '87', 'E3331DB163876D07E0533315A8C0E14C', 'INDEXURL', 'PERF_T_INDEXAUTH', '接口链接', 'S', '2000', null, 0, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIINDEXAUTHLEFT', null, '1', 'LEFTTREE', '1', '2016', '87', 'E3331DB163846D07E0533315A8C0E14C', 'LEFTTREE', 'PERF_T_INDEXAUTH', '左侧树类型', 'S', '100', null, 0, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', 'E3331DB163806D07E0533315A8C0E14C', 'ORDERNUM', 'PERF_T_INDEXAUTH', '排序', 'N', '6', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REMARK', '1', '2016', '87', 'E3331DB163856D07E0533315A8C0E14C', 'REMARK', 'PERF_T_INDEXAUTH', '描述', 'S', '2000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SELECTTYPE', '1', '2016', '87', 'E3331DB163836D07E0533315A8C0E14C', 'SELECTTYPE', 'PERF_T_INDEXAUTH', '授权类型', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'INDEXAUTHSTATUS', null, '1', 'STATUS', '1', '2016', '87', 'E3331DB163866D07E0533315A8C0E14C', 'STATUS', 'PERF_T_INDEXAUTH', '授权状态', 'N', '1', null, 1, 1, null, sysdate);


--财政个性行业(指标授权)数据源
delete from fasp_t_dicdssource where guid ='INDEXCOMFUNCAUTH';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXCOMFUNCAUTH', 'INDEXCOMFUNCAUTH', 'INDEXCOMFUNCAUTH', '财政个性行业(指标授权)', '1', '20140422000000000', '20150423', null, '2020', '87', null, '8717', '1', '2', 'select t.ele_code as guid,
       t.ele_code as code,
       t.ele_name as name,
       nvl((b.ele_code), ''#'') as superguid,
       nvl((b.ele_code), ''#'') as SUPERID,
       t.level_no as levelno,
       case
         when t.is_leaf = 0 and nvl((b.ele_code), ''#'') <> ''#'' then
          1
         else
          t.is_leaf
       end isleaf,
       t.is_enabled as status,
       t.mof_div_code,
       t.fiscal_year
  from ELE_VD10004 t
  left join ELE_VD10004 b
    on t.parent_id = b.ele_id
 where t.is_enabled = 1
   and t.level_no in (1, 2)
   and (t.mof_div_code = ''109900000'' or t.mof_div_code =PERF_AUTHPROVINCE_VIEW.get_province)
   and (t.fiscal_year =PERF_AUTHPROVINCE_VIEW.get_year)
 order by t.ele_code', null, 1, 'pmkpi');