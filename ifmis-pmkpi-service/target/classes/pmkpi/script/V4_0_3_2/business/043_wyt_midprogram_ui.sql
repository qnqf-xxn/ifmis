i number;
begin
 select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTPERFMIDDECLARE' and t.column_name='CREATE_TIME';
   if i = 0 then 
     execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add CREATE_TIME VARCHAR2(17)';
  end if;
  execute immediate'
    comment on column PERF_T_DEPTPERFMIDDECLARE.create_time
    is ''项目创建时间''
  ';
  --重构视图
  execute immediate '
    create or replace view v_perf_t_deptperfmiddeclare as
    select *
    from perf_t_deptperfmiddeclare
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
   ';
