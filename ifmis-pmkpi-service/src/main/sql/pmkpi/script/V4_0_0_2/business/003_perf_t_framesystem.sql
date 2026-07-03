i number;
begin
  -- 绩效指标体系表增加字段
    select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_FRAMESYSTEM' and t.COLUMN_NAME='YEAR';
  if i=0 then
    execute immediate 'alter table PERF_T_FRAMESYSTEM add year NUMBER(4) ';
  end if;
  
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_FRAMESYSTEM' and t.COLUMN_NAME='PROVINCE';
  if i=0 then
    execute immediate 'alter table PERF_T_FRAMESYSTEM add PROVINCE VARCHAR2(9) ';
  end if;
  execute immediate'
  create or replace view v_perf_t_framesystem as
select
        t.ele_code as guid,
        t.ele_code as code,
        t.ele_name as name,
        t.parent_id as superid,
        t.level_no as levelno,
        t.is_leaf as isleaf,
       t.mof_div_code,
       1 status,
       t.ordernum,
       t.remark,
       t.start_date,
       t.end_date,
       t.is_enabled,
       t.update_time,
       t.is_deleted,
       t.create_time,
       t.fiscal_year,
       t.year,t.province
 FROM perf_t_framesystem T
    WHERE T.IS_DELETED=2 AND PROVINCE=global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
    AND YEAR=global_multyear_cz.Secu_f_Global_Parm(''YEAR'')';  
