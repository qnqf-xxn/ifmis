i number;
begin
  --监控分新 扩展 大文本备用 字段
  
    --表字段注册
    select count(*) into i from bus_t_diccolumn t where t.tablecode ='PERF_T_PROTRACEANALYSIS' and t.columncode ='EXTTEXT';
    if i = 0 then
      execute immediate '
        insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
        values (null, null, null, ''0'', ''EXTTEXT'', ''1'', ''2020'', ''87'', ''DA6CADF6ED1A5078E0535164A8C0FDA3'', ''EXTTEXT'', ''PERF_T_PROTRACEANALYSIS'', ''备用字段'', ''S'', ''4000'', null, null, 1, null, sysdate)';
    end if;
  
   --表
     select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_PROTRACEANALYSIS' and t.COLUMN_NAME='EXTTEXT';
    if i=0 then
      execute immediate 'alter table PERF_T_PROTRACEANALYSIS add EXTTEXT VARCHAR2(4000)';
    end if;
    
    --重构视图
    execute immediate'
    create or replace view V_PERF_T_PROTRACEANALYSIS as
    select *
    from PERF_T_PROTRACEANALYSIS t
      where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';