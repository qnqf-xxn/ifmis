 i number;
begin
   select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='GUOYOUAMT';
    if i=0 then
       execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(GUOYOUAMT NUMBER(20,5))';
    end if;
   select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='ZHUANHUAMT';
    if i=0 then
       execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(ZHUANHUAMT NUMBER(20,5))';
    end if;
   select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='SHEHUIAMT';
    if i=0 then
       execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(SHEHUIAMT NUMBER(20,5))';
    end if;
    
    --÷ÿππ ”Õº
    execute immediate'create or replace view v_perf_t_deptperfdeclare as
select *
    from PERF_T_DEPTPERFDECLARE t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
