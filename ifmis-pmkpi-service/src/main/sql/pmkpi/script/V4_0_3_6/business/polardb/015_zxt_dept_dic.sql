delete from bus_t_dictable where tablecode = 'PERF_T_DEPTINDEXADJUST';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_DEPTINDEXADJUST', '部门绩效指标调整表', '部门绩效指标调整表', 3, 1, 'PERF_T_DEPTINDEXADJUST', 'pmkpi', null, '0', 1, '0', 0, 1, 'V_PERF_T_DEPTINDEXADJUST', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode = 'PERF_T_DEPTINDEXADJUST';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
select DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, sys_guid() as COLUMNID, COLUMNCODE, 'PERF_T_DEPTINDEXADJUST' as TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION from bus_t_diccolumn where tablecode = 'BGT_PERF_INDICATOR';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
select t.lt_ele_code as DEID, e.value_ref as CSID, null as EXP, t.is_sys as ISSYS, t.field_name as DBCOLUMNCODE, '1' as ISUSES, 
'2016' as YEAR, '87' as PROVINCE, sys_guid() as COLUMNID, t.field_name as COLUMNCODE, 'PERF_T_DEPTINDEXADJUST' as TABLECODE, 
t.field_cn_name as NAME,
DECODE(  (btrim((t.data_type)::text))::character varying
            , ('Date'::text)::character varying
            , ('D'::text)::character varying
            , ('DATE'::text)::character varying
            , ('D'::text)::character varying
            , ('DateTime'::text)::character varying
            , ('D'::text)::character varying
            , ('Integer'::text)::character varying
            , ('N'::text)::character varying
            , ('Currency'::text)::character varying
            , ('N'::text)::character varying
            , ('Decimal'::text)::character varying
            , ('N'::text)::character varying
            , ('S'::text)::character varying
        ) AS datatype,
        CASE
            WHEN (instr(t.data_length, ','::character varying) > 0) THEN (substr((t.data_length)::text, (0)::numeric, ((instr(t.data_length, ','::character varying) - 1))::numeric))::character varying
            ELSE t.data_length
        END AS datalength,
        null as scale, '1' as VERSION,null as NULLABLE, null as DEFAULTVALUE, sysdate as DBVERSION 
from cfs_ltable_field t  
LEFT JOIN cfs_lt_element e ON e.lt_ele_code = t.lt_ele_code AND e.lt_ele_code <> 'BE13014'
where t.table_name = 'BGT_PERF_INDICATOR';

delete FROM Bus_t_Dictable t where t.tablecode = 'PERF_BGT_INDEXPROADJUST';

insert into Bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_BGT_INDEXPROADJUST', '指标对应项目关系调整', '指标对应项目关系调整', 2, 1, 'PERF_BGT_INDEXPROADJUST', 'pmkpi', null, '0', 1, '0', 0, 1, 'V_PERF_BGT_INDEXPROADJUST', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode = 'PERF_BGT_INDEXPROADJUST';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
select DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, sys_guid() as COLUMNID, COLUMNCODE, 'PERF_BGT_INDEXPROADJUST' as TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION from bus_t_diccolumn where tablecode = 'PERF_BGT_INDEXPRO';


delete FROM Bus_t_Dictable t where t.tablecode = 'PERF_BGT_LINKBGTINFOADJUST';

insert into Bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_BGT_LINKBGTINFOADJUST', '预算挂钩机制调整', '预算挂钩机制调整', 2, 1, 'PERF_BGT_LINKBGTINFOADJUST', 'pmkpi', null, '0', 1, '0', 0, 1, 'V_PERF_BGT_LINKBGTINFOADJUST', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn where tablecode = 'PERF_BGT_LINKBGTINFOADJUST';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
select DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, sys_guid() as COLUMNID, COLUMNCODE, 'PERF_BGT_LINKBGTINFOADJUST' as TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION from bus_t_diccolumn where tablecode = 'PERF_BGT_LINKBGTINFO';
