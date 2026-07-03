i integer;
begin
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='ENDVALTYPE';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add ENDVALTYPE VARCHAR2(40)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.endvaltype is ''完成值取值方式''';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='ENDVALSOURCE';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add ENDVALSOURCE VARCHAR2(40)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.endvalsource is ''指标完成值数据来源''';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='VALRULE';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add VALRULE VARCHAR2(40)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.valrule is ''赋值规则''';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='EVIDENCEFILE';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add EVIDENCEFILE VARCHAR2(40)';
     execute immediate ' comment on column BAS_PERF_INDICATOR.evidencefile is ''佐证资料要求''';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='ISSTANDPUSH';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add ISSTANDPUSH VARCHAR2(40)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.isstandpush is ''是否为标准化工作组发布''';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='COMPUTETYPE';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add COMPUTETYPE VARCHAR2(2000)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.computetype is ''计算方式''';
  end if;
  select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='REMARK';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add REMARK VARCHAR2(2000)';
     execute immediate 'comment on column BAS_PERF_INDICATOR.remark is ''备注''';
  end if;
  
  execute immediate 'create or replace view v_bas_perf_indicator as
  select * FROM BAS_PERF_INDICATOR T WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';