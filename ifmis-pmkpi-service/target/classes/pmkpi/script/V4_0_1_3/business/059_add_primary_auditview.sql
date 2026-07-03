-- 审核定义视图表  修改主键
 i integer;
begin
  -- 删除主键
    execute immediate ' alter table PERF_T_CUSTOMAUDITVIEW drop primary key';
    
    execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW
      add constraint PK_PERF_T_CUSTOMAUDITVIEW primary key (GUID,province,year)
      using index ';
