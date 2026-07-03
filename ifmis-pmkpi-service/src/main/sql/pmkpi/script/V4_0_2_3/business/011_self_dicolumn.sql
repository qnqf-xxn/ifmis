   i number;
begin
  --自评预算执行情况业务表 扩展 完成情况 字段
  
    --表字段注册
     select count(*) into i from bus_t_diccolumn t where t.tablecode ='PERF_T_SELFPROFUND' and t.columncode ='COMPLETION';
    if i = 0 then
      execute immediate '
        insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
        values (null, null, null, ''0'', ''COMPLETION'', ''1'', ''2020'', ''87'', ''B74D29A8705C4446E0530100007F1A00'', ''COMPLETION'', ''PERF_T_SELFPROFUND'', ''完成情况'', ''S'', ''200'', null, null, 1, null, sysdate)';
    end if;
  
   --表
     select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPROFUND' and t.COLUMN_NAME='COMPLETION';
    if i=0 then
      execute immediate 'alter table PERF_T_SELFPROFUND add COMPLETION VARCHAR2(2000)';
    end if;
    
    --重构视图
    execute immediate'
    create or replace view v_perf_t_selfprofund as
    select *
    from perf_t_selfprofund t
      where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
