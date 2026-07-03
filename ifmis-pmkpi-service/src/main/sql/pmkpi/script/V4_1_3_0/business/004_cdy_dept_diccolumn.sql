begin
  
delete from bus_t_diccolumn t where t.tablecode in('BGT_PERF_INDICATOR') and t.columncode = 'ISFIXED';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISFIXED', '1', '2016', '87', '1CCC505D439ABF55E063030011ACABFD', 'ISFIXED', 'BGT_PERF_INDICATOR', '是否固化', 'N', '1', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn t where t.tablecode in('BGT_PERF_GOAL_INFO') and t.columncode = 'END_YEAR';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFYEAR', null, '1', 'END_YEAR', '1', '2016', '87', '1CCC505D439EBF55E063030011ACABFD', 'END_YEAR', 'BGT_PERF_GOAL_INFO', '截止年度', 'S', '4', null, 1, 1, null, sysdate);

update bus_t_diccolumn t set t.datalength='300' where t.tablecode 
in('BGT_PERF_INDICATOR','PM_PERF_INDICATOR','PERF_T_ADJUSTINDEX','PERF_T_PROINDEXTRACE','PERF_T_SELFPERFINDEX') 
and t.columncode in('LV1_PERF_IND_CODE','LV2_PERF_IND_CODE','LV3_PERF_IND_CODE','CODE');

update bus_t_diccolumn t set t.csid=null where t.tablecode in('BGT_PERF_INDICATOR') and t.columncode in('LV1_PERF_IND_CODE','LV2_PERF_IND_CODE','LV3_PERF_IND_CODE');

update bus_t_diccolumn t set t.datalength='4000' where t.tablecode in('PERF_T_DEPTPERFDECLARE') and t.columncode in('FUNCDESC','FUNCTION');

update bus_t_diccolumn t set t.datalength='2000' where t.tablecode in('BGT_PERF_GOAL_INFO') and t.columncode in('ZQGOAL');

update bus_t_diccolumn t set t.nullable=1 where t.tablecode='BGT_PERF_INDICATOR' and t.columncode='METERUNIT';

update bus_t_diccolumn t set t.nullable=0 where t.tablecode='BGT_PERF_INDICATOR' and t.columncode in('MOF_DIV_NAME','DEPT_NAME','LV1_PERF_IND_CODE','LV1_PERF_IND_NAME','LV2_PERF_IND_CODE','LV2_PERF_IND_NAME','LV3_PERF_IND_CODE','LV3_PERF_IND_NAME');