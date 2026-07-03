   i number;
begin
   --表
    select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='SCORE';
    if i=0 then
      execute immediate 'alter table PERF_T_SELFPROFUND add SCORE VARCHAR2(40)';
    end if;
    
    select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='FZSCORE';
    if i=0 then
      execute immediate 'alter table PERF_T_SELFPROFUND add FZSCORE VARCHAR2(40)';
    end if;
    
    select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='CODE';
    if i=0 then
      execute immediate 'alter table PERF_T_SELFPROFUND add CODE VARCHAR2(100)';
    end if;
    
    DELETE FROM Bus_t_Diccolumn t WHERE t.tablecode='PERF_T_SELFPROFUND' and t.columncode in ('CODE','FZSCORE','SCORE');
    insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'CODE', '1', '2020', '87', 'B74D66A8707B4446E0530100007F1A22', 'CODE', 'PERF_T_SELFPROFUND', '编码', 'S', '100', null, 1, 1, null, sysdate);

    insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'FZSCORE', '1', '2020', '87', '2787CBE526E94AA0AB1217DBFA34CE44', 'FZSCORE', 'PERF_T_SELFPROFUND', '分值', 'S', '40', null, 1, 1, null, sysdate);

    insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'SCORE', '1', '2020', '87', '2787CBE526E94AA0AB1217DBFA34CE55', 'SCORE', 'PERF_T_SELFPROFUND', '得分', 'S', '40', null, 1, 1, null, sysdate);


    --重构视图
    execute immediate'
    create or replace view v_perf_t_selfprofund as
    select *
    from perf_t_selfprofund t
      where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
