begin
execute immediate'
create or replace view v_perf_t_frame as
select
        t.ele_code as guid,
        t.ele_code as code,
        t.ele_name as name,
        t.parent_id as superid,
        t.level_no as levelno,
        t.is_leaf as isleaf,
       t.mof_div_code,
       t.ordernum,
       t.remark,
      1 status,
       t.start_date,
       t.end_date,
       t.is_enabled,
       t.update_time,
       t.is_deleted,
       t.create_time,
       t.fiscal_year,
       t.frametype,
       t.year,
       t.province,
       t.weight
       FROM perf_t_frame T
    WHERE T.IS_DELETED=2 AND PROVINCE=global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
    AND YEAR=global_multyear_cz.Secu_f_Global_Parm(''YEAR'')';