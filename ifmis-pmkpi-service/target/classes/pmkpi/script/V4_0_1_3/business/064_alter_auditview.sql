  -- 审核定义 -- 自定义视图表字段 CLASSIFY 修改为可为空
i integer;
begin
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CUSTOMAUDITVIEW' and t.column_name='CLASSIFY' and t.NULLABLE = 'N';
    if i=1 then
    execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW modify CLASSIFY VARCHAR2(40) null';
end if;
   
-- 重构试图 (自定义视图信息表的视图)
   execute immediate '
create or replace view V_PERF_T_CUSTOMAUDITVIEW as
select * from PERF_T_CUSTOMAUDITVIEW where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

-- 重构试图 (审核定义业务配置表的视图)
   execute immediate '
create or replace view V_PERF_T_BUSAUDITDEFINE as
select * from PERF_T_BUSAUDITDEFINE where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

