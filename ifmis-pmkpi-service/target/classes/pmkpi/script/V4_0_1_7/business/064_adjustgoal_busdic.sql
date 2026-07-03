begin
  
--绩效目标调整-调整-调整说明保存  
delete from Bus_t_Diccolumn where tablecode = 'PERF_T_ADJUSTGOAL' and columncode = 'ADJUSTREMARK';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ADJUSTREMARK', '1', '2016', '87', 'C44DCC54DF8BCE04E053B11FA8C0F765', 'ADJUSTREMARK', 'PERF_T_ADJUSTGOAL', '调整说明', 'S', '4000', null, 1, 1, null, sysdate);

